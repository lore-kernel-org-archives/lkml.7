Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B25CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D732053B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx7QfTuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfJ1HBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:01:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35126 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfJ1HBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:01:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id l3so2651962qtp.2;
        Mon, 28 Oct 2019 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B8JVLFtcc9aWg+tsverFb6TLrQIPxF39zUE7VKNDhoI=;
        b=hx7QfTuEid1Hcj9TC3rALkWx+Gku6XnXWmunhXazNO71XEThreP9UWB8Bbni20gYiM
         sEkQUdjWgoiI7PAdzADqeTbaJQyGZFXJVnSmWMm/RXJ6lqqiQKtAdjTPw7vkmG3j7LtP
         0XvfwbTK0m2QKX3LHUgqxDvmEK30kijN7fm2IYP5qloO/XJJW9dwQxAcm837u18moSd5
         Tosf26t4ivUB2P4ACk8BPI2ezXkAUGMwAr48Pc2+hqdGVVEk8XtGwUK+basUtTCTNqi4
         EQza5taJZUTXnWSASmu5uDmURdnonkMDQXIhakgP97IqoVztrIelaMPK+gWTwQLlt28g
         e7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B8JVLFtcc9aWg+tsverFb6TLrQIPxF39zUE7VKNDhoI=;
        b=NB7yPxi5TlntLHLcjUVWlkcdZi9dZTP8j/ALIei2QUIJTLvNW/p4nVDd4FNRKIAccd
         zDh917kto9AXhoawwXyYdQtbgyBD6p1yMY2Pj/OdKuI30vhq1M8rL3YTOFPES36LRVAz
         IBdSalaJADLUU62SIhHk/dph87IjXc7j8afIUipom8r3oOr1aOu4u+sg0OUTr/LgdpBE
         ZrJjj9jNIw2fO84ZyVefez7hGBj+xB7Etd5v955uIeTEb6XiI0Wpd1+wPn4QuJLpzTO1
         UdxhaQKGWcw7g9DGTGfS+P+qrq0WvQo3JE3q2HDGBMeyvzsaS+O5afDFv9vgf2/P7Y4Z
         UOfQ==
X-Gm-Message-State: APjAAAXgqc5++ZX/87boFB71Z2hBPN/dbpyjrhxf84fmdEpXFarp8DGU
        RulI3FDcdEWJZ7918moEp7labPAufIr2s4MtTDc=
X-Google-Smtp-Source: APXvYqx2RYAkGHTJdZoVZBWsqyraT9MFsCxp3j+m5VBkKsDI1NziE3k2TjQbNslMx3rA0R2JsmQoQxMDbxfR3cIGwkA=
X-Received: by 2002:ac8:542:: with SMTP id c2mr16290854qth.338.1572246110227;
 Mon, 28 Oct 2019 00:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191028024101.26655-1-nickhu@andestech.com>
In-Reply-To: <20191028024101.26655-1-nickhu@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 28 Oct 2019 15:01:14 +0800
Message-ID: <CAEbi=3cs1h4pOU9TcP3JCp921Jj4qYiGtqWCkJ2VKby0YFbbXg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] KASAN support for RISC-V
To:     Nick Hu <nickhu@andestech.com>,
        Greentime Hu <greentime.hu@sifive.com>
Cc:     aryabinin@virtuozzo.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh@linuxfoundation.org, alankao@andestech.com,
        Anup.Patel@wdc.com, atish.patra@wdc.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Hu <nickhu@andestech.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> KASAN is an important runtime memory debugging feature in linux kernel wh=
ich can
> detect use-after-free and out-of-bounds problems.
>
> Changes in v2:
>   - Remove the porting of memmove and exclude the check instead.
>   - Fix some code noted by Christoph Hellwig
>
> Changes in v3:
>   - Update the KASAN documentation to mention that riscv is supported.
>
> Changes in v4:
>   - Correct the commit log
>   - Fix the bug reported by Greentime Hu
>
> Nick Hu (3):
>   kasan: No KASAN's memmove check if archs don't have it.
>   riscv: Add KASAN support
>   kasan: Add riscv to KASAN documentation.
>
>  Documentation/dev-tools/kasan.rst   |   4 +-
>  arch/riscv/Kconfig                  |   1 +
>  arch/riscv/include/asm/kasan.h      |  27 ++++++++
>  arch/riscv/include/asm/pgtable-64.h |   5 ++
>  arch/riscv/include/asm/string.h     |   9 +++
>  arch/riscv/kernel/head.S            |   3 +
>  arch/riscv/kernel/riscv_ksyms.c     |   2 +
>  arch/riscv/kernel/setup.c           |   5 ++
>  arch/riscv/kernel/vmlinux.lds.S     |   1 +
>  arch/riscv/lib/memcpy.S             |   5 +-
>  arch/riscv/lib/memset.S             |   5 +-
>  arch/riscv/mm/Makefile              |   6 ++
>  arch/riscv/mm/kasan_init.c          | 104 ++++++++++++++++++++++++++++
>  mm/kasan/common.c                   |   2 +
>  14 files changed, 173 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/include/asm/kasan.h
>  create mode 100644 arch/riscv/mm/kasan_init.c
>
Hi Nick,

I have tested KASAN feature with test_kasan.ko based on commit
cd9e72b80090a8cd7d84a47a30a06fa92ff277d1 (tag: riscv/for-v5.4-rc3) and
it passed in Qemu and Unleashed board.
Thank you for fixing the bug. :)

Tested-by: Greentime Hu <greentime.hu@sifive.com>
