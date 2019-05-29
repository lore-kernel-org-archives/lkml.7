Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E5CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E046821E6E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stSrV1RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE2W7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:59:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35037 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2W7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:59:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so1688576plo.2;
        Wed, 29 May 2019 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iRXiq08eonK9BxjJjymdgHQ4qGSvRUxD96bZCDtUMV8=;
        b=stSrV1REP7r/iO0UySmKgfFQfgnoSywv5NEtp+3mDh+GJouFI80ivyUakPvqig8Azk
         YgB10Lri9r0RC0ld01sWyFm0/h8uTiv14UMm9g9A5G5CsmRxkOYkpXzsBxF+Q17278tr
         Px91blXo6+fUgF+HLBAuoi2qy4+OyklLJPHr9DZt3StO0PqO4rhu88kqA9lQuNlnPgvN
         yn07ols/kBnUXU7GcG4++x6XMFl1njQt5KNlxr6O8HGncwNDZXgKxrpK6qctCadJc6WV
         PlenhQY9FKgMHji+69msD05gr+N6JwIZ2G+9zzgd1/be20BaLEw4xZLahuoCFZPzkVjy
         dljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iRXiq08eonK9BxjJjymdgHQ4qGSvRUxD96bZCDtUMV8=;
        b=lIKICgNdqe8nW2pKu226NZHVZM8dO147F1gPugTsGpbLhr+u77QJgdAbjF+H9EJliV
         co0r9aaHsm/01TP7b2Cyf4PtXgARL1FqwtP546o7fbtGrHUe9tTbqQYX6Or/ZuQSh8ZB
         eizX9HMXEVRFSRqeobl0F2MVczZggy8ZaDS+6CixDAqtymuKuYXIHSMK7MFBVIDPX+2d
         qHRKeScffwtFuvPEBX0fZAItVFafPrThHQ7RIh3Vut44mFuWsCFnfxNj3x0/rGq9DHMI
         aAFLMvrqwyxhcPV6clVPSPIbr5+X68caQIfNJUB5ZNRmloxEinib9djDeNGOTILY+ABo
         wyuA==
X-Gm-Message-State: APjAAAWHIOXWTNUGk8NgirbSn5jLAVC43aodSaCxCwAYd1zVBiCX5/j2
        NpGFKQfI7s2fz3+lzJJNhYX/3H8sV8Q=
X-Google-Smtp-Source: APXvYqx96A2IXwPpSqyQ4BjLhdKAVqBGtW28Z6W8F3//efV2DHQ3i/2tcwUQ5QxYVU6xOHShEZbpJA==
X-Received: by 2002:a17:902:b601:: with SMTP id b1mr458014pls.117.1559170740954;
        Wed, 29 May 2019 15:59:00 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id s66sm822586pfb.37.2019.05.29.15.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:59:00 -0700 (PDT)
Date:   Wed, 29 May 2019 15:57:48 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx: Add mclk0 clock for SAI
Message-ID: <20190529225742.GA17556@Asurada-Nvidia.nvidia.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
 <20190528132034.3908-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528132034.3908-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 01:21:00PM +0000, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Audio MCLK source option is selected with a 4:1 MUX
> controller using MCLK Select bits in SAI xCR2 register.
> 
> On imx6/7 mclk0 and mclk1 always point to the same clock
> source. Anyhow, this is no longer true for imx8.
> 
> For this reason, we need to add mclk0 and handle it
> in a generic way in SAI driver.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 6 ++++--
>  arch/arm/boot/dts/imx6ul.dtsi | 9 ++++++---
>  arch/arm/boot/dts/imx7s.dtsi  | 9 ++++++---

These are dtsi/dts files that have SAI missing mclk0:
arch/arm/boot/dts/imx6ul.dtsi
arch/arm/boot/dts/imx6sx.dtsi
arch/arm/boot/dts/ls1021a.dtsi
arch/arm/boot/dts/imx7s.dtsi
arch/arm/boot/dts/vfxxx.dtsi
arch/arm64/boot/dts/freescale/imx8mq.dtsi
arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi

Would it be possible for you to update the others also?

Thanks
Nicolin
