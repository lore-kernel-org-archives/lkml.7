Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C90C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0BD21741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChvXLtUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfCXRtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:49:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39008 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:49:54 -0400
Received: by mail-yw1-f67.google.com with SMTP id z9so1836989ywd.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kp+OPi0GCEAAjBJlB9Ei1vwn3RIxdBa9aoeK/95jFns=;
        b=ChvXLtUWbmxGigvgJqSQZrqrEIkcFQMK2iqf1Ot9VkMRlQZTx7FowzRPFrM7ATXsdw
         4FV4i8eb7rBcrkJOY1IoKy2bFwKpjzW+Qhp0lDImvsHoqSPVCd1/h9ZrxYhEkMFtLt3V
         8jAUXhjMUsjxzzV0SqvmuVtU2919sjMqlR6LNWSZpXCxOrdmdakNpUrjlHRe5oCXh1C5
         IHZ9VM5mp9oyWa2LW47DBH1CSpLmCoSJhtfK1lMPk3bRvQI61b/nwi68omzY8NgDtAl9
         uIKdOL+0ji1gGAKSlj9tN7NjoFU38KzTf1Nb4bLqyqLABgGcSCD1mBc2tQEpLqNM9kbv
         tXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kp+OPi0GCEAAjBJlB9Ei1vwn3RIxdBa9aoeK/95jFns=;
        b=IsoAfjiIvCS/TNBJ6a+NAEbtPTT8H0aZnIB24hPSI5UwYDmxehkJI8d+XuRpTgm5xk
         KtJCYhLhdL8HLdSGufQ8ZEk0VTlIcKEmiBRf6hIu8Vlu0tKpzeyzOTMgFdqYtKDbPc7S
         Vk6eVkpsoNM1gRL6QIHikcdxpQwr/WA1xOtEUEfz48Z7sFSi2ZQuk/Btz89FFtRXZ1vR
         2/G//qciM4xHI8uxZjWQMSh2O/VNXv9N3nEfDh9kjU8WvNHvsugdae3BT0TJBXMf440D
         bm+8NJJPusQFOGZHQLHFlxZVL1ZDuIVyafD2kaz4z/VTYntNqA4TY0BPIRFTQbBKzikQ
         evEQ==
X-Gm-Message-State: APjAAAXmgofRrUGrB9HqV3qpkkdlarQzyIRdCVwl40hdqpkQZF0aLaJN
        pB32RVB8RYoDTdTLTFDQfgA=
X-Google-Smtp-Source: APXvYqw1jLTpYUaKxnS82xJrc0REeRU6VCvAHNTHusOyGP8QQuMhTUgdL6JgeryyJqThTWzBYQYkjA==
X-Received: by 2002:a81:118f:: with SMTP id 137mr17661432ywr.330.1553449793528;
        Sun, 24 Mar 2019 10:49:53 -0700 (PDT)
Received: from localhost.localdomain ([36.255.87.251])
        by smtp.googlemail.com with ESMTPSA id n126sm4534733ywc.94.2019.03.24.10.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 10:49:52 -0700 (PDT)
From:   ojaswin <ojaswin25111998@gmail.com>
Cc:     ojaswin <ojaswin25111998@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging: fix styling of the comment related to SPDX-License-Identifier in vt6656/*.h
Date:   Sun, 24 Mar 2019 23:17:22 +0530
Message-Id: <1553449747-25704-1-git-send-email-ojaswin25111998@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl styling error related to SPDX-License-Identifier comment 
in vt6656/*.h

Signed-off-by: ojaswin <ojaswin25111998@gmail.com>
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

