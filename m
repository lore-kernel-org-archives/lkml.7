Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A57BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F62C206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1Ni0USQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfFEAm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 20:42:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53808 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFEAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 20:42:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x550YI29161118;
        Wed, 5 Jun 2019 00:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Tbgmsx0BLpXVDNqw4K1e+6YBW7jqMnAbJks3Wr0Trhk=;
 b=1Ni0USQmAz5qcWM0vJRu/jvxmWMwCdvjBLFvFqHOIiPD1yctYqBZf0M1LlIyFMTQVn40
 HlCSoHCZGZJRlWaxyVRrNLsRe5sWuO7lNJv8ctZDnX79bN4eFn1nZrw/RZ9bVUL8VyIA
 c0v+BSVlVbSUD++HBXuAjPfZ6DltGrZog7v3qtSwBzIpSmml+7dOFGXV8K7bJxcmVqwf
 e4BXv/gwmRuPU/mzow/Myt+Ks3wg4SMLcjCDci9+0q0ogXvaWC+VQ1/MhdZ5ANpHWHW8
 OSGRgXZlBGIScZDIClmAzip13IDh9GMkRGNeJ77+JlmqzcW3AbsnAQ9Lgk1940/0h/vk Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2sugstg46h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 00:42:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x550eU1c151687;
        Wed, 5 Jun 2019 00:42:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2swnh9w1be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 00:42:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x550gItn014126;
        Wed, 5 Jun 2019 00:42:18 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 17:42:17 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Srinivas Eeda <srinivas.eeda@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH 2/3] tracing: Adding additional NULL checks.
Date:   Tue,  4 Jun 2019 17:42:04 -0700
Message-Id: <1559695325-17155-3-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559695325-17155-2-git-send-email-divya.indi@oracle.com>
References: <1559695325-17155-1-git-send-email-divya.indi@oracle.com>
 <1559695325-17155-2-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=875
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=906 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have exported certain functions providing access to Ftrace
instances from other kernel components, we are adding some additional
NULL checks to ensure safe usage by the users.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 kernel/trace/trace.c        | 3 +++
 kernel/trace/trace_events.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c80521..a60dc13 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3205,6 +3205,9 @@ int trace_array_printk(struct trace_array *tr,
 	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
+	if (!tr)
+		return -EINVAL;
+
 	va_start(ap, fmt);
 	ret = trace_array_vprintk(tr, ip, fmt, ap);
 	va_end(ap);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b6b4618..445b059 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -800,6 +800,8 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 	char *event = NULL, *sub = NULL, *match;
 	int ret;
 
+	if (!tr)
+		return -ENODEV;
 	/*
 	 * The buf format can be <subsystem>:<event-name>
 	 *  *:<event-name> means any event by that name.
-- 
1.8.3.1

