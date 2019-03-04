Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C5CC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF53206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfCDRxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:53:19 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:60056 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfCDRxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:53:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E5C0EFB06;
        Mon,  4 Mar 2019 18:53:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gsKglCX0H-40; Mon,  4 Mar 2019 18:53:12 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9DC45414F2; Mon,  4 Mar 2019 18:53:11 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
Date:   Mon,  4 Mar 2019 18:53:08 +0100
Message-Id: <cover.1551710977.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a 5.5" 720x1440 TFT LCD MIPI DSI panel with built in touchscreen and
backlight as found in the Librem 5 devkit.

These patches are against linux next as of 2019-02-08.

Changes from v2
* As per review comments from Sam Ravnborg
  * Lowercase sentinel
  * Drop '_panel' postfix
  * DRM_DEV_ logging instead of plain DRM_
* Add Sam's Reviewed-by:
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
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-rocktech-jh057n00900.c    | 386 ++++++++++++++++++
 5 files changed, 419 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
 create mode 100644 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c

-- 
2.20.1

