Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F32C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBFD2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TPP9KpyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391583AbfETO3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:29:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfETO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:29:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so13297308wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Og70WNEmTdPgbTBwIRYC9peTJhdQFaT0tNDc4FieJXc=;
        b=TPP9KpyDP5vFcpOUw/yQA9W/7WkWxhJ4C6bvuAOIO3Zd0xodBwQeHmJmrNhVxvJxSo
         9zcZepW+8OAYij4hDgHL3mkM7ndI03U2r2xQ947iq9uKcTTvVsTOicx8U3JWR+B5mtYs
         kRjSzpEVreiB7QeDqbcDthFHNLT8jD3pnVltpt5RnmnR237hjSdNlV6eOZfRseDWe8db
         hud0mwJpNHZvTjE88JeRa73DbQkJSLBILJ384Um7aGGmOV2sziedkUkBknuTBPwkC8u/
         gx/ADw6WALNpBA8IPUUm8ZD0scgLV7XSQ/xZU66lEjzzWhbLJNAOabWbDrIoB17zkNkF
         Lg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Og70WNEmTdPgbTBwIRYC9peTJhdQFaT0tNDc4FieJXc=;
        b=YIkeYU8UQY8UHuTWM70peEFNgL/2o3RkYi8zYjc2eVzfJGlBHg/k6beW1nFPoM1/Q4
         sTviB0+lLHeC9+GGUnXHYI2q3iZk961/4hK4pEGP9hESEauQ127kl2m5yflWyH/Qh0bn
         M1qSRiNyTuU10T3DLpyG7T3pT7aYrOxiKghyT/l1XemRx9QVW7GOeYjmhSwiEpRL3B7u
         U9AMSiRDzrZnGB0yGLjE9iH67r0KVwRjKeD/tKUEOR58dEkednsODlQV4o9Ov5IBIrAA
         ylWxVTtoEiPhW8JsLNxp7bVxpZXZMdEPj2dw82vh0+qM73uuam0A59Ap1lp8EYSRkulF
         z9iQ==
X-Gm-Message-State: APjAAAUaW1u/ahEHFbkiwnivt+BRkhj43Bgb8/EHAEGSH/Eb4U2j7vdc
        0Fvkkyf8zprDjnwP90AznhJzWw==
X-Google-Smtp-Source: APXvYqzY3iiWaTBWNafX3BRMqsugNaiEAhJbQ39kbQ1xWgZg6oMj3evRkAqgQhnoNxmYWAjvj5Cjfg==
X-Received: by 2002:a1c:a695:: with SMTP id p143mr12584472wme.128.1558362569098;
        Mon, 20 May 2019 07:29:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q13sm17750808wrn.27.2019.05.20.07.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:29:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] drm/meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:29:27 +0200
Message-Id: <20190520142927.1009-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c      | 15 +--------------
 drivers/gpu/drm/meson/meson_crtc.h      | 15 +--------------
 drivers/gpu/drm/meson/meson_drv.c       | 15 +--------------
 drivers/gpu/drm/meson/meson_drv.h       | 14 +-------------
 drivers/gpu/drm/meson/meson_dw_hdmi.c   | 14 +-------------
 drivers/gpu/drm/meson/meson_dw_hdmi.h   | 14 +-------------
 drivers/gpu/drm/meson/meson_plane.c     | 15 +--------------
 drivers/gpu/drm/meson/meson_plane.h     | 15 +--------------
 drivers/gpu/drm/meson/meson_registers.h | 12 +-----------
 drivers/gpu/drm/meson/meson_vclk.c      | 14 +-------------
 drivers/gpu/drm/meson/meson_vclk.h      | 14 +-------------
 drivers/gpu/drm/meson/meson_venc.c      | 14 +-------------
 drivers/gpu/drm/meson/meson_venc.h      | 14 +-------------
 drivers/gpu/drm/meson/meson_venc_cvbs.c | 15 +--------------
 drivers/gpu/drm/meson/meson_venc_cvbs.h | 15 +--------------
 drivers/gpu/drm/meson/meson_viu.c       | 14 +-------------
 drivers/gpu/drm/meson/meson_viu.h       | 14 +-------------
 drivers/gpu/drm/meson/meson_vpp.c       | 14 +-------------
 drivers/gpu/drm/meson/meson_vpp.h       | 14 +-------------
 19 files changed, 19 insertions(+), 252 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 5579f8ac3e3f..a8416b6b7782 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * Written by:
  *     Jasper St. Pierre <jstpierre@mecheye.net>
  */
