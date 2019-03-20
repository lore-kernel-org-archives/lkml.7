Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3BB218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fpDBk1lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCTVVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:21:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35482 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTVVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:21:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so2070017pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irvMbISskK/KpJ3A2VOS6FKNJ4d1rqkwk9RIpQHEpwQ=;
        b=fpDBk1lfpiNfT+iMmTIWLG17IrS51L7bbAsFjCFj9U8XPGRFAD6FAw362vt6F4yVVW
         EfC/1z+1KSHdaSoTYVYrwlGagElG2L/OsbZS+RiB0lOFFpoVdjaZdZppHBlTrzz9qqtJ
         ucZ6GFdJ9VCuyl11YaA10zV0ZhcbM22IWs1yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irvMbISskK/KpJ3A2VOS6FKNJ4d1rqkwk9RIpQHEpwQ=;
        b=kqg2YSwpPdhf8kuZyd+5+ZqNdwhzsMxfl1gAMjVjTfNmXKXkcmopl1/Jd/gbv3WxTV
         nfttmtFdtZQnGU0qeVNOMhIuUe1ZWjRYyZ0FX+62H9+z+gDfbawscMCTXX47oGDuQHXS
         QRWT1umovxEw46BwXyxqTaKOo9NKBJ4/3S0GBoSqugIsBaySb7AMFlbPGLvX+ZrxtXHb
         Pgp7+PGa0ryXgJY6SFae6xx6BwQEDaJZ2vK0jahUYtDzFbqlAnLvyQNCwP2taXXouYSD
         OVHb1+4+scQfxJ5ljO3bBucRYR6Am15iWZHZCBHrpSQANFKU6m87/TW6hjRO8tR4cHko
         B8ew==
X-Gm-Message-State: APjAAAU6j4bmsznOPaPD08w1o6cwDd29UX97ajXmkrP8Su6ZcOkmEwCM
        R9B2Ltu0wv8a4UNz6BZiK/UnvQ==
X-Google-Smtp-Source: APXvYqwMbFZhuW18rG/DZXr/mEPJDjIDXCX7/xUQBgP9mdm224E4CYf95z5bS6KnsdoZHMNPgBtxtA==
X-Received: by 2002:a17:902:9a43:: with SMTP id x3mr10571446plv.173.1553116862799;
        Wed, 20 Mar 2019 14:21:02 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u13sm5288609pfa.169.2019.03.20.14.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 14:21:02 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/2] platform/chrome: Add support for v1 of host sleep event
Date:   Wed, 20 Mar 2019 14:20:30 -0700
Message-Id: <20190320212030.43682-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320212030.43682-1-evgreen@chromium.org>
References: <20190320212030.43682-1-evgreen@chromium.org>
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
via a WARN(). Future versions could accept the sleep parameter
from outside the driver, and return the response information to
usermode or elsewhere.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

 drivers/mfd/cros_ec.c                   | 37 +++++++++++++++++++++----
 drivers/platform/chrome/cros_ec_proto.c |  9 ++++++
 include/linux/mfd/cros_ec.h             |  2 ++
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 6acfe036d522..5305ea706aa9 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -75,20 +75,47 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
 
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
+		buf.u.req1.u.suspend_params.sleep_timeout_ms =
+				EC_HOST_SLEEP_TIMEOUT_DEFAULT;
+
+		buf.msg.outsize = sizeof(buf.u.req1);
+		buf.msg.insize = sizeof(buf.u.resp1);
+		buf.msg.version = 1;
+
+	} else {
+		buf.u.req0.sleep_event = sleep_event;
+		buf.msg.outsize = sizeof(buf.u.req0);
+		buf.msg.version = 0;
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
+		WARN(buf.u.resp1.u.resume_response.sleep_transitions &
+		     EC_HOST_RESUME_SLEEP_TIMEOUT,
+		     "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
+		     buf.u.resp1.u.resume_response.sleep_transitions &
+		     EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
+
+	return ret;
 }
 
 int cros_ec_register(struct cros_ec_device *ec_dev)
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 97a068dff192..78ceab659a36 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -414,6 +414,15 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	else
 		ec_dev->mkbp_event_supported = 1;
 
+	/* Probe if host sleep v1 is supported for S0ix failure detection. */
+	ret = cros_ec_get_host_command_version_mask(ec_dev,
+						    EC_CMD_HOST_SLEEP_EVENT,
+						    &ver_mask);
+	if (ret < 0 || !(ver_mask & EC_VER_MASK(1)))
+		ec_dev->host_sleep_v1 = 0;
+	else
+		ec_dev->host_sleep_v1 = 1;
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

