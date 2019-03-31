Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0B0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E7020870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfCaQTy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:19:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51986 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731176AbfCaQTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:19:54 -0400
Received: from p5b1271a2.dip0.t-ipconnect.de ([91.18.113.162] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hAdBS-0000sn-8k; Sun, 31 Mar 2019 18:19:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] drm: rockchip: add fixed screen size DVI-D support for rk3066 hdmi
Date:   Sun, 31 Mar 2019 18:19:45 +0200
Message-ID: <4928946.oK5HkskicG@phil>
In-Reply-To: <20190321001440.31057-6-jbx6244@gmail.com>
References: <20190321001440.31057-1-jbx6244@gmail.com> <20190321001440.31057-6-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Donnerstag, 21. März 2019, 01:14:40 CEST schrieb Johan Jonker:
> Add fixed screen size DVI-D support
> for rk3066 hdmi with an extra patch.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

> +static const struct drm_display_mode edid_cea_modes[] = {
> +	/* 4 - 1280x720@60Hz 16:9 */
> +	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74250, 1280, 1390,
> +		   1430, 1650, 0, 720, 725, 730, 750, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +};

you already dropped this patch from v6, but just for completeness sake,
I don't think there should be a static mode for dvi displays.

Similar to hdmi, dvi also can use ddc to read the monitor edid and some
sort of static mode might behave badly if for example a display with less
than this 720p is connected.

I think I remember reading in the Rockchip tree that they added that for
the case reading the edid fails, but if that happens the reading should
be fixed and not worked around a failure :-)


Heiko


