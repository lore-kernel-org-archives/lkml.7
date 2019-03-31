Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F83C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 14:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D720882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 14:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbfCaOBX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 10:01:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51402 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfCaOBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 10:01:23 -0400
Received: from p5b1271a2.dip0.t-ipconnect.de ([91.18.113.162] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hAb1Q-0000NF-BB; Sun, 31 Mar 2019 16:01:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] drm: rockchip: introduce rk3066 hdmi
Date:   Sun, 31 Mar 2019 16:01:15 +0200
Message-ID: <3503295.Ps5hWAbIar@phil>
In-Reply-To: <20190330095639.14626-2-jbx6244@gmail.com>
References: <20190330095639.14626-1-jbx6244@gmail.com> <20190330095639.14626-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Samstag, 30. März 2019, 10:56:36 CEST schrieb Johan Jonker:
> From: Zheng Yang <zhengyang@rock-chips.com>
> 
> The RK3066 HDMI TX serves as interface between a LCD Controller and
> a HDMI bus. A HDMI TX consists of one HDMI transmitter controller and
> one HDMI transmitter PHY. The interface has three (3) 8-bit data channels
> which can be configured for a number of bus widths (8/10/12/16/20/24-bit)
> and different video formats (RGB, YCbCr).
> 
> Features:
> HDMI version 1.4a, HDCP revision 1.4 and
> DVI version 1.0 compliant transmitter.
> Supports DTV resolutions from 480i to 1080i/p HD.
> Master I2C interface for a DDC connection.
> HDMI TX supports multiple power save modes.
> The HDMI TX input can switch between LCDC0 and LCDC1.
> (Sound support is not included in this patch)
> 
> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied to drm-misc-next with a smallish change as described below,
please double check. [0]

> +static int
> +rk3066_hdmi_probe_single_connector_modes(struct drm_connector *connector,
> +					 uint32_t maxX, uint32_t maxY)
> +{

instead of

> +	return drm_helper_probe_single_connector_modes(connector, 1920, 1080);

it is now doing

+	if (maxX > 1920)
+		maxX = 1920;
+	if (maxY > 1080)
+		maxY = 1080;
+
+	return drm_helper_probe_single_connector_modes(connector, maxX, maxY);

to take into account maxX / maxY being already below 1920x1080

> +}


Heiko

[0] https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f84d3d37b7fbb022e33b79d54374466f6fbc7186


