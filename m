Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54324C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3AE2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfHOWkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:40:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46534 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHOWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:40:24 -0400
Received: by mail-oi1-f193.google.com with SMTP id t24so3404677oij.13;
        Thu, 15 Aug 2019 15:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5N0BrmR1Tjy4UAxxe/8xM6uCYUxnCI+4Zt+Yt4/wBa0=;
        b=d0AlVKdcuc8e7USj1p+njHyS5CIXk+ViENs9nRRjJqjKRbGNze1Wlk6uyf0hrSpfEY
         PfePUGshj2edu0rm5Q35HKCsgMoUpYBpyAzg2q9bUqDHJYPj78N8DmXE0yGUDNk41XxA
         X02BMykh80mMpWr0aWqRlL/0G2KHo/UFHLJ6sm1rTpy/hTnt0D00upf7idRGrPdpbj4p
         +3HlzQo9fgIyc2IyKqXU/OlF6oeYRODNq2OoKQdYgnEQZ96d4asYtHimFEHNtpx09UtV
         OYP+9temn5sv696CCFMs/qKfaS/V/aw4gy1wQpaZWesPaoA3p8kcAPsue3aYpiqobVGp
         YFrw==
X-Gm-Message-State: APjAAAV7u7PtzF7xLDoIAKrSrKrgJq8S/LnBv9UMa1wx8s8MFjVkSg5D
        w/Iph15ghbucuOQnOlxSXgz93c90LZM=
X-Google-Smtp-Source: APXvYqwYW4D/hTHIhZmRg6kF45XejlNLGsR7+EHYaCi+BY2j30kZLJbhDCf93qyLpBI2Gl4BqjLJvw==
X-Received: by 2002:aca:f593:: with SMTP id t141mr3194805oih.76.1565908822733;
        Thu, 15 Aug 2019 15:40:22 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id a22sm1486121otr.3.2019.08.15.15.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 15:40:21 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id p124so3440362oig.5;
        Thu, 15 Aug 2019 15:40:21 -0700 (PDT)
X-Received: by 2002:a54:4191:: with SMTP id 17mr2851640oiy.175.1565908820908;
 Thu, 15 Aug 2019 15:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190814072649.8237-1-yinbo.zhu@nxp.com> <20190814072649.8237-2-yinbo.zhu@nxp.com>
In-Reply-To: <20190814072649.8237-2-yinbo.zhu@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 15 Aug 2019 17:40:09 -0500
X-Gmail-Original-Message-ID: <CADRPPNSW4A0gkbzcPD=y-J_YHSnbAgP7p=RQnS6i0U-Ze=L6qA@mail.gmail.com>
Message-ID: <CADRPPNSW4A0gkbzcPD=y-J_YHSnbAgP7p=RQnS6i0U-Ze=L6qA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] soc: fsl: guts: Add definition for LS1028A
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Alison Wang <alison.wang@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>,
        Rajat Srivastava <rajat.srivastava@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 2:26 AM Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> Adding compatible string "ls1028a-dcfg" to initialize guts driver
> for ls1028 and SoC die attribute definition for LS1028A
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied for next.

> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 1ef8068c8dd3..34810f9bb2ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -102,6 +102,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
>           .svr          = 0x87360000,
>           .mask         = 0xff3f0000,
>         },
> +       /* Die: LS1028A, SoC: LS1028A */
> +       { .die          = "LS1028A",
> +         .svr          = 0x870b0000,
> +         .mask         = 0xff3f0000,
> +       },
>         { },
>  };
>
> @@ -224,6 +229,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>         { .compatible = "fsl,ls1012a-dcfg", },
>         { .compatible = "fsl,ls1046a-dcfg", },
>         { .compatible = "fsl,lx2160a-dcfg", },
> +       { .compatible = "fsl,ls1028a-dcfg", },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.17.1
>
