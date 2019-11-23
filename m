Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A12C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 00:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29922067D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 00:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAFRx87W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfKWAed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:34:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37125 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 19:34:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id p24so4334630pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 16:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=Wc5BiZ4I36HRDEEesag6zOFOwEaj3z0DfK9Nrlush+M=;
        b=DAFRx87WKODf/taUcv5k3GFO0oVJuxdM0hqW2dr/FlpkY7X01nEEoYXCHuUiYfkweO
         xuInVbogrsuKkR8EYh0aRNgNGGJnzWDVyE6ZQ+KTdgIJqV3AFRRFkhu+0/XOLq4Hal6Z
         ajCWdNc3XxUYsgn0EGt1Ze91c8MzjiaEI2zGMNNfonWg/p7Q7YWLNOXFNpZFGY8kO+B5
         xTOwwcYcVTUZpc2wWUR8hWAjxE+rHRlsYmwWmddhEFPNNQj07mwkHCoNY5npl15+V22e
         2U1Q1M65y/usY/iclKE6/YOQvhjF1TqDsje3JAegdIAQXa6SfmrsDlCiepT3wC1Zoiep
         BCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=Wc5BiZ4I36HRDEEesag6zOFOwEaj3z0DfK9Nrlush+M=;
        b=lbNFy2B8WsJxDB5aBkXdA5ELRpxbGr50ui4hHLfTATOZcUTlL1BQRIyFL9c6+arh8u
         NksewLZV9zviIuFyM4w4L7b7YXKX8HbCwl9OHyO0hzYkYQkmM01wNRBnNbAAnIoR+iKC
         GL25x8ylMuabZKMnTwmFGn5UcrGfCt62kZJiF3rZ+5JmdRgEpcpe3S20+H8x2+vteg5a
         7pW2FuZa8+BLpufNlaecuoElbzQrFLbRE37a0UQJfM2FqyqdZOkKFh5FcacHeXshFV71
         JRSFJXwhd5phWi6qJv2yY8a5xWHCf9k0I/kqVSyAxBZ5wbx1taPatEdP6eiKA9/dm6T6
         6kdQ==
X-Gm-Message-State: APjAAAX0HATVh5aGlLEcw79nLbPuFvy84Lqi8D99NcOopct+TCHNUktL
        LrqPLBNRLzhf3+4G1TyrKBVymaaVgGU=
X-Google-Smtp-Source: APXvYqycGUwOGtI9grWjunlCYHSGXUm7Ws9eGxG4NRCjB1ejXFBbTbjFJ8i+ZHZ8PJptBniA/Nj0jg==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr21660060pfi.162.1574469272664;
        Fri, 22 Nov 2019 16:34:32 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id x186sm8700961pfx.105.2019.11.22.16.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 16:34:32 -0800 (PST)
Date:   Fri, 22 Nov 2019 16:34:32 -0800 (PST)
X-Google-Original-Date: Fri, 22 Nov 2019 16:34:08 PST (-0800)
Subject:     Re: [PATCH 0/2] riscv: defconfigs: enable debugging options 
In-Reply-To: <20191122225659.21876-1-paul.walmsley@sifive.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-a92b32ea-0365-407c-9569-1ebce2d3b37f@palmerdabbelt.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 14:56:57 PST (-0800), Paul Walmsley wrote:
> Enable more debugging options in the defconfig.  Debugfs is generally
> useful for everyone; the other options are intended to make it easier
> for developers and testers to catch problems earlier.
>
>
> - Paul
>
> Paul Walmsley (2):
>   riscv: defconfigs: enable debugfs
>   riscv: defconfigs: enable more debugging options
>
>  arch/riscv/configs/defconfig      | 24 ++++++++++++++++++++++++
>  arch/riscv/configs/rv32_defconfig | 24 ++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
>
> Kernel object size difference:
>    text	   data	    bss	    dec	    hex	filename
> 6665154	2132584	 312608	9110346	 8b034a	vmlinux.rv64.orig
> 6779347	2299448	 313600	9392395	 8f510b	vmlinux.rv64.patched
> 6445414	1797616	 255248	8498278	 81ac66	vmlinux.rv32.orig
> 6552029	1921996	 257448	8731473	 853b51	vmlinux.rv32.patched

Does it make sense to turn on some CONFIG_*_SELFTEST entries as well?  I know
I've found RISC-V bugs with ATOMIC64_SELFTEST before, but they do take a while
to run.  I just turned on 

    diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
    index 420a0dbef386..90001c3746cd 100644
    --- a/arch/riscv/configs/defconfig
    +++ b/arch/riscv/configs/defconfig
    @@ -100,4 +100,18 @@ CONFIG_9P_FS=y
     CONFIG_CRYPTO_USER_API_HASH=y
     CONFIG_CRYPTO_DEV_VIRTIO=y
     CONFIG_PRINTK_TIME=y
    +CONFIG_DEBUG_RT_MUTEXES=y
    +CONFIG_DEBUG_SPINLOCK=y
    +CONFIG_DEBUG_MUTEXES=y
    +CONFIG_DEBUG_RWSEMS=y
    +CONFIG_DEBUG_ATOMIC_SLEEP=y
    +CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
    +CONFIG_LOCK_TORTURE_TEST=y
    +CONFIG_WW_MUTEX_SELFTEST=y
    +CONFIG_RCU_PERF_TEST=y
    +CONFIG_RCU_TORTURE_TEST=y
     # CONFIG_RCU_TRACE is not set
    +CONFIG_PERCPU_TEST=m
    +CONFIG_ATOMIC64_SELFTEST=y
    +CONFIG_TEST_LKM=m
    +CONFIG_TEST_USER_COPY=m

as an experiment and OE looks like it's still functional, but it looks like the
lock torture stuff keeps running and the RCU torture can't run at the same
time.

Either way, this looks good to me!
