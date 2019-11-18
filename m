Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B982620722
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="QdyCU5aK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKRIjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:39:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37111 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:39:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id t1so18327902wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ph+qSnanbDkdpIO26fSuxJz1tEC79JDzqdWxgamIBpg=;
        b=QdyCU5aKOlkegIsEZLdv/OEGGK18f90hRR9Fyz1sj7ZN3IyhUGiflXw964G2k2WPC7
         oaDAQ9hKT3XQdIcKhWqEJ49n40hsgzfhycERaLikcwHT22y/wHT0SxuHDMfbtQWrFvqE
         +5rMw3muEmYRkNEYObQoG7paBc2qgyhODaYXWYSj50eVte2t3cSD3eCTcBPCbEMUxuIw
         t0H1lXwyWdZr//gd0toF52gfY+P1Biv9Y2/E6UwHrAAX3IYfiMybsRPmNQMa642Y4395
         oaTSg74vSz103xu0FY44V2HO4UKSTi/l3nuWdiW51Ei7AjMZZS3MUgZau21azGGqaMDf
         AygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ph+qSnanbDkdpIO26fSuxJz1tEC79JDzqdWxgamIBpg=;
        b=Hf0+ugVu6tvOv7NyoCqjOi2nJsvTHtHozhEeeEIdyX3dEgSJMstS2hs3P2jVanTJ4I
         w1Anfa4DxflczuzQBb8JvNK6Sbrsq8lySBcvalT1YLrV6qhTv0n1XdT7Sj/si+yHJvij
         84a139Wh3NytlmYivzI/YZnRIKkaap4DrYTnCGXZVBwSWgqoojrVNmXO/jwiOkxjuo+Q
         nZT14JCki5LJyYm57db3jfbc5C74gLMxE04HP7ydI29+YA4MfmD1ASmf9OOte1rLLZEt
         Iqd7FCR0KDQ8N4mJ3q7HHuZRSOls/CtEzGKgNhZyjgHClQPXi2rJpQJ+TQ+G/q3GGOsC
         3d1w==
X-Gm-Message-State: APjAAAVNE6MMnMLpRuR7pfoiITJA7L1C7qwukdOgui/TseBugSk8PZtD
        /useJQf/Z+P0aXzQ312JmWOPvkN4lyZBEsMz
X-Google-Smtp-Source: APXvYqy72gHUkjLUKNbCKplvTwE08G03rEBnI8SCV89Sp+9JOkFzqFLSI7/ih5M7aRB7Ab5WOJZajQ==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr27822580wrv.187.1574066360153;
        Mon, 18 Nov 2019 00:39:20 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id z14sm21700530wrl.60.2019.11.18.00.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:39:19 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [Patch v2 2/3] firmware: google: Unregister driver_info on failure and exit in gsmi
Date:   Mon, 18 Nov 2019 09:38:59 +0100
Message-Id: <20191118083903.19311-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191118083903.19311-1-patrick.rudolph@9elements.com>
References: <20191118083903.19311-1-patrick.rudolph@9elements.com>
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
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
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

