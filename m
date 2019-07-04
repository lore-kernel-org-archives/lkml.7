Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A4CC5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A468218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aASMFOix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfGDCgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:36:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39088 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfGDCgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:36:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so1668260pgi.6;
        Wed, 03 Jul 2019 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2ZSY8dUe+kI50ne1+y2CFQaSDYbQtEYZ74W1nwW0ZUY=;
        b=aASMFOixncAfiUd8Qqgc4EqdBaToyLLuZM+xa4uQDSsHVH7ltixuSKu85mqmoXWET8
         g0o70gB8g3/LDD8YL4UnRoHzU5BbyJmbDUWM63UTZuC0ebZOi6d+RMjRgpW+TrVztJei
         bmvFuiWYzj5Wq6tjJl3SY4yIfoczJw8yaQdeh8zYp8VYP/5tk7gk7hAUQsQXgBtGcfi4
         22B2dNbLzV5VOqsvlqf+It7FKmYWgSUnjbi5OuKeTfcbWIg3uaOPo1VUC+b9JTorhd+d
         Db+YFE444zBWiXlPVH/OEHe2moyNufDbMxHJ6/mBscxOWhwPSIAn+4Sw+kdNpP2aCJ4/
         QiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ZSY8dUe+kI50ne1+y2CFQaSDYbQtEYZ74W1nwW0ZUY=;
        b=Waj6hm7PWy/4lDLcgQomX0gUNE0y+IEfgYehBMjQrTE0mNsOXx7ugOYZOZb40Eydym
         sPdb+njeEvyMKcouh+M77jTJxw+SoRnhGiDz7MJvuO64P4+zE1yOrDKQgAXWpvWSuqLv
         URUMghOi1zSt+KRu4yZFbfkGhgF3qD6rpzsHbGXkoXt8+HW25mF7K2R9ZgUIi5uLL65K
         wkKWYu79EYcYx/ub7Rz7uyXWI63PJZScWFZEONoyWbElGMfUofoGtUWqOn7odx8b0eAe
         7vR9PDrOak9cxl67v/LdgyHX9GeFOV+2QA+DJDgTXx6JdWa9bmy1HcV8jcbAL2mxFQap
         T2sA==
X-Gm-Message-State: APjAAAU7t7kJ3YSGIFXMf8g+bJDjIatjPMTtJQotMAtfGcnDuSmnK0mD
        bt04/JpU52EwnRYnliKORzA=
X-Google-Smtp-Source: APXvYqwGJNJSefXjcEI6bpEEy9g2NVKZWfM3ppnnfn3UDO5NsGiImAV+lB544o11HM7uMNJoEZOHiQ==
X-Received: by 2002:a17:90a:9a8d:: with SMTP id e13mr16763513pjp.77.1562207814017;
        Wed, 03 Jul 2019 19:36:54 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id v23sm3859428pff.185.2019.07.03.19.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:36:53 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 10/10] platform/x86/asus-wmi: using dev_get_drvdata directly
Date:   Thu,  4 Jul 2019 10:36:47 +0800
Message-Id: <20190704023647.4873-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/platform/x86/asus-wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9b18a184e0aa..49049b02a015 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1353,8 +1353,7 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 					  struct attribute *attr, int idx)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct asus_wmi *asus = platform_get_drvdata(pdev);
+	struct asus_wmi *asus = dev_get_drvdata(dev->parent);
 	int dev_id = -1;
 	int fan_attr = -1;
 	u32 value = ASUS_WMI_UNSUPPORTED_METHOD;
-- 
2.11.0

