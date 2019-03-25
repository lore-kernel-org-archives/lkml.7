Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB36EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9106720863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQb700Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfCYOPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:15:07 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40924 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:15:05 -0400
Received: by mail-yw1-f66.google.com with SMTP id p64so7144243ywg.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZyKfuhZZyacAS9OB7o+/+5KJ+l9OMc6VWyvztFukgs=;
        b=iQb700FsPoSKwi99Qm02fQBjIEQ9W9Vrq5STOB6MtBCIBgNMAMeIVoIVysicWynoJ6
         O5NsPvvrPMnwBJbihoxXpVnJ83Ee7Ej2ikSBYOuMMbb3LtD0QDRt0enJ0tS7fMzhEj+p
         pVbvnSpZBFGVXag9dJWzusY7pjB+Gd9sVBCSV+LcbVORPHY3HmXxj+LvWsgsccKrtLSU
         rRidz0qIVh6CRYC2I/YdvvzhR29iV5lXxMFVVYXa0PRhGX/htGKyuf+yDBUOY01dSrYG
         9Zk1gA+n0mpqIrXvvBMwuD+nrFlVdG77QqM0j0CAhXSv597fFUScxMcBM3dbOyZtvzl2
         JYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZyKfuhZZyacAS9OB7o+/+5KJ+l9OMc6VWyvztFukgs=;
        b=UakFb1eu4kc1Pk90ZcNNNZwvaRK5UW/6r+5W034v9ZmuP3MyyGv4ZetV5P9YXSzHVc
         UskeE0S9YlxPmNysHWbk531U6sN4RFwq/y4x3CASCjqQOi3DcdhwC8Biduu69hkqtSio
         Ghwl03I4dthvLVC9URN2zwso+v3utUcitUoKD0RepIPoUVyrihoNdAzWQhQutcFLgNOJ
         S4yEe3SdSPjKlvTqEOYyaZBxEIe2h0oTOQbiZOgYTm35t0keWuMsvKyVKN2BROBcm7zi
         IgOQ7iT9XdiMXzpyOliqZPpxyOd2hqPjCsO9ImaEi6Ri84Gf/SLDw5RvY/BmpQ1Pwg5B
         BSRA==
X-Gm-Message-State: APjAAAWOhhUlRinUw506EqzXSJUsF2vZK+FS8FHY06iEZrb4Dq9M3LI/
        y5WWuw/hpn+T/qGRbomtqCem7J50JE4=
X-Google-Smtp-Source: APXvYqyWpCkxBSk/Rrdiq/AqaPL7KBHJaR7fu6WK+OJPrgrFhhG4f4kDCZNsT53MRkqJXyRJAOQLLQ==
X-Received: by 2002:a81:e4e:: with SMTP id 75mr21362093ywo.149.1553523304367;
        Mon, 25 Mar 2019 07:15:04 -0700 (PDT)
Received: from localhost.localdomain ([36.255.87.251])
        by smtp.googlemail.com with ESMTPSA id f70sm5451915ywb.22.2019.03.25.07.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:15:03 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin25111998@gmail.com>
Cc:     ojaswin <ojaswin25111998@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging: fix styling of the comment related to SPDX-License-Identifier in vt6656/*.h
Date:   Mon, 25 Mar 2019 19:36:53 +0530
Message-Id: <1553522934-7366-1-git-send-email-ojaswin25111998@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190324195714.GA8262@kroah.com>
References: <20190324195714.GA8262@kroah.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ojaswin <ojaswin25111998@gmail.com>

Fix checkpatch.pl styling error related to SPDX-License-Identifier comment 
in vt6656/*.h

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

