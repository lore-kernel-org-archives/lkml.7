Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED104C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E11208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDsbwwHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfF3Flw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34435 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfF3Fls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id q64so6764128vsd.1;
        Sat, 29 Jun 2019 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YmPyHZ8dDaGq4wOOYUfRrP02saBuikUQohVrtGbVNIQ=;
        b=oDsbwwHbK68Ni8qTmaH83d6uoBN2aaEfFMv3CNPeT20QpwXOzPAtvHUFSGXXWIBinQ
         drXSxr2afFIEyF9fdJobBO9C9/XY7p+RKWYJebkrUUao7v1pYWK6cEbAeTWdaMmw1TjO
         7pXdyMObIPh7+z1KDbtIPjZgx30RYW+QuYWrgrn+FTUWVrWttYz6iPAqSxsa7DlFyy4J
         FI7/1ZU9iS/NyAI29RCpnRJ2xhlsK9aXPm9UcplfmY/xroLbTxq/9PCqnJR0ygSrqQrn
         YIcMMus5Js6QE1kmPEz3yZTl+v475JwuJj3BhHWbTzhCB+8eGHrANVh51PglnHr/YjrO
         R6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmPyHZ8dDaGq4wOOYUfRrP02saBuikUQohVrtGbVNIQ=;
        b=Z0KJfc2DcCU8cDI5/jzV/umFCK02/KgeqpamN9z0zwZJBfiAFcuaYsEnhgOEIIj4XZ
         ZhViLI7jXTqmDbYBLHcWFB5+b+nGTqsbxr4gc+91cFKs5l1j1w2goCkPn4SjGnjway8f
         hDlSMcvazD93uUPaZFszGI1SRediPBQknbqDqwKN5QCf9R+bAt9Qhzl2Ha6r/YlAF0xC
         8g+JYTMJCtKzPpOFcbadxp82HhU4e+HJjq/e7fZZg1Frikxyj4uzIfGaacUcP/h2VYAt
         uYTWDmxnKlObgkQaK2K7fvKlIVzyKnnhbMEic59jcCYnfYJ43TWJUvcv77a/mbD+l1Pp
         pzHg==
X-Gm-Message-State: APjAAAV4w2ASVvSRDBTf1TDCH+/szBBkOXtdeLjp8+lfn8b7EXrx2t8Q
        cZbUf0TGtfeMILAI96u67KSwtecjfg==
X-Google-Smtp-Source: APXvYqz0OAK6Iu1jTdoJ+PWbEyVH33gAs/NHtWPY5wn2SejRysO4MQZWdB4YY56ysD8HkLYZPH9zZA==
X-Received: by 2002:a67:f492:: with SMTP id o18mr10727937vsn.62.1561873307328;
        Sat, 29 Jun 2019 22:41:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id r136sm1926676vke.46.2019.06.29.22.41.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:41:47 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [RFC 7/9] platform/x86: huawei-wmi: Add fn-lock support
Date:   Sun, 30 Jun 2019 01:41:06 -0400
Message-Id: <20190630054108.19205-8-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630054108.19205-1-ayman.bagabas@gmail.com>
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
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

