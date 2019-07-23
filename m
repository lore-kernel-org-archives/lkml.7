Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59773C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2592E218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AaPTUtJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbfGWHpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:45:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34221 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbfGWHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:45:55 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so79875834iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BT0utqb6aDy4mLvXW1LBMi7UGN//r+QNpXUxBB/VbEE=;
        b=AaPTUtJRTF6jZOMTgWEyC6y2aRQEu2iFMZgbUh48TChZSvfo8V4ZeMuRkpge8V+yFV
         6guAYk3TlAedZIw6upGyuY05AEGNBJKVljzkhBr3mLiEjJpEecffW3fd9ucQQL5ylhZX
         Fz30AaNFhi8wGNfi8Rpr1lAipL1cWZXAHV5nZue0W6BKIaAM910r5pzzU9iekmbeYQL8
         bKEFzZcPw1w43YqJmFOU+Aq0JRMF8geTMWCDodpLFrfvtgoTKe5C7isW42JGjigDXPUP
         Vy2nI9Wtl2dFXIFe3qWGPd0Q9HfU9vG3Tk+f05nRGRa3kqATdOpTvgL4LWKJedhyjutu
         kv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BT0utqb6aDy4mLvXW1LBMi7UGN//r+QNpXUxBB/VbEE=;
        b=GwNv6NLdS1Y8YuEw7Eq0VtrjhElniV9muHSG/A8WqNVNdNJheHt0J3ZsgEyf+dZ0T/
         16IcFJn9rumPvmkPAVUKx5ErLzXrH4I7T5Cv+PjWy17hVkE//fN/gVBwAR9N3RMUX+VV
         LYSBfaFNHNhzzyaWIFLwyfb6xP972WhIS61QBmRa4dOo0MMTH9jVwylYV0qHvjpm+tk9
         IP2sN+uRDHtzK1XE4Nf631/6HsXtssK06l8AybnQ/7XvI+xc/cmydERPGBfp0hiVS0DC
         yucmiZWrI9fCYzYPQyhTGPp8u9Hj2ezhWLw31D2/6GVvuq/cKKhLNkp191MwEIZX9l7D
         ZfFg==
X-Gm-Message-State: APjAAAWju/2jM2uHF3GRF0mhh9/suD/B2YWBWLtS/7KeHyZYZ6nUH7Uv
        /rqd2rF5tWop6Yu98bHNWtjc3BZ+AOkoYDR6Ttw=
X-Google-Smtp-Source: APXvYqyNe2NrO6fhmK0Lv25MrmKSYiYlqvOZkRf4p1ip6K8JbOfSnh7cMLrBf9IoRChrcaKJDEEfQxcy9GNOymgNOlo=
X-Received: by 2002:a02:37d6:: with SMTP id r205mr76200009jar.57.1563867954303;
 Tue, 23 Jul 2019 00:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAMRc=MdaLPcy4fJOEbcXAriHLHrXUZD6Bh5X2Eq+2OBvcC4cOQ@mail.gmail.com>
 <20190722161006.GA4297@linux-8ccs>
