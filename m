Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72505C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 11:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ED02073F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574593362;
	bh=0/yvSf42ay7lCMKPfChvbyAPrYRpgvyNPso6UpdwwaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wXpZoxucX042mrITjATp8/s7dtUgpLGR3Dqjsb8344G19U3VAvraJKMZCepTXqwU8
	 5/dG/DME2E/FnIQNe/Xl5zpzlpzCmv9nBEMHOYZijzoi7VqJOUybmlYATf9rGTondO
	 ZUP5nBmFwIBAFF/ad46BfQ+vGUiIETfh6+pLv+Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKXLCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 06:02:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41890 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfKXLCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 06:02:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id b18so13932424wrj.8;
        Sun, 24 Nov 2019 03:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2T7RRFPErosSbwjrbbw8iSP4bnBzM5uhxBucwjlDmc=;
        b=iQzfOlAjpeJIEyHmd0/r/0tVUQU3e71ID2x4YbsZKDEIN+4et773DDnrdgtUemrTKa
         +vhh1LvkOI+yrLCIpgNAvFLF4Ufu20TpeJLf7gmrDo+9DiDVFUs1TTScL2TNXjmcM0Ay
         4kHJH7RWRe3fke+q7IKeMo7gHa8kmW5w6I8wJlcNtSAOk6QeaPxplxeul95z0WMTD3yV
         sWCuhsjznAS6Cl28gg3fnxgYZuQyPkp76yk543fZrcyq9xOEmhpeJynzJj/6WTUafqLx
         UJhie8Jz90iep1vCRLDmE5riUCzct0ITdlj9W9GoFoPsN8hC5Bb+MYA0FG0NIm9z36r1
         x5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2T7RRFPErosSbwjrbbw8iSP4bnBzM5uhxBucwjlDmc=;
        b=bz0EhrehdOM3maRucMjVM4TwE5/F2oNzZPYqdtkaw65jcOVw2hAZFpCdr4/Py0FETJ
         kFjAU/RaxaKbT5yXlIzIckyjFOBtLGd0YkMlY3dLp1R4ENCeGRuKOP1sNM4GMpqNwtHq
         lkcoDEV+PuyxLSOnxRxc4INRZz6R7+1gqjpRJinHW0OXj4Bugt92ywl62vTEVY+jnPV6
         uSYe8RKhAuSZDT5FDNQbmZfOJoDQM4xWP/yQhxcKHZ12679EmRw15OvQCkdgDLtdraDJ
         cTpe+FeZ0OxUtd0mmlQjkVjMyDhnW0Wjlcuid8kz9EOkOUd5+btwt4mq8Zc+uqX29Vx1
         qoHg==
X-Gm-Message-State: APjAAAU5/whQXJazx1LhTC9oBskmzKHjnhFny45FcLcCUUXW7f0DVDP3
        0zBR2CSmfT1rwB5MEIvGUqsS0QFq
X-Google-Smtp-Source: APXvYqxgMd/MLBT1r0SE07UajO6Mm4TNLpoTKQ9CRCo1Sv1IY4Cl5vfl7D4b4WDnI3aZR75BVzdr6w==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr25802196wrc.175.1574593358116;
        Sun, 24 Nov 2019 03:02:38 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l4sm4619113wml.33.2019.11.24.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 03:02:37 -0800 (PST)
Date:   Sun, 24 Nov 2019 12:02:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: x86/iopl] x86/iopl: Restrict iopl() permission scope
Message-ID: <20191124110235.GA42804@gmail.com>
References: <157390508247.12247.14556309921021621273.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157390508247.12247.14556309921021621273.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/iopl branch of tip:
> 
> Commit-ID:     c8137ace56383688af911fea5934c71ad158135e
> Gitweb:        https://git.kernel.org/tip/c8137ace56383688af911fea5934c71ad158135e
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Mon, 11 Nov 2019 23:03:28 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Sat, 16 Nov 2019 11:24:05 +01:00
> 
> x86/iopl: Restrict iopl() permission scope
> 
> The access to the full I/O port range can be also provided by the TSS I/O
> bitmap, but that would require to copy 8k of data on scheduling in the
> task. As shown with the sched out optimization TSS.io_bitmap_base can be
> used to switch the incoming task to a preallocated I/O bitmap which has all
> bits zero, i.e. allows access to all I/O ports.
> 
> Implementing this allows to provide an iopl() emulation mode which restricts
> the IOPL level 3 permissions to I/O port access but removes the STI/CLI
> permission which is coming with the hardware IOPL mechansim.
> 
> Provide a config option to switch IOPL to emulation mode, make it the
> default and while at it also provide an option to disable IOPL completely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/Kconfig                        | 32 +++++++++-
>  arch/x86/include/asm/pgtable_32_types.h |  2 +-
>  arch/x86/include/asm/processor.h        | 28 ++++++--
>  arch/x86/kernel/cpu/common.c            |  5 +-
>  arch/x86/kernel/ioport.c                | 87 ++++++++++++++++--------
>  arch/x86/kernel/process.c               | 32 +++++----
>  6 files changed, 139 insertions(+), 47 deletions(-)

> --- a/arch/x86/include/asm/pgtable_32_types.h
> +++ b/arch/x86/include/asm/pgtable_32_types.h
> @@ -44,7 +44,7 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
>   * Define this here and validate with BUILD_BUG_ON() in pgtable_32.c
>   * to avoid include recursion hell
>   */
> -#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
> +#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 41)

Note that this commit has two (fortunately harmless) bugs:

 - On 32-bit kernels the actual size of 'struct cpu_entry_area' was, 
   before this commit, 38 pages - while CPU_ENTRY_AREA_PAGES was 40, i.e.
   it's a pre-existing bug.

 - This commit increases cpu_entry_area by *TWO* pages (the new 
   ->mapall[] ioperm array is 8k large), while CPU_ENTRY_AREA_PAGES is 
   only increased by +1 page - but this is harmless, because we already 
   had an accidental 'reserve' of pages.

 - The resulting CPU_ENTRY_AREA_PAGES of 41 pages is still 1 page higher 
   than the true size of 40 pages.

The reason why these bugs remained undiscovered was that they are 
harmless (too many pages allocated), and the assert that was supposed to 
check these values was buggy.

So I'd suggest not rebasing this commit - especially since fixing the 
value will trigger the buggy assert, but wanted to give a heads-up.

I'll send the fix patch with more details to x86/urgent separately - and 
on merging x86/urgent to x86/iopl in -tip I made the merge accurate, to 
resolve the resulting semantic conflict.

Thanks,

	Ingo
