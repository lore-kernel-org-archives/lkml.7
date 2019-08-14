Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F03C32757
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9483420651
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h8aLJeHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfHNR4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:56:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50356 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfHNR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:56:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHs10j120570;
        Wed, 14 Aug 2019 17:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=J+aGgNDqEz2aIyvG1OIozCO8IpVEKubIfpgBTA5oyI4=;
 b=h8aLJeHfb1GTlUsKk7NkcTNaHvtAKy7Z/IorgEDRjwr6CZnwal8edHgjrSu4YnyiRis/
 AkVHj4sGZp3LLM+7PdZWZ/zzaII35yC7TU07o0uUOh+C4tyqTrpVbQnbxZYhBzExU3ft
 W+2S9z8bvJDq7YAcTKylEvEnfCo18snsI1pAjv/+kQ8xGwKGPydN4pQNWYh+34PPrz1Q
 NHZSl7P4n5RElN4KAycjHH65dYdSWQj0tzlJPbk5WMDzCmD9Q8hnBvBEcYhXkq5jXUjt
 rZE1J1Y3563SOURG+yVEa/u7YWo04rO588C7HAAb3DqQEE/uRpWdXV7xfWwyQ8QzdRe1 Mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u9nvpef69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHqwHt114082;
        Wed, 14 Aug 2019 17:55:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ucmwhprch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7EHtdTx008276;
        Wed, 14 Aug 2019 17:55:39 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 10:55:39 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: [PATCH 2/5] tracing: Verify if trace array exists before destroying it.
Date:   Wed, 14 Aug 2019 10:55:24 -0700
Message-Id: <1565805327-579-3-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=946
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=996 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trace array can be destroyed from userspace or kernel. Verify if the
trace exists before proceeding to destroy/remove it.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 kernel/trace/trace.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c80521..468ecc5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8421,17 +8421,27 @@ static int __remove_instance(struct trace_array *tr)
 	return 0;
 }
 
-int trace_array_destroy(struct trace_array *tr)
+int trace_array_destroy(struct trace_array *this_tr)
 {
+	struct trace_array *tr;
 	int ret;
 
-	if (!tr)
+	if (!this_tr) {
 		return -EINVAL;
+	}
 
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

