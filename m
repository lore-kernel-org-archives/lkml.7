Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A87C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70B4222C5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9jJVItZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCXNGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 09:06:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37156 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCXNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 09:06:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so4586777pgq.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yOOufHbnikMM1LiQJPeWitOPftHSPpAB3K4xz2kxR88=;
        b=f9jJVItZLZc+iIINfiByXwhSaxXneKFmTm4B6oGtCevYiLEHBZ5oyS/eGUw058u9Sk
         sAFsiCd77HXmJHlZCTBYcZYaqmUxyVJni1AuPaLDdhOLOg3H03uqUY6sfaA4D1N2zOkr
         6KttsynIrKEkrywuedKion+cXrc5hQuuq2DRDdfrCdkMmGC7wAyAhyivSMoQrgnLDQM8
         nFnJqTMQt3pKF+fWOL3r9f/vjgaan/jC/icCVfEK1MM/aipFzWuvYbP3lApd7e9v7ViF
         YNRAOlMBNH9BuqrzklpoTQUJMZpmb+fKSjXRF7igXAXZaVXSCtnIr1K1JBYN7I0b2g7R
         Z49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yOOufHbnikMM1LiQJPeWitOPftHSPpAB3K4xz2kxR88=;
        b=Soz6IKXpoxl3dRHkq/TfqKE5KvnkZTO5jlBjzvf8nyPja9Iz/O/rmzx04M3SpOLK0h
         qEhPaRI9FNUpkMKEpB6j4YNZVfGMf9ptzARlnIGKzLwkoiPSFCHH3UlqnhqRVIiM9naK
         OZQZmxFhPFA8ha3JeEuFLwDr/0jqE7OI/WTnp4UXTinLnl0VL0o4gGHBSNIiRc7GG0Jp
         eYR+cb9HTq8eztKrqIcX5f9e0J3+iA7GfdgBGloQlEel38m9ZV0Uy0xqT0dc+4dpWwXk
         T8qGJwhqfpXMjE+8zn6Vh2XeRIhrZLR7KzUFKHEFmewlN66RJ6nVysnv+Jt78mwMy3bP
         kbnQ==
X-Gm-Message-State: APjAAAWqL4+uiS1j879pUIgFbJwApTLfyEdvzdXC8aY1eOLm5wXO0qlh
        7MApdYKR6qqKug1IhzceYkE=
X-Google-Smtp-Source: APXvYqyJvrDk2faL3BlavlJ5iJeVbAE2HYGF42ELOyRZp1px/UMzxAFxTDPcaKvmiDZBAka9fqw1pw==
X-Received: by 2002:a63:c06:: with SMTP id b6mr18477840pgl.440.1553432812962;
        Sun, 24 Mar 2019 06:06:52 -0700 (PDT)
Received: from localhost.localdomain ([103.252.26.177])
        by smtp.gmail.com with ESMTPSA id s79sm26395687pfa.61.2019.03.24.06.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 06:06:51 -0700 (PDT)
From:   grbesd1@gmail.com
To:     forest@alittletooquiet.net
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, Ganesh Biradar <grbesd1@gmail.com>
Subject: [PATCH 01/01] staging: vt6655: Modify comment style of SPDX License Identifier
Date:   Sun, 24 Mar 2019 18:36:09 +0530
Message-Id: <20190324130609.7571-1-grbesd1@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganesh Biradar <grbesd1@gmail.com>

Fix the comment style of SPDX license identifier based on header file
type

Signed-off-by: Ganesh Biradar <grbesd1@gmail.com>
---
 drivers/staging/vt6655/channel.h    | 2 +-
 drivers/staging/vt6655/desc.h       | 2 +-
 drivers/staging/vt6655/device.h     | 2 +-
 drivers/staging/vt6655/device_cfg.h | 2 +-
 drivers/staging/vt6655/dpc.h        | 2 +-
 drivers/staging/vt6655/key.h        | 2 +-
 drivers/staging/vt6655/mac.h        | 2 +-
 drivers/staging/vt6655/power.h      | 2 +-
 drivers/staging/vt6655/rf.h         | 2 +-
 drivers/staging/vt6655/rxtx.h       | 2 +-
 drivers/staging/vt6655/srom.h       | 2 +-
 drivers/staging/vt6655/tmacro.h     | 2 +-
 drivers/staging/vt6655/upc.h        | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6655/channel.h b/drivers/staging/vt6655/channel.h
index 53f623a4af65..0d2709607456 100644
--- a/drivers/staging/vt6655/channel.h
+++ b/drivers/staging/vt6655/channel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/desc.h b/drivers/staging/vt6655/desc.h
index b4a0037b40c1..d4572847b08a 100644
--- a/drivers/staging/vt6655/desc.h
+++ b/drivers/staging/vt6655/desc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 2f9e9219e8c8..29f354ced563 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/device_cfg.h b/drivers/staging/vt6655/device_cfg.h
index 6b41c74f7c2a..04db6a8d3db3 100644
--- a/drivers/staging/vt6655/device_cfg.h
+++ b/drivers/staging/vt6655/device_cfg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/dpc.h b/drivers/staging/vt6655/dpc.h
index 93af4220605f..eac67794cc49 100644
--- a/drivers/staging/vt6655/dpc.h
+++ b/drivers/staging/vt6655/dpc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/key.h b/drivers/staging/vt6655/key.h
index 0942d8703f98..9347776fa3a5 100644
--- a/drivers/staging/vt6655/key.h
+++ b/drivers/staging/vt6655/key.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b8ab09434773..8c8c26792343 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/power.h b/drivers/staging/vt6655/power.h
index 2ec40045fddb..d1736c1cbfa8 100644
--- a/drivers/staging/vt6655/power.h
+++ b/drivers/staging/vt6655/power.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/rf.h b/drivers/staging/vt6655/rf.h
index bfce5a89657d..042ac67a9709 100644
--- a/drivers/staging/vt6655/rf.h
+++ b/drivers/staging/vt6655/rf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/rxtx.h b/drivers/staging/vt6655/rxtx.h
index 08db848613f0..464dd89078b2 100644
--- a/drivers/staging/vt6655/rxtx.h
+++ b/drivers/staging/vt6655/rxtx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/srom.h b/drivers/staging/vt6655/srom.h
index 577f20dc4308..d8aad3ff5f46 100644
--- a/drivers/staging/vt6655/srom.h
+++ b/drivers/staging/vt6655/srom.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/tmacro.h b/drivers/staging/vt6655/tmacro.h
index 6795b5d74cfc..8f4699f0d1f4 100644
--- a/drivers/staging/vt6655/tmacro.h
+++ b/drivers/staging/vt6655/tmacro.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 61b3e568ff9a..d028ad2ba0d4 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
-- 
2.17.1

