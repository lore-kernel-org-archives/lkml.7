Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3157D2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Ufi061f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCNMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:12:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=90c11Nh1d8+GkEJhmfFaluZa0qNebHyc1nBO4nMBHWc=; b=2Ufi061f4J7lr2hhQeijZrAr9
        bwugzvs/K4fEAehfuwLiiyl5BHD0bRN3+y9FE8WIPFOMxv45I2tM+colZJ/YSdR/5dPZ4QAVhwOAw
        vaLCOdI6mHeHCgHFqeXFGTXs6E8KzoOcu1oGknSGtfdjCwWc3IsU0VyfKZWauNli/pNRlnKP7v+L6
        sd/taGFQd9jxCNsJdaVOC0IGIv7Nm53FBqu3CcX2LH8boOG5APJkhmuqNFIr8PGBcK+yogczlnH7C
        Knacu0MWy9z1RQS1Z+hdk+FQ5zftkSM/ug1yvtoNMEn30c/g3iCElOhR5WPWr2sIGi7DM9Fb1jb5I
        sgxcLZH1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBfgr-0002VJ-VF; Wed, 03 Apr 2019 13:12:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B59622038C24C; Wed,  3 Apr 2019 15:12:28 +0200 (CEST)
Date:   Wed, 3 Apr 2019 15:12:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v3 11/11] locking/rwsem: Optimize rwsem structure for
 uncontended lock acquisition
Message-ID: <20190403131228.GI4038@hirez.programming.kicks-ass.net>
References: <1551380981-3113-1-git-send-email-longman@redhat.com>
 <1551380981-3113-12-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551380981-3113-12-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:09:41PM -0500, Waiman Long wrote:
> For an uncontended rwsem, count and owner are the only fields a task
> needs to touch when acquiring the rwsem. So they are put next to each
> other to increase the chance that they will share the same cacheline.

Did you try and micro-bench this?

