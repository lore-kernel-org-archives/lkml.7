Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B26C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27672071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD9WVRWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKWRJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 12:09:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36412 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKWRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 12:09:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so10958663lja.3;
        Sat, 23 Nov 2019 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j83nFTVfMtqNZdG7bDqp5KO3Sy0JHsgiNUcUKGNznRw=;
        b=QD9WVRWY3GaW82EE2neF3DzIT1RKW2ZHKO+Ruxgkcm81kVJ5vP93G8wMwXnoWYto2l
         1765iU4Fe0Iqqo7yi5IrZemz9T/7ur7sFPk83r31GxXBwpmxt0lkKKWsBP9IM6UB9sRE
         ZDCv+/k/PSg7i+XKEpJtjpBwyrrzpPn1uw3a4nY8wawKwN8Mss0m3y1moxz5dt/VaEby
         fr3RxjePoV8r/cu9nIAJ/nx9f65uHEBpilkLJV79/AvMvGTzyIQdDATsXpaj/R293ews
         1H1tVCWn1hXo1DfZEfC32POgm0txPTRb4b+wLdLszIhRPHpL/tvv+8uwLVaAyfmMGDlg
         SgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j83nFTVfMtqNZdG7bDqp5KO3Sy0JHsgiNUcUKGNznRw=;
        b=fOQ0M6EocCe8kBmoxNoyFo7kGVKiWqtr533aZc+njf0p/0tM0uW0ITZuLkjuH1nAho
         JMdbDq7V0mRzhEZLHX57/1lBdR7babzBbu2bfE/oyoAqnmDHf1FPegrDaGZi6f/phuD9
         erSaQmqHQc0J5YOElcaeCailwCE6qRqdCQgo0vakeZoZvo3mQT+VvgZWeUs28lUXaXbG
         /dBDp64mG1RKOc0mucW8qwxydXGPjLSgjgSPe1mhPL7eTt5uK2yoBygY+bjrQhBM65Iu
         KtSvwJ7EiWBzHMhpjcrqqRrDJ/GAa9H4csDbtrpl9+dpAGYBtq10t8id6L4AJ5pfe9S0
         cBhA==
X-Gm-Message-State: APjAAAWm/QGnkU3HXF/+UdKQP0W7HaZvEy+RP1mJi/smCChDQaSEH1yR
        ki2SL2MeduBt1xHbYptYTqbholmqfW8qv8sQZyNZejtC
X-Google-Smtp-Source: APXvYqxQ019+TumcDMsHiVKMajnZaruf8NAyKLasRWn/pDaLWWYVx54vzDNZbe0VjeeZE8NSjNIYrlBnFYrI4ts/7UU=
X-Received: by 2002:a2e:2c1a:: with SMTP id s26mr16591026ljs.239.1574528965875;
 Sat, 23 Nov 2019 09:09:25 -0800 (PST)
MIME-Version: 1.0
References: <59793b1ae533636528942b2cec14ec68b9830fcf.1574510649.git.agx@sigxcpu.org>
In-Reply-To: <59793b1ae533636528942b2cec14ec68b9830fcf.1574510649.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 23 Nov 2019 14:09:28 -0300
Message-ID: <CAOMZO5DjXfSoWRV-6pvAD+nwXLRAxRASZOsOwLFbsxkNwTUxaw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add eLCDIF controller
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 9:09 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Add a node for the eLCDIF controller, "disabled" by default.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
> With some minimal support on imx8mq we might as well add it to the DT
>
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi
> index 7f9319452b58..00aa63bfd816 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -448,6 +448,23 @@
>                                 fsl,sdma-ram-script-name =3D "imx/sdma/sd=
ma-imx7d.bin";
>                         };
>
> +                       lcdif: lcdif@30320000 {

Forgot to say that generic node names are preferred, so maybe:

lcdif: lcd-controller@30320000 {

instead?
