Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F82ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A278E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WjIQD1PC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfJOIj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:39:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfJOIj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:39:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9F8cOk9178994;
        Tue, 15 Oct 2019 08:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=ARgJngw/EKwo7//1vnF1N8vdv7+VDvf0AqFaDb+ArC8=;
 b=WjIQD1PCdG8gNqNaB4rr68DTWdc5GwKT9T8LDyX/d5fU4RXXt7n/Uno1y8fdniBOPp7X
 tfItlcZ0j4CmBWhGSixmMmMSdK4xnZZAM1So5KMBKdkmV2gbI6VT0wtuhFv6TQyTDyiE
 D4Sax8+H56C8cYelm5Zr0lG0O+QzLgIUQ3xXYG+b0ghE4YaWUXxF4GxERx/i/AD9pi0L
 SC/ij6fiPRXvR//QxR8PrbdyydYXPiq9RsX3zjGBAYxhiwPzfS08Egj0JaLu3M+SQ/sn
 G9jfh+CVpjMcKuP2IFUzuBpGeIMDvkS/ZO6Xb0rjDGl9NqjjvTkNPIepcTc7cxi4dJJq hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vk68ue96d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 08:39:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9F8ckIx076448;
        Tue, 15 Oct 2019 08:39:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vkrbmh85f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 08:39:06 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9F8ckaZ007044;
        Tue, 15 Oct 2019 08:38:46 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 08:38:46 +0000
Date:   Tue, 15 Oct 2019 11:38:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Darren Hart <dvhart@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>, Takashi Iwai <tiwai@suse.de>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/x86: huawei-wmi: make validation stricter in
 huawei_wmi_battery_set()
Message-ID: <20191015083837.GA29104@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think it makes sense for "end" to be negative or for even for it
to be less than "start".  That also means that "start" can't be more
than 100 which is good.

Fixes: b7527d0f4502 ("platform/x86: huawei-wmi: Add battery charging thresholds")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/platform/x86/huawei-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 6720f78c60c2..02a505a72172 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -343,7 +343,7 @@ static int huawei_wmi_battery_set(int start, int end)
 	union hwmi_arg arg;
 	int err;
 
-	if (start < 0 || end > 100)
+	if (start < 0 || end < start || end > 100)
 		return -EINVAL;
 
 	arg.cmd = BATTERY_THRESH_SET;
-- 
2.20.1

