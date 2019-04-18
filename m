Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F98FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AA220835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifHWCy7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbfDRO2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:28:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbfDRO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MzNRznmnd3KIUUKFNOUhJMiTmRbrG25oVTa4vHxjdo0=; b=ifHWCy7LFfwD4AUNLHcOZAala
        6EJ+2gBZy9lzh/S+Qipr1cGE+4tgfGa/n0M/3AAi63lO3aGaWZX1uGO0zDUpBX8+WNmUKYqroTGQa
        EP0z7P6u5HXgjJEotF/VcVNwG6Cd5sATjlEL0DJGFZDBBB7zANd3+3ES9ayZsk/4yWwbqI9oX0vEh
        LroHVxzl93L0nGhHVRlQ8bV+GDoLUujZbrDKOevI58QQWWYooyrhH+Kvit9p4sfgZBDSh9nlYc7YZ
        kGY2lGFtqEtnvQ9SyPAUT31of05Rnlg8WhgbUOkOL4F7K6bLFhU3ptT5ONFFHK6QowRzooYltGBU6
        ZUCCeFvdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH81Z-0002vY-PO; Thu, 18 Apr 2019 14:28:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC15629B9B7B6; Thu, 18 Apr 2019 16:28:22 +0200 (CEST)
Date:   Thu, 18 Apr 2019 16:28:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 15/16] locking/rwsem: Merge owner into count on x86-64
Message-ID: <20190418142822.GC12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-16-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-16-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:58PM -0400, Waiman Long wrote:
> +#ifdef CONFIG_X86_64
> +#define RWSEM_MERGE_OWNER_TO_COUNT
> +#endif

> +#ifdef RWSEM_MERGE_OWNER_TO_COUNT
> +
> +#ifdef __PHYSICAL_MASK_SHIFT
> +#define RWSEM_PA_MASK_SHIFT	__PHYSICAL_MASK_SHIFT
> +#else
> +#define RWSEM_PA_MASK_SHIFT	52
> +#endif

I really dislike how this hardcodes x86_64.

It would be much better to have a CONFIG variable that gives us the
PA_BITS. Then all an architecture needs to do is set that right.

FWIW:

arch/arm64/Kconfig:config ARM64_PA_BITS_48
arch/arm64/Kconfig:config ARM64_PA_BITS_52

So ARM64 could also use this -- provided we get that overflow thing
sorted.
