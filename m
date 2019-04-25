Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BCC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D35B20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YJSdfZ7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbfDYURk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:17:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33391 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfDYURk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:17:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so484509pfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5fkf5yKfz2Ypcm+PBwoO3dAoRYLWoAtz23trESpGGa0=;
        b=YJSdfZ7KObgzWpPiLcJ1+7fQSIsg22kv3cqhiYUZCSpjc4Xpc8Z4yKDa7UfFm9D9kk
         BzeWIv/TIWmq5V9kwbvt5R9psk0uWVm+vlSpZneZhc9QWoyAz0PcCS1hd2019KdBHOSk
         ucVeHDk+O98AhNMR+YOx0Pt3Y30v/gC1qKEVU3dhRzvpVnNTugYV4qq2LjtR/rcRQ349
         ovbq0OmTpLoKm3xM1czjkwrBMoFz3s2KrK0mm3Oyz6RbZ1EudrdToj2HdLoFWHPzOkwm
         JagIkg+VSEwSTO7crj45WZ6l80s4vcnyDfpnpTOcA/8d/C1gdUdGGh3STPrAVHDBFVzM
         6H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5fkf5yKfz2Ypcm+PBwoO3dAoRYLWoAtz23trESpGGa0=;
        b=siQZlotDcmmg3j/Sc7/QoIa2FMacPPd8fBo34VzVZBLPceZHJqk9xeWBG+YUoFOGPF
         Z1E1EqoRpUp6UcniArFK07U9ujLgF3JOcYvK0xXMI7R4ygfDsnmMR3E4lXRBA3uYw6mi
         cTJ540h1a68pHkQszU+78etIi/grFxVywGiOF0tXai0Dk8cAGtpOTM2BHRMk66IGpITE
         hgsGCe+HfjTvo3q58jhrJ055ZtsDzNG2uduHwQHXinaZfWx+o7ng/YeYfzHgJVyUsZib
         T4oVlY+aoIWmeoZZ+kF/EBfqAhFdZCu+H1bU4BfgLpkiJ6bA4C5SWwcDlrrpp2mNNUco
         GhPA==
X-Gm-Message-State: APjAAAUssLr0bLbZ6HwXlGxaEEul46DilpLpowH1CC1PAurvdjScpW38
        mIZJPICJQNacTeVLTsPWX6C4cIPu3AY=
X-Google-Smtp-Source: APXvYqyxgxOQakakHtjr/zCjeQs5Vra+7CYxhqgReW+/b2m/YCR5eDf4DmbT/8k6K9/zbwJ1ByjJ3g==
X-Received: by 2002:a63:500f:: with SMTP id e15mr39264150pgb.198.1556223458820;
        Thu, 25 Apr 2019 13:17:38 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id a6sm49638589pgd.67.2019.04.25.13.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 13:17:37 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:17:37 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 13:13:01 PDT (-0700)
Subject:     Re: [1/3] x86: Update DEBUG_TLBFLUSH options description.
In-Reply-To: <20190410224449.10877-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, bp@alien8.de,
        gary@garyguo.net, hpa@zytor.com, mingo@redhat.com,
        linux-riscv@lists.infradead.org, luc.vanoostenryck@gmail.com,
        tglx@linutronix.de,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-4767a1c0-439a-4092-ba98-ec388d714a10@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 15:44:47 PDT (-0700), atish.patra@wdc.com wrote:
> CONFIG_DEBUG_TLBFLUSH was added in 'commit 3df3212f9722 ("x86/tlb: add
> tlb_flushall_shift knob into debugfs")' to support tlb_flushall_shift
> knob. The knob was removed in 'commit e9f4e0a9fe27 ("x86/mm: Rip out
> complicated, out-of-date, buggy TLB flushing")'.  However, the debug
> option was never removed from Kconfig. It was reused in commit
> '9824cf9753ec ("mm: vmstats: tlb flush counters")' but the commit text was
> never updated accordingly.
>
> Update the Kconfig option description as per its current usage.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/x86/Kconfig.debug | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index 15d0fbe27872..c1a48d4ffebb 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -125,21 +125,12 @@ config DOUBLEFAULT
>  	  hair.
>
>  config DEBUG_TLBFLUSH
> -	bool "Set upper limit of TLB entries to flush one-by-one"
> +	bool "Save tlb flush statstics to vmstat"
>  	depends on DEBUG_KERNEL
>  	---help---
>
> -	X86-only for now.
> -
> -	This option allows the user to tune the amount of TLB entries the
> -	kernel flushes one-by-one instead of doing a full TLB flush. In
> -	certain situations, the former is cheaper. This is controlled by the
> -	tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
> -	to -1, the code flushes the whole TLB unconditionally. Otherwise,
> -	for positive values of it, the kernel will use single TLB entry
> -	invalidating instructions according to the following formula:
> -
> -	flush_entries <= active_tlb_entries / 2^tlb_flushall_shift
> +	Add tlbflush statstics to vmstat. It is really helpful understand tlbflush
> +	performance and behavior. It should be enabled only for debugging purpose.
>
>  	If in doubt, say "N".

Reviewed-by: Palmer Dabbelt <palmer@sifivee.com>

I'm not going to take this via my tree, but I'll look into the next two.
