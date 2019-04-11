Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42939C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188D3206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDKOdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:33:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfDKOdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:33:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B656AF50;
        Thu, 11 Apr 2019 14:33:34 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] rtc: ds1685: fix crash caused by referencing wrong device struct
Date:   Thu, 11 Apr 2019 16:33:21 +0200
Message-Id: <20190411143323.20945-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs entries added by rtc_add_group are called with the rtc device
as argument and not the underlying device. Fixed by using the dev->parent

Fixes: cfb74916e2ec ("rtc: ds1685: use rtc_add_group")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/rtc/rtc-ds1685.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 2710f2594c42..2f5194df239e 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1004,7 +1004,7 @@ static ssize_t
 ds1685_rtc_sysfs_battery_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct ds1685_priv *rtc = dev_get_drvdata(dev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev->parent);
 	u8 ctrld;
 
 	ctrld = rtc->read(rtc, RTC_CTRL_D);
@@ -1024,7 +1024,7 @@ static ssize_t
 ds1685_rtc_sysfs_auxbatt_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct ds1685_priv *rtc = dev_get_drvdata(dev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev->parent);
 	u8 ctrl4a;
 
 	ds1685_rtc_switch_to_bank1(rtc);
@@ -1046,7 +1046,7 @@ static ssize_t
 ds1685_rtc_sysfs_serial_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	struct ds1685_priv *rtc = dev_get_drvdata(dev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev->parent);
 	u8 ssn[8];
 
 	ds1685_rtc_switch_to_bank1(rtc);
-- 
2.13.7

