Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4E8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C50206E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jf5f5dR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfKMVRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:17:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37562 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfKMVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:17:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADL3tST034275;
        Wed, 13 Nov 2019 21:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=RPjQHq0tM5Z7OdG1crdfUzGn0KI+1jsG44d2MmF5/+k=;
 b=Jf5f5dR5/jqfmdczHtqgDS1ctMGWiHrpl5MyTuRJ1TCkBoFoPMjcq1Q/sqpL6x1ERkVq
 NRAeQEbaeSzVQxXnNo0t3HYmgz2iw9HbGyWO+3GsC/ttegoIQgDzKLqUJKRALiHHxD0X
 eughK9DfWIG6ZGWXWml1jKCDQOX6nNJ5OdnB7njBoH3lg2Z7fB09pSZ3+77z4/aIbY4b
 42M5mDUY+wB+H0KpK8cYnDRAYXpAUJ+R7aFJuuqFqTZYmj5Ag7t8tiVUd23bE915fK3I
 eIVXt43L/g6Oru4L9jrfp+19IFCUGy4WedZktnqEvz3yTOqLqObZV+N3wxOlT4yGLNeV zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w5p3qy6b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:17:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADL3xnD170590;
        Wed, 13 Nov 2019 21:17:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w8g1876ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:16:59 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADLGxGF015428;
        Wed, 13 Nov 2019 21:16:59 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 13:16:58 -0800
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Joe Jin <joe.jin@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: [PATCH 2/5] tracing: Verify if trace array exists before destroying it.
Date:   Wed, 13 Nov 2019 13:15:59 -0800
Message-Id: <1573679762-7774-3-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573679762-7774-2-git-send-email-divya.indi@oracle.com>
References: <1573679762-7774-1-git-send-email-divya.indi@oracle.com>
 <1573679762-7774-2-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=948
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trace array can be destroyed from userspace or kernel. Verify if the
trace exists before proceeding to destroy/remove it.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Reviewed-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
 kernel/trace/trace.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c80521..bff967f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8421,17 +8421,26 @@ static int __remove_instance(struct trace_array *tr)
 	return 0;
 }
 
-int trace_array_destroy(struct trace_array *tr)
+int trace_array_destroy(struct trace_array *this_tr)
 {
+	struct trace_array *tr;
 	int ret;
 
-	if (!tr)
+	if (!this_tr)
 		return -EINVAL;
 
 	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 
-	ret = __remove_instance(tr);
+	ret = -ENODEV;
+
+	/* Making sure trace array exists before destroying it. */
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr == this_tr) {
+			ret = __remove_instance(tr);
+			break;
+		}
+	}
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
-- 
1.8.3.1

