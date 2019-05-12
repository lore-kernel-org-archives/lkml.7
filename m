Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF5C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB0120862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K3sxFPvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfEMDfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 23:35:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39748 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfEMDfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:35:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4D3YL17040258;
        Mon, 13 May 2019 03:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=r32tubxsUXPdHsbPUXKPUehGznTQnk+IpyDTdJj3D7Q=;
 b=K3sxFPvX27NlUsM04jJx+vPeBVvEciwZnkM1PCKdWRXzOJZ2JYX5lFAT+uTS0z4u8M19
 f0qA13BJ0ZuqmIX51GQ6n6q+SN8T5/zRq4g3RdRNW2u0wk+5n4/pTP/97p/btMq4kOtZ
 sAEKvgGIA1/GZQnNnWeHzEkB8CpenMMBeCB3CcwJucuQW4fCgWhGrnOL+MmxBtIE6s7h
 k98ClGykoA2MS3VWIf/2W4MBss0yQ4Bu0wmnt1V0QtSvqqDEn1Ak+0ZDU9kAzyp0XPW+
 ZPluFctbNEf10mZOS8ldocEVRB1HPbjCVX1XXGh/3sg6P5igSDlygcBDsKFUixcl/1B5 dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2sdkwdcatr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 03:34:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4D3Va3B145133;
        Mon, 13 May 2019 03:32:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sdnqhr439-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 03:32:20 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4D3WEw7025820;
        Mon, 13 May 2019 03:32:14 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 May 2019 20:32:13 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v2] doc: kernel-parameters.txt: fix documentation of nmi_watchdog parameter
Date:   Sun, 12 May 2019 11:35:27 +0800
Message-Id: <1557632127-16717-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9255 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130023
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9255 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default behavior of hardlockup depends on the config of
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.

Fix the description of nmi_watchdog to make it clear.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 v2: fix description using words suggested by Steven Rostedt

 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 08df588..b9d4358 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2805,8 +2805,9 @@
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
 			When panic is specified, panic when an NMI watchdog
-			timeout occurs (or 'nopanic' to override the opposite
-			default). To disable both hard and soft lockup detectors,
+			timeout occurs (or 'nopanic' to not panic on an NMI
+			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
+			To disable both hard and soft lockup detectors,
 			please see 'nowatchdog'.
 			This is useful when you use a panic=... timeout and
 			need the box quickly up again.
-- 
1.8.3.1

