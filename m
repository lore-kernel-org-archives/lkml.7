Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D222C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD70E2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgAHNvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:51:36 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50617 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgAHNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:51:36 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1HmG-1irvZ64Bre-002q6O; Wed, 08 Jan 2020 14:51:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drm: panel: fix excessive stack usage in td028ttec1_prepare
Date:   Wed,  8 Jan 2020 14:51:05 +0100
Message-Id: <20200108135116.3687988-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tKeoXcUsVKacqijm/XBhh86H/1egpokkSRB3oJsHcu9HgP2Y928
 1GSfviPvOtLi8YZQaeX23+XqClPiJrywRCkJJRGjf8vAfQfiopAva7YFo0tnacKJDhyia6v
 nYYGyu/22VW3xwc/I5Kcaf1stwZOTbn9Uk/fdCdpa1CSzmYXbgEVMI+3dfKJEF4pjqd14+w
 b59uP2AOjmLkOyP7/qYkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NnEmuwJCtxs=:oQlhA3d15KmrDDp73DbB0R
 U7msgIXTj8DRZ7ZrBKZLKvIrfwFqeca2gA0mT+PqYsfFdPcEnp1ZC3zWHC2xBcgDPOGZsWzzl
 qb9ZLn7st+2WRFQrYuQsWDjlkVaspQM0B2WnTx9It2RRS3DGhV2Lkjs0Q2vU1fx/7MGIF5WSu
 kGYCMb53pgJ2HYcovEzYuid8cYXX5/861XJdOaPAXdL5I5AYqSqwCjmAH1xbT6kY0yhicMryT
 cTcsoqUh/Sf8/BApRfpBnwB4vTkPcsYoV37klsMNv3YDr1lNikGT2CBGAECCHH8o8OS4Zx+JP
 9o6EtHjZiD8Imdqw7d8LS6Vml+HSqm3lkjMaDtvspGnHhJGPj64qq7TXeu0GgxQehWo1GgeSu
 flj2aAqmHkdG7eYGvjjYx5E5lY1/IWPnPIN2jGMDhgJi13/pW0PEpUivk0tVeA1/5OQ+hj3/0
 DTc+8bYQ7WuKfeZNk2MGF9IJjLF0MYutC2lFJFOdlzG2M776WmWxFm7GR/u3uICcm1kSmujZh
 5L42Hmf5xYNNx30ORmqdu5YbxxLV8/EBWjuY7L/fGaftxxaZGzsRUBQAD9Ro84w7CqMfro/cm
 X9q7to4wGHu+fHoSsKpEau53GNaifrLcUkuNzoWP6xhMpOv9d5YVdUEEXH5TX6aQaRL/qKWm1
 Nk6bhDXJIn5iPWO48+ktnkqEh0poK9EHaarqjycpI5kXXEQkgcUhr5So2Hv03gyEkn2wFZhrP
 f5HEks8KlKwNE9KrnrOZNyoT5MhJIyo7U9S/PVV93Ai76ZRiXjstI+6ncpHTgecskFFMuJ08e
 3YPWm8AhJ3af1iLELo/25DOT5sDSUb/WvM7woQSnDhHYFHo2D2ePg1+iyjmPmTULo/FjB7xSS
 oHJev4NpXbZzpWwc309w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc -O3 in combination with the structleak plug, the compiler can
inline very aggressively, leading to rather large stack usage:

drivers/gpu/drm/panel/panel-tpo-td028ttec1.c: In function 'td028ttec1_prepare':
drivers/gpu/drm/panel/panel-tpo-td028ttec1.c:233:1: error: the frame size of 2768 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
 }

Marking jbt_reg_write_*() as noinline avoids the case where
multiple instances of this function get inlined into the same
stack frame and each one adds a copy of 'tx_buf'.

The compiler is clearly making some bad decisions here, but I
did not open a new bug report as this only happens in combination
with the structleak plugin.

Link: https://lore.kernel.org/lkml/CAK8P3a3jAnFZA3GFRtdYdg1-i-oih3pOQzkkrK-X3BGsFrMiZQ@mail.gmail.com/
Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
- mark all three functions as noinlien
- add code comment
- add link to more detailed analysis
---
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
index cf29405a2dbe..5034db8b55de 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
@@ -86,7 +86,12 @@ struct td028ttec1_panel {
 
 #define to_td028ttec1_device(p) container_of(p, struct td028ttec1_panel, panel)
 
-static int jbt_ret_write_0(struct td028ttec1_panel *lcd, u8 reg, int *err)
+/*
+ * noinline_for_stack so we don't get multiple copies of tx_buf
+ * on the stack in case of gcc-plugin-structleak
+ */
+static int noinline_for_stack
+jbt_ret_write_0(struct td028ttec1_panel *lcd, u8 reg, int *err)
 {
 	struct spi_device *spi = lcd->spi;
 	u16 tx_buf = JBT_COMMAND | reg;
@@ -105,7 +110,8 @@ static int jbt_ret_write_0(struct td028ttec1_panel *lcd, u8 reg, int *err)
 	return ret;
 }
 
-static int jbt_reg_write_1(struct td028ttec1_panel *lcd,
+static int noinline_for_stack
+jbt_reg_write_1(struct td028ttec1_panel *lcd,
 			   u8 reg, u8 data, int *err)
 {
 	struct spi_device *spi = lcd->spi;
@@ -128,7 +134,8 @@ static int jbt_reg_write_1(struct td028ttec1_panel *lcd,
 	return ret;
 }
 
-static int jbt_reg_write_2(struct td028ttec1_panel *lcd,
+static int noinline_for_stack
+jbt_reg_write_2(struct td028ttec1_panel *lcd,
 			   u8 reg, u16 data, int *err)
 {
 	struct spi_device *spi = lcd->spi;
-- 
2.20.0

