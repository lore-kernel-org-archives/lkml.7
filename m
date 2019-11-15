Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099A7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F6C20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="KKjjUIuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfKONuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:50:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54734 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKONuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:50:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id z26so9707174wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5Of54WAILYpbaWPTiRDBYhFev2SO+yUEDiluAb/oog=;
        b=KKjjUIuhNrEuXAQXUboOF7sYFDkh7fgUbv6MtYgWqSuf1VvMKFnPFIH2t69k61Ozbf
         g5iGtrirMXGGfHhzME6CR1ubIUe4imCzug1VtyZfN7obTZbJ3m3fCMhzdUjYw9jcBEsX
         4no1r1p4TYTNHbVVGEL5TPi4QriYNwAIEv/2NlMGvfHveV5Jd9cS1vLixfgkKVR3OM93
         S4XWRAttutfw1PIlPq4y4vDzXDy8ZURX62ChvpkD3pbOGD/Tmiw79XBhBLKuiQemuCmr
         MChAurhlEAgHZa3srYof6BjkEpMBDAop65Jzi905wWt2zfhg7kL+a1voHflU4kl6CUie
         Ddhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5Of54WAILYpbaWPTiRDBYhFev2SO+yUEDiluAb/oog=;
        b=RQPWjNSeK8WwaOwARBj5GSE/vGuT15LDYmiBnoXD2T8vEylT3JkaYXW5TpM7jOKGmA
         ar3JrO5XX2+7kSGrL43QR64iP43D+cZyniGszLb9d5TOpNQDcCyVWJbfJt5pogbwTtbQ
         TQRcU4WxABIKiYDmisl7ei36aHKUoZYavQb1Jq66rYtH+FRvow8CPVDu4hWzP4P6DNUU
         5sfa3/Wq9X/XGv7/uFlnppL4DrA/NyZBST8M65Vkg9mx5Byj8mqjJfRj30VHKTWbffAT
         tit2sZEDnu3Ihfxua9gQxPnwnW60zsdEgsXItv8qkOUBTvRlg+Rjg1LY+0PQUK1QAhEw
         24Uw==
X-Gm-Message-State: APjAAAUIk5WEuuuji3xKKb0nXLsBID+SAVGL20JZRO9/OdeUnuvr8FLh
        z3WlmRHYqN/6cP3Amj5IRyIRIdTC+xv3rV+V
X-Google-Smtp-Source: APXvYqxX5Jiw9YhKz+9EiqxHlldfQDuvN9T8MjwDupj/gVzfrNNlEFHYNukg3U76iawnCK4ObeDwWA==
X-Received: by 2002:a1c:80c7:: with SMTP id b190mr15141266wmd.3.1573825806541;
        Fri, 15 Nov 2019 05:50:06 -0800 (PST)
Received: from localhost.localdomain (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id f14sm11119906wrv.17.2019.11.15.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:50:05 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, patrick.rudolph@9elements.com,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH 1/3] firmware: google: Release devices before unregistering the bus
Date:   Fri, 15 Nov 2019 14:48:37 +0100
Message-Id: <20191115134842.17013-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115134842.17013-1-patrick.rudolph@9elements.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Fix a bug where the kernel module can't be loaded after it has been
unloaded as the devices are still present and conflicting with the
to be created coreboot devices.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/google/coreboot_table.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 8d132e4f008a..88c6545bebf4 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -163,8 +163,14 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __cb_dev_unregister(struct device *dev, void *dummy)
+{
+	device_unregister(dev);
+}
+
 static int coreboot_table_remove(struct platform_device *pdev)
 {
+	bus_for_each_dev(&coreboot_bus_type, NULL, NULL, __cb_dev_unregister);
 	bus_unregister(&coreboot_bus_type);
 	return 0;
 }
-- 
2.21.0

