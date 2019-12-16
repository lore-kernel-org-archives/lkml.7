Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD400C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE308206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfLPN6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:58:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59930 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfLPN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:58:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AC99B291972
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ulrich Hecht <uli@fpond.eu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v21 0/2] drm/bridge: PS8640 MIPI-to-eDP bridge
Date:   Mon, 16 Dec 2019 14:58:32 +0100
Message-Id: <20191216135834.27775-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This driver seems to continue failing to reach upstream. The latest
version send by Ulrich [1] one month ago, seems to fix all the issues
that prevented the driver to get merged, but, recent changes ended with
this driver not building in current mainline. This new version is like a
RESEND with these build errors fixed, and also a couple of few changes more
to use device managed resources when available.

This bridge is required to have the embedded display working on an Acer
Chromebook R13 ("Elm"). Hopefully we are a bit more close to have this
driver merged. If more changes are required, please let me know and I
will work on it.

Note: Along these around 20 revisions of this driver I was unable to
reconstruct the full changelog history, so I'm skipping this. Sorry
about that, I promise I'll maintain the changelog for future revisions.

Thanks,
 Enric

[1] https://patchwork.kernel.org/cover/11176929/

Changes in v21:
 - Use devm_i2c_new_dummy_device and fix build issue using deprecated i2c_new_dummy
 - Fix build issue due missing drm_bridge.h
 - Do not remove in ps8640_remove device managed resources

Changes in v19:
 - fixed return value of ps8640_probe() when no panel is found

Changes in v18:
 - followed DRM API changes
 - use DEVICE_ATTR_RO()
 - remove firmware update code
 - add SPDX identifier

Changes in v17:
 - remove some unused head files.
 - add macros for ps8640 pages.
 - remove ddc_i2c client
 - add mipi_dsi_device_register_full
 - remove the manufacturer from the name and i2c_device_id

Changes in v16:
 - Disable ps8640 DSI MCS Function.
 - Rename gpios name more clearly.
 - Tune the ps8640 power on sequence.

Changes in v15:
 - Drop drm_connector_(un)register calls from parade ps8640.
   The main DRM driver mtk_drm_drv now calls
   drm_connector_register_all() after drm_dev_register() in the
   mtk_drm_bind() function. That function should iterate over all
   connectors and call drm_connector_register() for each of them.
   So, remove drm_connector_(un)register calls from parade ps8640.

Changes in v14:
 - update copyright info.
 - change bridge_to_ps8640 and connector_to_ps8640 to inline function.
 - fix some coding style.
 - use sizeof as array counter.
 - use drm_get_edid when read edid.
 - add mutex when firmware updating.

Changes in v13:
 - add const on data, ps8640_write_bytes(struct i2c_client *client, const u8 *data, u16 data_len)
 - fix PAGE2_SW_REST tyro.
 - move the buf[3] init to entrance of the function.

Changes in v12:
 - fix hw_chip_id build warning

Changes in v11:
 - Remove depends on I2C, add DRM depends
 - Reuse ps8640_write_bytes() in ps8640_write_byte()
 - Use timer check for polling like the routines in <linux/iopoll.h>
 - Fix no drm_connector_unregister/drm_connector_cleanup when ps8640_bridge_attach fail
 - Check the ps8640 hardware id in ps8640_validate_firmware
 - Remove fw_version check
 - Move ps8640_validate_firmware before ps8640_enter_bl
 - Add ddc_i2c unregister when probe fail and ps8640_remove

Jitao Shi (2):
  Documentation: bridge: Add documentation for ps8640 DT properties
  drm/bridge: Add I2C based driver for ps8640 bridge

 .../bindings/display/bridge/ps8640.txt        |  44 ++
 drivers/gpu/drm/bridge/Kconfig                |  11 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/parade-ps8640.c        | 655 ++++++++++++++++++
 4 files changed, 711 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ps8640.txt
 create mode 100644 drivers/gpu/drm/bridge/parade-ps8640.c

-- 
2.20.1

