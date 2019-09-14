Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278F5C4CEC5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 02:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FF420717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568428225;
	bh=SmCg3dZf3LJ6WJN5//nawR5IgYMlBzdTkJhmOH6UDe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2cqynI90p/PGRCHoHCDaQP3PlsydQ82fYapDr+OjRml9SUyVqGABjQ2R/n1WxuJ8F
	 4GQjxHziG+cbR6IRwkMfn/qFKdUFzZn0FgPOYMRybbUDXqEXfSgEHGOjyCs+0gAoXV
	 QhC/cxv6Knc6mrcYcunmQmnICx4Be4+tm/ICff3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfINCaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 22:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfINCaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 22:30:14 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19FD720717;
        Sat, 14 Sep 2019 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568428213;
        bh=SmCg3dZf3LJ6WJN5//nawR5IgYMlBzdTkJhmOH6UDe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Xhco409vITvYR9NuYdOO+zjmi3muTEfUi9ctzCj55lTpeK7zpJ3ZtME23rrIS34Z
         gPi7JunWRp5q1mfc85VM25m8eZyarwNIn7RjKresSf375POU6ISQWEjvcC138ezy/q
         CXDAuUNnfkmt/SK5R4O52p5SEW0k92/6q270cgKQ=
Date:   Sat, 14 Sep 2019 10:30:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan @ agner . ch" <stefan@agner.ch>,
        "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 00/13] Common patches from downstream development
Message-ID: <20190914023004.GA3425@dragon>
References: <20190827131806.6816-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827131806.6816-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 01:18:16PM +0000, Philippe Schenker wrote:
> 
> This patchset holds some common changes that were never upstreamed.
> With latest downstream kernel upgrade, I took the aproach to select
> mainline devicetrees and atomically add missing stuff for downstream.
> 
> These patches I send here are separated out with changes that also
> have a benefit for mainline.
> 
> --------------------- Update version 4 and later -----------------------
> Patches that got pulled in an earlier patchset version got dropped in
> this patchset.
> ------------------------------------------------------------------------
> 
> Philippe
> 
> Changes in v5:
> - changed legacy gpio-key,wakeup to wakeup-source
> - Add note in commit message about disabled status
> - Added Olek's reviewed-by
> - change group name
> - Add pinmux to iomuxc
> - Adjusted commit message
> - Switched to consistent naming: pinctrl_xxx: xxxgrp
> - Added Olek's Reviewed-by
> - Added Olek's Reviewed-by
> - Added Olek's Reviewed-by
> - Added Olek's Reviewd-by
> - Added Olek's Reviewed-by
> - Add Olek's Reviewed-by
> - Added note to commit message about disabled status
> - Add Olek's Reviewed-by
> 
> Changes in v4:
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Add Marcel Ziswiler's Ack
> - Move can nodes to module deviceteree include imx6ull-colibri.dtsi
> - Add Marcel Ziswiler's Ack
> 
> Changes in v3:
> - Add new commit message from Stefan's proposal on ML
> - Fix commit message
> - Fix commit title to "...imx6-apalis:..."
> 
> Changes in v2:
> - Deleted touchrevolution downstream stuff
> - Use generic node name
> - Better comment
> - Changed commit title to '...imx6qdl-apalis:...'
> - Deleted touchrevolution downstream stuff
> - Use generic node name
> - Put a better comment in there
> - Commit title
> - Removed f0710a
> that is downstream only
> - Changed to generic node name
> - Better comment
> 
> Max Krummenacher (2):
>   ARM: dts: imx6ull-colibri: reduce v_batt current in power off
>   ARM: dts: imx6ull: improve can templates
> 
> Philippe Schenker (9):
>   ARM: dts: imx7-colibri: Add touch controllers
>   ARM: dts: imx6qdl-colibri: Add missing pin declaration in iomuxc
>   ARM: dts: imx6qdl-apalis: Add sleep state to can interfaces
>   ARM: dts: imx6-apalis: Add touchscreens used on Toradex eval boards
>   ARM: dts: imx6-colibri: Add missing pinmuxing to Toradex eval board
>   ARM: dts: imx6ull-colibri: Add sleep mode to fec
>   ARM: dts: imx6ull-colibri: Add watchdog
>   ARM: dts: imx6ull-colibri: Add general wakeup key used on Colibri
>   ARM: dts: imx6ull-colibri: Add touchscreen used with Eval Board

Applied all, but except this one which uses base64
Content-Transfer-Encoding.

Shawn

> 
> Stefan Agner (2):
>   ARM: dts: imx7-colibri: add GPIO wakeup key
>   ARM: dts: imx7-colibri: fix 1.8V/UHS support
> 
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 39 +++++++++++
>  arch/arm/boot/dts/imx6q-apalis-eval.dts       | 13 ++++
>  arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 13 ++++
>  arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 13 ++++
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 27 ++++++--
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 17 +++++
>  .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 38 +++++++++++
>  .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi |  2 +-
>  arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   |  2 +-
>  arch/arm/boot/dts/imx6ull-colibri.dtsi        | 64 +++++++++++++++++--
>  arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi   | 38 +++++++++++
>  arch/arm/boot/dts/imx7-colibri.dtsi           | 30 ++++++++-
>  12 files changed, 280 insertions(+), 16 deletions(-)
> 
> -- 
> 2.23.0
> 
