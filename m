Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D6DC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CEB206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y57sT1dO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDCQKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:10:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43680 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDCQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oxctlf33XRUqCqvjvLyuJJ32TcsfAlFm5J/QwPvH0xw=; b=y57sT1dO2KjmuSwmkOuNr/Gyy
        NIEztjZ0SL9wEXDevahqEBZzDBdEJ5dEA7DzEbfIibjdIX8BjbSt7yeXUM0rbXqsbSTTslqL9VsYn
        ltC83Ww8awqiUWTzTLTpCZTrJykBBo29+EyFvClbnDavQ6swQGotFpO6gECG0ef+FuzY4Hcdi+AD+
        MqDckoRs+1Chp4nrTAF+YlzHgK9AWRQDIEb5e67yqXpWUajT4quBRrEz5pLobpgsezv6VUvXZVfqV
        UcsCtp5MEkxRE7WtVTu9V3b4Zd07wwb2yFl5mky5Rnx70nY8Xu/suomXeLtyNa23d5B4zl65fNQMy
        ppi1gwUcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBiSi-0003s2-Hg; Wed, 03 Apr 2019 16:10:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DF842038D44F; Wed,  3 Apr 2019 18:10:03 +0200 (CEST)
Date:   Wed, 3 Apr 2019 18:10:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190403161003.GL4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <20190401090653.GF11158@hirez.programming.kicks-ass.net>
 <20190401093345.GA14281@hirez.programming.kicks-ass.net>
 <7A8A6827-BF79-47FC-99A1-C9EE00D9C3B1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A8A6827-BF79-47FC-99A1-C9EE00D9C3B1@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:53:53AM -0400, Alex Kogan wrote:

> > One thing we could maybe do is change locked and count to u8, then your
> > overlay structure could be something like:
> > 
> > struct mcs_spinlock {
> > 	struct mcs_spinlock *next;
> > 	u8 locked;
> > 	u8 count;
> > };
> I was trying to keep the size of the mcs_spinlock structure for the non-NUMA variant unchanged.
> If this is not a huge concern, changing the fields as above would indeed simplify a few things.

Well, sizeof(struct mcs_spinlock) is unchanged by the above proposal
(for x86_64).

And I don't think it matters for x86, which is very good at byte
accesses, my only concern would be for other architectures that might
not be as good at byte accesses. For instance Alpha <EV56 would generate
shit code, but then, Alpha isn't using qspinlock anyway.


