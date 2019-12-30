Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC50EC2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23D82071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfL3JEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:04:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35432 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfL3JEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:04:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A6F8926AE6A
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
Subject: [PATCH v24 0/2] drm/bridge: PS8640 MIPI-to-eDP bridge
Date:   Mon, 30 Dec 2019 10:04:17 +0100
Message-Id: <20191230090419.137141-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is another version of the driver. Note that the driver changed
significally and is a more simply because now is using the panel_bridge
helpers. Apart from this, I addressed the comments from Maxime, Laurent
and Ezequiel.

This bridge is required to have the embedded display working on an Acer
Chromebook R13 ("Elm"). Hopefully we are a bit more close to have this
driver merged. If more changes are required, please let me know and I
will work on it.

Note: Along these around 20 revisions of this driver I was unable to
reconstruct the full changelog history, so I'm skipping this. Sorry
about that, I promise I'll maintain the changelog for future revisions.

Thanks,
 Enric

Changes in v24:
- Fix GPIO polarity as all GPIO descriptors should be handled as active high (Laurent Pinchart)
- Make static ps8640_bridge_attach (Ezequiel Garcia)
- Use a define for the number of lanes (Ezequiel Garcia)

Changes in v23:
- Merge mute/unmute functions into one (Nicolas Boichat)
- Use enum for ENABLE/DISABLE instead of bool (Ezequiel Garcia)
- Rename mute/unmute to vdo_control and fix error messages (Nicolas Boichat and Enric)
- Add space between address and address parameter 'address%02x' (Nicolas Boichat)
- Add Tested-by Hsin-Yi
- Added me as author after the refactor

Changes in v22:
- Migrate to YAML format (Maxime Ripart)
- Remove mode-sel property.
- Rename sleep-gpios to powerdown-gpios.
- Remove sysfs attributes because are not really used (Enric Balletbo)
- Use enum for address page offsets (Ezequiel Garcia)
- Remove enable tracking (Enric Balletbo)
- Use panel_bridge API (Laurent Pinchart)
- Do not use kernel-doc format for non kernel-doc formatted commands (Enric Balletbo)
- Remove verbose message for PAGE1_VSTART command (Ezequiel Garcia)
- Use time_is_after_jiffies idiom (Ezequiel Garcia)
- Remove unused macros (Ezequiel Garcia)
- Fix weird alignment in dsi->mode_flags (Laurent Pinchart)
- Use drm_of_find_panel_or_bridge helper (Laurent Pinchart)
- Remove mode-sel-gpios as is not used (Laurent Pinchart)
- Remove error messages to get gpios as the core will already report it (Enric Balletbo)
- Remove redundant message getting the regulators (Laurent Pinchart)
- Rename sleep-gpios to powerdown-gpios (Laurent Pinchart)
- Use ARRAY_SIZE(ps_bridge->page) instead of MAX_DEV when possible (Laurent Pinchart)
- Fix race with userspace accessing the sysfs attributes (Laurent Pinchart)
- Remove id_table as is only used on DR platforms (Laurent Pinchart)
- Convert to new i2c device probe() (Laurent Pinchart)
- Use i2c_smbus_read/write helpers instead of open coding it (Laurent Pinchart)
- Remove unnused global variables (Laurent Pinchart)
- Remove unnused fields in ps8640 struct (Laurent Pinchart)
- Remove commented-out headers (Laurent Pinchart)

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

 .../bindings/display/bridge/ps8640.yaml       | 112 ++++++
 drivers/gpu/drm/bridge/Kconfig                |  11 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/parade-ps8640.c        | 348 ++++++++++++++++++
 4 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ps8640.yaml
 create mode 100644 drivers/gpu/drm/bridge/parade-ps8640.c

-- 
2.24.1

