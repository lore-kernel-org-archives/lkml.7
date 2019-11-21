Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C78FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147EE206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gbRkCRJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKUSzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:55:50 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34489 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:55:49 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so4764365iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YMHfxCsFWJZxE/YLhMGLLlnP7UvdAj72cQ6sRIuqMc=;
        b=gbRkCRJAwXqzeuLEyE+SmiBmNAxdaN5YhZF5PFk3wpx2+tnfuM3JzO3RiahXoEbX9Z
         iUI6r+QjOEFggThdmm1Lr5BC9Pl4x214Cl2efGtqP/iTw9qdvyxOyHfg6NyYKtyUb0Xx
         PSZPJ3KaFsYceyruelPBsYEHUh9M/UUhnGt1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YMHfxCsFWJZxE/YLhMGLLlnP7UvdAj72cQ6sRIuqMc=;
        b=IYIZZzKmvErF1d2ERsR3FI4LKpG3oYzZJjOHFdcBmrQ6EZ6zvwejfBsvu+wx8QcQzA
         AVvMAVgyvyaC4f9yheZK5Xuq+ej+VE9FWgkFtLyBiraTzNB/yqcBdtc9Up/ybislboZG
         KrY+EtWdLkDabfF/7WvQpUsWGfG54B888DoCYS+nlX0fbfmbVFuJQP7+PBGj/nZKjiQN
         VXq8Du49tNdwZwggCnyoWFd9QYOHu21GKB5JaSkz6vFPdaQW+0PKV/K6f9nSojdjItEM
         oH32Y04D6FIt/a2liaxb1XOptVTyvEpmPYlY3/RMDc8vtA5O8HLpHbRHyyrwvV4DbTZB
         tttg==
X-Gm-Message-State: APjAAAX46/X/k8ZwAZ84hNn/lE+K6NO5hd2a4ukBvDVkYQnT65nmTUya
        0ygSGM9NpQw2jfj0hiYzD9jtXg==
X-Google-Smtp-Source: APXvYqxs2Np9YTcT0ulKRSa1JP5+6YtaEzHQ3c+JiCkkHXRleSntiiLPv/PYk959fgbh6if9BijkoQ==
X-Received: by 2002:a6b:b4ca:: with SMTP id d193mr9228161iof.71.1574362548496;
        Thu, 21 Nov 2019 10:55:48 -0800 (PST)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id s11sm1541764ilh.54.2019.11.21.10.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 10:55:48 -0800 (PST)
From:   Raul E Rangel <rrangel@chromium.org>
To:     enric.balletbo@collabora.com
Cc:     akshu.agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_proto: Add response tracing
Date:   Thu, 21 Nov 2019 11:55:45 -0700
Message-Id: <20191121115542.1.Iaf98f0ab455b626537e77cfa71cef6ff2ab6f37b@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to view response codes as well.

I renamed the trace event from cros_ec_cmd to cros_ec_request and added
a cros_ec_response.

Example:
$ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
$ cat /sys/kernel/debug/tracing/trace

