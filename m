Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63610C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BB52080D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avJspCbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfKXOJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 09:09:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40060 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 09:09:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so5752403pgd.7;
        Sun, 24 Nov 2019 06:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BIZEOh+2SoolQV+w98xfGiKw61hN8b99t1HqhjHBMcw=;
        b=avJspCbwxgRf8JRPnfdcCZ4RaMm0FlX+WmFZqgukiH8xG1GXXb0pjfOytH3Yz5n9V/
         QFlR7GDaFK4Xln+GbiKZzXwdRLKODx4/eM3hHKE7Jo2naU8Fmh8FOKJH7zIPOr+nJG58
         dc2c/en1D0+/FklNhFoL2s0RegFtqkiG9XY8tLsmfEk2FfS9/1fSNi1kUw//VAmxEvaj
         3hO9ShGZ20KDz98C+aincxS9/tRnkwBEp1PVmJ8kHfop97MLw3vjAgzyVlnDQYc3K+vM
         ngEOz6uUXJ4oAGYqyucJlNnEaJUbqn5KIjRj8Ke78K6D4qHICgweSrCQgY8rEaXVIDQF
         QabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BIZEOh+2SoolQV+w98xfGiKw61hN8b99t1HqhjHBMcw=;
        b=FSrtUDAM7IdZBpnWlT88QCUFjNy7awTrUqoB4JU5gw352Kop/0IGBYOMFw25TQS/wa
         Lm45i56UL2DsbBc/VKbjm2A9bW2+wt42bvVogzqIdZT0PvhUNBkhlCXjI8RZvRYaimQq
         ZucWnFE4HazlyTKetn4awqDjO+dmIzzJDxLk300jmo+lbtpYcXUzupPuLg6wgnkBiL5d
         gjp8KYtyBkL6K423/MBVMCEer5Tv3OxWvUzTk1vN5/ex10LUH0xDII3S3e6uWwJQDFvb
         OpfWph5FyMbJkS0ktkwz8MePKwgy4W26+9PuR6ggp21Lpzc7kHiW9yPQfmqiDoSiIRmI
         vchw==
X-Gm-Message-State: APjAAAUnJMHDEu8eXV6Lc89j77wYnflSCfkhEXeAdfFH7fNhCAyxyNnH
        luJD8mu8Dyh3pCBDhMkj//A=
X-Google-Smtp-Source: APXvYqzV4/N4HOdxJ0cQtjPpcUY8RcPuU/t/SwDDADaMHBYnSSbkvE2bypioZl57w/Aw1BOYLeiOig==
X-Received: by 2002:a63:ff0b:: with SMTP id k11mr28003070pgi.274.1574604578685;
        Sun, 24 Nov 2019 06:09:38 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Nov 2019 06:09:37 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 6/8] thermal: intel_pch: switch to use <linux/temperature.h> helpers
Date:   Sun, 24 Nov 2019 23:08:48 +0900
Message-Id: <1574604530-9024-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the intel pch thermal driver to use
deci_kelvin_to_millicelsius() in <linux/temperature.h> instead of helpers
in <linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/temprature.h>.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f..3cce310 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -92,7 +92,7 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 		if (ACPI_SUCCESS(status)) {
 			unsigned long trip_temp;
 
-			trip_temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+			trip_temp = deci_kelvin_to_millicelsius(r);
 			if (trip_temp) {
 				ptd->psv_temp = trip_temp;
 				ptd->psv_trip_id = *nr_trips;
-- 
2.7.4

