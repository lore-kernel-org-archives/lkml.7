Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35FECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A9A2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VHkK0EHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfJAQEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:04:16 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:64710 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfJAQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569945855; x=1601481855;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=V31EWNMvdqyWe/Qg+FgJTs3uamoYxLmoNCf8l4/4axk=;
  b=VHkK0EHmY7Iti2xqC8lDjuvy2I+kugptvS428xpSiiohNwCYOSHdrb30
   wdRrdG6C3XbyqxxEnQMcPwXCSmZGiZTS/6OXtUtRiIMhW9/foYiyePg2t
   ShbhOer6mJqseoyB7swaYks3j3UQkSBEMrxwFQrcjJj/6JVMBgE/7MHpS
   8=;
X-IronPort-AV: E=Sophos;i="5.64,571,1559520000"; 
   d="scan'208";a="419069137"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 01 Oct 2019 16:04:13 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 8BB09A1E7E;
        Tue,  1 Oct 2019 16:04:13 +0000 (UTC)
Received: from EX13D02UWC002.ant.amazon.com (10.43.162.6) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 1 Oct 2019 16:04:13 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D02UWC002.ant.amazon.com (10.43.162.6) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 1 Oct 2019 16:04:12 +0000
Received: from 8c859006a84e.ant.amazon.com (172.26.203.30) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 1 Oct 2019 16:04:12 +0000
From:   Patrick Williams <alpawi@amazon.com>
CC:     Patrick Williams <alpawi@amazon.com>,
        Patrick Williams <patrick@stwcx.xyz>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (pmbus) add VR12/VR13 mode support write paths
Date:   Tue, 1 Oct 2019 11:03:41 -0500
Message-ID: <20191001160407.6265-1-alpawi@amazon.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmbus_core supported VR11/VR12/VR13 modes when reading
VID-formatted registers, but the write path only supported
VR11 translations.  Add support for VR12 and VR13 to
'data2reg_vid' for translating these formats.  This is the
inverse of 'reg2data_vid'.

Signed-off-by: Patrick Williams <alpawi@amazon.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 8470097907bc..f0d696552142 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -845,9 +845,19 @@ static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 static u16 pmbus_data2reg_vid(struct pmbus_data *data,
 			      struct pmbus_sensor *sensor, long val)
 {
-	val = clamp_val(val, 500, 1600);
+	switch (data->info->vrm_version) {
+	case vr11:
+		val = clamp_val(val, 500, 1600);
+		return 2 + DIV_ROUND_CLOSEST((1600 - val) * 100, 625);
+	case vr12:
+		val = clamp_val(val, 0, 1520);
+		return ((val - 250) / 5) + 1;
+	case vr13:
+		val = clamp_val(val, 0, 2500);
+		return ((val - 500) / 10) + 1;
+	}
 
-	return 2 + DIV_ROUND_CLOSEST((1600 - val) * 100, 625);
+	return 0;
 }
 
 static u16 pmbus_data2reg(struct pmbus_data *data,
-- 
2.17.2 (Apple Git-113)

