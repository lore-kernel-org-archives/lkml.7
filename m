Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D000FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42171214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqXvYCt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKHFUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39715 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHFUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so3270427plk.6;
        Thu, 07 Nov 2019 21:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yc0niyL+e0o1G++JHufjcorcLLXvUhYDXt59boslzgg=;
        b=VqXvYCt3yjpIemP9x5nAW9klS4OYDVtIurvAczrm8dcH4b8jG/vIFrq7HA1zhqdEn1
         WMmjWTT2tVk9wuQjqUzpDZlm/M8CCbwrETRX7+w+0nUluHW3CNl2B/iGn3Ja6NnEbsXp
         kf8vL/FOvPYedRq62dRG9jVGyG7wieYlyIv4oBqusl9akmvh0RKK6TKcIeooBUcOob/I
         H7lb4QLWxAzI8BaclZ2jWIpDuwDKY52OplmZwGyNALIK1a6EBhRcfKBfeCy2IvL3Xpao
         amyUwRxPbHN4UXXl8WWQKP/7RN3AW2p44AoRbPCEUf0riQEEJjiWwtQlnYHOykFdN9c8
         p44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yc0niyL+e0o1G++JHufjcorcLLXvUhYDXt59boslzgg=;
        b=ibpGaxS2RBIee4jXTi8/nvwlLLBgmk9C3pzjTToC0BCNOyQLSmCPb19rdZH4lT9+mY
         qJc4HjrDh32B7fqtb8654uS+5hbjXDJojweqCOqp+lrLuoWd2uGIs+vt6lLlKiSzoVrG
         Ish7EFfbu+J6Gi+k5kTdHaA2rDz2jiSYW6r5xGs1290NFcz388Oady7WlZa3IPtnXx5W
         hRuzsqSj6d2rtiI9JuaDtousxcmBfgOnICzBGUGfLbTRuHyqKhWOkOD5u1+HwzN/xxMM
         i8k6Km+yjqZFrONHAfFmIi5mMExu4xNGcVZsOwKvbyPjhy0s89YidyIkU9vmWkzyude0
         TzKQ==
X-Gm-Message-State: APjAAAVCsrw1hhBDXB5FcwfhL9+1MsO11E2B4JB2hGtXFkHJE2MmZw2o
        0Ghr0RZ1CKASP/OWwRegca+cruJkUr91sA==
X-Google-Smtp-Source: APXvYqxc7+DDnJiPlXxQJe9LqipaDRCwapIGhvHz7o6az10ji38/hskICugffhdh+/IZ6mIRKsHrrg==
X-Received: by 2002:a17:90a:9741:: with SMTP id i1mr10898615pjw.41.1573190404659;
        Thu, 07 Nov 2019 21:20:04 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:04 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 01/11] fsi: Add fsi-master class
Date:   Fri,  8 Nov 2019 15:49:35 +1030
Message-Id: <20191108051945.7109-2-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

This change adds a device class for FSI masters, allowing access under
/sys/class/fsi-master/, and easier udev rules.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 1f76740f33b6..0861f6097b33 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1241,6 +1241,10 @@ static ssize_t master_break_store(struct device *dev,
 
 static DEVICE_ATTR(break, 0200, NULL, master_break_store);
 
+struct class fsi_master_class = {
+	.name = "fsi-master",
+};
+
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
@@ -1249,6 +1253,7 @@ int fsi_master_register(struct fsi_master *master)
 	mutex_init(&master->scan_lock);
 	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
 	dev_set_name(&master->dev, "fsi%d", master->idx);
+	master->dev.class = &fsi_master_class;
 
 	rc = device_register(&master->dev);
 	if (rc) {
@@ -1350,8 +1355,15 @@ static int __init fsi_init(void)
 	rc = bus_register(&fsi_bus_type);
 	if (rc)
 		goto fail_bus;
+
+	rc = class_register(&fsi_master_class);
+	if (rc)
+		goto fail_class;
+
 	return 0;
 
+ fail_class:
+	bus_unregister(&fsi_bus_type);
  fail_bus:
 	unregister_chrdev_region(fsi_base_dev, FSI_CHAR_MAX_DEVICES);
 	return rc;
@@ -1360,6 +1372,7 @@ postcore_initcall(fsi_init);
 
 static void fsi_exit(void)
 {
+	class_unregister(&fsi_master_class);
 	bus_unregister(&fsi_bus_type);
 	unregister_chrdev_region(fsi_base_dev, FSI_CHAR_MAX_DEVICES);
 	ida_destroy(&fsi_minor_ida);
-- 
2.24.0.rc1

