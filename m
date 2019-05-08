Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3081EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046D021019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNDiEoSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfEHSqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:46:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33836 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHSqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:46:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so2395019pfa.1;
        Wed, 08 May 2019 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JNay4jcqTIf3TxhFDX1t8TifoGH7V35urjWSNb/yQUE=;
        b=HNDiEoSpqNMpymTo7ntrs+bFYni4DmCPaZr0cwRKYK0RAZlVWl3ybQkuSMkCDRbnRz
         +8QIYTI6/6k/+K70KGJYOj7hpYZh5+R+Ra/brxTfhhWebKV06EPiGCvZSIbIbaG+5kjO
         xmiBzYyfvomrxSPhgcbsldFhq4op3SmVPSUqA0PwptC5mmQ0KLg3eCHnqkgd9TzifGMe
         aZsDbqsEdliT4ta1zAxuwHEJkzcaqza+8GuiDu3KZaFTxPpMQNHJnncJoZK6QTZQSqcv
         /iUvKNwL6Trr4ebj+PB2t5wYruT7INHbEvIOroelWNuaYKU7GT/93E3P/92e2mgnF4ik
         c/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JNay4jcqTIf3TxhFDX1t8TifoGH7V35urjWSNb/yQUE=;
        b=SOIYdusSDQjFj5RG/QeZTqWQ6ezHYcdeGUCwvoYlZF71SBMPG0uT8tJqfDvq4jGbFs
         X8rnBsdJerPG45Cx7jv1dIGct6SxSxgnfpXWjI15c3txjBWrSp2ErgxhOsVDGryMcUt8
         /fGGml+hwKsGACE1QQFQeL9WQhIb59AWGnhhpEjeS4w/5+WoVbPimFLBnHVFkeHnMk2k
         5/7nAbgSfFl4VogXcIWEY5W71Cm50nxKghVXAo/s0yZPNUurPKOEmDZFnDW1IsQXhdlN
         FvUc+XglyqGFCMnlxGZGHGIfldylp8GG8JHHRXjLuyBZO0ptOwqHztstXZbINPY5dNmW
         lGIA==
X-Gm-Message-State: APjAAAWJ14YhmJM9U+x/Gamvoq7j5o4Z3jPMBVFgtADZukencfJYSQ3M
        u4Q2Gs4CMpEi5jqRIm0S/ujtIcNP
X-Google-Smtp-Source: APXvYqy0pxNjwmj3BYBDeSldU11tN0weGxy16EqaJ+sCZ+3CzbrLFllWK4HZnvWO8SyR8FCoqXhf1Q==
X-Received: by 2002:a65:5181:: with SMTP id h1mr49673394pgq.167.1557341202267;
        Wed, 08 May 2019 11:46:42 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o66sm23257953pfb.184.2019.05.08.11.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:46:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v5 1/2] firmware: arm_scmi: Fetch and store sensor scale
Date:   Wed,  8 May 2019 11:46:34 -0700
Message-Id: <20190508184635.5054-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508184635.5054-1-f.fainelli@gmail.com>
References: <20190508184635.5054-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for dealing with scales within the SCMI HWMON driver,
fetch and store the sensor unit scale into the scmi_sensor_info
structure. In order to simplify computations for upper layer, take care
of sign extending the scale to a full 8-bit signed value.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
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

