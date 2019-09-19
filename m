Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DBFC4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C58621907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfISAiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:38:18 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48088 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727634AbfISAiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:38:17 -0400
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x8J0cGSH017188
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 20:38:16 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x8J0cBRW023366
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 20:38:16 -0400
Received: by mail-qt1-f198.google.com with SMTP id d1so2115853qtq.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=Tl2rf6JeocaEFmRZvibly+0M3bTjf3OySViDdJOt7sQ=;
        b=OL2w0eMSlm+7zOsCpJE2k7qI3vsPAygbQGNn4ogumRXVgNZkpsNDjzXmXxlH9nueq0
         zTWXkFT1TG9x7wF6CAdV9HylGKmCBHe6JzvIWSjLvdiQWOuBEao1Semz9paBh6F61+DK
         uAULNueM4Muzb7Ho4YHZQ8Ung0N9GOProMfUYVT/JjV8uqo7yVdV7Jrq0Wsut2j2M/eM
         Cd2t1DqjTuOPAIDzb731g2gdb+e1AZ1W+vum4eMp9QLwl2DwR5DDopPQ4w7U3NV6A26O
         E7FaPlfIpZy3WnLnAEePQTl2CzVeXAdGNMQuq69s9b4a/aHvM4E/Hm9Pvf95cm4MKJQA
         jlsA==
X-Gm-Message-State: APjAAAUOqDSNANkrqhtngHG50pZStYcQXv8v8Iiy7fHbYlVmUBbwd8lP
        +Y13O4dTQBAY78N19vPlLvgQ5Q8l9xUxCF6meC65Gjyd6ZyvMC8jQdki+lLX7Kt1+imjBCvMFLR
        2uXe0+LhBpWdMOWf2pRTWu9wZ85AT3hWbaSQ=
X-Received: by 2002:ac8:6918:: with SMTP id e24mr607961qtr.60.1568853490866;
        Wed, 18 Sep 2019 17:38:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbVJ7JccYjBIOVP6gw0tP+9nusUoCzA7tXMjWWGK9/gnCwov29CnPCfQeW7sp7UY9KzPbpAA==
X-Received: by 2002:ac8:6918:: with SMTP id e24mr607940qtr.60.1568853490520;
        Wed, 18 Sep 2019 17:38:10 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id v4sm3091126qkj.28.2019.09.18.17.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:38:09 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] drivers/staging/exfat - fix SPDX tags..
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 18 Sep 2019 20:38:08 -0400
Message-ID: <122590.1568853488@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copyright notices as I got them said "GPLv2 or later", which I
screwed up when putting in the SPDX tags.  Fix them to match the
license I got the code under.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/drivers/staging/exfat/Makefile b/drivers/staging/exfat/Makefile
index 84944dfbae28..6c90aec83feb 100644
--- a/drivers/staging/exfat/Makefile
+++ b/drivers/staging/exfat/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 obj-$(CONFIG_EXFAT_FS) += exfat.o
 
diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 6c12f2d79f4d..3abab33e932c 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index f086c75e7076..81d20e6241c6 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 1565ce65d39f..e1b001718709 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index b3e9cf725cf5..79174e5c4145 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_nls.c b/drivers/staging/exfat/exfat_nls.c
index 03cb8290b5d2..a5c4b68925fb 100644
--- a/drivers/staging/exfat/exfat_nls.c
+++ b/drivers/staging/exfat/exfat_nls.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5f6caee819a6..229ecabe7a93 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_upcase.c b/drivers/staging/exfat/exfat_upcase.c
index 366082fb3dab..b91a1faa0e50 100644
--- a/drivers/staging/exfat/exfat_upcase.c
+++ b/drivers/staging/exfat/exfat_upcase.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */

