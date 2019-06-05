Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB99AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DF820874
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uuxW5Kfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfFEAms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 20:42:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53806 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFEAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 20:42:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x550Z1OG162050;
        Wed, 5 Jun 2019 00:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=c5azvVfPt2xcmajcePerZc/MJE/6GZzmboOOmBWkC0U=;
 b=uuxW5KfrYE4znBKzbl1GZqOHHb/Sv6IrNFPWNbCq2BIG9FILol8XxNaflFsPc6eKVED1
 8EGaAizgFV1kNDk7sLE01VLkCrdleauaHcQ0fzDdO4bOWcsSthDmiT42wg52Y56USEA9
 QCNwlsEZydp/Bh0lC1dkvG9DQkTTwux9Tfw3+AQNMMtU13zLeX7BaOlWIKgpa3gWfZth
 lK5ZSQ8loURTYOvhUm6AsxGoIwYGyPEk+4MbPUn9l4Zz07hbuVL6YZgyZusxKNOiPzED
 An1OomtHbs1NjKIK4hkts6y6pCBhljE4HkKS2cZ7eXndhYDfDt5+2++X3JxhOow8G2/w 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sugstg46f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 00:42:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x550ebh5116348;
        Wed, 5 Jun 2019 00:42:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2swnhbw1em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 00:42:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x550gHm5014121;
        Wed, 5 Jun 2019 00:42:17 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 17:42:16 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Srinivas Eeda <srinivas.eeda@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH 1/3] tracing: Relevant changes for kernel access to Ftrace instances.
Date:   Tue,  4 Jun 2019 17:42:03 -0700
Message-Id: <1559695325-17155-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559695325-17155-1-git-send-email-divya.indi@oracle.com>
References: <1559695325-17155-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For commit (f45d122): tracing: Kernel access to Ftrace instances.
We need the following additional changes to ensure other kernel components can
use these functions -
1) Remove static keyword for newly exported fn - ftrace_set_clr_event.
2) Add the req functions to header file include/linux/trace_events.h.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 include/linux/trace_events.h | 6 ++++++
 kernel/trace/trace_events.c  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731..d7b7d85 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -539,6 +539,12 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
 
+void trace_printk_init_buffers(void);
+int trace_array_printk(struct trace_array *tr, unsigned long ip,
+		const char *fmt, ...);
+struct trace_array *trace_array_create(const char *name);
+int trace_array_destroy(struct trace_array *tr);
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 
 /*
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

