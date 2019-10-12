Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6FAC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475D02067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDORRgs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfJLGxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33298 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfJLGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so14118812wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qqj/nrtgrj7T526mRixYvVR9P1e7BOzGZBrRGmLHoMg=;
        b=VDORRgs7HVWsN7gF9w1rwI9oadtUhPDEXK5jDTa6w26m94qeaobDZVn3JcRsxxXacV
         goVv2ihF8bSRKgTOIg4XudDbWMyyFFngulBpWD7SO0ldxIV/9ACtiuBWJqYRZX4cjg82
         u3ad4jjLCVohlMz4KnAEATIZWI0spGkZcuWV6ZDLWThEkmgV/DOxP4okzE1ZfO+xvXyu
         q4VFSfR2WkodxKFoQjeUmVUpW2SoXCVqMWzXCzo64JNKjIPgwBGXReXkNCfpTyTy1GI9
         d4m31zDs/G36G6uWGG+biaFkM0VuiVdHlT1ehNfaJ0oJPKa2W7OT8BCHkYt4oIR/M/ZO
         HXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qqj/nrtgrj7T526mRixYvVR9P1e7BOzGZBrRGmLHoMg=;
        b=pqns2Qa+iIKXA8qigCkainX+xXjYp3yLWOFvFNPvgXL+nyvTw7oOEe6ZY7pAABJuRE
         sEdxRrc8kVqpxPjbQNvG63/J/4QYm1Viu5CNb4S3Z32iAPAqQ08bdoPicuxijBRGFx5V
         N/zCn3pcyoAHF5sWm18i9YkMrTfnCc30zW/0qNxCcyeJNSP1pZ4nMC+vOMdb1YhfgPjB
         cDDf2GlHsfAQGyWzncDs67LLyUasS0uKjR65kA/g70wmpxQ1fNe77lVX3mo9xp5cBiMi
         ZMJ+XywryS2dS8CiolJFsFgAt0YE1/C4Yhh4LSwE/FUxXl+i/zIBteUi5Iy52VEZicUp
         5WwQ==
X-Gm-Message-State: APjAAAXdf9+xGXhTf382Nxi2EtueyxaEc8K0k2itkey9l4giF20hdvNH
        YjtSyDQnShrJEDkebbfofocTfw==
X-Google-Smtp-Source: APXvYqzahIdVjnlDiEQq5qLbIAzOkm6ved1lrxBkittuTnLSlR3NgNF+pe39yXJR6ZGQZcRUTBZE5Q==
X-Received: by 2002:adf:f192:: with SMTP id h18mr15691694wro.252.1570863183415;
        Fri, 11 Oct 2019 23:53:03 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 02/11] thermal: Move struct thermal_attr to the private header
Date:   Sat, 12 Oct 2019 08:52:46 +0200
Message-Id: <20191012065255.23249-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure belongs to the thermal core internals but it is exported
in the include/linux/thermal.h

For better self-encapsulation and less impact for the compilation if a
change is made on it. Move the structure in the thermal core internal
header file.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 5 +++++
 include/linux/thermal.h        | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index f1206d67047f..0e964240524d 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -41,6 +41,11 @@ extern struct thermal_governor *__governor_thermal_table_end[];
 	     __governor < __governor_thermal_table_end;	\
 	     __governor++)
 
+struct thermal_attr {
+	struct device_attribute attr;
+	char name[THERMAL_NAME_LENGTH];
+};
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a389d4621814..603766a4068c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -46,6 +46,7 @@
 struct thermal_zone_device;
 struct thermal_cooling_device;
 struct thermal_instance;
+struct thermal_attr;
 
 enum thermal_device_mode {
 	THERMAL_DEVICE_DISABLED = 0,
@@ -130,11 +131,6 @@ struct thermal_cooling_device {
 	struct list_head node;
 };
 
-struct thermal_attr {
-	struct device_attribute attr;
-	char name[THERMAL_NAME_LENGTH];
-};
-
 /**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
-- 
2.17.1

