Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1CE21019
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDAKfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:35:45 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35136 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfDAKfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:35:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 82C9DFB05;
        Mon,  1 Apr 2019 12:35:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 88NIVB1lk3W7; Mon,  1 Apr 2019 12:35:35 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 347D344B5C; Mon,  1 Apr 2019 12:35:35 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
Date:   Mon,  1 Apr 2019 12:35:32 +0200
Message-Id: <cover.1554114302.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 fixes up the DT binding example and uses a wider cc list since I
failed to extend that when touching more files.

The panel is a 5.5" 720x1440 TFT LCD MIPI DSI panel with built in
touchscreen and backlight as found in the Librem 5 devkit.

These patches are against linux next as of 2019-03-22. v3 got acked by Sam
Ravnborg:

  https://lists.freedesktop.org/archives/dri-devel/2019-March/209326.html

Changes from v4
* As per review comments from Fabio Estevam
  * Add missing unit name in dt binding docs

Changes from v3
* Forward to next-20190322
* Add MAINTAINERS entry

Changes from v2
* As per review comments from Sam Ravnborg
  * Lowercase sentinel
  * Drop '_panel' postfix
  * DRM_DEV_ logging instead of plain DRM_
* Add Reviewed-by:
* Add "panel-rocktech-" to the driver name following
  the pattern from other drm panel drivers.

Changes from v1
* As per review comments from Sam Ravnborg
  * Make SPDX-License-Identifier match MODULE_LICENSE
  * Sort include files alphabetically
  * Drop drmP.h and use individual includes
  * Drop superfuous 'x' in mode printout on error path
  * Allpixelson_set: Add proper space around '*'
  * Drop superfluous put_device(&ctx->backlight->dev);
  * Add /* Sentinel */ in jh057n_of_match
  * Drop jh057n->enabled
  * Drop drm_display_info_set_bus_formats
* Kconfig: Depend on BACKLIGHT_CLASS_DEVICE which somehow got lost
* Move jh057n_enable close to jh057n_disable

Guido Günther (3):
  dt-bindings: Add vendor prefix for ROCKTECH DISPLAYS LIMITED
  dt-bindings: Add Rocktech jh057n00900 panel bindings
  drm/panel: Add Rocktech jh057n00900 panel driver

 .../display/panel/rocktech,jh057n00900.txt    |  18 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-rocktech-jh057n00900.c    | 386 ++++++++++++++++++
 6 files changed, 425 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
 create mode 100644 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c

-- 
2.20.1

