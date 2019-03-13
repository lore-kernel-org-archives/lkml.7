Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24995C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E702520693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N0xPSEvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfCMKtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:49:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44755 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCMKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:49:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id d2so1236900qti.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhzR6aubWEYgzikBR/ws80jTTDYj/MkeU9A7euzIPNw=;
        b=N0xPSEvm2SMEiqkEn5mdNzntu4XU15JPKSEEvdM8WOKL1gpkmakRljsyBOThrIPneb
         7jrbcIZ6Pz/SrAKvRsR5b5ZBRhDlhEBG5RU6/gb3exWTM/wnG+thegzV0W00kRHmCQjI
         2gOfDI6rqDI9q+MlF9e6078Cwd1xnt1PVO5Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhzR6aubWEYgzikBR/ws80jTTDYj/MkeU9A7euzIPNw=;
        b=OdQ4Znlp8wuV7FL8KA3h/m2/Iaz5ghIqRxVP2bef2chP5BMk8plKsJBEKCL7qPnUrs
         uCdq1g8N+pby8E4RBuF/HR2xk3SluqIpPzL3AQ6m8HZKT2Q0lKQU2R9bpNZOPsLkYigz
         b8cdV9BDtWFUsDO0qbfKy62aWm400FjLega9FKqsTakLyJ/baQQI/G93RQlQPIM2GO1q
         +5+/CKAiyybyel0JcZmAJXM4Fx3K5aIxjaejGWNFhueclwxYe08ZG4OsjM6HyhSZSFQU
         MYi8f/bYXtCMKygoe4LyZ6MeRjfMjO1XcIw7MrTqfhQ38lyfPnddnjmTsrye4X1c9afN
         llbw==
X-Gm-Message-State: APjAAAWcsone3/+3cTlMHAPI3KEaACWqq7JO0v5kRcgIrKMYXy8xRdnN
        AFT21TxIulU1ulXGGJUk68ZFipHX1C05CoIqAtQRzA==
X-Google-Smtp-Source: APXvYqxe5R6Rs2hTIgCTeBVSIiF6J50pyjo+yD0VwOJUCN+qC8XUAe0iZWlfUTP3NHHHr0UgIWFEjZFIhtZwy6RvtN8=
X-Received: by 2002:ac8:2847:: with SMTP id 7mr33275907qtr.335.1552474159659;
 Wed, 13 Mar 2019 03:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <1552465563-6940-1-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1552465563-6940-1-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 13 Mar 2019 18:49:08 +0800
Message-ID: <CANMq1KC31g7=NiW2zHLxqv9yH7a11qRLdieSyoES446ZJxi8Sw@mail.gmail.com>
Subject: Re: [RESEND PATCH v1, 00/18] add drm support for MT8183
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 4:53 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This series are based on 4.20-rc1 and provide 18 patches to
> support mediatek SOC MT8183

v1 (https://patchwork.freedesktop.org/series/54451/#rev1) had a large
number of comments, and I don't think you addressed any of them here?
Can you please do so before resending?

> Yongqiang Niu (18):
>   drm/mediatek: update dt-bindings for mt8183
>   drm/mediatek: add mutex mod and sof into ddp private data
>   drm/mediatek: redefine mtk_ddp_sout_sel
>   drm/mediatek: move rdma sout from mtk_ddp_mout_en into
>     mtk_ddp_sout_sel
>   drm/mediatek: add ddp component CCORR
>   drm/mediatek: add mmsys private data for ddp path config
>   drm/mediatek: add commponent OVL0_2L
>   drm/mediatek: add component OVL1_2L
>   drm/mediatek: add component DITHER
>   drm/mediatek: add gmc_bits for ovl private data
>   drm/medaitek: add layer_nr for ovl private data
>   drm/mediatek: add function to connect module with it's previous one
>   drm/mediatek: add ddp write register common api
>   drm/mediatek: add connect function for ovl
>   drm/mediatek: add RDMA1 fifo size into RDMA private data
>   drm/mediatek: add function mtk_ddp_comp_get_type
>   drm/mediatek: add ovl0/ovl0_2l usecase
>   drm/mediatek: add support for mediatek SOC MT8183
>
>  .../bindings/display/mediatek/mediatek,disp.txt    |  11 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  64 ++-
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  23 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  42 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 458 ++++++++++++++++-----
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  11 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        | 100 +++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  24 ++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  55 +++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   4 +
>  10 files changed, 688 insertions(+), 104 deletions(-)
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
