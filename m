Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329FDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A034206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpkAMpmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfGaRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:53:36 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36078 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfGaRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:53:31 -0400
Received: by mail-yb1-f195.google.com with SMTP id d9so18318648ybf.3;
        Wed, 31 Jul 2019 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YmPyHZ8dDaGq4wOOYUfRrP02saBuikUQohVrtGbVNIQ=;
        b=hpkAMpmvNOtFxbAzq7Rj86ZGsKpOir3GJ99AJTe6kwi9ybicQC7TSiKRCK45vjVoD9
         72iuLSEfmp13a2CFWw1n4h64jiPmynh99wpcTWz1Be/OCoiZmQpgfhH43M5IpbQoaefg
         ECFfAd9uzU91m4FM+Yc5ayCHtRcmJoc1fIVMz7X3ZJmnWC3CGkUR8n4BfPFDZh+8L6L1
         40J8WTvd4/xPAc2mFpD6Bsm8bpZOXk0Mmp5xyEXe6Q/C9eVYYkLST0mLk2Tmz+Hexlif
         6uPeLV0yab+SqzsrS7gy/TnnQ9VMc/1vdTT52z2Q72qrwR2rXQZcAKghKMbzwOR/AVbs
         ntMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmPyHZ8dDaGq4wOOYUfRrP02saBuikUQohVrtGbVNIQ=;
        b=rjcdRhnPVQM+lQJ/KMvmcgpuOYFb2/fNp5dTp/m/pGVJiBO6dz3oVP+6LwW2elpYxq
         yukQyTe/uBxF0qXVIm9fpNp/tdoJs3oOuKtI0l39cID8JN6H7Ahr+oRlCNULSbJsgT14
         Gi52c06M5zGrWpV4YXg7FaJ7XB+6hz5c5lV/e628oyHb+z6vnCMNbplfra0blc5MdyU/
         rhbDD3L6XflrM5C2jzEM5pIERwxEipvAhdB58WGq/CMRPC8u80J2UJSCWxb43xvzTo6p
         1UMptLnUJOg14KBJoEoEx+ndB3HegT+v2NizhCBrXwKPWfU/NC+QL0z/AUKO0cnvECin
         YDag==
X-Gm-Message-State: APjAAAWFJ9LRTewqVRN8KkQv1ADnrqtkczYR0MUQFMtI6wGk+Qzy+zGh
        EpmzP/cofZ04LkdKaePWKg==
X-Google-Smtp-Source: APXvYqzy2iBVuUnEnTQNmQa5OOhb/cHA3x/v/crI+Vm9UD80Qulphe14LMvjoBwoP8RRH23vM5LvBg==
X-Received: by 2002:a5b:bc8:: with SMTP id c8mr9338954ybr.152.1564595610754;
        Wed, 31 Jul 2019 10:53:30 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id w193sm10517294ywa.72.2019.07.31.10.53.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:53:30 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 7/9] platform/x86: huawei-wmi: Add fn-lock support
Date:   Wed, 31 Jul 2019 13:52:53 -0400
Message-Id: <20190731175255.25676-8-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731175255.25676-1-ayman.bagabas@gmail.com>
References: <20190731175255.25676-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huawei Matebook laptops uses Fn key and toggle to access F1-F12 keys.
Along with that, there is this feature called fn-lock that inverts the
behavior of this Fn key.

Implement the basic functionality of this feature to be used later by
sysfs interface support introduced in this series.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index da3986cd0428..4159e10bda26 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -351,6 +351,36 @@ static int huawei_wmi_battery_set(struct device *dev, int low, int high)
 	return err;
 }
 
+/* Fn lock */
+
+static int huawei_wmi_fn_lock_get(struct device *dev, int *on)
+{
+	u8 ret[0x100] = { 0 };
+	int err, i;
+
+	err = huawei_wmi_cmd(dev, FN_LOCK_GET, ret, 0x100);
+	if (err)
+		return err;
+
+	/* Find the first non-zero value. Return status is ignored. */
+	i = 1;
+	do {
+		*on = ret[i] - 1; // -1 undefined, 0 off, 1 on.
+	} while (i < 0x100 && !ret[i++]);
+
+	return 0;
+}
+
+static int huawei_wmi_fn_lock_set(struct device *dev, int on)
+{
+	u8 arg[8];
+
+	*(u64 *)arg = FN_LOCK_SET;
+	arg[2] = on + 1; // 0 undefined, 1 off, 2 on.
+
+	return huawei_wmi_cmd(dev, *(u64 *)arg, NULL, NULL);
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
-- 
2.20.1


