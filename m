Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD5EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C4A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683026;
	bh=Qo7gGg6DiQXM9rORRgFa/R0Kp/2G6f9GdtCTj659ZyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OBxDsHb2IsEa1mVquQNlsjkvWfHiAIe7pacmnHYiA9VI8cnJkbdDfbQqGXisR245e
	 unx5muxtijEjm4znmyWa4KmpX1REAWET1EAIyvV2F/i4F3RBCfBDfqebZVzET6szT0
	 gqiT21io86VyCc9/SAufJgdKVvMlVTdqond9Hwjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfF1AuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:50:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33003 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfF1AuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so2223139plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OncWFB2MqnR1/OaJA7wEfh0+edJpgnnSs9Q1oS9q/ZA=;
        b=iPcm3YqYCCy0eKnSpuMUzVB+EPfqRs60e7VFGg3kXsUb3vqQ6JUpJzVyZ4AHfdczS0
         IIxSWumv5VkjViY/LsraNhFljDchJxQuRhzkSVK1PG8TUwrVjHft8yuPlQ7UyuIXqDCv
         x05jU+xGICkEGgcTFeZcaAP2vGtKgaw59g4MMu4yDe3CVSbX3CO6DD4VkpOQdC25kTeI
         kIYisueg5E7yQoInjMD/vJZMiIsKqUc4ru+OPRJIhkqtiLehAvJv7sLNBLsds7yqLZEW
         VO3j+6BOrGZuIuI/kKj/xsvHK6TT6SlvtAu5boIUC8ciNWiGCqIBGugljjQW3nZ2Z9YO
         13sg==
X-Gm-Message-State: APjAAAX8ukZYlVhAnN1nyNAtZMhBwG2+UXdyWYnVZqgEZb4j6mKq7eeA
        JywgwuXifztCpnXl/oSL7/h8rg==
X-Google-Smtp-Source: APXvYqwmsB/Afp0fu+EJ8gtQSSN8OqTgLlckMMG2rd5xQt9eDMf1WOOOJ9gTdMpZ6Bc4ueW3IvOaLw==
X-Received: by 2002:a17:902:e490:: with SMTP id cj16mr7942734plb.136.1561683020604;
        Thu, 27 Jun 2019 17:50:20 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id h2sm269882pgs.17.2019.06.27.17.50.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:19 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 03/15] fpga: dfl: fme: align PR buffer size per PR datawidth
Date:   Thu, 27 Jun 2019 17:49:39 -0700
Message-Id: <20190628004951.6202-4-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

Current driver checks if input bitstream file size is aligned or
not per PR data width (default 32bits). It requires one additional
step for end user when they generate the bitstream file, padding
extra zeros to bitstream file to align its size per PR data width,
but they don't have to as hardware will drop extra padding bytes
automatically.

In order to simplify the user steps, this patch aligns PR buffer
size per PR data width in driver, to allow user to pass unaligned
size bitstream files to driver.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index 6ec0f09e5994..3c71dc3faaf5 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -74,6 +74,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	struct dfl_fme *fme;
 	unsigned long minsz;
 	void *buf = NULL;
+	size_t length;
 	int ret = 0;
 	u64 v;
 
@@ -85,9 +86,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	if (port_pr.argsz < minsz || port_pr.flags)
 		return -EINVAL;
 
-	if (!IS_ALIGNED(port_pr.buffer_size, 4))
-		return -EINVAL;
-
 	/* get fme header region */
 	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
 					       FME_FEATURE_ID_HEADER);
@@ -103,7 +101,13 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		       port_pr.buffer_size))
 		return -EFAULT;
 
-	buf = vmalloc(port_pr.buffer_size);
+	/*
+	 * align PR buffer per PR bandwidth, as HW ignores the extra padding
+	 * data automatically.
+	 */
+	length = ALIGN(port_pr.buffer_size, 4);
+
+	buf = vmalloc(length);
 	if (!buf)
 		return -ENOMEM;
 
@@ -140,7 +144,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	fpga_image_info_free(region->info);
 
 	info->buf = buf;
-	info->count = port_pr.buffer_size;
+	info->count = length;
 	info->region_id = port_pr.port_id;
 	region->info = info;
 
-- 
2.22.0

