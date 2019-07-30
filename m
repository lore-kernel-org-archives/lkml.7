Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0440C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CE8206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr/qg1bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfG3QcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:32:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36566 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfG3QcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:32:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so62718083ljj.3;
        Tue, 30 Jul 2019 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xx3vIoXX8Mxn7Xfw2L25UDOZ1rfyh83SbXwIfDYTy98=;
        b=Jr/qg1bcxy7MjeWhxfQDSfgI4H19sw3Jz78Pye41vfpqN+qGQyZ5gO32yCnGAwrCwV
         IDJb7U1TOxEAb6pIpWroZIuT7EH8L5n+TenAghKXZ3DFNlsOZ4lD+Vcm71PyTVQcdU8n
         nz9o7mFEcxcOwswCwYoJO2VtzDaYHKf3Z4RAnWrAIp48DYXqZFKMqhiwEj8Hhwr1N8me
         ruOzUTSHHKXkzoToPBzodjKX6V1oOfQetH5lvFZqATFZ8IK321BWFLek4FQyCWqLIG35
         az6aUKKZjPWBpZbPuW9142x9uyef+DFsNPlRQBOkSv+vxQHYAL+YcoELTlO6LXvDWRVC
         /eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xx3vIoXX8Mxn7Xfw2L25UDOZ1rfyh83SbXwIfDYTy98=;
        b=sfDP/UWGIqQ1+qQRFvSDR84heCpDKuNC8hM9aPTe4NpActF3XrWZpU5BCptPmPWcJj
         RvRHqIH49tkTYJwLGe+Mrz6UO0TYj+Dwmx0pPXFfeft/e3OsHh2D8kqtU0ZWeh8lbYMU
         E1bycnEFzSb63asynmC9RD/fLNODnyulSTJNMFynFUNBDlQ3WnJRNfghEW4nkrZDWfOh
         WXO76jU/52vY/8kcFXsLuS9shtbReGpYtWU2MeEDkqOT3/A9wf1+sHe/lN1fQu2JadXu
         3ArqLyTllU2iC8a/RFlqxbBxKQKRB40ncaglBJGlLJkaHkPSNRPPaZrCanbC1KMj7Mqj
         uQCA==
X-Gm-Message-State: APjAAAVDCGQiVccb87ZKBITQsPS4MPyCsni6rHPZaetN8Z2joJWXDpmv
        t2qNexgE6QZS8z9rMxibHHnTT04SS++yS6qER4Y=
X-Google-Smtp-Source: APXvYqycFcTFoT9V2kVAqMs+UnnH6bzjYSJTSertHTYTAJI+RtGajdJMivgIKh9SwCSMNIC3PdQzfGaeyRqcszz+JWM=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr24607447ljs.44.1564504329883;
 Tue, 30 Jul 2019 09:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190729172007.3275-1-krzk@kernel.org> <20190729172007.3275-2-krzk@kernel.org>
In-Reply-To: <20190729172007.3275-2-krzk@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jul 2019 13:33:30 -0300
Message-ID: <CAOMZO5BzA7JfNhJtZjUCewGicWFy1Qemx3jV1=+27MjUnsq4kQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6ul-kontron-n6310: Add Kontron
 i.MX6UL N6310 SoM and boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Jul 29, 2019 at 2:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> --- a/Documentation/devicetree/bindings/eeprom/at25.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at25.txt
> @@ -3,6 +3,7 @@ EEPROMs (SPI) compatible with Atmel at25.
>  Required properties:
>  - compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
>    Example "<vendor>,<type>" values:
> +    "anvo,anv32e61w"

This usually comes as a separate patch, but anyway:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
