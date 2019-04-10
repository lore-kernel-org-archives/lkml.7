Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BC9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC0B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=boundarydevices-com.20150623.gappssmtp.com header.i=@boundarydevices-com.20150623.gappssmtp.com header.b="fYVqrLWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfDJHgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:36:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39792 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfDJHgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:36:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so1736963qte.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 00:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boundarydevices-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JyF8Y8lqtTJiU7zBDRtefa/bIG2gPtY3Rz9qH5PAR9U=;
        b=fYVqrLWmBybiD3LRsjwCfu9cXQe2fiUlCS5X32h/AuMYAO1yUafWQVJ+zHAcmI5H3P
         4h1+ipPqGL2ASOOns7tXZr7FwPiKQx1mV4lSaivYnNI8G7n+p1qbgwZb6CAPtXUJuIC2
         pP2AFtvwTVNFsXFhiRBgro0IGeaKHkilH71yDJJ4fTyHIptJXZwrvMQ4TrdEhT2t/Om6
         2M0cHrwFbEseYZYpjZz1P1DSi0FIU4xrGMVEmhg5WuSnvw8sh26aPITEoA8WIBDJa8Uq
         y8b4VQEsGwNFzx4ADwZyqFd4yitAvKxkM7s7CWkNlwiapHM1nHOKBe+PA2FrKIDt68q6
         +94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JyF8Y8lqtTJiU7zBDRtefa/bIG2gPtY3Rz9qH5PAR9U=;
        b=BUrgRwImfwXI3JVm6gOlkWF/xoRx9S1jhwCl0NQw1EZKc4tPnnJpFKISjzbqrC9p/B
         9UMcr9RR9xIC4UZ6S6l70UtcBmnxILAGdPjJiSPaXZWx7oE2hs3X6isn0oCI30QuP09D
         wlTuRA1EFuT+stD5OA3GW+CWn+rqffy0a6Y7Pr9qUD9cvojdDBntnOx38QPMFiwDtAPR
         lQV/PDz6pwdfghrJrPFi6dJV1QScY4QRVqdFR0uzGcVV6IuNRaBZHHN7lBCEGzhBOy+w
         aU0jzrxvvvV4DBLMTTkHOPiMax6SL2/kglwcYubYNviguamF3C5kfJDmNAAETmd+Pe66
         GMWg==
X-Gm-Message-State: APjAAAW7ToqHV6/7KmfpC0EaGmFPohGoOlW70GaryJURx3bQO1+Fnctn
        QlrUxR0juntEiOkS2oSZpDz+M0BnIwBC3CiDidms0w==
X-Google-Smtp-Source: APXvYqwzGCxzPUxtzOkzbRJg3W+2pMr/P9gqBzdBjkDJ5Dz9usp+mG/tkSnQo4FFukYy3dschWHM58rbSLzRQMXwEy0=
X-Received: by 2002:a0c:b505:: with SMTP id d5mr34229775qve.62.1554881760979;
 Wed, 10 Apr 2019 00:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190408175319.9106-1-robert.foss@collabora.com>
 <CAOMZO5DAvaibi5r9CXzk8qbE7XHiHJHHvi9rcq_BJdx7aRVgoQ@mail.gmail.com> <4fd506a1-c961-0569-6d39-283758f363d9@collabora.com>
In-Reply-To: <4fd506a1-c961-0569-6d39-283758f363d9@collabora.com>
From:   Gary Bisson <gary.bisson@boundarydevices.com>
Date:   Wed, 10 Apr 2019 09:35:50 +0200
Message-ID: <CAAMH-ys-S7miJFCAY9bxrDGTPPT7e7c430-_4+edH8scV_qTwA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-nitrogen6_max: Disable LVDS channels
To:     Robert Foss <robert.foss@collabora.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 9, 2019 at 2:07 AM Robert Foss <robert.foss@collabora.com> wrote:
>
> Hey Fabio,
>
> On 4/8/19 10:37 PM, Fabio Estevam wrote:
> > Hi Robert,
> >
> > [Adding Gary]

Adding Troy, I'm no longer a full-time employee at Boundary Devices.

> > On Mon, Apr 8, 2019 at 2:54 PM Robert Foss <robert.foss@collabora.com> wrote:
> >>
> >> If a LVDS device is not connected, having the LVDS channels
> >> enabled will prevent imx-ldb from probing correctly even
> >> if other CRTCs are connected.
> >>
> >> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> >> ---
> >>   arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> >> index 39200e5dc896..5b413cf4c250 100644
> >> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> >> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> >> @@ -703,7 +703,7 @@
> >>          status = "okay";
> >>
> >>          lvds-channel@0 {
> >> -               status = "okay";
> >> +               status = "disabled";
> >>
> >>                  port@4 {
> >>                          reg = <4>;
> >> @@ -715,7 +715,7 @@
> >>          };
> >>
> >>          lvds-channel@1 {
> >> -               status = "okay";
> >> +               status = "disabled";
> >
> > I am not sure I understood what you are trying to fix.
>
> If CONFIG_DRM_IMX_LDB is enabled, LVDS DT channels are enabled
> and no LVDS-panels are connected the imx-ldb driver will
> fail to bind.
>
> This is a problem, since it will prevent other actually connected
> display output from being used, even if they bind properly.
>
> >
> > Could you please share some logs when imx-ldb fails to probe correctly?
>
>
> [    2.119563] component_bind_all() trying to bind: ldb
> [    2.124600] imx-drm display-subsystem: binding ldb (ops imx_ldb_ops)
> [    2.146169] drm_of_find_panel_or_bridge() np->name=lvds-channel  np->type=<NULL>
> [    2.153709] drm_of_find_panel_or_bridge() no panel found for remote
> [    2.160081] drm_of_find_panel_or_bridge() bridge needed
> [    2.162043] drm_of_find_panel_or_bridge() bridge not found
> [    2.165331] drm_of_find_panel_or_bridge() failed
> [    2.170023] imx-drm display-subsystem: failed to bind ldb (ops imx_ldb_ops): -517
>
> This at the same time as HDMI binds properly:
>
> [    4.458954] dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.30a with
> HDCP (DWC HDMI 3D TX PHY)
> [    4.469633] imx-drm display-subsystem: bound 120000.hdmi (ops dw_hdmi_imx_ops)
>
> Which in the end causes the IMX driver to not initialize properly
> and ignore the HDMI connection that bound properly.
> This in turn prevents us from having any graphical output while there
> is no LVDS panel connected.

Does this happen if the LVDS is disabled in cmdline? (adding "video=LVDS-1:d")

Note that a bootscript was written for mainline kernel that takes care
of display configuration [1].

Currently this bootscript disables all the displays that aren't used.
It was tested with HDMI, where LVDS and LCD display are disabled, and
it *used to* work.

If this doesn't work then there's most likely a regression somewhere.

Regards,
Gary

[1] https://github.com/boundarydevices/u-boot-imx6/blob/boundary-v2018.07/board/boundary/bootscripts/bootscript-mainline.txt#L90
