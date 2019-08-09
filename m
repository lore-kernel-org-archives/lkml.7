Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA08C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B03216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig+OAtP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405399AbfHIDEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:04:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42624 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404533AbfHIDEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:04:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so45094947pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkv9lR0hAtLKOW5gkirlFYTKguflMZvyPqUX9XJEFP8=;
        b=ig+OAtP2gw5ZGHC7kb/G98hh1FK4Wc2v1ulYMIqyuuB6U+aEQ7jDqrZ8+nunqgl9qt
         /gqgfZC0z3eeznbxr4Hsmatv8pY/Z8Y1IY/kKL85tzlhKcx24pVXNM9df3jmdz9+/ngu
         lUDBmY65fid2RtFO3K7RM4pFiDfPNf7B3PEdd/IfblT1GhnK8cMSa6TkqALPRM8A1N3n
         nQPaXYSBA7yKqsy7yEI2T2iYNjK6WJ3z9JVa8OCLatuyyleapeWvVYHKKXwSx7ke0Cgi
         R4g8yd/9XhVruVrmgHEr6l9FSgmRHILnwq/BfoCp2CrrbEfxxnoBQUPaJsVfMshYVqfY
         1SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkv9lR0hAtLKOW5gkirlFYTKguflMZvyPqUX9XJEFP8=;
        b=tA+vRuOeQmzrxc9S9qzR2eRLZZDTbetCmzXN5lbRwV9ZdFeKjP7Rd++bd/+RuPbdHu
         B48LDKitWs928/Ks4DKoHXzxDTQc0kHAL0yKR/uYPy9Atibwl8HQwTsN7hT2SED9kf7T
         dHXoHPYifwTz4ZDEgwcn+i1uZiKFL6iddR6l1khV4QSImeLmFOfl+F3MCYCVrGjWqM8q
         H+GnDMAVAxg7M//SYJzpSlDXFP/T8RafZqVavtad06OjffXlqZz05LfEYmerueKBcMRS
         pEKAgzO0dSJa7KpjCJkn9bxsSndOmU8SWKWoYPEwzwDgNXZyRmNCdt5c7BI7/gveqFgv
         uG4Q==
X-Gm-Message-State: APjAAAUNVLsKdvrO/DUWzUhrUf9I/esl68NkOc+j/PdOeXSMqo5vBP9u
        3tCO7rGRSet2hCDe4GFpS8s=
X-Google-Smtp-Source: APXvYqzwYr2SVNpMMxAdcYQ9Urz+CDCc1DrarrFpT95gsVVoB6V3ZEsbz1CDkRRDaCJFCxXzwu+Icw==
X-Received: by 2002:a63:f357:: with SMTP id t23mr15859793pgj.421.1565319839914;
        Thu, 08 Aug 2019 20:03:59 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id o14sm3556284pjp.19.2019.08.08.20.03.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:03:59 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] regulator: core: Add devres versions of regulator_enable/disable
Date:   Fri,  9 Aug 2019 11:03:52 +0800
Message-Id: <20190809030352.8387-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a coccinelle script to detect possible chances
of utilizing devm_() APIs to simplify the driver.
The script found 147 drivers in total and 22 of them
have be patched.

Within the 125 left ones, at least 31 of them (24.8%)
are hindered from benefiting from devm_() APIs because
of lack of a devres version of regulator_enable().

Therefore I implemented devm_regulator_enable/disable()
to make more drivers possible to use devm_() APIs.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/regulator/devres.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 3ea1c170f840..507151a71fd3 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -115,6 +115,61 @@ void devm_regulator_put(struct regulator *regulator)
 }
 EXPORT_SYMBOL_GPL(devm_regulator_put);
 
+static void devm_regulator_off(struct device *dev, void *res)
+{
+	regulator_disable(*(struct regulator **)res);
+}
+
+/**
+ * devm_regulator_enable - Resource managed regulator_enable()
+ * @regulator: regulator to enable
+ *
+ * Managed regulator_enable(). Regulator enabled is automatically
+ * disabled on driver detach. See regulator_enable() for more
+ * information.
+ */
+int devm_regulator_enable(struct device *dev, struct regulator *regulator)
+{
+	struct regulator **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_regulator_off, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = regulator_enable(regulator);
+	if (!ret) {
+		*ptr = regulator;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_regulator_enable);
+
+/**
+ * devm_regulator_disable - Resource managed regulator_disable()
+ * @regulator: regulator to disable
+ *
+ * Disable a regulator enabled by devm_regulator_enable().
+ * Normally this function will not need to be called and the
+ * resource management code will ensure that the regulator is
+ * disabled.
+ */
+void devm_regulator_disable(struct regulator *regulator)
+{
+	int rc;
+
+	rc = devres_release(regulator->dev, devm_regulator_off,
+			    devm_regulator_match, regulator);
+
+	if (rc != 0)
+		WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_disable);
+
 struct regulator_bulk_devres {
 	struct regulator_bulk_data *consumers;
 	int num_consumers;
-- 
2.20.1

