Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37901C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AD521855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948722;
	bh=lLf2g9KCQK5PoHP2qYZDVggikNw887AYHXv+3PO2oMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=urx95Fpem6Voi7FlTbqInWOt16Gh1nylo9vcNIcsCP0+djaxXhuJY6FVQHM/gAkhE
	 WrcCrOXjz8uUs7LGQKJ5phTxMgQjLE2EDYVh0KWIpnL4dPLbfW8I2T5tz0DkAXH+OR
	 HCrikLPvGvdnRUMDkNd8LFoW0un74JrNYmxVRK04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfJAQn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733011AbfJAQns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:43:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9D121A4A;
        Tue,  1 Oct 2019 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948227;
        bh=lLf2g9KCQK5PoHP2qYZDVggikNw887AYHXv+3PO2oMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6CN8BUq7BafHLop4DpVE05CTlNG/0scDLLiTmcM4tUQPtRTXT/SuXTdRmdLR+qWa
         lyMhTGyHSyWTNbMOUFCr0wmzIss8dAc0SbFNg0wqdYn9jYOrrPGYGXw39TRl3IPz90
         FtbC7MRtIRFpBduvwo9Tmxk+CdMGiWHzxfM/oMJc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 25/43] thermal_hwmon: Sanitize thermal_zone type
Date:   Tue,  1 Oct 2019 12:42:53 -0400
Message-Id: <20191001164311.15993-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Mavrodiev <stefan@olimex.com>

[ Upstream commit 8c7aa184281c01fc26f319059efb94725012921d ]

When calling thermal_add_hwmon_sysfs(), the device type is sanitized by
replacing '-' with '_'. However tz->type remains unsanitized. Thus
calling thermal_hwmon_lookup_by_type() returns no device. And if there is
no device, thermal_remove_hwmon_sysfs() fails with "hwmon device lookup
failed!".

The result is unregisted hwmon devices in the sysfs.

Fixes: 409ef0bacacf ("thermal_hwmon: Sanitize attribute name passed to hwmon")

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_hwmon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 40c69a533b240..dd5d8ee379287 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -87,13 +87,17 @@ static struct thermal_hwmon_device *
 thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
+	char type[THERMAL_NAME_LENGTH];
 
 	mutex_lock(&thermal_hwmon_list_lock);
-	list_for_each_entry(hwmon, &thermal_hwmon_list, node)
-		if (!strcmp(hwmon->type, tz->type)) {
+	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
+		strcpy(type, tz->type);
+		strreplace(type, '-', '_');
+		if (!strcmp(hwmon->type, type)) {
 			mutex_unlock(&thermal_hwmon_list_lock);
 			return hwmon;
 		}
+	}
 	mutex_unlock(&thermal_hwmon_list_lock);
 
 	return NULL;
-- 
2.20.1

