Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F76C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB132082C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9LX/xrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfCaJS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:18:28 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:44948 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfCaJS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:18:28 -0400
Received: by mail-yb1-f177.google.com with SMTP id s1so2411354ybl.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l7mobgYMZ7KhPLLmG0+GZYT4Abqske1ZvXbxUuBIlGM=;
        b=r9LX/xrlaKmu6uUqEoJWnWTashwF97pUsjKGsY0++gPF50VR51IWlcDzFWpa2jWINS
         0ONR5j4ZzuLMKz1jEhh0+Xjk6aGpSVUIQFzTRgrZbCVogVocP2Qg6I8LC/qamrwVx3kk
         oU7kRl4g1FTkfgSU8Z/dxIAZ2/kunOJVthi9lO9IyqNTTXznU4obycXS8jATYRe1gd1M
         oTyCIS7JCipqt2s1+kupshqAHlstNgzUnLYFvEx9Tq5DMNTLpnoGQosTIz236i1Facbl
         wGa+0pAAj2xlsscXZgYN2CKrRIcEiTaONR3GfJZLtzb6cIpNIijuHnQVcjffQYZpr5Z9
         JtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l7mobgYMZ7KhPLLmG0+GZYT4Abqske1ZvXbxUuBIlGM=;
        b=eebkDpETg5ft/WD7Tm2FZ82Ax6/hdjQF2qU3SMBNVhIpRfOR3WV9uRXRclt4lVsK4L
         0zwNrCIMTbMOcJnGC9gIqcrepkprkD1RJHwdwejhYUH14j7gQ+y6q28diZGSecOXVRHu
         URD4VetkD/g+h8oepxm4mKmLN8Z4eiwlNYkjDf0qLK6Ydvmtv+2vKveQu1RNISLs6IOf
         9JQQ4gSRGUFBAkTqrsFgvwZ5bFNZrVrudePGsEcXGbvrqN6aYG1WPlOY09h6Vxo6Call
         DJaG6W52yY2e8ukDake4ggyk+/3Ey0bzwAflkKQUguZ31SFuLfYinErObb26AQm1Pv9o
         9S0Q==
X-Gm-Message-State: APjAAAVpQSwFNhdho/3mv+aO6HhP4rWxGrCr4JQL7oAsxzOoZuO/7LEN
        MjaGIHPGPiFOYCd55bKH3qg=
X-Google-Smtp-Source: APXvYqwkhv4gYOkMwW1S8MvXkX0kbYdeseS/WObHszgqoqFIrME7GfaRaxPMkLYt/5QBKHrR+uKP8w==
X-Received: by 2002:a25:1a46:: with SMTP id a67mr4682285yba.225.1554023906731;
        Sun, 31 Mar 2019 02:18:26 -0700 (PDT)
Received: from localhost.localdomain ([36.255.87.251])
        by smtp.googlemail.com with ESMTPSA id i75sm2497615ywa.29.2019.03.31.02.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Mar 2019 02:18:26 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin25111998@gmail.com>
Cc:     Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers/staging: Fix styling of the comment related to SPDX-License-Identifier in vt6656/*.h
Date:   Sun, 31 Mar 2019 14:44:36 +0530
Message-Id: <1554023786-12066-1-git-send-email-ojaswin25111998@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190331073825.GA9087@gmail.com>
References: <20190331073825.GA9087@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl styling error related to SPDX-License-Identifier
comment in vt6656/*.h
* v2: fix patch styling

Signed-off-by: Ojaswin Mujoo <ojaswin25111998@gmail.com>
---
 drivers/staging/vt6656/baseband.h | 2 +-
 drivers/staging/vt6656/card.h     | 2 +-
 drivers/staging/vt6656/channel.h  | 2 +-
 drivers/staging/vt6656/desc.h     | 2 +-
 drivers/staging/vt6656/device.h   | 2 +-
 drivers/staging/vt6656/dpc.h      | 2 +-
 drivers/staging/vt6656/firmware.h | 2 +-
 drivers/staging/vt6656/int.h      | 2 +-
 drivers/staging/vt6656/key.h      | 2 +-
 drivers/staging/vt6656/power.h    | 2 +-
 drivers/staging/vt6656/rf.h       | 2 +-
 drivers/staging/vt6656/rxtx.h     | 2 +-
 drivers/staging/vt6656/usbpipe.h  | 2 +-
 drivers/staging/vt6656/wcmd.h     | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.h b/drivers/staging/vt6656/baseband.h
index a907e30..c3b8bbd 100644
--- a/drivers/staging/vt6656/baseband.h
+++ b/drivers/staging/vt6656/baseband.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card.h
index 0a91d9b..75cd340 100644
--- a/drivers/staging/vt6656/card.h
+++ b/drivers/staging/vt6656/card.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/channel.h b/drivers/staging/vt6656/channel.h
index 6d0d282..cca330f 100644
--- a/drivers/staging/vt6656/channel.h
+++ b/drivers/staging/vt6656/channel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/desc.h b/drivers/staging/vt6656/desc.h
index ac45ebb..3a83a9e 100644
--- a/drivers/staging/vt6656/desc.h
+++ b/drivers/staging/vt6656/desc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index a2feeb9..6074ced 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/dpc.h b/drivers/staging/vt6656/dpc.h
index ddd0cb7..e080add 100644
--- a/drivers/staging/vt6656/dpc.h
+++ b/drivers/staging/vt6656/dpc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/firmware.h b/drivers/staging/vt6656/firmware.h
index f30ae90..161126f 100644
--- a/drivers/staging/vt6656/firmware.h
+++ b/drivers/staging/vt6656/firmware.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/int.h b/drivers/staging/vt6656/int.h
index 1e6ff92..987c454e9 100644
--- a/drivers/staging/vt6656/int.h
+++ b/drivers/staging/vt6656/int.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/key.h b/drivers/staging/vt6656/key.h
index 1306ff4..918c07c 100644
--- a/drivers/staging/vt6656/key.h
+++ b/drivers/staging/vt6656/key.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/power.h b/drivers/staging/vt6656/power.h
index d5a3198..58755ae 100644
--- a/drivers/staging/vt6656/power.h
+++ b/drivers/staging/vt6656/power.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/rf.h b/drivers/staging/vt6656/rf.h
index f77866a..6103117 100644
--- a/drivers/staging/vt6656/rf.h
+++ b/drivers/staging/vt6656/rf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index 44698f4..d528607 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/usbpipe.h b/drivers/staging/vt6656/usbpipe.h
index 5d7708f..2910ca5 100644
--- a/drivers/staging/vt6656/usbpipe.h
+++ b/drivers/staging/vt6656/usbpipe.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/wcmd.h b/drivers/staging/vt6656/wcmd.h
index 4a96f4d..a0d98cf 100644
--- a/drivers/staging/vt6656/wcmd.h
+++ b/drivers/staging/vt6656/wcmd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
-- 
2.7.4

