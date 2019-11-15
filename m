Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52256C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B67820715
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="endDTSGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKONuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:50:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34577 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKONuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:50:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so10128088wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPqNE1lV8uNU1HbMJqXHuF3ifYmkzeAOvJ5fb7/933k=;
        b=endDTSGSky7hbBNeTk7jcQHKgzocmhMhKiLsy0ZeFyqEbWBbvi046QWG8cziJXo+SW
         SjwVBDTXo4H95dWmm2Wf8d0PyontBgJfMxaRroO7285v3bhm2ifTCAEs+i2pCS1jGbVw
         7GClakov3mX5mcshD2LS4Y03ID81rz/CmUXj4FegY0UFhHX0nXc5/5MwhTXikPJ89o3P
         +c3XHE2vNYU0gHxDwNeKvcrq92qs3NfZv9rsnS75bweNMlLay5LqqYytrnZyorS7UthD
         J/nR5eLY84EMs0P+Xeni4cebOi2QRgXx1d51SMDlXs99u3ALlkdnbvclBfBXbfNjp4SX
         eFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPqNE1lV8uNU1HbMJqXHuF3ifYmkzeAOvJ5fb7/933k=;
        b=qUlq3R0UWdLY1WrlbDZeApn6EBaIW1ANyedQZyB+OuA+okkQMVjy4+tm2m0YuU9o8V
         0qHhNbow3Jbxwe8smImg57qduH1zpl6XcJak/Ebz1eWTLlGEiJzhkf7FsMovH9o/XwuT
         ubMoq8puHNQxfS4WgHznPg3T29x4KUe+iFvzV/2i350wXUtPIZcssbBf5qcUvIeEJ/eW
         wCr1QjoKEpFmBotpnT4fZSWilz7liR+hbWwqkOG/9VSlK/2CHsoQPNpI/Bn0jHANTfOY
         utIG2jESHgZjdH3frKUrgqs5hwjtWXblDj7YOOMJs/hOFjOA/xTQSSABQ6jv5MAWlbhL
         FONQ==
X-Gm-Message-State: APjAAAVEeHIwYyFA4F//nH0Y5GSGY71Jlb0FppeHyBdkiemk2I4mmlrY
        wzpekqEoruuIR4tOle/x+GEVbAzZAO7XMZI9
X-Google-Smtp-Source: APXvYqxL75RnJxzTQy0jTB/2qlYpO55j5zOqEemQX2feaTv050kqNcWb3GWRcA6B/AgUtAF33rOBrA==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr14863930wmk.155.1573825811247;
        Fri, 15 Nov 2019 05:50:11 -0800 (PST)
Received: from localhost.localdomain (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id f14sm11119906wrv.17.2019.11.15.05.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:50:10 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, patrick.rudolph@9elements.com,
        Arthur Heymans <arthur@aheymans.xyz>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] firmware: google: Unregister driver_info on failure and exit in gsmi
Date:   Fri, 15 Nov 2019 14:48:38 +0100
Message-Id: <20191115134842.17013-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115134842.17013-1-patrick.rudolph@9elements.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Heymans <arthur@aheymans.xyz>

Fix a bug where the kernel module couldn't be loaded after unloading,
as the platform driver wasn't released on exit.

Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/firmware/google/gsmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index edaa4e5d84ad..974c769b75cf 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -1016,6 +1016,9 @@ static __init int gsmi_init(void)
 	dma_pool_destroy(gsmi_dev.dma_pool);
 	platform_device_unregister(gsmi_dev.pdev);
 	pr_info("gsmi: failed to load: %d\n", ret);
+#ifdef CONFIG_PM
+	platform_driver_unregister(&gsmi_driver_info);
+#endif
 	return ret;
 }
 
@@ -1037,6 +1040,9 @@ static void __exit gsmi_exit(void)
 	gsmi_buf_free(gsmi_dev.name_buf);
 	dma_pool_destroy(gsmi_dev.dma_pool);
 	platform_device_unregister(gsmi_dev.pdev);
+#ifdef CONFIG_PM
+	platform_driver_unregister(&gsmi_driver_info);
+#endif
 }
 
 module_init(gsmi_init);
-- 
2.21.0

