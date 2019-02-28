Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66984C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C464218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjrUtY96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbfB1SkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:40:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35528 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfB1SkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:40:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id z19so18627365otm.2;
        Thu, 28 Feb 2019 10:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=281J533cm8Mq2gkG6Koc9nq8Kvg2bVEm0r9YRwAbVUA=;
        b=gjrUtY96LH4IuvNOHUzhDFc6qq0X/4/XvQ1N1hEZbJj4HcuxM4F03igpbo2uoBc07T
         jmefZvwy2922cpJyf+sd04UeW2vtle7XK9vnmaVrW29yYKLQEkhlJsdH3TgPaWzCUHtN
         Rjxxnr0KCpNQ+m3qwuPBvIp0KwDNXGdodf+OmfNQh8n9fN8kaygV+HeIbO4x+wypkX8B
         RFgAdW3j0tipmpgVFl/VCgECKx/KdHOELaUT8ISRoIvJUFgK+zZgsP/KA3C3jVSybQiE
         UOHU1j072gfNIwi4at9UiwRuCpPYb8jO9gtMTA8e0VvPJK0197BjE29Ws9qxch8to5IV
         T03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=281J533cm8Mq2gkG6Koc9nq8Kvg2bVEm0r9YRwAbVUA=;
        b=tJOJ/gzkJLqMx+xFX8jC/LDDQwCs9T1JyxkdoRxrfcxELkqRBX/dIRc9jZQp1AfUa3
         NVOkeTUP9vVmcEe8Frab/vz2eJBP2KWzP+e17gekvO3B49DcvHFrnjUdTKVGfDB+4Vuw
         0QT8au+am11n8C2zfTGkJPXIDxqvUu45Qf8v5qReD8b+rJ8njFINSNngdbfW4KWQDhJY
         KYgaFToFTxLzO/hKE19EUghAlc54RJmuuSsRnd6zAENwPB4JsLjIXggm9fBuH/VIlZHF
         BWdFOcOvaQ//oEMEpaUFSS+GbTiecj+QSCo3uSsZ5AbnJukO8kTphJCRj0CS2va2PZEt
         zkpQ==
X-Gm-Message-State: APjAAAXd6XVM3H4yi9Y8aHtBc8oZ/AFZs3nJSbofZJq/2/Y3FSSBN2dX
        Vasxy/QKmh5cTosGsZlu+CIfT1zKodm/qCPJtnE=
X-Google-Smtp-Source: APXvYqx2cndA7WoRhT9xVx5379LMl2RQ4jfjL3cctwYyE2hQ9tN2Grkx8xFMj74lzzLQhDoN6vpSMQrmGOpQUu1kqZ4=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr667215otk.287.1551379221903;
 Thu, 28 Feb 2019 10:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20190227063737.24445-1-daniel.baluta@nxp.com> <20190227063737.24445-6-daniel.baluta@nxp.com>
In-Reply-To: <20190227063737.24445-6-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Feb 2019 15:40:12 -0300
Message-ID: <CAOMZO5AY--Q7FDwK-k8u=mkR-9bxz0XWXN3HNZb4Pb+MESZ6Dg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: imx8mq-evk: Enable wm8524 codec
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

> +
> +       wm8524: audio-codec-0 {

This -0 is not needed as we have a single codec on this board.

> +               #sound-dai-cells = <0>;
> +               compatible = "wlf,wm8524";
> +               clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
> +               clock-names = "mclk";

The clocks and clock-names properties can be removed, right?

I don't see them defined in the binding doc and the codec driver does
not call clk_get(), so there is a mismatch.

Also, I still think this one and the previous patch could be made into
a single patch that adds audio support for the board.
