Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B2C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475420652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvsdqA01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfFRGnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:43:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34099 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfFRGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:43:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so12592555wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qhMEjTGxN0dhDss7cc7zfKbD1VT4IQism6fVgX1NpE=;
        b=dvsdqA01/pZ+815FjjW8tFL5UWf7khLLQ82Ejhqn6TxNO1tCDktEgPtkMa4HNv7OLR
         1U39nh2EFsrtSmlNZcgDcq/9sa+nGn3SUOMpDbfIAp95GzajjL3XI+3GbjB5ULFzEoSH
         IwACWh8kuOmwu5jEKWjMzofeGDXqP9safEXyJXu8ve2REW9BQaUclrQL8parNOK0OQjD
         B3wkQTkyxFJk8UmfoMVdfQg+Tn/UTwLgckw83gJpr19cDBf/Gz90iGpXy7nsEYrqDA2m
         eZwEj4HpXDoxWiOrmV6yaBfhp8pBtJeFO0hOjxV5cmt7gkv5WG1rUgP3mWcFMvMsVNL0
         dfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qhMEjTGxN0dhDss7cc7zfKbD1VT4IQism6fVgX1NpE=;
        b=DkSmx4Nb1RhjoXK/0y9qmwA1gbCKZggEC4YQHe5jaEdj8K7NpPjeJb89LGLn/bpTH2
         EUU3xU5WYOC+mOmcstL69l3e2MUKfu3tg5nU1tw/43kNZFXgMyIL/O748sUB8wr53NfO
         NHoB1mGNRpAe+W3fJk9FsOJFFcS1Pc0VimpgV95t+JXjnN6rPMSxuDgONtvsoskMOptz
         zKtU6oFUwj9v92pOa3vg2Dma39eYnoYV9BTmDfLN2g9s7pv2LZzkTrNbwGHbsfQ8PkYD
         BBKQZU/myhMNyEKd111AtiA5ti6PyHsfVqAjxvrL9/f9tkgZc4RWvdKVvNLG/hULdlHJ
         HkTw==
X-Gm-Message-State: APjAAAXdu0TbPqeGm3aqnuRA+jR+qCZKPCNbTzw5UsLoIG961NT2K4fm
        G//FHgW2ghmw3AXFvRwFBkJDxFtpkLECd8CKVsq9VM0c
X-Google-Smtp-Source: APXvYqyc9odfP5kl53sVaAJSFZ9kxou4Lg+4NAUEX3RWJa1eraarQrRn5NVyE6c41JtA+QlG76Va2MCtJMEgh2C9gYE=
X-Received: by 2002:a5d:4b43:: with SMTP id w3mr14892373wrs.166.1560838760111;
 Mon, 17 Jun 2019 23:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com> <1560169080-27134-15-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1560169080-27134-15-git-send-email-yong.wu@mediatek.com>
From:   Tomasz Figa <tfiga@google.com>
Date:   Tue, 18 Jun 2019 15:19:07 +0900
Message-ID: <CAAFQd5A5GUn1Zq1xF2_2V0MReNPd5bra2F=nquvodSAZUua5AQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/21] iommu/mediatek: Add mmu1 support
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <yingjoe.chen@mediatek.com>, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 9:21 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Normally the M4U HW connect EMI with smi. the diagram is like below:
>               EMI
>                |
>               M4U
>                |
>             smi-common
>                |
>        -----------------
>        |    |    |     |    ...
>     larb0 larb1  larb2 larb3
>
> Actually there are 2 mmu cells in the M4U HW, like this diagram:
>
>               EMI
>            ---------
>             |     |
>            mmu0  mmu1     <- M4U
>             |     |
>            ---------
>                |
>             smi-common
>                |
>        -----------------
>        |    |    |     |    ...
>     larb0 larb1  larb2 larb3
>
> This patch add support for mmu1. In order to get better performance,
> we could adjust some larbs go to mmu1 while the others still go to
> mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
>
> mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> value of that register is 0 which means all the larbs go to mmu0
> defaultly.
>
> This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/iommu/mtk_iommu.c | 46 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 3a14301..ec4ce74 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -72,26 +72,32 @@
>  #define F_INT_CLR_BIT                          BIT(12)
>
>  #define REG_MMU_INT_MAIN_CONTROL               0x124
> -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> +                                               /* mmu0 | mmu1 */
> +#define F_INT_TRANSLATION_FAULT                        (BIT(0) | BIT(7))
> +#define F_INT_MAIN_MULTI_HIT_FAULT             (BIT(1) | BIT(8))
> +#define F_INT_INVALID_PA_FAULT                 (BIT(2) | BIT(9))
> +#define F_INT_ENTRY_REPLACEMENT_FAULT          (BIT(3) | BIT(10))
> +#define F_INT_TLB_MISS_FAULT                   (BIT(4) | BIT(11))
> +#define F_INT_MISS_TRANSACTION_FIFO_FAULT      (BIT(5) | BIT(12))
> +#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   (BIT(6) | BIT(13))

If there are two IOMMUs, shouldn't we have two driver instances handle
them, instead of making the driver combine them two internally?

And, what is even more important from security point of view actually,
have two separate page tables (aka IOMMU groups) for them?

Best regards,
Tomasz
