Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6332CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3956221774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+A0daFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK1OzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:55:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36033 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfK1OzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:55:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so13280989pfd.3;
        Thu, 28 Nov 2019 06:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7KKKKjGEFkR1SZnk4/a5jY9T/FwK0zSdmITwZXojgTQ=;
        b=b+A0daFBKQNfri8HQ2Q7cGR8yVFHZWPi34/Bisw6NXiroctpWAIBBZSMjDUC0UffkD
         UbqbJlDUILM6iU2yQwiVi1CYPlyPzIYxQ5nsy+/uU8fWwl+TvDucXD3st6juFY+osGra
         DFG03yi9evpjwIYOWp1eGgzpoGt3D3ziBlGQJrYW2c5PYSSwbQgbVnJFCFTRVnXAEJDc
         0Gzv+YdPsqL0v79gY9JlbwCsRdyUgqqrNy3PT/srXpDXsg3ZJk13/zngvaxr/UssAavP
         mD47472O5gmTBa4mRxze8atPA9zWNOTvyzxFpOaS4o8z/mVGkN+mSjmRtwCa+JVGfqYq
         jXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7KKKKjGEFkR1SZnk4/a5jY9T/FwK0zSdmITwZXojgTQ=;
        b=m/sfPlMzqh6zdpJFwrJxBRYqk/P7D4YssKiCjef1SLctgWR7F3eZ7cgBcSDyRYAnlp
         Kk91Xhh3UXa67SH/4p9EFEtl0bDvv3gRypBD+mOYuO2xFTckea2lPB3NZqgFU0OxSd+/
         Lx1QF978k+yQN4wzAwA+tOYLgkafrQd2AvhVbFiLmQLT1jXk4aR5RnQJ2b5mCt8xjcmd
         LXxs5mBAmDA2gQkjGlSdukRd9zBAshfab4Kd3ebt+00Z0/sQqnoYjYrQMvhP66uin3/4
         CY+w05Bc/6T3oxe1ltWzKr2TF6sZFeIaXt9fp7RnbZ7QbY2SjZrbUwM1oDAiXzynmizV
         RLMA==
X-Gm-Message-State: APjAAAVXaMJlvrOCmWplUG2TuaB0KopyYCMBaCqZfpC3m0G0rT/0l+ky
        BNP6z3TwDOzwpHjyBJuLG8s=
X-Google-Smtp-Source: APXvYqypnawADf67Fr6UMIh3dr5nN4MKDxVHUVaoWAhJayCpe2CG3j8GYcbi5A395taCn6KVEARtOg==
X-Received: by 2002:a65:62cc:: with SMTP id m12mr11002643pgv.397.1574952909701;
        Thu, 28 Nov 2019 06:55:09 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:55:08 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 3/8] platform/x86: asus-wmi: switch to use <linux/temperature.h> helpers
Date:   Thu, 28 Nov 2019 23:54:34 +0900
Message-Id: <1574952879-7200-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asus-wmi driver doesn't implement the thermal device functionality
directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
is a bit odd.

This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
<linux/temperature.h>.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- add Acked-by tag

 drivers/platform/x86/asus-wmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..6a1a2f9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -33,7 +33,7 @@
 #include <linux/seq_file.h>
 #include <linux/platform_data/x86/asus-wmi.h>
 #include <linux/platform_device.h>
-#include <linux/thermal.h>
+#include <linux/temperature.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
@@ -1512,9 +1512,8 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 	if (err < 0)
 		return err;
 
-	value = DECI_KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
-
-	return sprintf(buf, "%d\n", value);
+	return sprintf(buf, "%ld\n",
+		       deci_kelvin_to_millicelsius(value & 0xFFFF));
 }
 
 /* Fan1 */
-- 
2.7.4

