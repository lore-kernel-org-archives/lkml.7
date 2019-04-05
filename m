Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADDEC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23F020700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XH20c09P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfDEWj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:39:59 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35143 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:39:59 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so12225548itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hldxkxWM3hSqdi6yUY+bXZzasV3q/AnL0PcDXeuAe2Y=;
        b=XH20c09P60dJZkY66k9m3ybp4fpAUszioaLrHzef3zwNGL0ZMnqvo9WdSXzeP2o/gg
         O04GOv4m8Zc3Ev1y7pSNoVXLk/EPILD84Ot63hEbhs1rrn4CxE+JHWWndFX0N5tiwPvk
         87qywvqFHM+ZD9V5mnLmPuApZHbo3wkh71rcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hldxkxWM3hSqdi6yUY+bXZzasV3q/AnL0PcDXeuAe2Y=;
        b=sN1buIwERsjR9OUP4c/mRdmxyaGEAm5yaS+krrqxHGCna9tEAQPcoWZDiskzQWtQ4O
         YoKqhs2rSxkhT4ye7CtC1Z8kiiy8uPVfVOCIS2EhI9aewJsUJpEKgY4tIHCV6KDDVne6
         HYBUkkR+5FQwFIRJ9Y8wt7gyrcROAdUofFYOyHtf1wmfO/CVh/e2rCnfTJp/Jj53uB41
         Q8vVXO0KLSpaV0vtld32HL9VUupsGMvnPYG6jbpRNfM0AtcWvmE0drw14noNjnz5nHbs
         XcSY+qCto6hQihJc9Ehh5g49qkbIez1moktafcdcJWuXHIz6GheAmElQUhTuxLMJNp5b
         zHVw==
X-Gm-Message-State: APjAAAUR5SGIGRahqXMjui5ro485uzIy4kK3u4Byt0DxBhMl2i8sm42g
        1NIHP0i1mwfQxFv7gWaXCJaFZw==
X-Google-Smtp-Source: APXvYqzwspJVT+mUIUoNQ3XyoBhSvzAqD/LNs7En3926HdGzEQwpMPx9Jss2QVjPKdJNGucB0RHpsQ==
X-Received: by 2002:a24:6583:: with SMTP id u125mr7998517itb.151.1554503998450;
        Fri, 05 Apr 2019 15:39:58 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id f132sm9588011ioa.76.2019.04.05.15.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 15:39:57 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        groeck@google.com, dtor@google.com, sjg@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH 1/2] power_supply: Add more charge types and CHARGE_CONTROL_* properties
Date:   Fri,  5 Apr 2019 16:35:53 -0600
Message-Id: <20190405223554.228813-1-ncrews@chromium.org>
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

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/power/supply/power_supply_sysfs.c |  4 +++-
 include/linux/power_supply.h              | 10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

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