diff --git a/drivers/gpu/drm/meson/meson_crtc.h b/drivers/gpu/drm/meson/meson_crtc.h
index b62b9e51764d..4f0f212e51db 100644
--- a/drivers/gpu/drm/meson/meson_crtc.h
+++ b/drivers/gpu/drm/meson/meson_crtc.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * Written by:
  *     Jasper St. Pierre <jstpierre@mecheye.net>
  */
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 72b01e6be0d9..26be64b94237 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * Written by:
  *     Jasper St. Pierre <jstpierre@mecheye.net>
  */
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index 9614baa836b9..0d27556f2838 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -1,19 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef __MESON_DRV_H
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 779da21143b9..a42a15b87974 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.h b/drivers/gpu/drm/meson/meson_dw_hdmi.h
index 03e2f0c1a2d5..4e48b5e0ffe8 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.h
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef __MESON_DW_HDMI_H
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index bf8f1fab63aa..9f6070c4386c 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * Written by:
  *     Jasper St. Pierre <jstpierre@mecheye.net>
  */
diff --git a/drivers/gpu/drm/meson/meson_plane.h b/drivers/gpu/drm/meson/meson_plane.h
index e26b8b0aa1fa..1a414284d6b8 100644
--- a/drivers/gpu/drm/meson/meson_plane.h
+++ b/drivers/gpu/drm/meson/meson_plane.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * Written by:
  *     Jasper St. Pierre <jstpierre@mecheye.net>
  */
diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index cfaf90501bb1..5ba1b599c5cf 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -1,16 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  */
 
 #ifndef __MESON_REGISTERS_H
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index b39034745444..69e2bebd6bd5 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/gpu/drm/meson/meson_vclk.h b/drivers/gpu/drm/meson/meson_vclk.h
index 4bd8752da02a..444216649e6b 100644
--- a/drivers/gpu/drm/meson/meson_vclk.h
+++ b/drivers/gpu/drm/meson/meson_vclk.h
@@ -1,19 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /* Video Clock */
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 6faca7313339..bd3bb436ce37 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 97eaebbfa0c4..9ea56b7607fc 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -1,19 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index 2c5341c881c4..d24ef94c7fe2 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * Written by:
  *     Jasper St. Pierre <jstpierre@mecheye.net>
  */
diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.h b/drivers/gpu/drm/meson/meson_venc_cvbs.h
index 9256ccf9d931..2c6d9006c391 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.h
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * Written by:
  *     Jasper St. Pierre <jstpierre@mecheye.net>
  */
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index b59072342cae..f8e032df17bd 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -1,21 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/gpu/drm/meson/meson_viu.h b/drivers/gpu/drm/meson/meson_viu.h
index 0f84bddd2ff0..2b9b30655fac 100644
--- a/drivers/gpu/drm/meson/meson_viu.h
+++ b/drivers/gpu/drm/meson/meson_viu.h
@@ -1,19 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /* Video Input Unit */
diff --git a/drivers/gpu/drm/meson/meson_vpp.c b/drivers/gpu/drm/meson/meson_vpp.c
index 8c52a3455ef4..a03ce09af8a3 100644
--- a/drivers/gpu/drm/meson/meson_vpp.c
+++ b/drivers/gpu/drm/meson/meson_vpp.c
@@ -1,21 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
  * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/gpu/drm/meson/meson_vpp.h b/drivers/gpu/drm/meson/meson_vpp.h
index 815177cc7dfd..de7cea1985ad 100644
--- a/drivers/gpu/drm/meson/meson_vpp.h
+++ b/drivers/gpu/drm/meson/meson_vpp.h
@@ -1,19 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /* Video Post Process */
-- 
2.21.0

