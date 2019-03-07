Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845DD2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552000406;
	bh=INjc24gcVImPOVJ/sMT6g77Zw1IbvRfAw2yxX06dDzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C/KuCAdLGhsoZtIRcLgqD182l75cP6KN541hh7RlainQSbB+GPTEWicbCk4Z+Xc7v
	 MHCIBe4lINwBoXnp8B/xilCkfnpih79W8yrnuNzMCZza8vrngalNwxEMnxOLuybfny
	 UGDhEaNIjeulFjFZbi35dQohawpaBAbOcynW7mx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCGXNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:13:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCGXNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:13:24 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C6BA2085A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552000403;
        bh=INjc24gcVImPOVJ/sMT6g77Zw1IbvRfAw2yxX06dDzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EoksDNfCFXl5A+ve8NhBGl5MyXtiHYzJOCBKo9QpJSO0TGrfgd9ce9mPjw0thzXRC
         LGCUy6HWulglN1N8sC3Xbx9xuMV2nZ6MipFy/oM2Wd0Em+M02u31PfP3WwWVMUsIxe
         l5eZDJLZiGaQ/cUABiSbGaldUimU7iaB0rJE+8gw=
Received: by mail-qk1-f172.google.com with SMTP id x9so10169146qkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:13:23 -0800 (PST)
X-Gm-Message-State: APjAAAXyxQHbSQIy91voV1bNrU29DybKTkS+3MkC150kuW3BBWJtOrB0
        8crP59WQrjQC8xuTzs7x1vAZ9Iqw9p6x87Ggjg==
X-Google-Smtp-Source: APXvYqyTIEKMIo+xzytE9QrZ1wmMm0DPywRYpBsHAmj72MSJaWnsavZw5xfRKKhsyprvsUZdkgG5oEXgvLOw3rJD2xU=
X-Received: by 2002:a05:620a:13f1:: with SMTP id h17mr5451207qkl.147.1552000402566;
 Thu, 07 Mar 2019 15:13:22 -0800 (PST)
MIME-Version: 1.0
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com> <1549022873-40549-2-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1549022873-40549-2-git-send-email-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Mar 2019 17:13:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLa1QNYTo+Yj-5fC4k8C1bd+V8qi5LiHgLA_qZY+Gy5cg@mail.gmail.com>
Message-ID: <CAL_JsqLa1QNYTo+Yj-5fC4k8C1bd+V8qi5LiHgLA_qZY+Gy5cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        linux-amlogic@lists.infradead.org, Huicong Xu <xhc@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 6:08 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
> Scrambling when supported or mandatory.
>
> This patch also adds an helper to setup the control bit to support
> the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
>
> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
> on the Rockchip 4.4 BSP kernel at [1]
>
> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
>
> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> Cc: Huicong Xu <xhc@rock-chips.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 85 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
>  include/drm/bridge/dw_hdmi.h              |  1 +
>  3 files changed, 85 insertions(+), 2 deletions(-)

This commit in drm-misc-next is breaking booting on the Rock960. I
have FB and fbcon enabled. The boot hangs after this message:

[    3.012334] [drm:rockchip_drm_fbdev_create] FB [1920x1080]-24
kvaddr=(____ptrval____) offset=0 size=8294400

Rob
