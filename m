Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9831EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1C8205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecz0z6kR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbfDDJjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:39:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53550 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfDDJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RidMHjcG2n3Ka1GU8mcjqYcEO6QOzS8K6B8jmbrnzjM=; b=ecz0z6kR40bYeXQnEgfyDpmst
        xY0vGJfXamJKzNLe1he9e54Rkp1VEZLV/ekoxE++1vO2NcdiNfDhBh/Tn2Bkf3aYiMpSQSdCzE3br
        ni4iKI0K2gwBu7QqaztS2nN9lelc+0o44fpwWJdr9ut3uvnTJuuIfg90As1116uESzQ+euS3qLgd6
        5LvjYHgmdWo4BYuI1QkR0kGkn+Y30Ixtow9woivM3ntTSO7Fy4uZMhTO+MYjaZxijAVCmo2RDVOqF
        X/wGWbha4BaS4Ee6mhTyivtx5Q2LqYiFYjImLqgQsiOMbbqP39r4NTn5B3eximGavnVYv4b+V6Nc8
        2qq24y6sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBypq-0002Nt-00; Thu, 04 Apr 2019 09:39:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 721CC2038C23E; Thu,  4 Apr 2019 11:38:59 +0200 (CEST)
Date:   Thu, 4 Apr 2019 11:38:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>,
        Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190404093859.GU4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:05:24AM +0200, Juergen Gross wrote:

> Without PARAVIRT_SPINLOCK this would be just an alternative() then?

That could maybe work yes. This is all early enough.

> Maybe the resulting code would be much more readable if we'd just
> make PARAVIRT_SPINLOCK usable without the other PARAVIRT hooks? So
> splitting up PARAVIRT into PARAVIRT_GUEST (timer hooks et al) and
> the patching infrastructure, with PARAVIRT_GUEST and PARAVIRT_SPINLOCK
> selecting PARAVIRT, and PARAVIRT_XXL selecting PARAVIRT_GUEST.

Well, ideally we'll get static_call() sorted and use that.
