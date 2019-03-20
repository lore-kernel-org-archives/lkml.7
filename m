Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEB7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCEC218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EAOjxP6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfCTUs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:48:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36325 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:48:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id t206so2992163oib.3;
        Wed, 20 Mar 2019 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkf20fehmYLH1YP5jLWlVRh0irPw1QZbgsIQvR8Hnag=;
        b=EAOjxP6lykTvlsBncOWYV1Rg5YLZP0ouoSC51dlyQGcNnuhNpJpTxcxKh2vuk8OXPG
         eu5otKNktAl57mo+KsHPBrbUDtGFkkxFZs4Qiuh/49dPnefhTNV8qGTf3YE0gdpMhGMV
         LBYEKlD9M4pkm6mM0WrD2h3uuxubJldxkoYZzvpdoYRr32Ek5mWvsFgJDpwwQ+rGC8cm
         wMukqTlw1Ychw1ZeGgeKyTYLptPO70AdizUFx/hpsFI4PCYqGefIEgekcGXcameQonDg
         7qojkrJ00v/Kpk5h3TXJk71zjfrG27tEnQC4eaE6/pAEtvIgUKXPPKJrzHhF0pYlEehS
         Xvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkf20fehmYLH1YP5jLWlVRh0irPw1QZbgsIQvR8Hnag=;
        b=mz1Ux9sl7SpJD4eD15oGmR+sGRPG/ISGl2HzKn+bugGfCSA9RhsfXDqaF+Lv7nIyIp
         fUmP+7esH3DHKSUC7omPxYKZc7xEO5f3zg3AGkBX1P3YUNJsRdP4/W/vv82s9+bHAGxB
         zd8CAFPLyElm7XMGj9qFduuMeVknaD79EZxIlEzR6QsA9SvZdcv2TiE9st9/hMs30BLf
         tlYmWb/yiu3X3CcFt2BFFSDwLY2axP4mClt0ERa013AiKpIeAELwl/BYga9DkOjlZeXZ
         YeJ2POCDq/PoVSmyRXjJsQQjDjTg17M/4BnPc2+OEU8ebhxK/E0L2L3angIaEX1qu5y2
         gJLw==
X-Gm-Message-State: APjAAAVsA9JvwURDIrF0A4chO26/AS+dOuJ6s4pdPkSjFIhR46UX1OUx
        Xwho3OvtOUkYRnzpYPj2+HBEn1kInxiTMQ6r778=
X-Google-Smtp-Source: APXvYqzihIMVVRCn9dzb8ELnlf1ptftrwD2n1QDCQys2LFhxcidQERbvWaYi27RBN/CNc92MCTIDDz9a9IxcuBX3Z5U=
X-Received: by 2002:a54:4e02:: with SMTP id a2mr6732386oiy.140.1553114907404;
 Wed, 20 Mar 2019 13:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
 <98776767-c4d7-1207-6d42-97105f289bec@amlogic.com> <CAFBinCC7P40sqrDGTuM8M=jVOFTgZLDUK6rGdNpigFoepyCASw@mail.gmail.com>
 <20190307140959.10092d45@xps13> <ccb95e75-e62f-c510-cabd-853481f77fc8@amlogic.com>
 <CAFBinCBd=dOZjv4KEDY9ODOONDO=WtaBqAMRi_a+gH3_iZEAHQ@mail.gmail.com>
 <CAFBinCA7LLK6K3ZqauJy2N-z5-kTfuTztmoSQ=Bk4A5Xagxddw@mail.gmail.com> <8134890a-457d-7803-01a4-1832f925f65f@amlogic.com>
