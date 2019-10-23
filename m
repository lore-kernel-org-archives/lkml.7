Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CAC207FA
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="yLN/ddNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfJWDYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:24:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50702 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfJWDYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:24:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id q13so9405437wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 20:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoiwGNtU0nAEwpqhaQ40WOeNzy+Ug1D1A+7yaqwVZpE=;
        b=yLN/ddNFMfFhvPjBZjTwKqoSwWn/DGdu7QUqpRbP8p9LI1mFK7KIlnrmHTLH01uos+
         X0D82O2AYz2IOS9/+jyeTWKP9FcdB/e3uP6Z42DJbWTV6MQr7OkuzYq3kjk1RuEoOSOC
         eNv3Qo7LIIG+xOTLtiUJ+6EnRnxxTFzlGvAGBHGPUMmYKgEhFhfnbJFhQI1rQPdG1OiE
         d96LttnBqOssIU7NYDQc5/uF1ZD1QnrxEj/9dMaee9uPD4JB1Vjxwda0O5TfOCTW1vBp
         YBogOBQGt8j3ddQYskXwVEGM3mtoVnSL2pbeaIDRQvrjheAM3nxeNfolhNL/blZzk/9l
         TX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoiwGNtU0nAEwpqhaQ40WOeNzy+Ug1D1A+7yaqwVZpE=;
        b=BcXE0W73TpoM4OcN+LnNmPyKLRo22ZZDfFfaTFJKCatwYYQqciZmHbsyEqJt1GjFRS
         V5Re3g7X8DcBjoZOZjveTmIeCaiEQDJ4kSWE+SNShO+nnNUuneWsmfgUnjpE+dTdQh+c
         1tiohX4B08cZ8y78r0x8/+Iri9DdQ7B5vWz1x+eLZT9K3dANZKayUbJc/u7LEzErgNEc
         o34/IgA6v7P7q1qPJpf/H5ZjViKAw8Mm6OyNxI7PoaXGDczrJoWzLC/00DgohyvkX6Yq
         VsZBpehp97vlAhnLeOHg/VuGI5Ec4kGJOM3IgDNC0Xf8HKsmxjkqEZ7J7GUnn6bBgily
         B0iA==
X-Gm-Message-State: APjAAAUTP7qTx6aet/7iP2FSR/gu5TotvnzK60TT4zMmLuL7q+4vsaqM
        y2TSie8cJhr0C4hbX4du2dS9FCpV2X5BSxKEGoLsuA==
X-Google-Smtp-Source: APXvYqy5Sx8ql4wbo4/WWnaIsB4nlRntpQJU9X6Eo8IJsbZIxg84bb2+RxjkQXSTZmod8Omr2TCvJvSRKbaedXpuwn0=
X-Received: by 2002:a1c:9695:: with SMTP id y143mr5676311wmd.103.1571801071659;
 Tue, 22 Oct 2019 20:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190925063706.56175-3-anup.patel@wdc.com> <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>
 <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>
 <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
 <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com> <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 23 Oct 2019 08:54:19 +0530
Message-ID: <CAAhSdy3KccuzC0pV6Jy_diLwkdgb=SdHBQnsSoGrgpu6g7TCQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 6:37 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Tue, 22 Oct 2019, Alistair Francis wrote:
>
> > I think it makese sense for this to go into Linux first.
> >
> > The QEMU patches are going to be accepted, just some nit picking to do
> > first :)
> >
> > After that we have to wait for a PR and then a QEMU release until most
> > people will see the change in QEMU. In that time Linux 5.4 will be
> > released, if this can make it into 5.4 then everyone using 5.4 will get
> > the new RTC as soon as they upgrade QEMU (QEMU provides the device
> > tree). If this has to wait until QEMU has support then it won't be
> > supported for users until even later.
> >
> > Users are generally slow to update kernels (buildroot is still using
> > 5.1 by default for example) so the sooner changes like this go in the
> > better.
>
> The defconfigs are really just for kernel developers.  We expect users to
> define their own Kconfigs for their own needs.
>
> If using the Goldfish code really is what we all want to do (see below),
> then the kernel patch that should go in right away -- which also has no
> dependence on what QEMU does -- would be the first patch of this series:
>
> https://lore.kernel.org/linux-riscv/20190925063706.56175-2-anup.patel@wdc.com/
>
> And that should go in via whoever is maintaining the Goldfish driver, not
> the RISC-V tree.  (It looks like drivers/platform/goldfish is completely
> unmaintained - a red flag! - so probably someone needs to persuade Greg or
> Andrew to take it.)

GregKH has already queued this for Linux-5.5 and you can see this
commit present in linux-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/platform/goldfish?h=next-20191022

>
> Incidentally, just looking at drivers/platform/goldfish, that driver seems
> to be some sort of Google-specific RPC driver.  Are you all really sure

Nopes, it's not RPC driver. In fact, all Goldfish virtual platform devices
are MMIO devices.

> you want to enable that just for an RTC?  Seems like overkill - there are
> much simpler RTCs out there.

No, it's not overkill. All Goldfish virtual platform devices are quite simple
MMIO devices having bare minimum registers required for device
functioning.

The problem is VirtIO spec does not define any RTC device so instead of
inventing our own virtual RTC device we re-use RTC device defined in
Goldfish virtual platform for QEMU virt machine. This way we can re-use
the Linux Goldfish RTC driver.

BTW, I will send-out QEMU Goldfish RTC patches today or tomorrow
addressing nit comments from Alistair.

Regards,
Anup
