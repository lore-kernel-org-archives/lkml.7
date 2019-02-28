Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6314BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F51218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt3Fun1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfB1S3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:29:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46702 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1S3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:29:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id c18so18523792otl.13;
        Thu, 28 Feb 2019 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPxNELC/mMzQcnBrBkeXrAaVVc9OKke25zTgzjlC2Hg=;
        b=Rt3Fun1I0xzcwYyy0eOn2evBLece0Q0TW/TYnPBuOhchbLskhcRqxNGh1p40iww2Us
         8xKTXEvCyjmSOiwBmgMsiWF/usEFzOmoUxjzxlB7Vbvcojv+6geOSiXPW6WiAvBfQ72d
         zbDRekfBiCGGZMPJUA4aFmMGHtaBSXN9vwsBR4Th31atSOtulFkQcH50irfOrCG3HL49
         YdjVDIyhN+73tJf26h+uGcQoCVBgzc++M3OaGDyfdk3UZXguXbBi/LCi3gPamutmWEM3
         kzP8uJfTkUZ6myPfdVyWBBf+IY4xSap1bf/DJ9kdd9/oZu5AT4Zd/WtYqNXM9tubMzaf
         YXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPxNELC/mMzQcnBrBkeXrAaVVc9OKke25zTgzjlC2Hg=;
        b=PEQt7VVHcBqusGT7VaaliGzKh0D5LskXepmqKpvXEpl84B4EdYRA/UxuITCE95Hrnx
         lWU+l5X2hurHMQO1SW56Ey5lv6OMnyyAjFSiqVJ0JYVdXE62wlu1JvBJvk3KMF/7/4TT
         y7C+3T6TwiscvKoB3Vq27x/3tE0JUjZAarAkoNnbh5lGBIGlb1qddhWp+CiTcHASWMj8
         9RYklisvFSZTROjKjMX2HQZjyw9i+x2oXWq56IrFesx2vyY0EdLSORREIaBBD3HElpSC
         YXcr5j9ZVeIiRLOvkexW3Uv/Z3NrfeJ/ZilMbbp5pgsf7nhQVr6vxAXOThiEriU4vHXS
         aueA==
X-Gm-Message-State: APjAAAX1WLKjPf8ylCvVMCGfU8B/ydTz8DOtydM8J0ZlN7TZI7/tOmxW
        /lBhRHhTxZaDUWgjIw2bQwNhhP/J1/ecfxRjKXU=
X-Google-Smtp-Source: APXvYqzec5gsQCrIahOujFpzujtPCezr0eEh9qEZZfC37IpzFf3H06I9xgw84+VDQaXpba6aGDzeFqQTWF2FK4gVJ14=
X-Received: by 2002:a9d:6d94:: with SMTP id x20mr678736otp.78.1551378552808;
 Thu, 28 Feb 2019 10:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20190227063737.24445-1-daniel.baluta@nxp.com> <20190227063737.24445-2-daniel.baluta@nxp.com>
In-Reply-To: <20190227063737.24445-2-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Feb 2019 15:29:03 -0300
Message-ID: <CAOMZO5AeH3uBfD_5dVc_-M4+cGmYsx9kohc01E16o5yNu4bRSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: imx8mq: Add SDMA nodes
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
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Anson Huang <anson.huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 3:38 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> SDMA1 is part of AIPS-3 region and SDMA2 is part
> of AIPS-1 region.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> [initial submit in i.MX internal tree]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [adaptation for linux-next]

Reviewed-by: Fabio Estevam <festevam@gmail.com>
