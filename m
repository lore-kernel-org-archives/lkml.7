Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94523C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED2D218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfGZMEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:04:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45569 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGZMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:04:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hqyxR-0007X3-Da; Fri, 26 Jul 2019 12:04:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] intel_th: msu: fix missing allocation failure check on a kstrndup
Date:   Fri, 26 Jul 2019 13:04:21 +0100
Message-Id: <20190726120421.9650-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

kstrndup can potentially return NULL, so add a null memory check to
avoid a null pointer reference later on.

Addresses-Coverity: ("Dereference null return")
Fixes: 615c164da0eb ("intel_th: msu: Introduce buffer interface")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 4892ac446c01..dd7e3c304ee5 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1848,6 +1848,8 @@ mode_store(struct device *dev, struct device_attribute *attr, const char *buf,
 		len = cp - buf;
 
 	mode = kstrndup(buf, len, GFP_KERNEL);
+	if (!mode)
+		return -ENOMEM;
 	i = match_string(msc_mode, ARRAY_SIZE(msc_mode), mode);
 	if (i >= 0)
 		goto found;
-- 
2.20.1

