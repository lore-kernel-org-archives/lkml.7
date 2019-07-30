Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C591C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34342206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YV5Dtbg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfG3AD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:03:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36928 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfG3ADX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:03:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNx0bD162470;
        Tue, 30 Jul 2019 00:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=QV3mkbvDqVOuRyxrBxvxIwvW8RbxilJ7TWeQkboRwPw=;
 b=YV5Dtbg3JaqFI8k7yfiuTDuc4CdZGDjWE8t2gVtHRk7CgTbqPZUP5TkCrMDI4tDpRQCW
 Tv1pMiiNKojHrMh9e5/dHWk10PlrCOyBEg6jRZ/Pb/D2OlnazqEw0Hj8tPBJldqwWMIT
 xryKNvfU4DhuAgjQvWl+0JZCPxwyPYsd+0ZzLjxWXGjdLO1vRD+LjhR6DdaNOasI2mvt
 aF8fQAsAF8Kgd6eFxX5sQq6Oz6gf9Zz5N+RZ5gPWbErAb6Skztr7YYa17Cik1nvt9sNA
 QNuJ8kbNaciQvMH8hRMSsY/dmbIvAzBgrbwpTPI8NY0Bu18vihcYJ11wUHblgmTLb5sG MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u0f8qtph3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNvhx8039139;
        Tue, 30 Jul 2019 00:02:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2u0xv7tha8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U02ql4012440;
        Tue, 30 Jul 2019 00:02:52 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 17:02:52 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH 7/7] tracing: Un-export ftrace_set_clr_event
Date:   Mon, 29 Jul 2019 17:02:34 -0700
Message-Id: <1564444954-28685-8-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
References: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907290261
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907290261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "trace_array_set_clr_event" to enable/disable events to a trace
array from other kernel modules/components.
Hence, we no longer need to have ftrace_set_clr_event as an exported API.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-By: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 include/linux/trace_events.h | 1 -
 kernel/trace/trace_events.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 6da3600..025ae2b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -542,7 +542,6 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, int set);
-int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 
 /*
  * The double __builtin_constant_p is because gcc will give us an error
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9ee6b52..96dd997 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -795,7 +795,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match;
 	int ret;
@@ -834,7 +834,6 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
 
 /**
  * trace_set_clr_event - enable or disable an event
-- 
1.8.3.1

