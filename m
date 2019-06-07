Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C370C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1AF208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fukRxLFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfFGVF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:05:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43480 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbfFGVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:05:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so1760566pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/JCuNUNHpvYXS5HzA6CyKCsgw+Y9FIdtQCe1irA9XM=;
        b=fukRxLFxtd7ntyRussvwUhf3/zME/vEBn6WGUhgH1C6xOnnk0xy7yOcRq4qemQ/RTZ
         PrX8Ex6DvqdTxy457AK7HsZtrQQqB9xNE6LljfHQ9P0unErJGi2JsAgc42A54+WTAWfv
         4RYexHsqYcIebiGu00X5NriGKSpzU3V8os//8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/JCuNUNHpvYXS5HzA6CyKCsgw+Y9FIdtQCe1irA9XM=;
        b=cdW5aYYMU8Y0E5CObaCL7XR33UyXxhMBsWKc0e3OFNB3/q+n4XvvyC2JNykWLpbcP4
         HUYi+CP76sgUdTmgHcbj/jjnEi3M/uYYjEEKdIjwZZ/93etJxASEyYYCvJl34vwpdy0v
         oEIfnGGZFpwnIjNKuI5vMP/Xin6DH5O3w14Y47Sw+Gj0eGk4KSgOVwR6bchWgMeWdGDt
         XWA/5fIa6rDM952Mho/p8po756+F1Q117chN2wbzhNMwWDl8zdqpmDlbzzD4T2Ak5vpU
         Lnu+4N1ymH4sIGzAze9fTUkcF6qok8Mh+zP1Z0R8sjg1asIpcy+onue0jl8lqTXZRe2A
         L45Q==
X-Gm-Message-State: APjAAAWsT1a9u4JLQ8782f+M5tpoG+fOayUKhZqAvxIJ9ZN7ET/SZgkf
        5rSckD60iShDOQI+DgNxS+NrxA==
X-Google-Smtp-Source: APXvYqxjHp5dkMvJDKi1lSt+UmE9FfTR90t9yYb9tPqSBVjLl7gU0dBNruK1PMygm1fD6LLqIOfdrg==
X-Received: by 2002:a65:490f:: with SMTP id p15mr4761307pgs.275.1559941558355;
        Fri, 07 Jun 2019 14:05:58 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id n2sm5583391pgp.27.2019.06.07.14.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 14:05:57 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH] platform/chrome: Expose resume result via sysfs
Date:   Fri,  7 Jun 2019 14:05:28 -0700
Message-Id: <20190607210528.248042-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ECs that support it, the EC returns the number of slp_s0
transitions and whether or not there was a timeout in the resume
response. Expose the last resume result to usermode via sysfs so
that usermode can detect and report S0ix timeouts.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Enric, I'm not sure if this conflicts with your giant refactoring.
I can rebase this on your series, but patchwork doesn't have patch
2 of your series, so you'd have to point me to a tree.

---
 drivers/mfd/cros_ec.c                   |  6 +++++-
 drivers/platform/chrome/cros_ec_sysfs.c | 17 +++++++++++++++++
 include/linux/mfd/cros_ec.h             |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index bd2bcdd4718b..64a2d3adc729 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -110,12 +110,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 
 	/* For now, report failure to transition to S0ix with a warning. */
 	if (ret >= 0 && ec_dev->host_sleep_v1 &&
-	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
+	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
+		ec_dev->last_resume_result =
+			buf.u.resp1.resume_response.sleep_transitions;
+
 		WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
 			  EC_HOST_RESUME_SLEEP_TIMEOUT,
 			  "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
 			  buf.u.resp1.resume_response.sleep_transitions &
 			  EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
+	}
 
 	return ret;
 }
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 3edb237bf8ed..2deca98c7a7a 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -308,18 +308,35 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 	return count;
 }
 
+/* Last resume result */
+static ssize_t last_resume_result_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+	int ret;
+
+	ret = scnprintf(buf,
+			PAGE_SIZE,
+			"0x%x\n",
+			ec->ec_dev->last_resume_result);
+
+	return ret;
+}
+
 /* Module initialization */
 
 static DEVICE_ATTR_RW(reboot);
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(flashinfo);
 static DEVICE_ATTR_RW(kb_wake_angle);
+static DEVICE_ATTR_RO(last_resume_result);
 
 static struct attribute *__ec_attrs[] = {
 	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
 	&dev_attr_flashinfo.attr,
+	&dev_attr_last_resume_result.attr,
 	NULL,
 };
 
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index cfa78bb4990f..d50ade418a83 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -163,6 +163,7 @@ struct cros_ec_device {
 	struct ec_response_get_next_event_v1 event_data;
 	int event_size;
 	u32 host_event_wake_mask;
+	u32 last_resume_result;
 };
 
 /**
-- 
2.20.1

