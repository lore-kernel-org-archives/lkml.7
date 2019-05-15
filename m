Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C4CC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FB62084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M7a7HwAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEOJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:33:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:33:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9OeIN092518;
        Wed, 15 May 2019 09:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Q70LVHYNhr323o+iw2jk2yflkPHA+6Bp+Y48KCc+tBE=;
 b=M7a7HwALKDw/lPIL2a5UGhJnxFUI4DmMjNkAnFxniz65u5uq7r4Lpfh+mL6FgxLx85Xy
 nRkqsoTPGSG2Vpj7TsZIZqdmOwiEJbhJTSx7NXNCkhLKHGy3AbT3zzYTWdCaVqxAsclo
 1z10XQbSwVSOebG6nVPhlmEdtNFcXzVWb4b7HGs+5XsvMqu3OVuudtyo9kKgVAE867AZ
 DKesb6NhqllRlFcMLOYJ1Zj8ZA+BB2C0Il77idamc2wOGbWdNd0Ha3Rnm+V2GbUf2fAW
 1ben3bR4tjJJNlm2BVpWKxjWwVt5C6wnsjhAF9rMIQZZegNUchO9nVE12fMm8TUaO02x TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sdnttukt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:33:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9XKIS144224;
        Wed, 15 May 2019 09:33:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2sdmebmtun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:33:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4F9XUkd025829;
        Wed, 15 May 2019 09:33:30 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 May 2019 02:33:29 -0700
Date:   Wed, 15 May 2019 12:33:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] test_firmware: Use correct snprintf() limit
Message-ID: <20190515093322.GB3409@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905150061
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905150061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The limit here is supposed to be how much of the page is left, but it's
just using PAGE_SIZE as the limit.

The other thing to remember is that snprintf() returns the number of
bytes which would have been copied if we had had enough room.  So that
means that if we run out of space then this code would end up passing a
negative value as the limit and the kernel would print an error message.
I have change the code to use scnprintf() which returns the number of
bytes that were successfully printed (not counting the NUL terminator).

Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_firmware.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 7222093ee00b..b5487ed829d7 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -223,30 +223,30 @@ static ssize_t config_show(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
-	len += snprintf(buf, PAGE_SIZE,
+	len += scnprintf(buf, PAGE_SIZE - len,
 			"Custom trigger configuration for: %s\n",
 			dev_name(dev));
 
 	if (test_fw_config->name)
-		len += snprintf(buf+len, PAGE_SIZE,
+		len += scnprintf(buf+len, PAGE_SIZE - len,
 				"name:\t%s\n",
 				test_fw_config->name);
 	else
-		len += snprintf(buf+len, PAGE_SIZE,
+		len += scnprintf(buf+len, PAGE_SIZE - len,
 				"name:\tEMTPY\n");
 
-	len += snprintf(buf+len, PAGE_SIZE,
+	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"num_requests:\t%u\n", test_fw_config->num_requests);
 
-	len += snprintf(buf+len, PAGE_SIZE,
+	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"send_uevent:\t\t%s\n",
 			test_fw_config->send_uevent ?
 			"FW_ACTION_HOTPLUG" :
 			"FW_ACTION_NOHOTPLUG");
-	len += snprintf(buf+len, PAGE_SIZE,
+	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
-	len += snprintf(buf+len, PAGE_SIZE,
+	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"read_fw_idx:\t%u\n", test_fw_config->read_fw_idx);
 
 	mutex_unlock(&test_fw_mutex);
-- 
2.20.1