In-Reply-To: <20190722161006.GA4297@linux-8ccs>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 23 Jul 2019 09:45:43 +0200
Message-ID: <CAMRc=MezKpDU0urpMMuqUCqDBnmHBooVdry4jqUeffr4V7cXFQ@mail.gmail.com>
Subject: Re: [v5.3-rc1 regression] Hitting a kernel BUG() when trying to load
 a module on DaVinci SoC
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Jian Cheng <cj.chengjian@huawei.com>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 22 lip 2019 o 18:10 Jessica Yu <jeyu@kernel.org> napisa=C5=82(a):
>
> +++ Bartosz Golaszewski [22/07/19 14:12 +0200]:
> >Hi,
> >
> >with v5.3-rc1 I'm hitting the following BUG() when trying to load the
> >gpio-backlight module:
> >
> >kernel BUG at kernel/module.c:1919!
> >Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
> >Modules linked in:
> >CPU: 0 PID: 1 Comm: systemd Tainted: G        W
> >5.2.0-rc2-00005-g7dabaa5ce05a #19
> >Hardware name: DaVinci DA850/OMAP-L138/AM18x EVM
> >PC is at frob_text.constprop.16+0x2c/0x34
> >LR is at load_module+0x1888/0x21b4
> >pc : [<c0081bbc>]    lr : [<c0083c4c>]    psr: 20000013
> >sp : c6837e58  ip : c6b4fa80  fp : bf00574c
> >r10: c0601008  r9 : bf005740  r8 : c0493e38
> >r7 : c00807f8  r6 : 00000000  r5 : 00000001  r4 : c6837f38
> >r3 : 00000fff  r2 : bf000000  r1 : 00004b80  r0 : bf005818
> >Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> >Control: 0005317f  Table: c6b78000  DAC: 00000051
> >Process systemd (pid: 1, stack limit =3D 0x(ptrval))
> >Stack: (0xc6837e58 to 0xc6838000)
> >7e40:                                                       bf005740 c64=
92a90
> >7e60: 00000001 c6bf5788 00000003 c6837f38 bf0058c0 bf0058a8 bf00a495 c04=
93e38
> >7e80: 00000000 c05368c0 00000001 00000000 c0580030 c0574b28 00000000 000=
00000
> >7ea0: 00000000 00000000 00000000 00000000 6e72656b 00006c65 00000000 000=
00000
> >7ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000=
00000
> >7ee0: 00000000 00000000 00000000 aefb2bb8 7fffffff c0601008 00000000 000=
00004
> >7f00: b6cee714 c00091e4 c6836000 00000000 005bc668 c00847b0 7fffffff 000=
00000
> >7f20: 00000003 00000000 0000b2d0 c884e000 0000b2d0 00000000 c8852dcb c88=
533a0
> >7f40: c884e000 0000b2d0 c8858cb8 c8858b34 c88568d4 000058c0 00006190 000=
023b8
> >7f60: 00006713 00000000 00000000 00000000 000023a8 00000024 00000025 000=
00019
> >7f80: 0000001d 00000011 00000000 aefb2bb8 00000000 00000000 00000000 000=
00000
> >7fa0: 0000017b c0009000 00000000 00000000 00000004 b6cee714 00000000 000=
00000
> >7fc0: 00000000 00000000 00000000 0000017b 00000000 00000000 00000001 005=
bc668
> >7fe0: be907b00 be907af0 b6ce66b0 b6c3fac0 60000010 00000004 00000000 000=
00000
> >[<c0081bbc>] (frob_text.constprop.16) from [<c0083c4c>]
> >(load_module+0x1888/0x21b4)
> >[<c0083c4c>] (load_module) from [<c00847b0>] (sys_finit_module+0xbc/0xdc=
)
> >[<c00847b0>] (sys_finit_module) from [<c0009000>] (ret_fast_syscall+0x0/=
0x50)
> >Exception stack(0xc6837fa8 to 0xc6837ff0)
> >7fa0:                   00000000 00000000 00000004 b6cee714 00000000 000=
00000
> >7fc0: 00000000 00000000 00000000 0000017b 00000000 00000000 00000001 005=
bc668
> >7fe0: be907b00 be907af0 b6ce66b0 b6c3fac0
> >Code: e1a01621 e1a00002 eafe4531 e7f001f2 (e7f001f2)
> >---[ end trace 2cbefb0005882c52 ]---
> >Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000=
b
> >---[ end Kernel panic - not syncing: Attempted to kill init!
> >exitcode=3D0x0000000b ]---
> >
> >I bisected it to commit 06bd260e836d ("modules: fix BUG when load
> >module with rodata=3Dn") with commit 7dabaa5ce05a ("modules: fix compile
> >error if don't have strict module rwx") on top to make it build.
> >
> >Let me know if you need me to provide more info.
> >
> >Best regards,
> >Bartosz Golaszewski
>
> Hi Bartosz,
>
> Thanks for reporting this, I was able to reproduce this on qemu.
>
> This is due to hitting the BUG_ON() in frob_text() due to layout->base
> and/or layout->text_size not being page-aligned. These values are
> always page-aligned when CONFIG_STRICT_MODULE_RWX=3Dy, but in commit
> 2eef1399a86 ("modules: fix BUG when load module with rodata=3Dn"), the
> frob_text()+set_memory_x() calls got moved *outside* of the
> STRICT_MODULE_RWX block since some arches (like x86 and arm64)
> allocate non-executable module memory via module_alloc(), so naturally
> the module text needed to be made executable at a later stage of
> load_module(), regardless of whether STRICT_MODULE_RWX is set or not.
> In your case, you must've had CONFIG_STRICT_MODULE_RWX=3Dn and so we
> were calling frob_text() with non-page-aligned values, triggering the
> BUG_ON().
>
> In any case, could you please try and see if the following patch fixes
> the issue for you?
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 5933395af9a0..cd8df516666d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -64,14 +64,9 @@
>
>  /*
>   * Modules' sections will be aligned on page boundaries
> - * to ensure complete separation of code and data, but
> - * only when CONFIG_STRICT_MODULE_RWX=3Dy
> + * to ensure complete separation of code and data
>   */
> -#ifdef CONFIG_STRICT_MODULE_RWX
>  # define debug_align(X) ALIGN(X, PAGE_SIZE)
> -#else
> -# define debug_align(X) (X)
> -#endif
>
>  /* If this is set, the section belongs in the init part of the module */
>  #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))

That helps, thanks!

Please Cc me on the actual submitted patch.

Bart
