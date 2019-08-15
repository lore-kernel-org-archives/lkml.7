Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C863AC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C056206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfHOXJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:09:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39298 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbfHOXJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:09:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id 16so3492589oiq.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KueCoqv0v/W7V4/eL1H80gQgh9EGimyZb4UkR4ZiMo=;
        b=RfdbKtZLk6McraAvphR8g4CfcQ5SsT1qT16EF8avBGIhHmXoTuDAp6fZnT0zpxnc86
         UBJbn9nk82yOgX0bFJYZGJANfssCatFvgX6y1vv64t9W4gAv32Rl3sDNVAZ0x8S31sRF
         NqWOCvSblxSLLO+dAcm4+B5nV1PowMAaXdqK7uC57vRI5M0sFDmpYMtehJcUyte/Qzb3
         mcQoc9vWWRwC55ewyktP9hNGcGRMcgPkCWp+x2ZMgtLNbJeuaceyhPbnkrtoIrEkkgbZ
         Tsw1422CwC3PTF7E9tL2mz4gPYPWTjfDsxrgksiMkYQmDSLbLqZVwqiXkmJ2heiZc5IU
         GHKQ==
X-Gm-Message-State: APjAAAVMu5P/eakOwg/medxXdS7iME3lOwVgNV/c0q6ggo04HoT/W9xX
        UhMHd71RM3fJbJ9OwCv/+yR8tr+D3M8=
X-Google-Smtp-Source: APXvYqwGBWiPyvvWs8m39AIAtQCmYX3nojzA0B2ExrcRAKq8IKawTgRBa6T7UD6NpzS5OGeFGhRaKw==
X-Received: by 2002:aca:cd41:: with SMTP id d62mr3043815oig.78.1565910573833;
        Thu, 15 Aug 2019 16:09:33 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id n22sm1437858otk.28.2019.08.15.16.09.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 16:09:33 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id c7so8073650otp.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:09:33 -0700 (PDT)
X-Received: by 2002:a9d:7383:: with SMTP id j3mr5708386otk.74.1565910573210;
 Thu, 15 Aug 2019 16:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com> <1562165800-30721-4-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1562165800-30721-4-git-send-email-ioana.ciornei@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 15 Aug 2019 18:09:21 -0500
X-Gmail-Original-Message-ID: <CADRPPNT9LGdMWuBcBnvWXhD8Q-qbTNOzbYp1dRrt0NXb2DBgDw@mail.gmail.com>
Message-ID: <CADRPPNT9LGdMWuBcBnvWXhD8Q-qbTNOzbYp1dRrt0NXb2DBgDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: fsl: FSL_MC_DPIO selects directly FSL_GUTS
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 9:58 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> Make FSL_MC_DPIO select directly FSL_GUTS. Without this change we could
> be in a situation where both FSL_MC_DPIO and SOC_BUS are enabled but
> FSL_GUTS is not.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index b6804c04e96f..7e62c1d0aee7 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -22,7 +22,7 @@ config FSL_GUTS
>  config FSL_MC_DPIO
>          tristate "QorIQ DPAA2 DPIO driver"
>          depends on FSL_MC_BUS
> -        select SOC_BUS
> +        select FSL_GUTS

NACK.  Although DPIO only exists on SoCs with the GUTS block for now.
There is no direct dependency between the two IPs.  I don't think we
should add this dependency to make FSL_GUTS not configurable.  Here is
some explaination from kernel documentation:

        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

We probably shouldn't let it select SOC_BUS either from the beginning,
as the basic feature of DPIO should still work without defining
SOC_BUS.

Regards,
Leo

>          help
>           Driver for the DPAA2 DPIO object.  A DPIO provides queue and
>           buffer management facilities for software to interact with
> --
> 1.9.1
>
