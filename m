Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3789CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8279C2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzvNPizx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfKASXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:23:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40366 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfKASXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:23:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1I97qt120122;
        Fri, 1 Nov 2019 18:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=PTkoEEtcL3+nuIHWxsynGo3Qi7g5cwPRqx/QuAOHMmw=;
 b=IzvNPizxwBHZ6ZlxDbQ2LmNr+DM3knu9AxVorlawmdugr8WcqjLSc4vUQ428RcGlvogR
 tkcNTZnyxeNZuZ+I6CwpHMN4Luwedc6y83MKM3tLGyv7P522E2XHLg8jld/9YXMyF8Gf
 wKjArFyZtEJ4Y9v0B9bALE+LZN9qxTQKcEpxMamA4yLMdsp+rtK5DFBLR6CM64CHnfza
 lSEKU5gKpEJYDul85a3NdZ/thktEO+v22mah5Anu9PuWXH8RyHmJ2xN6FlVoeOKJ6Bb1
 bynWvH/hIQAEeFe+pSdD12BFcGCKn5yf5vdFzyUUu35uJaFa2huiw1b6cJaUbGr4WSef Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vxwhg3bq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 18:23:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1I9Stv152878;
        Fri, 1 Nov 2019 18:21:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w0rurnbrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 18:21:17 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA1ILG0b021186;
        Fri, 1 Nov 2019 18:21:16 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.95.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 11:21:16 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, tglx@linutronix.de, peterz@infradead.org,
        serge@hallyn.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH 1/1] Selectively allow CAP_SYS_NICE capability inside user namespaces
Date:   Fri,  1 Nov 2019 11:18:28 -0700
Message-Id: <1572632308-7071-2-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572632308-7071-1-git-send-email-prakash.sangappa@oracle.com>
References: <1572632308-7071-1-git-send-email-prakash.sangappa@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9428 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9428 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow CAP_SYS_NICE to take effect for processes having effective uid of a
root user from init namespace.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f..628bd46 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4548,6 +4548,8 @@ int can_nice(const struct task_struct *p, const int nice)
 	int nice_rlim = nice_to_rlimit(nice);
 
 	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE) ||
+		(ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
+		uid_eq(current_euid(), GLOBAL_ROOT_UID)) ||
 		capable(CAP_SYS_NICE));
 }
 
@@ -4784,7 +4786,9 @@ static int __sched_setscheduler(struct task_struct *p,
 	/*
 	 * Allow unprivileged RT tasks to decrease priority:
 	 */
-	if (user && !capable(CAP_SYS_NICE)) {
+	if (user && !(ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
+		uid_eq(current_euid(), GLOBAL_ROOT_UID)) &&
+		!capable(CAP_SYS_NICE)) {
 		if (fair_policy(policy)) {
 			if (attr->sched_nice < task_nice(p) &&
 			    !can_nice(p, attr->sched_nice))
-- 
2.7.4

