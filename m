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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A8EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361042077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LCnrrgBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDODK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:10:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfDODK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 23:10:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F2xaYo185402;
        Mon, 15 Apr 2019 03:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=C89YXCyTkP9hRP2YyxQNBYCpKGFKBPYOlKJ85ap6qiE=;
 b=LCnrrgBxIrW+26RyxZoojYdHA8FuGZqc6XFwxN57dI7GthjWQllIEZgFRlXoHfdkt2Ys
 uOlUnxV1B5/zedBHjfa2R7c+yt1KGVZE+qsqoxNpG6pG3ZzASACqATcbhH29BiayyH6v
 gdf60JjZeaJT5SbN0MdQubFPh9a7CLh+n9Gm2Eq/v5hnFWvHW3Y6s1kKQ1i7Qty8SO3l
 cyW+3rPZVEvVaqR5HtKMrXItMf0tku/mImB96l7MotWoONN6musBuDnjE0u6jUadPY1e
 y+Z/UOqbwLI86uykyXfVBCovVyp7cjOOLQnIwA8JzsV/kNrGWSgyhmpyIPTBj8ArDAtl vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ru76t42gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 03:09:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F382m7073764;
        Mon, 15 Apr 2019 03:09:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ru5ta3vj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 03:09:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3F39ECj001943;
        Mon, 15 Apr 2019 03:09:14 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 20:09:14 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH 1/2] doc: Fixup definition of rcupdate.rcu_task_stall_timeout
Date:   Sun, 14 Apr 2019 11:11:03 +0800
Message-Id: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150019
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A positive value of rcupdate.rcu_task_stall_timeout is an interval
in seconds rather than jiffies.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 Documentation/RCU/stallwarn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index 1ab70c3..13e88fc 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -153,7 +153,7 @@ rcupdate.rcu_task_stall_timeout
 	This boot/sysfs parameter controls the RCU-tasks stall warning
 	interval.  A value of zero or less suppresses RCU-tasks stall
 	warnings.  A positive value sets the stall-warning interval
-	in jiffies.  An RCU-tasks stall warning starts with the line:
+	in seconds.  An RCU-tasks stall warning starts with the line:
 
 		INFO: rcu_tasks detected stalls on tasks:
 
-- 
1.8.3.1

