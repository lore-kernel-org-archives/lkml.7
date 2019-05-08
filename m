Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E166C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4521530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CONn6uI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfEHRAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:00:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36718 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfEHRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:00:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so1159356pgb.3;
        Wed, 08 May 2019 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NxAUam5Dvt1HQoAAg/vTkC6mAACjVaJFnU6FSnpD4fQ=;
        b=CONn6uI3sZhY9txU/ul8dooJT4LHPM/v1iQbwxmzcfCSCqJxEvLpyFT+r0IJCqbZnR
         UMYqkdkJwC6Z0/v4EGaE4+OgaXaPXC0pCCp6gix4k9ei/QlppPaDr9lHho/mTnmGATqb
         /ojOjeotcLZO8xCQ7y7iD+eaPPIT578OR5uTMHwpu3ju2lTGQQohkrAeqcr999S0lkA8
         M3L7TAvYbu/K+D6y3ZeVtDydVQ6ZzPPMNBy+h+gptyVzYHwBikC1EEe5bxWk77znoyhE
         3s5+mLaK8GcdKKjjbSn06rCbopBCeGy6l/6JzhTgWI6bIORwtTSDK7REWPgrq+8n+HxN
         /hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NxAUam5Dvt1HQoAAg/vTkC6mAACjVaJFnU6FSnpD4fQ=;
        b=f0iFVUQtHYX3O15d2KVURMD3VSU7m8SKql9YJwEE93lo4eRcBIB2l0kNbV7BDhlavQ
         u3tTj1RrQYXasOFNTLfJdxNShXk0l6bktlru5wB7py9HnsvigZdgmhmCEhuolS95okSP
         hl2gBzLhqsnp+CzJCYvSLfb17Am3QRmz8EmYIP8uPSMqlod8D44r0cdfKv+Cg3sfKHLi
         XhRxVoubjD8mL/U4q30zQVvnFTXnyVnQ+TMk1rQzTMSyqZKs9tWja+JqX48J3ASECqga
         gxCZpWFXM6PB2T7xJgBC7fBgb12j9cGB4QBS/WUGWtyNhFkfS2izur+tadQNPczK0JC8
         sVlw==
X-Gm-Message-State: APjAAAVLcbEfNp/X4fLdUi7TjWuCNMmU8l0I8oUq5D0nii8iDAlNVA/j
        lbL7FkoIpUOu+dRQGl8apSjnYSua
X-Google-Smtp-Source: APXvYqyidr30JBrMQn+0cCHfa68oqy10M/mQ+z/LUY0WKG2Rlh2YkbzPXibdIggDIJ8j9EoYNIzOZg==
X-Received: by 2002:aa7:82d6:: with SMTP id f22mr49384376pfn.190.1557334840649;
        Wed, 08 May 2019 10:00:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a80sm11347773pfj.105.2019.05.08.10.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:00:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v4 1/2] firmware: arm_scmi: Fetch and store sensor scale
Date:   Wed,  8 May 2019 10:00:34 -0700
Message-Id: <20190508170035.19671-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508170035.19671-1-f.fainelli@gmail.com>
References: <20190508170035.19671-1-f.fainelli@gmail.com>
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

