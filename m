Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D5820684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si4KYtZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCHMGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:06:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37776 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:06:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id w66so15646583oia.4;
        Fri, 08 Mar 2019 04:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HLyKfeXOu3o7HQFYe0vpQJbrTy+pfbrIxkyNznzr7c=;
        b=si4KYtZixThhDvktIpnz5wGV4JmxLfnxXKQsf9lW2hBTbujV/9vthsVAlL02tSuUCY
         vizQsER1VV1zXUoTtpJsyVe7ercYuTaNtx4M2SDaELdD16ZArtzr3XN69UO8bN6E/J6z
         lQwGFI+WQfAs4R0EoGNcjajH/QsCkX43jdxBBZou/y+AwysD4tS2n8s/ewQUYFXCFGzt
         YTU0qVp3/kPTkGHuXjuXAH+XisFnQJ0ukeXwhYhGVWicBGEr+99dzEytvTCeGfpsa9oM
         i+52NZduu5uBGOAhbuWITEMD+aQCp6JJH3J0fcB5Uk/WTft8omO3Fkfy4DMHQd2Kvu2N
         /21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HLyKfeXOu3o7HQFYe0vpQJbrTy+pfbrIxkyNznzr7c=;
        b=EMPWWjjrdjlxTGvjbst7pCTNsStpBqDo40///5Mq0OCSos17hPOwoRUYpT4MMMKkA0
         X8zzOjIYSA33VrhpsI7O5BbuGUJvaIaZsZlwVD3oQUXLV1rM4KVAr00r7+Wrpa8Y3kq1
         zRGFJwybIwh5uUtU8qKV25Eo4U4T2EX8PW+1mfbkL//4LpVvEVFTIg4+CyG4K0x1xtrg
         NGg1IYVRvC6RIDjrDMIauNFhFBFmS/Ji1Ptk6Ns1H/RZ8qXOWU+2XRG5EscEmYPTFDjp
         3kFwAu4IXdDhTrl+0HiO72sdFOTEm4Rk4F8+yW4cXms4zdcw4mfHU1OcPvD0oeq+bmxe
         2fDQ==
X-Gm-Message-State: APjAAAV4cuTXJZhaDHzNeXikv3dzG210GIAcHskl/Zh3Nccn54nCAfRV
        t0L2of7LCjXLkeZX7H5Vo0ZonNmDcxoTMnBtvJ8=
X-Google-Smtp-Source: APXvYqxzeDkagcK3d5ICciQEK8vmIyPY1FRLJeFbFfNb/0lNtG5ncatmh9DqsOH4efafC185GHUScCZAvicw+wt9NxM=
X-Received: by 2002:aca:aac7:: with SMTP id t190mr7690152oie.43.1552046796657;
 Fri, 08 Mar 2019 04:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20190308120141.3698-1-daniel.baluta@nxp.com> <20190308120141.3698-5-daniel.baluta@nxp.com>
In-Reply-To: <20190308120141.3698-5-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 8 Mar 2019 09:06:37 -0300
Message-ID: <CAOMZO5CXyV9PEbyW7Z0yxsTOk94Qu=PqQC4ijiUXOAPDR2nvgA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] arm64: dts: imx8mq-evk: Enable audio codec wm8952
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

On Fri, Mar 8, 2019 at 9:02 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> The main Audio DAC used on the EVK board is wm8952.
> The EVK provides the MCLK to wm8952.
>
> Digital interface is SAI2 which includes three signals:
> SYNC_CLK, BCLK and DACDAT.
>
> This patch sets:
>         * SAI2 pinctrl configuration
>         * clock hierarchy
>         * wm8960 codec
>
> Then uses simple-card machine driver to connect them
> into a sound card.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
