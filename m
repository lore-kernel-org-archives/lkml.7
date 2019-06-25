Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D144C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D34215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxQwoaSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfFYIkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:40:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34984 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfFYIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:40:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so15401804ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejxOd2mS2m5aGppcIAyiv0cZFZaSK9s/NYtz62kszvs=;
        b=wxQwoaSkbLLPQJPL+BoL1Icf1FXMBP7ECaYVSMRazAL/TZoV5FN//Ms7trRiw+SuQd
         581CzTIQTx/N9fE/sUXLZ7PfZgODwh0P87yWl+eKphHagimtQhjRUDz0I9oMrRT3Rdlx
         WrZho37U3od1bUGfg1nka8v2ot5UPnsBTSgHDliSu3xpGEfq6UlYG4A4Zj9hwI10Ql0K
         0hcqQDO+Gs8C1fHcg+250AaE3Dt+ta0TLprAYJt2lTuyAOO7Ca9iNKoZLmOHRMm4T8on
         wR07J71PBuWBLFz8YcY3eSEEwtH/PX+v6KA7LIsYG8EonQf7uo3yNxz4rPvnIQ2c8+Eq
         H2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejxOd2mS2m5aGppcIAyiv0cZFZaSK9s/NYtz62kszvs=;
        b=gNk3arSZDbTnDb5S6neRald6VpvTxcKhkaCiHPCOrQtQO9SHyTNa/tfLvr21eyDK17
         TTI5c97C/SCQ1GI8T0wkshQ0a3is1hFIu7cVxlb2TtzUsur+5VCdByNjk129HP+XwDh8
         sLRzPi9U1woySpcrIGKpALJaPbabmTcFYakLVX0jr83cLHqKJWShfVw6hGNzlN4WatJ4
         unBhRtTz1ui/iagyvtZKiCydqP9gaT4g7uhMNbsZg7SB6NdXssOq/c66Altwdrfz4fHz
         d4ui2skDPMLgYLJrCgdhxRBDni4n/aXrY5EUNNYFizGFjtjkcSLl/XrHrBBiWSOQWTtI
         YzXQ==
X-Gm-Message-State: APjAAAVc6zeAWzZ0xdwYdfV5bPSTOn/8KsRj/oYbzKQKGOEB4xHSDeQ1
        M+N6ZepaE+iI8YU48AITS/BpueMd6riY9Ujt8aFp9A==
X-Google-Smtp-Source: APXvYqyB4Z1lLvFvTlYxXutc/tB2HRL2IRjyx5/sUSP/WDd11DGWzAgBW9dlPUP+BvKIc2buVVM1H0owHVNURRDGGzY=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr60880342ljg.62.1561452011834;
 Tue, 25 Jun 2019 01:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190611122535.23583-1-Anson.Huang@nxp.com>
In-Reply-To: <20190611122535.23583-1-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 10:40:00 +0200
Message-ID: <CACRpkdYsunrq7CY4HhosxH-MVxBGLqLPGnraqx1=_gZ8DxYZLQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: imx: Add pinctrl binding doc for i.MX8MN
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 2:24 PM <Anson.Huang@nxp.com> wrote:

> From: Anson Huang <Anson.Huang@nxp.com>
>
> Add binding doc for i.MX8MN pinctrl driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij
