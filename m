Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E69C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41E320820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413580;
	bh=wkXd8LvsRDQsmIsQI1DMB/m6N5fb+f+VDdAigOle070=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nFyKcwvph/oeed/hN+5296NyPXY/N1uCVB4gHZDSepHfSea+0OKZIbifPSwaatCBY
	 lXnqzhNtuKfMljglvadbHogC8MX4hdRtcNkyCrIVHDUW0RPkf2w6Y/4Vi2mVeKTVg7
	 6NWY06oz8K6KDFr+4qwDsWEkUil6eBisTe1leOM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfFXV7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfFXV7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:36 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822DE20665;
        Mon, 24 Jun 2019 21:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561413575;
        bh=wkXd8LvsRDQsmIsQI1DMB/m6N5fb+f+VDdAigOle070=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FG9EtLCSkYGjdJmYxQbSShBk/IghxUE5O9kTJzVcelMAZzKAsdYFrsyxawgpty8ox
         vymL2hcpUMZLg3rLtDADZOh6FncBGexh2/l0jY+zGBavC04bRRsC9zKQYybDhrmKuA
         kaCU3FeX7BXum0WAQBJzzUM4Fw3XX/jEdMgXQttM=
Date:   Mon, 24 Jun 2019 14:59:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20190624145935.b9516f0316953057c76fff69@linux-foundation.org>
In-Reply-To: <20190624210043.13c924f1@canb.auug.org.au>
References: <20190624210043.13c924f1@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 21:00:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> mm/util.c: In function '__account_locked_vm':
> mm/util.c:372:2: error: implicit declaration of function 'lockdep_assert_held_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=implicit-function-declaration]
>   lockdep_assert_held_exclusive(&mm->mmap_sem);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   lockdep_assert_held_once
> cc1: some warnings being treated as errors
> 
> Caused by commit
> 
>   610509219f27 ("mm-add-account_locked_vm-utility-function-v3")
> 
> interacting with commit
> 
>   9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() -> lockdep_assert_held_write()")
> 
> from the tip tree.
> 
> I have applied the following merge fix patch.
> 
> ...
>
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -369,7 +369,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>  	unsigned long locked_vm, limit;
>  	int ret = 0;
>  
> -	lockdep_assert_held_exclusive(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_sem);
>  
>  	locked_vm = mm->locked_vm;
>  	if (inc) {

OK, thanks, I'll stage mm-add-account_locked_vm-utility-function.patch
behind linux-next and shall fix this up.

