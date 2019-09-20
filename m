Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50F8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A902070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IfK8t/nU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406652AbfITScu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:32:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43683 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406618AbfITScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:32:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id d4so1198480pgd.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nP7l7HPSlZ4edHh/gvYjfiqgqZG+4NVrpc/qCXzCjyo=;
        b=IfK8t/nU0xPo02/ZMcqNy5ARLWAwNxBsqvy4wqEvgbiXc3DM/mBx9JIMecP35NYtLY
         d6oZ4r7PnCsXhl9Pb0b3d7dlH/m5Hm9IPYMV/EiNhfkR+LcbVpPuYCyqERLt8fUHC6q1
         3StMkPgqAKCAu6i77204oJx8VRRPsEZFB3aLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nP7l7HPSlZ4edHh/gvYjfiqgqZG+4NVrpc/qCXzCjyo=;
        b=eJiAMICCeopjLcyrbfBUjoVMkEpwjv43FmRVnOypsiWcShA08a3KvP0DUJRAxUn5xK
         fA40q1mF+9fPIIOYDykGzNL5DLGGCgTKimtfjncFCF5DX8LoKDoCPFRtht/iPuSBCI1/
         Vvce7SOe0G3Hb3RkGqK1vlnRWegKnQrX9jmHXT3oR07EnxX2hzlFUBGgre2xiu8VK3VH
         bNclC1OU1peUr0+i42yKyHlvWu4mzgLKxuavUFZM7ugEkK9Wkpvh2HS/dnwAZAn7mAZa
         xNOLefD4o9G56elftWVcKVI6fl84J90bGr+jnnFRXsIQGglxqk2QbuQbeTVhOE6hQVuw
         R/lw==
X-Gm-Message-State: APjAAAV+T9s/aeJRsmWkB4Tt4n0xHT7+uiTu0KqLBm0WwLH8J9EyqvHQ
        SnB8f+QsbVioghgU20g2EXkqQQ==
X-Google-Smtp-Source: APXvYqwvjlTaUG+/BiPqEzp4X98x1fEsnlQky9Xq/O2jses1JwEdzhOGp2Ea852+u1y8xsoZzPxwQA==
X-Received: by 2002:a63:1904:: with SMTP id z4mr7163391pgl.403.1569004367160;
        Fri, 20 Sep 2019 11:32:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm4436072pfb.132.2019.09.20.11.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:32:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v7 5/6] tpm: tpm_tis_spi: Cleanup includes
Date:   Fri, 20 Sep 2019 11:32:39 -0700
Message-Id: <20190920183240.181420-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920183240.181420-1-swboyd@chromium.org>
References: <20190920183240.181420-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of these includes aren't used, for example of_gpio.h and freezer.h,
or they are missing, for example kernel.h for min_t() usage. Add missing
headers and remove unused ones so that we don't have to expand all these
headers into this file when they're not actually necessary.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 5e4253e7c080..ec703aee7e7d 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -20,22 +20,18 @@
  * Dorn and Kyleen Hall and Jarko Sakkinnen.
  */
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/wait.h>
-#include <linux/acpi.h>
-#include <linux/freezer.h>
 
-#include <linux/spi/spi.h>
-#include <linux/gpio.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/of_gpio.h>
+#include <linux/spi/spi.h>
 #include <linux/tpm.h>
+
 #include "tpm.h"
 #include "tpm_tis_core.h"
 #include "tpm_tis_spi.h"
-- 
Sent by a computer through tubes

