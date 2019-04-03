Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B69C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713A32082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f+5kF9AR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfDCVek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:34:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34800 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCVei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:34:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so129033pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OV11Yd+JyO8D2jFDZUkBxNwVTwEby0NJc8k+iAM1aeg=;
        b=f+5kF9ARFtRfY2Fy28XRkDvW1GkdbCg/sdLT2/6IhdEpPlh1sY7Sok1UGkjHgmAfvy
         02UqvoRTCn83JP2xVKbOZII4ohaj2YzoZaI+EMO8puwrC+a/LP5+TobAujXYYvAits3u
         yCK8inxjoXMR98XL5323p9tiaPG6xm5emuOgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OV11Yd+JyO8D2jFDZUkBxNwVTwEby0NJc8k+iAM1aeg=;
        b=ocsPQL5bFsR7Rua+w1E2ghLmYTWA1QPKg3DvQzR4vyvEgFnV1KOYtpNczpcq/RUSvg
         hiUnc6Qy5776Tru6tiobB6hbXdWNE1EKT9+kfFdXCkGHPuqFgZtNGrNhbCLtWBKFgW1l
         mpV87RJRkGipH4VoHQZookrziA+gL7t0TcRj857W1o6myD5RNjx1ltMdhvbH+1UCmCKE
         961bTSasjoSQdz47DjHL4grIq6PTISV5XkQTwNpdsT41h6vD+jyLrA57AckV3Bu6ExXJ
         WsQ3EhNObC98UOjaPCZ5yUtk3aML2CVgrBose0lo71s8HVd3InB/ZS1ittzM6g1N5ySt
         RyDg==
X-Gm-Message-State: APjAAAWqS0M4jjmAUkhV921hJGkZ5EPDAZeN++tsIcE0xIT4Zs5fyE4l
        NsheOy1yAX6DcySGWtUz9qPIIA==
X-Google-Smtp-Source: APXvYqyqpxyjNLNd/YhmN1lCMiHtSOEclp+thj6XQoYzofG6COmy7VvPAB6qwXYHUAxBZP8TaVGfEw==
X-Received: by 2002:a63:6142:: with SMTP id v63mr2053252pgb.342.1554327278000;
        Wed, 03 Apr 2019 14:34:38 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id k124sm21796741pgc.65.2019.04.03.14.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Apr 2019 14:34:37 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
Date:   Wed,  3 Apr 2019 14:34:27 -0700
Message-Id: <20190403213428.89920-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403213428.89920-1-evgreen@chromium.org>
References: <20190403213428.89920-1-evgreen@chromium.org>
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

Changes in v3: None
Changes in v2:
- Made unions anonymous
- Replaced reserved union members with a comment

 include/linux/mfd/cros_ec_commands.h | 57 ++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc91082d4c35..1cdb07c0ece1 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2729,6 +2729,63 @@ struct ec_params_host_sleep_event {
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
+		/* No parameters for non-suspend messages. */
+	};
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
+		/* No response fields for non-resume messages. */
+	};
+} __packed;
+
 /*****************************************************************************/
 /* Smart battery pass-through */
 
-- 
2.20.1

