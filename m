Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B6EC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB3D20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djkt6tnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfFROFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:05:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45714 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFROFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:05:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so14090513wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qHqhUTLPLAeUp/D+WrLyXnpz1H1Jll7QCXTM4rdBnU=;
        b=djkt6tnmuZedsgQ4v+Rua7yfQcRyCI0RbFda0KhvSR/oADzdiA/209ohNfhcVRf8d6
         lBE9K/fJZ8A/ZxP0jl48u8DqygtjLk6pPcX8AUimocdYXLXQw2RJnr38R2XKwe/o6X9N
         ZOamdY9l71DGHUPX8V3uIZCrEbLY+wqRqK7B1FvRUTZM/MkMpzxXqA7hgrkn5Vv+p3o/
         2i+Q5LM8XfqFHVaM1HEQ/GwNCw/9/FMpfSh9bxU2w3XRUBG016B+1xnhdb43B8UsSRqy
         +fvmLZDCETQ8DJLKlkJh49O4rQZNrKvjfVhSeSVPO8KLHJgxbRRnFB65V8aEhN9ws1tS
         SjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qHqhUTLPLAeUp/D+WrLyXnpz1H1Jll7QCXTM4rdBnU=;
        b=e/gpKMAEOlU/KLHbphgXnWvyPLXLAh9zTrt3/xzP8mJa4PgXlueM4UO1UaVhvAeZdH
         n8Sf1rlhvTCQYx6Ge1AoSaQXjQW0X34zo5TlYHMNQosn1TqayGya3dee44BcyzoV8HRQ
         92co6KekaJw+UbOr4fYkItGyXP6hf8yI5HRYBi1cDs+OHVk2V6D3v98mExZEgDYTlb5p
         IR1yx7WCM90f8uw16maXfns9detsUPzPc5b+44viQM9roMqrbB2ooLF4vLTvDNFZk9nS
         tJlzAg5fddidIdriWfVBVrEsqxw8ierqU1baahdKpiEodZhYxZidabhcLemULOUM1EV6
         H2LA==
X-Gm-Message-State: APjAAAV3PHLJJNj3X201CWzKt4fcuTugu97NHCiE7bI+cH/wdklCQd9S
        x+oVDKqzcLafUFmPl005J144Wi4FY1eC+N4nqrqHYw==
X-Google-Smtp-Source: APXvYqweODXawSwtgymTZRrJNdMT45q8SqezxZPypJ8zBOLy843m58QTD1p0JxHjbascNuxyphfbzEeuTcKrS6urlOY=
X-Received: by 2002:adf:90c3:: with SMTP id i61mr63288158wri.48.1560866751639;
 Tue, 18 Jun 2019 07:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
 <1560169080-27134-15-git-send-email-yong.wu@mediatek.com> <CAAFQd5A5GUn1Zq1xF2_2V0MReNPd5bra2F=nquvodSAZUua5AQ@mail.gmail.com>
 <1560859743.8082.23.camel@mhfsdcap03>
In-Reply-To: <1560859743.8082.23.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@google.com>
Date:   Tue, 18 Jun 2019 23:05:39 +0900
Message-ID: <CAAFQd5B8MiMA_OCUJ5HRmC5SA2772HF-rBGK0aZcKoWscOzOog@mail.gmail.com>
Subject: Re: [PATCH v7 14/21] iommu/mediatek: Add mmu1 support
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <yingjoe.chen@mediatek.com>, anan.sun@mediatek.com,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 9:09 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Tue, 2019-06-18 at 15:19 +0900, Tomasz Figa wrote:
> > On Mon, Jun 10, 2019 at 9:21 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > Normally the M4U HW connect EMI with smi. the diagram is like below:
> > >               EMI
> > >                |
> > >               M4U
> > >                |
> > >             smi-common
> > >                |
> > >        -----------------
> > >        |    |    |     |    ...
> > >     larb0 larb1  larb2 larb3
> > >
> > > Actually there are 2 mmu cells in the M4U HW, like this diagram:
> > >
> > >               EMI
> > >            ---------
> > >             |     |
> > >            mmu0  mmu1     <- M4U
> > >             |     |
> > >            ---------
> > >                |
> > >             smi-common
> > >                |
> > >        -----------------
> > >        |    |    |     |    ...
> > >     larb0 larb1  larb2 larb3
> > >
> > > This patch add support for mmu1. In order to get better performance,
> > > we could adjust some larbs go to mmu1 while the others still go to
> > > mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
> > >
> > > mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> > > value of that register is 0 which means all the larbs go to mmu0
> > > defaultly.
> > >
> > > This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Reviewed-by: Evan Green <evgreen@chromium.org>
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 46 +++++++++++++++++++++++++++++-----------------
> > >  1 file changed, 29 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 3a14301..ec4ce74 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -72,26 +72,32 @@
> > >  #define F_INT_CLR_BIT                          BIT(12)
> > >
> > >  #define REG_MMU_INT_MAIN_CONTROL               0x124
> > > -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> > > -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> > > -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> > > -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> > > -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> > > -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> > > -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> > > +                                               /* mmu0 | mmu1 */
> > > +#define F_INT_TRANSLATION_FAULT                        (BIT(0) | BIT(7))
> > > +#define F_INT_MAIN_MULTI_HIT_FAULT             (BIT(1) | BIT(8))
> > > +#define F_INT_INVALID_PA_FAULT                 (BIT(2) | BIT(9))
> > > +#define F_INT_ENTRY_REPLACEMENT_FAULT          (BIT(3) | BIT(10))
> > > +#define F_INT_TLB_MISS_FAULT                   (BIT(4) | BIT(11))
> > > +#define F_INT_MISS_TRANSACTION_FIFO_FAULT      (BIT(5) | BIT(12))
> > > +#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   (BIT(6) | BIT(13))
> >
> > If there are two IOMMUs, shouldn't we have two driver instances handle
> > them, instead of making the driver combine them two internally?
>
> Actually it means only one IOMMU(M4U) HW here. Each a M4U HW has two
> small iommu cells which have independent MTLB. As the diagram above, M4U
> contain mmu0 and mmu1.
>
> MT8173 and MT8183 have only one M4U HW while MT2712 have 2 M4U HWs(two
> driver instances).
>
> >
> > And, what is even more important from security point of view actually,
> > have two separate page tables (aka IOMMU groups) for them?
>
> Each a IOMMU(M4U) have its own pagetable, thus, mt8183 have only one
> pagetable while mt2712 have two.

I see, thanks for clarifying.

Best regards,
Tomasz