cros_ec_request: version: 1, command: EC_CMD_CONSOLE_READ
cros_ec_response: version: 1, command: EC_CMD_CONSOLE_READ, result: EC_RES_SUCCESS, rc: 0
cros_ec_request: version: 0, command: EC_CMD_USB_PD_POWER_INFO
cros_ec_response: version: 0, command: EC_CMD_USB_PD_POWER_INFO, result: EC_RES_SUCCESS, rc: 16

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/platform/chrome/cros_ec_proto.c |  7 +++++-
 drivers/platform/chrome/cros_ec_trace.c | 24 +++++++++++++++++++
 drivers/platform/chrome/cros_ec_trace.h | 32 +++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index bd485ce98a42..ef2229047e0f 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -54,7 +54,7 @@ static int send_command(struct cros_ec_device *ec_dev,
 	int ret;
 	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
 
-	trace_cros_ec_cmd(msg);
+	trace_cros_ec_request(msg);
 
 	if (ec_dev->proto_version > 2)
 		xfer_fxn = ec_dev->pkt_xfer;
@@ -73,6 +73,8 @@ static int send_command(struct cros_ec_device *ec_dev,
 	}
 
 	ret = (*xfer_fxn)(ec_dev, msg);
+
+	trace_cros_ec_response(msg, ret);
 	if (msg->result == EC_RES_IN_PROGRESS) {
 		int i;
 		struct cros_ec_command *status_msg;
@@ -95,7 +97,10 @@ static int send_command(struct cros_ec_device *ec_dev,
 		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
 			usleep_range(10000, 11000);
 
+			trace_cros_ec_request(status_msg);
 			ret = (*xfer_fxn)(ec_dev, status_msg);
+			trace_cros_ec_response(status_msg, ret);
+
 			if (ret == -EAGAIN)
 				continue;
 			if (ret < 0)
diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 6f80ff4532ae..28eb94d99ba2 100644
--- a/drivers/platform/chrome/cros_ec_trace.c
+++ b/drivers/platform/chrome/cros_ec_trace.c
@@ -120,5 +120,29 @@
 	TRACE_SYMBOL(EC_CMD_PD_GET_LOG_ENTRY), \
 	TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO)
 
+// See enum ec_status
+#define EC_RESULT \
+	TRACE_SYMBOL(EC_RES_SUCCESS), \
+	TRACE_SYMBOL(EC_RES_INVALID_COMMAND), \
+	TRACE_SYMBOL(EC_RES_ERROR), \
+	TRACE_SYMBOL(EC_RES_INVALID_PARAM), \
+	TRACE_SYMBOL(EC_RES_ACCESS_DENIED), \
+	TRACE_SYMBOL(EC_RES_INVALID_RESPONSE), \
+	TRACE_SYMBOL(EC_RES_INVALID_VERSION), \
+	TRACE_SYMBOL(EC_RES_INVALID_CHECKSUM), \
+	TRACE_SYMBOL(EC_RES_IN_PROGRESS), \
+	TRACE_SYMBOL(EC_RES_UNAVAILABLE), \
+	TRACE_SYMBOL(EC_RES_TIMEOUT), \
+	TRACE_SYMBOL(EC_RES_OVERFLOW), \
+	TRACE_SYMBOL(EC_RES_INVALID_HEADER), \
+	TRACE_SYMBOL(EC_RES_REQUEST_TRUNCATED), \
+	TRACE_SYMBOL(EC_RES_RESPONSE_TOO_BIG), \
+	TRACE_SYMBOL(EC_RES_BUS_ERROR), \
+	TRACE_SYMBOL(EC_RES_BUSY), \
+	TRACE_SYMBOL(EC_RES_INVALID_HEADER_VERSION), \
+	TRACE_SYMBOL(EC_RES_INVALID_HEADER_CRC), \
+	TRACE_SYMBOL(EC_RES_INVALID_DATA_CRC), \
+	TRACE_SYMBOL(EC_RES_DUP_UNAVAILABLE)
+
 #define CREATE_TRACE_POINTS
 #include "cros_ec_trace.h"
diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index 0dd4df30fa89..853eeaaac9da 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -18,7 +18,7 @@
 
 #include <linux/tracepoint.h>
 
-DECLARE_EVENT_CLASS(cros_ec_cmd_class,
+DECLARE_EVENT_CLASS(cros_ec_request_class,
 	TP_PROTO(struct cros_ec_command *cmd),
 	TP_ARGS(cmd),
 	TP_STRUCT__entry(
@@ -34,11 +34,39 @@ DECLARE_EVENT_CLASS(cros_ec_cmd_class,
 );
 
 
-DEFINE_EVENT(cros_ec_cmd_class, cros_ec_cmd,
+DEFINE_EVENT(cros_ec_request_class, cros_ec_request,
 	TP_PROTO(struct cros_ec_command *cmd),
 	TP_ARGS(cmd)
 );
 
+DECLARE_EVENT_CLASS(cros_ec_response_class,
+	TP_PROTO(struct cros_ec_command *cmd, int rc),
+	TP_ARGS(cmd, rc),
+	TP_STRUCT__entry(
+		__field(uint32_t, version)
+		__field(uint32_t, command)
+		__field(uint32_t, result)
+		__field(int, rc)
+	),
+	TP_fast_assign(
+		__entry->version = cmd->version;
+		__entry->command = cmd->command;
+		__entry->result = cmd->result;
+		__entry->rc = rc;
+	),
+	TP_printk("version: %u, command: %s, result: %s, rc: %d",
+		  __entry->version,
+		  __print_symbolic(__entry->command, EC_CMDS),
+		  __print_symbolic(__entry->result, EC_RESULT),
+		  __entry->rc)
+);
+
+
+DEFINE_EVENT(cros_ec_response_class, cros_ec_response,
+	TP_PROTO(struct cros_ec_command *cmd, int rc),
+	TP_ARGS(cmd, rc)
+);
+
 
 #endif /* _CROS_EC_TRACE_H_ */
 
-- 
2.24.0.432.g9d3f5f5b63-goog

