Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63BE218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayzrOWGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbfB1ScE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:32:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32890 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfB1ScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:32:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id q24so18628274otk.0;
        Thu, 28 Feb 2019 10:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuieyVZir8oSjbL88cSQAtgd+qLsj62A0YsIEiIuYOE=;
        b=ayzrOWGhpU0P06d+oozHmi06I7MHtLCd1/b+vjAG0tTQ1c/j+0M8Ni5byNmczcWzai
         UnoRmlOVCnE9El14pe24w015nQS98QZAAVeJyZ+RyV1SxIDr8h/MhEcf+orGjmgxUIrQ
         SFfVZbiJutppihvONUpFdhetRVH3PSO9ZYLzIYNdlCy5+70Z39lI+Y7jZT9/5KYZwOUa
         uLAHTUSPZoPAl2h18AUVUvFsFuEmhqxT3oS/NEat/Wl60+iHGsyphgwnLBY4drj2iKsB
         HWFE3JOqCKueYRBQLqm/L7ewiWYfp+dPXRuWHuhHtJKlFiYUPa9RA8wPMLx4xVg64ri6
         MJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuieyVZir8oSjbL88cSQAtgd+qLsj62A0YsIEiIuYOE=;
        b=Rl6VifmRL4snn5eSG9aeuLz6bjB/sXFdNiT9ff4KV63yJd9CSJJmhGSFhFOA82lpyQ
         iKmUBl258G/xUC4lOVtCIXwu3RRTxImtICSk+Avb3SA0YhDn+9LNk8IRUU5lXUwm+rjn
         KD1646AU1/H07+48uFSPOCCOAxpNNHGvQ7RK02k6pjS4wA1NCny1T2b/vaPIuH86bLtp
         A3ySlae6kBEohxDiMh2G+uvaTAiSyyc1lo64R202hMnom951JlXn1qxYW5sYD1AXhr7k
         yXYEyNQTjG/ltToLkpjiNjDX9BkJi1N6RvbrSbSYSil4gBITn3nL2GAURBoGF9aQzUUr
         GKvQ==
X-Gm-Message-State: APjAAAUWbCkZY3fcKUJ93goc4YJl+QafwwJ/+IR9VdQp0DU2Yz2UoVBb
        HC77/JgVniPeim5Wb0TB9upTeSjGvZERCVE61lA=
X-Google-Smtp-Source: APXvYqyluT4g5FgCPlFOzPD1Y66Lx8Dlj7r6pT2B/4T9oIBmnLtWj3C7/P/TM2X0/3OdUZLYg6b8X9hfzkA9lh/wRLQ=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr641876otk.287.1551378722949;
 Thu, 28 Feb 2019 10:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20190227063737.24445-1-daniel.baluta@nxp.com> <20190227063737.24445-4-daniel.baluta@nxp.com>
In-Reply-To: <20190227063737.24445-4-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Feb 2019 15:31:53 -0300
Message-ID: <CAOMZO5A7fe9U4qYegxiOC1sPApb22LcvpBLVgSz5XMWegDoZRA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: imx8mq: Add SAI2 node
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 3:38 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:

> +                       sai2: sai@308b0000 {
> +                               #sound-dai-cells = <0>;
> +                               compatible = "fsl,imx8mq-sai",
> +                                            "fsl,imx6sx-sai";
> +                               reg = <0x308b0000 0x10000>;
> +                               interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MQ_CLK_SAI2_IPG>,
> +                                        <&clk IMX8MQ_CLK_DUMMY>,
> +                                        <&clk IMX8MQ_CLK_SAI2_ROOT>,
> +                                        <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
> +                               clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";

mclk0 is not a valid entry as per the binding doc.
