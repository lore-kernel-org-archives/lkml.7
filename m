Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643AB2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYc6GAsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEFWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:41:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40967 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:41:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id l132so2563065pfc.8;
        Mon, 06 May 2019 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E5Dd3KTWD6CXDeQyGrryfHzlZnUN0IagEOvDF7fStsU=;
        b=rYc6GAsGNJY4zX3g6QYdRYAV9Fy8LhGm0OovP34jxb0OEZatnM4m710MQ288nFlXVW
         aODV9dCPzwT0a6u3eGQ679IS1JgFmz5hZQG7fn1u/o+EvFaZH07DyvjjCBwRQTKD76rb
         vJU/QbyWLP5bLL3/wZdt9OW4KteT3PGiEEoET/ZdMldivpnw+JqjfMLwfiezBJZxEavr
         q/ue5nnvia4Fa3r31P+NTnjI6BZAzLMmyQyr340miA06bynazZVEiQ0Q2g4cCiB5hk8M
         RE76YS1/6QxHnbckQtuhHth/NBcAmt2/tmKDXduPxYCIq+brr3MmECyhDTj7P2eC1VM4
         Is3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E5Dd3KTWD6CXDeQyGrryfHzlZnUN0IagEOvDF7fStsU=;
        b=VbaL3QzrBk4trNGOIgmlmGbcjwuzONjl9rJpnojNxGFKVzsiedIF/uYDAwjW4paHwR
         SHCW/u4GcXwFMaLVuLWfxmGvIfqLn+kDLo70s9RWtNI9Ql0/1EEUevPaBl2JJAUn9LAM
         bFGDZonE2PdLfoTaXWAQpDRxnrvJBdocnm5BL/hBn6YoPoMCrxYmnzw8QAgyUDB7f8u6
         NpqYj4RLwvjairVHFwya8P0FAcXpST/KqWteTxI0EIGlT8XiHyY00ZIxaPATAox9/lvw
         i8sKkGlHHZtsNHwkyFwskZugDfAU6bfMyoRed2XAPU9IkjEhFwrV+5hUZvW+1An2ssBM
         jagg==
X-Gm-Message-State: APjAAAV3aJU4bzajjgYxxa2qZXX9SvwSl0xfkkvWfHrbDhkBRqpry6BR
        PvnSZh2Z7jJ7NJ5lE7KUinU0LrL6
X-Google-Smtp-Source: APXvYqzlpp4RXTrN/URhBa3Ul4oDUGmN3bljpPYVgvpBc9mbG/MQkXpb0BqL9en9ld7lE1hc2AnSSA==
X-Received: by 2002:aa7:91c8:: with SMTP id z8mr37663612pfa.110.1557182477143;
        Mon, 06 May 2019 15:41:17 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id s11sm19784153pga.36.2019.05.06.15.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:41:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH 1/2] firmware: arm_scmi: Fetch and store sensor scale
Date:   Mon,  6 May 2019 15:41:08 -0700
Message-Id: <20190506224109.9357-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506224109.9357-1-f.fainelli@gmail.com>
References: <20190506224109.9357-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for dealing with scales within the SCMI HWMON driver,
fetch and store the sensor unit scale into the scmi_sensor_info
structure.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/firmware/arm_scmi/sensors.c | 7 ++++++-
 include/linux/scmi_protocol.h       | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index b53d5cc9c9f6..f324f0a13ebe 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -33,7 +33,8 @@ struct scmi_msg_resp_sensor_description {
 #define NUM_TRIP_POINTS(x)	(((x) >> 4) & 0xff)
 		__le32 attributes_high;
 #define SENSOR_TYPE(x)		((x) & 0xff)
-#define SENSOR_SCALE(x)		(((x) >> 11) & 0x3f)
+#define SENSOR_SCALE_MASK	0x3f
+#define SENSOR_SCALE(x)		(((x) >> 11) & SENSOR_SCALE_MASK)
 #define SENSOR_UPDATE_SCALE(x)	(((x) >> 22) & 0x1f)
 #define SENSOR_UPDATE_BASE(x)	(((x) >> 27) & 0x1f)
 		    u8 name[SCMI_MAX_STR_SIZE];
@@ -140,6 +141,10 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 			s = &si->sensors[desc_index + cnt];
 			s->id = le32_to_cpu(buf->desc[cnt].id);
 			s->type = SENSOR_TYPE(attrh);
+			s->scale = SENSOR_SCALE(attrh);
+			/* Sign extend to a full u8 */
+			if (s->scale & ((SENSOR_SCALE_MASK + 1) >> 1))
+				s->scale |= GENMASK(7, 6);
 			strlcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
 		}
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 3105055c00a7..7746f171f108 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -144,6 +144,7 @@ struct scmi_power_ops {
 struct scmi_sensor_info {
 	u32 id;
 	u8 type;
+	u8 scale;
 	char name[SCMI_MAX_STR_SIZE];
 };
 
-- 
2.17.1

