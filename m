Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1316CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE08221479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bXYc5ce1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389702AbfDRQnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:43:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52062 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389617AbfDRQn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:43:29 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so4324080itk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NrObpvgxh9HoWkErNdO7e4+P6ONVeeec8iZlE35gnE=;
        b=bXYc5ce1JdQlnbmLJizbhyuRvafMStc9e2qKHmtsegl2f182yaF95yexB4w3tZ3bFa
         7+nC826NPwd8CIK4nOrV+mbdDFTdnKLgCZsy9HnTkDMXLiXgJ5ePRLKp8KwIWDn7vc2R
         tMN2PCS65tpKfxARSwecKMBZT12MJ8J4yzkOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NrObpvgxh9HoWkErNdO7e4+P6ONVeeec8iZlE35gnE=;
        b=LUntYs2pPMuAFSApuVDj4in3qpIQBMZMoPjhUyBvfzLDDvRdRA/mwxJibaclMP2xbz
         j31rwxyvUI0QtXcV0Bb5EjM2X3n6a4RLA66I3DATlnwJER27vOqK8YPH6+J8EiOXBy4a
         xy4KJ6DvtZBdZxsAnS7VPnyk7tBVdn0oNINAaoYWgGVxXi0ZhMqNfRa5hVmb3ax7OEkZ
         +02VYeJmdDiaOT+tTLphnogIRvWPlD7qYB9retKOx599S99FNgVnGxiTlBMMVLWRylRn
         Km0Iz1Oi4++Ez6G5LMJZnMxDBohlHC+IyCWCXOf/vsTvK++G4P523fNbuKp9/kpfhYg1
         HjIQ==
X-Gm-Message-State: APjAAAUp3KN4QnD/pFGtjA4gFsng7d017iObGfaPDGVNfQ/uLlluaEpq
        QyLS8ExylV+UlyJZVeODRs7I+Q==
X-Google-Smtp-Source: APXvYqyaWO6E+v7fioCLOySjvITFH3v/BvNAKy1ud4984Zoun4oVEUELCTCe9ztSA3giFO0q7oINPg==
X-Received: by 2002:a24:2509:: with SMTP id g9mr4040001itg.149.1555605808615;
        Thu, 18 Apr 2019 09:43:28 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id g70sm1180905itg.40.2019.04.18.09.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 09:43:28 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v5 2/3] power_supply: Add CHARGE_CONTROL_{START_THRESHOLD,END_THRESHOLD} properties
Date:   Thu, 18 Apr 2019 10:43:13 -0600
Message-Id: <20190418164314.161065-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418164314.161065-1-ncrews@chromium.org>
References: <20190417214022.7jk3usygcpnls3pr@earth.universe>
 <20190418164314.161065-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
and POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties, to expand
the existing CHARGE_CONTROL_* properties. I am adding them in order
to support a new Chrome OS device, but these properties should be
general enough that they can be used on other devices.

When the charge_type is "Custom", the charge controller uses the
POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for some
other algorithm. For example, in the use case that I am supporting,
this means the battery begins charging when the percentage
level drops below POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
charging ceases when the percentage level goes above
POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD.

v5 changes:
- Add the other missing CHARGE_CONTROL_* properties documentation in
  a separate commit
- Split up adding the charge types and adding the
  POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
  POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties into
  two different commits.
v4 changes:
- Add documentation for the new properties, and add documentation for
  the the previously missing charge_control_limit and
  charge_control_limit_max properties.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  2 ++
 include/linux/power_supply.h                |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 544c4e0ef8b6..a5b144f61de8 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -114,6 +114,26 @@ Description:
 		Access: Read
 		Valid values: Represented in microamps
 
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
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 64dff5cfecc3..6104a3f03d46 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
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
index e86e05d8134d..d59205170232 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -125,6 +125,8 @@ enum power_supply_property {
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

