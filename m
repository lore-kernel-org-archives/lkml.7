Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752BEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B02C20863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRp7SQEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfDHUh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:37:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43648 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfDHUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:37:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id g7so10498463lfh.10;
        Mon, 08 Apr 2019 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIbTKZIfagUxRm4xxMZlgPKhmAJ2BsD9a15PdipvXg4=;
        b=kRp7SQEgOAAA84V9+wlp4qE030zmsGwRehjzojxapVCUynPbRpOlLuxpg5a2K3KNW1
         g5sOWV0J9T4Fg2vfqWxaivOaySbl/u5Ih+StQcPTysJYZBTM5FsaLlULS0PnTc06IGU7
         8D2K2kAkB9ww6z/4TfSulXEnwd5JwEe6iFmsuBQXxBH16zd9Ns791PxHbf8wMsk8Kj3i
         NjemEPwZmrqTHoDgmirek/jmc+ymeTaPw8+/r4xagK5tWyqIAu5nhzv6H7GtC+IuXSPa
         YIBIVuzvzD15LTvv3YQjDlAUFn4y0QpR/Y860NThl7O74wQmvKSrVQF/Z5wi6U+5t6Ws
         Hhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIbTKZIfagUxRm4xxMZlgPKhmAJ2BsD9a15PdipvXg4=;
        b=Afn18uMwv1LWx+IK31iLb05WKBE3mlD0AZ2Ri2snA84raVh8viHyC9/HCxVlV+3opo
         2i6FYmF2ffQYztP0z1ZPpZlPCKXEOAMwVcb9fIU/76dsrsjHLkeGwdg+wCStXACbFJfa
         9QNpJ2fa5OquV7N7CdWK/QGGm80IBB03ra3kjYxgOfPzQNnQYfS9mdLKpRcCv/b2G906
         sejkz2KzPfqAyxJKlqhfSk/GgIWsV5K8yKoR8n7CALbP5FWvgZZYC8nU/CIX7UdDA4gx
         NA8GLA91RHlPALWrgJ8/IbVrEXeV9SdtY/2KL1zVfQeF8crw5QXkq1+Yg3lBZh+ueFF1
         Iwwg==
X-Gm-Message-State: APjAAAW6rh+Zw+dsfg0JoilqokVoEHbAzcDPYaT8Bggs6PUBCvC6+j3f
        89H23fDhU6Qg7LNr/JPt68Ecqp/h7TwQAcOlnXo=
X-Google-Smtp-Source: APXvYqwuSq1zNYDk55/PkGJ4yvYVnAHaIXV6rYm75kb5kPZgJi/g6r57zurp2MvaQhRT2eAJTJhdNW3CRfzJcbgRNbY=
X-Received: by 2002:a19:6b14:: with SMTP id d20mr10105768lfa.152.1554755875612;
 Mon, 08 Apr 2019 13:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190408175319.9106-1-robert.foss@collabora.com>
In-Reply-To: <20190408175319.9106-1-robert.foss@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 8 Apr 2019 17:37:47 -0300
Message-ID: <CAOMZO5DAvaibi5r9CXzk8qbE7XHiHJHHvi9rcq_BJdx7aRVgoQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-nitrogen6_max: Disable LVDS channels
To:     Robert Foss <robert.foss@collabora.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

[Adding Gary]

On Mon, Apr 8, 2019 at 2:54 PM Robert Foss <robert.foss@collabora.com> wrote:
>
> If a LVDS device is not connected, having the LVDS channels
> enabled will prevent imx-ldb from probing correctly even
> if other CRTCs are connected.
>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> index 39200e5dc896..5b413cf4c250 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> @@ -703,7 +703,7 @@
>         status = "okay";
>
>         lvds-channel@0 {
> -               status = "okay";
> +               status = "disabled";
>
>                 port@4 {
>                         reg = <4>;
> @@ -715,7 +715,7 @@
>         };
>
>         lvds-channel@1 {
> -               status = "okay";
> +               status = "disabled";

I am not sure I understood what you are trying to fix.

Could you please share some logs when imx-ldb fails to probe correctly?

Is this a regression?
