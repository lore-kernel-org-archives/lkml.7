Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E30C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FF820989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W79MYHOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEGXKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:10:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40845 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfEGXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:10:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so8902795plr.7;
        Tue, 07 May 2019 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NxAUam5Dvt1HQoAAg/vTkC6mAACjVaJFnU6FSnpD4fQ=;
        b=W79MYHObhxKSz1yrBebZxY6fIgGFQNZrGIKFl/P07u3fvm0L1svG6Kge0eSRxVMp++
         HozWeRJd9krBTS+xX5kgatnXuUjD9tj/TvnMEHLL2cO8kQbZUF/lNWw586NJu17NAMcv
         ailq0uRykUWp8uFLRxoqACxHQA2bO+U4QJFEiX7wlWIww54EXW5ykKohjZClEbzdG4V5
         pQbIuKE1pEUnCXX9kQb6IU1GoFh54YlYmLWJfJR7yjlnLPnZ1cUP5EzLwc4P1HW5elL9
         I2H+DGBEluRSfw6DRuLlopJp/7NEJQPNe2mdK/zjG7tkkusjqNjlfErgu5gtocC1UsO2
         s10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NxAUam5Dvt1HQoAAg/vTkC6mAACjVaJFnU6FSnpD4fQ=;
        b=My2efH/zBEQwXiTIXRGMc0hQque7qeCKMyHU7MWUoc7J0M2qY8cPdSiv6VtnAP/LlU
         rPY/dGt1i6SCZFpDtE9VCh85c83PKRKrG7R+CDdOiIJEOBD0nzZ88My2FbnHupo4hnjc
         3ZfpXtgHx2UO/2R9NYLfjvZnvXwNA8vyNNuuw/xqaxxgZJlVZgSSC+9x9ag1Vcnav/oc
         MjW6HCse4ChZ/kN6cU9hPEZ5nA12sGx6G8RYei0xop4TkPhyEFLmnyocThlTX11gQcJ2
         SHvNFarlqg5SUtO9igFbAQ43ljDvV0rndjbNJD9jGOBmeUpyif0GR2VoqZW3brZjDLMl
         EleQ==
X-Gm-Message-State: APjAAAXajYvbUiVix9bs+E+XM079iro5GvshvoBiI1gtLZ5JVkl4vCAu
        bDYDWK7eOfSQuC0Jv46NOBkZz/+c
X-Google-Smtp-Source: APXvYqwxsPy0o2lNDye/b4YPbzc/hYdJL1LqlWL1647cpG9aT7GB0XIvVQFfixDP9ZMIBfigSy0I8g==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr28196267pln.10.1557270614534;
        Tue, 07 May 2019 16:10:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id w12sm7154742pfj.41.2019.05.07.16.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 16:10:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v3 1/2] firmware: arm_scmi: Fetch and store sensor scale
Date:   Tue,  7 May 2019 16:09:16 -0700
Message-Id: <20190507230917.21659-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507230917.21659-1-f.fainelli@gmail.com>
References: <20190507230917.21659-1-f.fainelli@gmail.com>
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

