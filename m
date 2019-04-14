Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8467C10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44572077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5Yv7G8++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfDODK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:10:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43700 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDODK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 23:10:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F2xgS3185420;
        Mon, 15 Apr 2019 03:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=S3rZN90fqdr6pFhmgDzEWKZx4JcRMGXDR94iqTn7l8I=;
 b=5Yv7G8++f4KVa/pzPb9OvsPcE00AIUYV7zxLouHNMi4fqafPYdP0R0FfrrzNFJsMmHSL
 ifFK/TE9otV7wQFVT88Njpzf9ySH+7Q1A47Qe3vjpHk5lfzoslJarXUO1hUeEEa/mV+D
 zrANQSzC8MHJCyk4wkUocPf3XKFwKENywMU1eCu0vfcGrCyUIQEdAuFH4vun2ctN0fr4
 Dek9vkT7KGQCRkIIkJKawx1Se8Pq8fwDrczydsGrF+nKL4KnJXuAUkdf3C9K5Zd6vGOZ
 YEMeLSdZViZkfycaQOL43hBlEqDcSqs4GsqF/vRWLZh91+fgXpDnA9IL9InMcwYnW3rp QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ru76t42h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 03:09:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F383Dd102684;
        Mon, 15 Apr 2019 03:09:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2rv2ttxjg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 03:09:29 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3F39SXf017286;
        Mon, 15 Apr 2019 03:09:28 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 20:09:27 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH 2/2] doc: kernel-parameters.txt: fix documentation of nmi_watchdog parameter
Date:   Sun, 14 Apr 2019 11:11:04 +0800
Message-Id: <1555211464-28652-2-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150019
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in "Documentation/lockup-watchdogs.txt:line 22", the default
behaivor after 'hardlockup' is to stay locked up rather than panic.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90..fcc9579 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2769,7 +2769,7 @@
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
 			When panic is specified, panic when an NMI watchdog
-			timeout occurs (or 'nopanic' to override the opposite
+			timeout occurs (or 'nopanic' which is the opposite
 			default). To disable both hard and soft lockup detectors,
 			please see 'nowatchdog'.
 			This is useful when you use a panic=... timeout and
-- 
1.8.3.1

