Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036AAC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91E621A49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VsXcQfps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfKEUvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:51:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51502 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEUvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:51:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so908872wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 12:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86+b3nLS9bc8VDStO93HdimlizslTYlGrlQhHJTbrT4=;
        b=VsXcQfpstDMDBiO/7BvB/yl0oN780/GG/FJehxFtBv77wAHaYRFX8xW5lDSq2WHLlS
         8RF/ARYHZfN5KAqvNgA91kSpzufz7c/zI/5GhNR34FdUiNTmFDlOvRAxt/jEz7Xc18fQ
         F3+4wE6qJOQtYYHS6cz5on9mOT+NI+HGGhjDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86+b3nLS9bc8VDStO93HdimlizslTYlGrlQhHJTbrT4=;
        b=Psc6cwvBehT6QCh96zkjX/UgqVsiYHWL72vfH0uuuK71yOFDZgOQ2e6kX6EQMQY0tj
         Vv0NkXYvx8o3qTXUz9iCfW+Rd7rvS7AIMQSuYZnH4ClyPLX89t6TQB0PFvvZvuBOqFOK
         Cxo60Y/t4J25d4OkoAvGYaclLNPZxdJOIdTnRuUxbx9G57mqQQwsxrKpZ8hbYZt3Hpup
         tE/3DqxxXZOtFCJG18PnUN289i1cp7U9uQUNBVqg9VWRkh1BxxbiRR+5IRGjyupY+knw
         HrE7CmvjWQymM8sZBv3tS8pkwSyICmLPX2pFiPt+dxZoi3R68Hu6VbxaBm8M3SHJF6Y0
         vqPQ==
X-Gm-Message-State: APjAAAUnVyruqAO5XvmqYxUg/iJrfZXssKHiWsmLIPIvdaxaf3+ly7Ij
        QlATeWfqNVnK2nWhwoRZITCGFA==
X-Google-Smtp-Source: APXvYqygaILxJIOrGAvvSOaxQJT6uuJyMfYoMplcREbHs8U18/qyRi5rEm0JQSsunlDySZ4b2tLKTQ==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr797441wmg.93.1572987082645;
        Tue, 05 Nov 2019 12:51:22 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id 4sm690226wmd.33.2019.11.05.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 12:51:21 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2] watchdog: make nowayout sysfs file writable
Date:   Tue,  5 Nov 2019 21:51:18 +0100
Message-Id: <20191105205118.11359-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105123125.25985-1-linux@rasmusvillemoes.dk>
References: <20191105123125.25985-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to delay setting the nowayout feature for a watchdog
device. Moreover, not every driver (notably gpio_wdt) implements a
nowayout module parameter/otherwise respects CONFIG_WATCHDOG_NOWAYOUT,
and modifying those drivers carries a risk of causing a regression for
someone who has two watchdog devices, sets CONFIG_WATCHDOG_NOWAYOUT
and somehow relies on the gpio_wdt driver being ignorant of
that (i.e., allowing one to gracefully close a gpio_wdt but not the
other watchdog in the system).

So instead, simply make the nowayout sysfs file writable. Obviously,
setting nowayout is a one-way street.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v2: drop redundant "current" variable and !!.

 .../ABI/testing/sysfs-class-watchdog          |  9 ++++++--
 drivers/watchdog/watchdog_dev.c               | 21 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
index 675f9b537661..9860a8b2ba75 100644
--- a/Documentation/ABI/testing/sysfs-class-watchdog
+++ b/Documentation/ABI/testing/sysfs-class-watchdog
@@ -17,8 +17,13 @@ What:		/sys/class/watchdog/watchdogn/nowayout
 Date:		August 2015
 Contact:	Wim Van Sebroeck <wim@iguana.be>
 Description:
-		It is a read only file. While reading, it gives '1' if that
-		device supports nowayout feature else, it gives '0'.
+		It is a read/write file. While reading, it gives '1'
+		if the device has the nowayout feature set, otherwise
+		it gives '0'. Writing a '1' to the file enables the
+		nowayout feature. Once set, the nowayout feature
+		cannot be disabled, so writing a '0' either has no
+		effect (if the feature was already disabled) or
+		results in a permission error.
 
 What:		/sys/class/watchdog/watchdogn/state
 Date:		August 2015
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index dbd2ad4c9294..d3bdcb144657 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -452,7 +452,26 @@ static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "%d\n", !!test_bit(WDOG_NO_WAY_OUT, &wdd->status));
 }
-static DEVICE_ATTR_RO(nowayout);
+
+static ssize_t nowayout_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+	unsigned int value;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &value);
+	if (ret)
+		return ret;
+	if (value > 1)
+		return -EINVAL;
+	/* nowayout cannot be disabled once set */
+	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status) && !value)
+		return -EPERM;
+	watchdog_set_nowayout(wdd, value);
+	return len;
+}
+static DEVICE_ATTR_RW(nowayout);
 
 static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
-- 
2.23.0

