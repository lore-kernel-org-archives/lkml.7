Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63820C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35108218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dUk0AOQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfCTVU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:20:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:20:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so2811264pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwzRKcrTw0645WVKxPkV1qbI608tr9KQ/mty/gY/Qrg=;
        b=dUk0AOQ2OTecYaLCcQHtM0RZdWcu0Z31bN4OkfuviPj7REaz6eemdRsstMxXklWrRn
         TddlnAoJ0y55p/bDsD7/P76jr5KldOHl+6guouK4l/Z4AXpgxb2SCQWAAbkORxJiKLc5
         0xyPB++OAKk1nrezgGXZDNpl2QBciqGee5D6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwzRKcrTw0645WVKxPkV1qbI608tr9KQ/mty/gY/Qrg=;
        b=MmL5CuHCGo+9dBzK/L48XHo/MvOlXCQ4GpoI45/oHHU9Dsaemv1PByhELAKPz0n+wb
         luEJNJU5xFaom05t2WsZvPFey5wLZ9CW40P79UCldFBPYcH2KvZ0GhZ7ArbKqRstPAxy
         svhxj9HOpWk7bj6N/ui7AqhUKNHwGBMLtaZxlc35FmGpT38AYkhcAIHM86HECkOas3yc
         vGvuaPuPjNLbH8XemQbBqjN4htycCKlm2ZeBeifYqadtTxdSLsQDhxawhcf3j6M+MNo3
         RmYyuSmKAc1bGnPIqKfu1RENCDqSIKvgs2KzacYJCzWV+x6odgjn5JIRq9wBWYhvBZEQ
         z4og==
X-Gm-Message-State: APjAAAUxXhTWLVj5yzc2EOIrVqPtFI1990SCEir3jTECudNJZs1yr5W2
        oJpzWlAFqFqHHDPKqinhB5Sl0A==
X-Google-Smtp-Source: APXvYqwoMjLqhVMLApltbBbLBey9mOKbHGSnn32+H56wf/e9cYcAxFzxP6KJHeOs9T1QkuKMrXSSPg==
X-Received: by 2002:a17:902:7590:: with SMTP id j16mr10188437pll.304.1553116856805;
        Wed, 20 Mar 2019 14:20:56 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u13sm5288609pfa.169.2019.03.20.14.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 14:20:56 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
Date:   Wed, 20 Mar 2019 14:20:29 -0700
Message-Id: <20190320212030.43682-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320212030.43682-1-evgreen@chromium.org>
References: <20190320212030.43682-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the command and response structures for the second revision
of the host sleep event. These structures are part of a new EC change
that enables detection of failure to enter S0ix. The EC waits a
kernel-specified timeout (or a default amount of time) for the S0_SLP
pin to change, and wakes the system if that change does not occur in
time.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

 include/linux/mfd/cros_ec_commands.h | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc91082d4c35..4db1240c28a8 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2729,6 +2729,65 @@ struct ec_params_host_sleep_event {
 	uint8_t sleep_event;
 } __packed;
 
+/*
+ * Use a default timeout value (CONFIG_SLEEP_TIMEOUT_MS) for detecting sleep
+ * transition failures
+ */
+#define EC_HOST_SLEEP_TIMEOUT_DEFAULT 0
+
+/* Disable timeout detection for this sleep transition */
+#define EC_HOST_SLEEP_TIMEOUT_INFINITE 0xFFFF
+
+struct ec_params_host_sleep_event_v1 {
+	/* The type of sleep being entered or exited. */
+	uint8_t sleep_event;
+
+	/* Padding */
+	uint8_t reserved;
+	union {
+		/* Parameters that apply for suspend messages. */
+		struct {
+			/*
+			 * The timeout in milliseconds between when this message
+			 * is received and when the EC will declare sleep
+			 * transition failure if the sleep signal is not
+			 * asserted.
+			 */
+			uint16_t sleep_timeout_ms;
+		} suspend_params;
+
+		/* Reserved space for non-suspend commands. */
+		uint16_t reserved;
+	} u;
+} __packed;
+
+/* A timeout occurred when this bit is set */
+#define EC_HOST_RESUME_SLEEP_TIMEOUT 0x80000000
+
+/*
+ * The mask defining which bits correspond to the number of sleep transitions,
+ * as well as the maximum number of suspend line transitions that will be
+ * reported back to the host.
+ */
+#define EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK 0x7FFFFFFF
+
+struct ec_response_host_sleep_event_v1 {
+	union {
+		/* Response fields that apply for resume messages. */
+		struct {
+			/*
+			 * The number of sleep power signal transitions that
+			 * occurred since the suspend message. The high bit
+			 * indicates a timeout occurred.
+			 */
+			uint32_t sleep_transitions;
+		} resume_response;
+
+		/* Padding for non-resume responses. */
+		uint32_t reserved;
+	} u;
+} __packed;
+
 /*****************************************************************************/
 /* Smart battery pass-through */
 
-- 
2.20.1

