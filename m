Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE6FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE04206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJcpIinR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfG3ADR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:03:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbfG3ADQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:03:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNwoMR162451;
        Tue, 30 Jul 2019 00:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=m3vqu7sDZ7UJADBAyxb1feCtycuAxPeOh7iKw94wR4g=;
 b=LJcpIinROwnWcWdkdEY6RWn5eVQKlIbXA2ISxhz9AJIDWbP6/X0DU/2C9oFJH1Tso2zA
 EGRMnz9XdrVFOOPrxEGpFI8DwqdL6FLxX6bVC40I5IP9DWxzOF31yzElI8f1fePCA5rZ
 xavOjOPfBRdMMkomCGkQhLmFIH8NbsRAQ4j2fYccnBTeNJA7swqwErlPr8C01htnCqqn
 uzv1HyBfLXeeQ2/ozW8n+q5kwLoTHdumUIW0mILskEgTTqm7CrtZcahUzEWBTRPKlvtS
 q7oNX1NqC3ngpnTvFQQ+XIuM0Zo8sYLVQj/d3JOTg0khzy0/nix1jVbar6eux5Kitssf 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u0f8qtpgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNvbSm039041;
        Tue, 30 Jul 2019 00:02:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2u0xv7th8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:46 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6U02jUq003732;
        Tue, 30 Jul 2019 00:02:45 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 17:02:45 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH 1/7] tracing: Required changes to use ftrace_set_clr_event.
Date:   Mon, 29 Jul 2019 17:02:28 -0700
Message-Id: <1564444954-28685-2-git-send-email-divya.indi@oracle.com>
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

As part of commit f45d1225adb0 ("tracing: Kernel access to Ftrace
instances") ftrace_set_clr_event was exported, but for other kernel
modules to use the function, we require the following additional changes

1. Removing the static keyword for this newly exported function.
2. Declaring it in the header file - include/linux/trace_events.h

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-By: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 include/linux/trace_events.h | 1 +
 kernel/trace/trace_events.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731..0f874fb 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -540,6 +540,7 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
 
 int trace_set_clr_event(const char *system, const char *event, int set);
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 
 /*
  * The double __builtin_constant_p is because gcc will give us an error
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0ce3db6..b6b4618 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -795,7 +795,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match;
 	int ret;
-- 
1.8.3.1

