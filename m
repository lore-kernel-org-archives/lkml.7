Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D4C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C972087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="supJbkS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEGTi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:38:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36068 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfEGTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:38:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so1188634plr.3;
        Tue, 07 May 2019 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NxAUam5Dvt1HQoAAg/vTkC6mAACjVaJFnU6FSnpD4fQ=;
        b=supJbkS+TvzwiaGvP7CzePiq38v/y5xY0z87bhAKggMMhvSyxETbpEDetJuR15OUjT
         AxuJQu8rp3sOufc6NUvueIbSBKpk/BrlBqtKNu4HP96mfG1KZFrMj/W5CgUergGGawk1
         V6M0EevyFGKuGjQOYJpzDJ81ZQBgjQQaeSrWoVb8SGCn9SSP4kdy66klqRlletmtU51N
         6/TX7lm5mXToRsytvDNCJT6lUE/xfefcI2FxJKDAH9DbRjBRsoVBF3sziA5yDB9jqTgt
         GqYx6g31qQBnNBJ0TlcxHzZ942zS1/R1nwPTlMdV8YJbbTFv7Us/rZJ59fsJLHkfUXIC
         zOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NxAUam5Dvt1HQoAAg/vTkC6mAACjVaJFnU6FSnpD4fQ=;
        b=ItO44BYrfPAHL05ydt7zc7eJ9HFRBtSrxTJosefHZTZiwB+3ne639wlhxpQeZwqcRA
         20IEMXDKXPY9nqOUcoH+gwZdeBGAWOhNV+OXwFBgqlUsC3A4L8r6l89AcSRvQKplNCpr
         ThH53McHCsZChx/zOmPzD4BZI7X8ejocKOnhRUhDMlhVRmydl9w+yl6b/l7RakZQXjqa
         OjxYNAlUjRxGKKpYjMEUiwTkW6crEyPDIf6ixAAQ4areiVtEF3lFaDXrWz2YlykOhScb
         bCyzmlwArXnI0cZEHl8Th9SLuEmzyrZFKMBuXgoH9dBWgyXleL1vXC6J86NOCaOCiRwb
         2Waw==
X-Gm-Message-State: APjAAAViGUG4zdV14X6qF51uzfwc1FXgCHWHdVLdRHDmYn1alv6YXcZ3
        ty2InsAbjxjxATKrkTsCwdPCF+k9
X-Google-Smtp-Source: APXvYqw5f3+BqYRPyHnvk/luvhl70lmxR6wsQrxcgUbarh8heRLEfenNRO+d7eY9YJWmBJT9OunRBg==
X-Received: by 2002:a17:902:364:: with SMTP id 91mr41315233pld.72.1557257897280;
        Tue, 07 May 2019 12:38:17 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id l21sm5964658pff.40.2019.05.07.12.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:38:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 2/3] firmware: arm_scmi: Fetch and store sensor scale
Date:   Tue,  7 May 2019 12:35:03 -0700
Message-Id: <20190507193504.28248-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507193504.28248-1-f.fainelli@gmail.com>
References: <20190507193504.28248-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for dealing with scales within the SCMI HWMON driver,
fetch and store the sensor unit scale into the scmi_sensor_info
structure. In order to simplify computations for upper layer, take care
of sign extending the scale to a full 8-bit signed value.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/firmware/arm_scmi/sensors.c | 6 ++++++
 include/linux/scmi_protocol.h       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index b53d5cc9c9f6..21353470a740 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -34,6 +34,8 @@ struct scmi_msg_resp_sensor_description {
 		__le32 attributes_high;
 #define SENSOR_TYPE(x)		((x) & 0xff)
 #define SENSOR_SCALE(x)		(((x) >> 11) & 0x3f)
+#define SENSOR_SCALE_SIGN	BIT(5)
+#define SENSOR_SCALE_EXTEND	GENMASK(7, 6)
 #define SENSOR_UPDATE_SCALE(x)	(((x) >> 22) & 0x1f)
 #define SENSOR_UPDATE_BASE(x)	(((x) >> 27) & 0x1f)
 		    u8 name[SCMI_MAX_STR_SIZE];
@@ -140,6 +142,10 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 			s = &si->sensors[desc_index + cnt];
 			s->id = le32_to_cpu(buf->desc[cnt].id);
 			s->type = SENSOR_TYPE(attrh);
+			s->scale = SENSOR_SCALE(attrh);
+			/* Sign extend to a full s8 */
+			if (s->scale & SENSOR_SCALE_SIGN)
+				s->scale |= SENSOR_SCALE_EXTEND;
 			strlcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
 		}
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 3105055c00a7..9ff2e9357e9a 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -144,6 +144,7 @@ struct scmi_power_ops {
 struct scmi_sensor_info {
 	u32 id;
 	u8 type;
+	s8 scale;
 	char name[SCMI_MAX_STR_SIZE];
 };
 
-- 
2.17.1

