Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B147BECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9552D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfJNRQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:16:47 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:2260 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731347AbfJNRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:16:47 -0400
X-Greylist: delayed 11570 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Oct 2019 13:16:46 EDT
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EE1WFt031570;
        Mon, 14 Oct 2019 09:03:11 -0500
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2vkcbvdp52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 09:03:11 -0500
Received: from us-aus-exch2.ni.corp.natinst.com (us-aus-exch2.ni.corp.natinst.com [130.164.68.12])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x9EE3AXu024287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 09:03:10 -0500
Received: from us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) by
 us-aus-exch2.ni.corp.natinst.com (130.164.68.12) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 14 Oct 2019 09:03:10 -0500
Received: from senary.amer.corp.natinst.com (130.164.49.7) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 14 Oct 2019 09:03:10 -0500
From:   Kyle Roeschley <kyle.roeschley@ni.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (tmp421) Allow reading at 2Hz instead of 0.5Hz
Date:   Mon, 14 Oct 2019 09:03:10 -0500
Message-ID: <20191014140310.7438-1-kyle.roeschley@ni.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_08:2019-10-11,2019-10-14 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our driver configures the device to read at 2Hz, but then only allows the
user to read cached temp values at up to 0.5Hz. Let's allow users to read
as quickly as we do.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
 drivers/hwmon/tmp421.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index a94e35cff3e5..83a4fab151d2 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -127,7 +127,8 @@ static struct tmp421_data *tmp421_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + (HZ / 2)) ||
+	    !data->valid) {
 		data->config = i2c_smbus_read_byte_data(client,
 			TMP421_CONFIG_REG_1);
 
-- 
2.23.0.rc1