In-Reply-To: <8134890a-457d-7803-01a4-1832f925f65f@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 20 Mar 2019 21:48:16 +0100
Message-ID: <CAFBinCBfkr-yyR4Vbd1HVmXVCOKuK-Kw1HKz4SMt9G3eA49HQQ@mail.gmail.com>
Subject: Re: [RFC PATCH nand-next 0/2] meson-nand: support for older SoCs
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Wed, Mar 20, 2019 at 4:32 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hi Martin,
>
> Thanks for your time.
> On 2019/3/20 4:27, Martin Blumenstingl wrote:
> > Hello Liang,
> >
> > On Sat, Mar 16, 2019 at 11:55 AM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > [...]
> >>> Martin, Now i am not sure whether NFC driver leads to kernel panic when
> >>> calling kmem_cache_alloc_trace.
> >> thank you for confirming that it works for you on GXL
> >>
> >> I'm not sure that this is a NFC driver problem.
> >> after enabling CONFIG_SLAB_FREELIST_HARDENED in my kernel config the
> >> crash moves. it's now crashing in slub.c's kfree() at
> >> BUG_ON(!PageCompound(page));
> > I added some debug prints in meson_nfc_read_buf() to get some details
> > about the info buffer before the crash,
> > format is: meson_nfc_read_buf <virtual address> <physical address>
> >
> > during my first test three different addresses are used:
> > - meson_nfc_read_buf e9e6c640 0x29e6c640 (works fine)
> > - meson_nfc_read_buf e9e6c680 0x29e6c680 (works fine)
> > - meson_nfc_read_buf ee39a34b 0x2e39a34b (crashes during kfree)
> >
> > so I tried playing around with the allocation size (see the attached
> > patch) and changed it to:
> >    kzalloc(PER_INFO_BYTE + 64, GFP_KERNEL)
> > this results in the following addresses being used:
> > - meson_nfc_read_buf e9ea4280 0x29ea4280 (works fine)
> > - meson_nfc_read_buf e9ea4300 0x29ea4300 (works fine)
> > (there is no crash anymore)
> >
> > Liang, are there any special requirements on the "info address" like
> > the alignment?
> It must be 4 bytes alignment. i have met it previously when debugging
> NFC driver on AXG platform, but it is not specified on spec. Now i am
> confused that how to get the no aligned address "xe39a34b" when using
> kmalloc; i think it should return the aligned address. doesn't it?
thank you for confirming the 4-byte alignment requirement!
I have no explanation for the unaligned address returned by kzalloc().
I'll ask on the linux-mm mailing list if they have a hint why this
happens.

> > also do you know why the PER_INFO_BYTE buffer is allocated dynamically
> > in meson_nfc_read_buf() instead of allocating it at initialization?
> > I'm not saying that it should be changed! I'm curious because there's
> > per-meson_nfc_nand_chip info and data buffers which are allocated at
> > initialization time.
> > NAND scan or initialization is divided into three stages:
> nand_scan_ident->nand_attach->nand_scan_tail. info and data buffer which
> depend on the result of nand_scan_ident are allocated on nand_attach; so
> nand_scan_ident can not use the info buffer on meson_nfc_nand_chip.
thank you for the explanation!

> Allocating a fixed size info buffer before nand_scan_ident and attach it
> on the struct meson_nfc; Or considering not use dma for reading data
> less than 8 bytes. Both can reduce kmalloc and kfree calling. Thanks.
both suggestions sound reasonable.
however, I will search for the root cause of the unaligned address
first before changing the Meson NFC driver.

[...]
> > [    2.227374] ------------[ cut here ]------------
> > [    2.231968] WARNING: CPU: 1 PID: 1 at
> > drivers/mtd/nand/raw/nand_base.c:5503 nand_scan_with_ids+0x1718/0x171c
> > [    2.241760] No oob scheme defined for oobsize 1280
> > ...
> > (the "No oob scheme defined for oobsize 1280" message is expected)
> >
> miss mtd_set_ooblayout(mtd, &meson_ooblayout_ops) on function
> meson_nand_attach_chip.
thank you for the suggestion. I didn't have time to test this on my
board yet but I'll let you know about my results during the weekend.
Does the missing mtd_set_ooblayout() call also affect GXL or AXG boards?


Regards
Martin
