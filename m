Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7004C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B8A20685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555975450;
	bh=jksw00oY19cQm89K6k5lNRMIF3y+Sje0nNhmccBChhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SnXprOdOWr/srKpFUCW/hbtkdDFMTQniIZWgeqogO4RBT9YPm3Ft1NFuHXRKZOCyx
	 YkRI7TJ58r/ot168MDhOJ9icOqKg7YiQkZ/B0/ixCP7gzGtb0uzY9SD17sthzAjaJ4
	 tRtytsOtd6tYPvIFksPk6rYl0v+GVSlnyqnpoj04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfDVXYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:24:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfDVXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 19:24:08 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51D5FB09;
        Mon, 22 Apr 2019 23:24:07 +0000 (UTC)
Date:   Mon, 22 Apr 2019 16:24:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ali Saidi <alisaidi@amazon.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_elf: Move brk out of mmap when doing direct
 loader exec
Message-Id: <20190422162405.503d0d068b880f87dc7bc889@linux-foundation.org>
In-Reply-To: <20190422225727.GA21011@beast>
References: <20190422225727.GA21011@beast>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 15:57:27 -0700 Kees Cook <keescook@chromium.org> wrote:

> Commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE"),
> made changes in the rare case when the ELF loader was directly invoked
> (e.g to set a non-inheritable LD_LIBRARY_PATH, testing new versions of
> the loader), by moving into the mmap region to avoid both ET_EXEC and PIE
> binaries. This had the effect of also moving the brk region into mmap,
> which could lead to the stack and brk being arbitrarily close to each
> other. An unlucky process wouldn't get its requested stack size and stack
> allocations could end up scribbling on the heap.
>
> ...
>
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1131,16 +1131,18 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	current->mm->end_data = end_data;
>  	current->mm->start_stack = bprm->p;
>  
> -	/*
> -	 * When executing a loader directly (ET_DYN without Interp), move
> -	 * the brk area out of the mmap region (since it grows up, and may
> -	 * collide early with the stack growing down), and into the unused
> -	 * ELF_ET_DYN_BASE region.
> -	 */
> -	if (!interpreter)
> -		current->mm->brk = current->mm->start_brk = ELF_ET_DYN_BASE;

The above bit isn't there any more.  Here's what I queued:

--- a/fs/binfmt_elf.c~binfmt_elf-move-brk-out-of-mmap-when-doing-direct-loader-exec
+++ a/fs/binfmt_elf.c
@@ -1134,6 +1134,17 @@ out_free_interp:
 	current->mm->start_stack = bprm->p;
 
 	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+		/*
+		 * For architectures with ELF randomization, when executing
+		 * a loader directly (i.e. no interpreter listed in ELF
+		 * headers), move the brk area out of the mmap region
+		 * (since it grows up, and may collide early with the stack
+		 * growing down), and into the unused ELF_ET_DYN_BASE region.
+		 */
+		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) && !interpreter)
+			current->mm->brk = current->mm->start_brk =
+				ELF_ET_DYN_BASE;
+
 		current->mm->brk = current->mm->start_brk =
 			arch_randomize_brk(current->mm);
 #ifdef compat_brk_randomized
_

