Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D60AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B202082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iUgvrSUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfDCVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:34:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43630 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDCVel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:34:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so213854pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSSz+zR7M/ELeq393leY6tHgOOqG0ck7KLOSfSbxL80=;
        b=iUgvrSULpteRl+PHacjTqhPJKe+Mk8h4NiAXxOl6sjJNr8u2bVPU96X69VfCDZ3U8y
         ushroGtR7VmEYXH0Uo7pyu212GOErfVyrUiLK2B0hzF94lKa3uK2IqaN2HWolbWu893Q
         uR6uLtkVw9BrXY8QKsEX2kne1hpw+beUCsaJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSSz+zR7M/ELeq393leY6tHgOOqG0ck7KLOSfSbxL80=;
        b=LNNS5tKZw2Jxv8WfMSslM3OB5qO2rwssUQyKPVCyJCALPL8/cAcfPDlPovTeA5MG60
         ZwJ2y44er0PSZnHjnqDn9eB+QsiluVq1d6owaV0mxSPtVuW3oUB1WwUE+k4dBxtOT4AK
         77dpTioJfNYwI86OhawYIwqFalLorJM3MBeBZpP6GNY9xcpMO2MYzSpHyB9wndadvMT/
         A9FTrzZOzE5VcdukO6w/+Fvb2tRISGXKVm/SgxzKxSXA0ikutKFmgpYWcLHFlV2gNeho
         ptqvVIrnIpGfXYVP4PUo1xg8UkDL8NDiBHgUUJW/Ct0aQtAdv0jnw1xFEoBOViCmDOg6
         smUw==
X-Gm-Message-State: APjAAAVYfoQEFsyp6pn1DEouoaB02jzv2ccxbxlz2aXjwOpBw+CAuNOB
        wei40n/oJxSny3v1L560m96aJQ==
X-Google-Smtp-Source: APXvYqyxPLkIlDti9Lp9fj/Qv/e5t3PXIRKnhHaQJ3ZQs3tsIU+Jx5vgeAEvW3etVoCAWj5or9FVHA==
X-Received: by 2002:a63:6941:: with SMTP id e62mr1874494pgc.99.1554327280038;
        Wed, 03 Apr 2019 14:34:40 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id k124sm21796741pgc.65.2019.04.03.14.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Apr 2019 14:34:39 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 2/2] platform/chrome: Add support for v1 of host sleep event
Date:   Wed,  3 Apr 2019 14:34:28 -0700
Message-Id: <20190403213428.89920-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403213428.89920-1-evgreen@chromium.org>
References: <20190403213428.89920-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support in code for the new forms of the host sleep event.
Detects the presence of this version of the command at runtime,
and use whichever form the EC supports. At this time, always
request the default timeout, and only report the failing response
via a WARN_ONCE(). Future versions could accept the sleep parameter
from outside the driver, and return the response information to
usermode or elsewhere.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v3:
- Consolidated boolean logic for host_sleep_v1 (Guenter)

Changes in v2:
- Removed unnecessary version assignment (Guenter)
- Changed WARN to WARN_ONCE (Guenter)
- Fixed C code to use anonymous unions
- insize is only bigger for resume events.

 drivers/mfd/cros_ec.c                   | 39 +++++++++++++++++++++----
 drivers/platform/chrome/cros_ec_proto.c |  6 ++++
 include/linux/mfd/cros_ec.h             |  2 ++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 6acfe036d522..bd2bcdd4718b 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -75,20 +75,49 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
 
 static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 {
+	int ret;
 	struct {
 		struct cros_ec_command msg;
-		struct ec_params_host_sleep_event req;
+		union {
+			struct ec_params_host_sleep_event req0;
+			struct ec_params_host_sleep_event_v1 req1;
+			struct ec_response_host_sleep_event_v1 resp1;
+		} u;
 	} __packed buf;
 
 	memset(&buf, 0, sizeof(buf));
 
-	buf.req.sleep_event = sleep_event;
+	if (ec_dev->host_sleep_v1) {
+		buf.u.req1.sleep_event = sleep_event;
+		buf.u.req1.suspend_params.sleep_timeout_ms =
+				EC_HOST_SLEEP_TIMEOUT_DEFAULT;
+
+		buf.msg.outsize = sizeof(buf.u.req1);
+		if ((sleep_event == HOST_SLEEP_EVENT_S3_RESUME) ||
+		    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
+			buf.msg.insize = sizeof(buf.u.resp1);
+
+		buf.msg.version = 1;
+
+	} else {
+		buf.u.req0.sleep_event = sleep_event;
+		buf.msg.outsize = sizeof(buf.u.req0);
+	}
 
 	buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
-	buf.msg.version = 0;
-	buf.msg.outsize = sizeof(buf.req);
 
-	return cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+
+	/* For now, report failure to transition to S0ix with a warning. */
+	if (ret >= 0 && ec_dev->host_sleep_v1 &&
+	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
+		WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
+			  EC_HOST_RESUME_SLEEP_TIMEOUT,
+			  "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
+			  buf.u.resp1.resume_response.sleep_transitions &
+			  EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
+
+	return ret;
 }
 
 int cros_ec_register(struct cros_ec_device *ec_dev)
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 97a068dff192..52ca564a64e7 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -414,6 +414,12 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	else
 		ec_dev->mkbp_event_supported = 1;
 
+	/* Probe if host sleep v1 is supported for S0ix failure detection. */
+	ret = cros_ec_get_host_command_version_mask(ec_dev,
+						    EC_CMD_HOST_SLEEP_EVENT,
+						    &ver_mask);
+	ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
+
 	/*
 	 * Get host event wake mask, assume all events are wake events
 	 * if unavailable.
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 8f2a8918bfa3..b6442201f77f 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -120,6 +120,7 @@ struct cros_ec_command {
  * @pkt_xfer: Send packet to EC and get response.
  * @lock: One transaction at a time.
  * @mkbp_event_supported: True if this EC supports the MKBP event protocol.
+ * @host_sleep_v1: True if this EC supports the sleep v1 command.
  * @event_notifier: Interrupt event notifier for transport devices.
  * @event_data: Raw payload transferred with the MKBP event.
  * @event_size: Size in bytes of the event data.
@@ -153,6 +154,7 @@ struct cros_ec_device {
 			struct cros_ec_command *msg);
 	struct mutex lock;
 	bool mkbp_event_supported;
+	bool host_sleep_v1;
 	struct blocking_notifier_head event_notifier;
 
 	struct ec_response_get_next_event_v1 event_data;
-- 
2.20.1

