Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B54C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DB521872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAXOhi/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKLXT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:19:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45222 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:19:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so316751ljg.12;
        Tue, 12 Nov 2019 15:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMjwveH3CUuLmsxzUrrc19s3Wz8y9XDlrlIq+OXDB/o=;
        b=mAXOhi/zUV3TiTyp9nCQ+06pCmLgs3jTZA914CYgYmfDQFhlj0lvAEkMt7LUkjk8c7
         yiRAjDtkLchtZfvJxM7yir7R/ceWA3qiLdyUA9Wd9ntw3qY1oRo87fn3SVSXmJyITUkj
         tS3JrOvImdDr07jeeW7n/dETixbXrsusRgAaQallO4JrOTa8QBhF86KpHnBT6VRoJyp1
         p4NRaskU7mOtgoV5F19pWcSdP0UqbIZYcpTFZ9fGjofPOk1sAA2YC4MsjBPrfi6/E5XS
         9SAKtDCOkWHh0LFOZTb2/jNTOWDf92AEFBeqrkaLLlrfs4uRnrY0uS4sVPjC+YgfptZn
         gQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMjwveH3CUuLmsxzUrrc19s3Wz8y9XDlrlIq+OXDB/o=;
        b=ha1BLIB1u+AUKdTTDZKYbbeFO5tHJ1Tji2UJoh+KIEPbf/m1QLg9zIAvtnysuvjaH6
         yBx34I5VyQsii4Y0V+usFtmEe6LyXyJ/UkpoUIvL9/Q0V3AHozWns3qejaanoVfZgn2z
         VJkwqxNMpVme8CfTuswWwbVHxNFPEIgJFP+KV9LbxfACBj/UsZveM1A2MqpGNSLJzPPT
         wMhUxiEVx/dKZK9mjTX0LxWRfLKUnk3ZPDwbGvpmqWm5dyOXEKYp8OLO1mWqgEm/Zi1n
         bBRPMSzN0z/5DvoT1Er4od3s4SelB0hlr+NDOM8UsvQzjyvC04TFCzQsqSBStAmlkBgE
         4Evg==
X-Gm-Message-State: APjAAAVaTUDRpVsP/gljEViQ9v2pbLMAcmX6SgGcTn9m8R1Tl/XwBbYj
        1KrarW/ahaSIzNc3Nyf1UNbDPHMPk+bM6hT25Mk=
X-Google-Smtp-Source: APXvYqwVXiqCC0PuqZq7mcUeN3z5CHKrDqFe9eCwZIGLh5LdIV2o9g66iNddxCo3PGbxNDaeVk/V9lLsVlH9ntASnLs=
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr220451ljp.0.1573600795494;
 Tue, 12 Nov 2019 15:19:55 -0800 (PST)
MIME-Version: 1.0
References: <1573586526-15007-4-git-send-email-oliver.graute@gmail.com> <1573593892-25693-1-git-send-email-oliver.graute@gmail.com>
In-Reply-To: <1573593892-25693-1-git-send-email-oliver.graute@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Nov 2019 20:19:44 -0300
Message-ID: <CAOMZO5DYssbnVsemV+U24wbVoYM3LM3ZZtFwWHonXLHKF0Y+kg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL compatibles
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 6:25 PM Oliver Graute <oliver.graute@gmail.com> wrote:
>
> Add the compatibles for Variscite i.MX6UL compatibles
>
> Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index f79683a..d0c7e60 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -182,6 +182,7 @@ properties:
>                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
>                - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
>                - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
> +              - variscite,6ulcustomboard" # i.MX UltraLite Carrier-board

I guess what you mean is:

variscite,imx6ul-var-6ulcustomboard # i.MX6 UltraLite Carrier-board
