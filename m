Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51430C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AC3217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J5xiunHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfDQAna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:43:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52942 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfDQAn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:43:29 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so1836090itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9bgm6CyxqWtNme83DcEVb/eMJLZNOOrCyjeVNpJS6Y=;
        b=J5xiunHkjq7ardLq98NdC9dZlEno7qldkfE+/ONU+E/ZjlGxfu/ESUEm3AEv5RBffS
         YPV9rX2YX5EzZ02ixhtwimdVQrP7VCjEvOxS7Fkqe5hN4e/0QHJeGsEDOpKadiXg0jeY
         oAWIaISYkBosjM0fulGYGKQpEiqglMsCWwpgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9bgm6CyxqWtNme83DcEVb/eMJLZNOOrCyjeVNpJS6Y=;
        b=s+M0gs5tswY+yacmTEsuvppXe+LekhZfmQwEf8Q1xxMxH20e+5nVXiI4z9utPXfwOD
         v8fHlGMJ0Fd9H77Rpau8VRgWuzB96HmTVFn4lGlsJX4I4aVg24ob42KW/zWA4ctvJSnL
         bpufzEho7/CKIA5djD3TL39ks8O3/aDzRWr+Xlfq1ctq7FBcYZozI29CXXw2yTQhlmso
         Q9yzlFDZyKH/FJtNmBroHJ8KjmOlyrLdJjXV5wZNSLx7f5Qf5cxOrx0qHMbxBI8t7Yen
         5nviUJvRD5c3msfepzp7o3wpRG2vqdW8Vu4UXu6hKUhzDi6VtcUIR6aMKhdHtSKauDt4
         Y36Q==
X-Gm-Message-State: APjAAAVC4vnpS/lb/nXPWdyrJPpTVvBKJDqwbU2vRJMl9Z2YgH6Rz3z+
        6JkQzjPF3e0Z24Y2ph4Qap6CHQ==
X-Google-Smtp-Source: APXvYqwISjFmQienWSx+/1EdOK5XbSrmNz7JAUT8/8yr8yr8972wj0qteAKymJJRp0sFkswMSnK8Eg==
X-Received: by 2002:a05:660c:288:: with SMTP id s8mr33066887itl.36.1555461808595;
        Tue, 16 Apr 2019 17:43:28 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id b1sm575111itd.12.2019.04.16.17.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 17:43:27 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v4 1/2] power_supply: Add more charge types and CHARGE_CONTROL_* properties
Date:   Tue, 16 Apr 2019 18:43:19 -0600
Message-Id: <20190417004320.232200-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "Standard", "Adaptive", and "Custom" modes to the charge_type
property, to expand the existing "Trickle" and "Fast" modes.
In addition, add POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
and POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties, to expand
the existing CHARGE_CONTROL_* properties. I am adding them in order
to support a new Chrome OS device, but these properties should be
general enough that they can be used on other devices.

The meaning of "Standard" is obvious, but "Adaptive" and "Custom" are
more tricky: "Adaptive" means that the charge controller uses some
custom algorithm to change the charge type automatically, with no
configuration needed. "Custom" means that the charge controller uses the
POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for some
other algorithm. For example, in the use case that I am supporting,
this means the battery begins charging when the percentage
level drops below POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
charging ceases when the percentage level goes above
POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD.

v4 changes:
- Add documentation for the new properties, and add documentation for
  the the previously missing charge_control_limit and
  charge_control_limit_max properties.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-power | 51 +++++++++++++++++++--
 drivers/power/supply/power_supply_sysfs.c   |  4 +-
 include/linux/power_supply.h                | 10 +++-
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5e23e22dce1b..b77e30b9014e 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -114,15 +114,60 @@ Description:
 		Access: Read
 		Valid values: Represented in microamps
 
+What:		/sys/class/power_supply/<supply_name>/charge_control_limit
+Date:		Oct 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum allowable charging current. Used for charge rate
+		throttling for thermal cooling or improving battery health.
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_control_limit_max
+Date:		Oct 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum legal value for the charge_control_limit property.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_control_start_threshold
+Date:		April 2019
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents a battery percentage level, below which charging will
+		begin.
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/charge_control_end_threshold
+Date:		April 2019
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents a battery percentage level, above which charging will
+		stop.
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
 What:		/sys/class/power_supply/<supply_name>/charge_type
 Date:		July 2009
 Contact:	linux-pm@vger.kernel.org
 Description:
 		Represents the type of charging currently being applied to the
-		battery.
+		battery. "Trickle", "Fast", and "Standard" all mean different
+		charging speeds. "Adaptive" means that the charger uses some
+		algorithm to adjust the charge rate dynamically, without
+		any user configuration required. "Custom" means that the charger
+		uses the charge_control_* properties as configuration for some
+		different algorithm.
 
-		Access: Read
-		Valid values: "Unknown", "N/A", "Trickle", "Fast"
+		Access: Read, Write
+		Valid values: "Unknown", "N/A", "Trickle", "Fast", "Standard",
+			      "Adaptive", "Custom"
 
 What:		/sys/class/power_supply/<supply_name>/charge_term_current
 Date:		July 2014
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..6104a3f03d46 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -56,7 +56,7 @@ static const char * const power_supply_status_text[] = {
 };
 
 static const char * const power_supply_charge_type_text[] = {
-	"Unknown", "N/A", "Trickle", "Fast"
+	"Unknown", "N/A", "Trickle", "Fast", "Standard", "Adaptive", "Custom"
 };
 
 static const char * const power_supply_health_text[] = {
@@ -274,6 +274,8 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(constant_charge_voltage_max),
 	POWER_SUPPLY_ATTR(charge_control_limit),
 	POWER_SUPPLY_ATTR(charge_control_limit_max),
+	POWER_SUPPLY_ATTR(charge_control_start_threshold),
+	POWER_SUPPLY_ATTR(charge_control_end_threshold),
 	POWER_SUPPLY_ATTR(input_current_limit),
 	POWER_SUPPLY_ATTR(energy_full_design),
 	POWER_SUPPLY_ATTR(energy_empty_design),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 2f9c201a54d1..d59205170232 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -40,11 +40,15 @@ enum {
 	POWER_SUPPLY_STATUS_FULL,
 };
 
+/* What algorithm is the charger using? */
 enum {
 	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
 	POWER_SUPPLY_CHARGE_TYPE_NONE,
-	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
-	POWER_SUPPLY_CHARGE_TYPE_FAST,
+	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
+	POWER_SUPPLY_CHARGE_TYPE_FAST,		/* fast speed */
+	POWER_SUPPLY_CHARGE_TYPE_STANDARD,	/* normal speed */
+	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
+	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
 };
 
 enum {
@@ -121,6 +125,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
-- 
2.20.1

