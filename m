Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C57AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5725A21721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RdOzZcMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfHNR4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:56:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfHNR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:56:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHs1Mj120575;
        Wed, 14 Aug 2019 17:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=SSMJC3aScSlshwt5SB5ePlyEPYgLUM6hbpqyTGbKCLw=;
 b=RdOzZcMegxclZSmR7kDPpLD2kxR0+6dAPAAffexngMYDz5GzOmN5tvK7zbkeXog2HLUV
 qy3YjCKLaqCIxeJFFpBTP+6QJVVEsoWE181th6pTZ0dJZTwSZucBoHfjrmHfJWpBh8FV
 JWljR9JfzpPh08M6rzraW5fiHQ8x4wnBbM8umOhO2lpTxO3ZqUFFuDqWeFt9kVWN5taX
 NARaIrF2kqHBL1tlbp4EnUupxiuNHHWflljAKYrQb6Fo1tHQCje9bh7tZyhyQ15Dm4S6
 Nane+wgKXvr5QBT33hIHybVaSd+/wk5qoO8/40+G0anH26KPs2K00VQyiqR6s8QoM68f EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u9nvpef6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHr0Ge114299;
        Wed, 14 Aug 2019 17:55:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ucmwhprd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:41 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7EHtewE008290;
        Wed, 14 Aug 2019 17:55:40 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 10:55:40 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: [PATCH 3/5] tracing: Adding NULL checks
Date:   Wed, 14 Aug 2019 10:55:25 -0700
Message-Id: <1565805327-579-4-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of commit f45d1225adb0 ("tracing: Kernel access to Ftrace
instances") we exported certain functions. Here, we are adding some additional
NULL checks to ensure safe usage by users of these APIs.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 kernel/trace/trace.c        | 3 +++
 kernel/trace/trace_events.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 468ecc5..22bf166 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3205,6 +3205,9 @@ int trace_array_printk(struct trace_array *tr,
 	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
+	if (!tr)
+		return -ENOENT;
+
 	va_start(ap, fmt);
 	ret = trace_array_vprintk(tr, ip, fmt, ap);
 	va_end(ap);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0ce3db6..2621995 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -800,6 +800,8 @@ static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 	char *event = NULL, *sub = NULL, *match;
 	int ret;
 
+	if (!tr)
+		return -ENOENT;
 	/*
 	 * The buf format can be <subsystem>:<event-name>
 	 *  *:<event-name> means any event by that name.
-- 
1.8.3.1

