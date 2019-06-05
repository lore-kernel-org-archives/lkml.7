Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EECC282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA63206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kfIIvFE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFEAmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 20:42:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34276 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfFEAmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 20:42:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x550YvN1181842;
        Wed, 5 Jun 2019 00:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=pKcVDYej571iUEZ1fuxZmn8sto91jp1Lw9EvBVj8DHg=;
 b=kfIIvFE0l/cnN2gXMZJU1y9gTn026TyIvi9+/9GZPKjGHdQe/x3JP4ScsiS8i358AFDz
 Ej1lUhvyTxFkYnGzWbiyNts6LYwA77ojcbTspId27dq5/S7OwzngAqiAtzwerSoqH0IX
 q+M8tGFfPxG//ZyS+19RmnfPPHlh4hQbNU76LHWEluZaSwNpQ58ToR+1ZKoQB77x2ofg
 JZCrCT1QJnX/TF/LDuhC6HmPd8lR1H6pR2JWTcZg0Qr/urukEekDpnUCjRR8NH1WyI+E
 FbRFtajX47GS2DZleelPoi98RxQu4+ayALOByJLV3nV1FoUpPTnNl7zFpNDYKPviGnGO TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2suevdgb2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 00:42:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x550eqmn085940;
        Wed, 5 Jun 2019 00:42:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2swngkn3rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 00:42:20 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x550gJYk028699;
        Wed, 5 Jun 2019 00:42:19 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 17:42:19 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Srinivas Eeda <srinivas.eeda@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH 3/3] tracing: Add 2 new funcs. for kernel access to Ftrace instances.
Date:   Tue,  4 Jun 2019 17:42:05 -0700
Message-Id: <1559695325-17155-4-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559695325-17155-3-git-send-email-divya.indi@oracle.com>
References: <1559695325-17155-1-git-send-email-divya.indi@oracle.com>
 <1559695325-17155-2-git-send-email-divya.indi@oracle.com>
 <1559695325-17155-3-git-send-email-divya.indi@oracle.com>
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

Adding 2 new functions -
1) trace_array_lookup : Look up and return a trace array, given its
name.
2) trace_array_set_clr_event : Enable/disable event recording to the
given trace array.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 include/linux/trace_events.h |  3 +++
 kernel/trace/trace.c         | 11 +++++++++++
 kernel/trace/trace_events.c  | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d7b7d85..0cc99a8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -545,7 +545,10 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
 struct trace_array *trace_array_create(const char *name);
 int trace_array_destroy(struct trace_array *tr);
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+struct trace_array *trace_array_lookup(const char *name);
 int trace_set_clr_event(const char *system, const char *event, int set);
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, int set);
 
 /*
  * The double __builtin_constant_p is because gcc will give us an error
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a60dc13..1d171fd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8465,6 +8465,17 @@ static int instance_rmdir(const char *name)
 	return ret;
 }
 
+struct trace_array *trace_array_lookup(const char *name)
+{
+	struct trace_array *tr;
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, name) == 0)
+			return tr;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(trace_array_lookup);
+
 static __init void create_trace_instances(struct dentry *d_tracer)
 {
 	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 445b059..c126d2c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -859,6 +859,28 @@ int trace_set_clr_event(const char *system, const char *event, int set)
 }
 EXPORT_SYMBOL_GPL(trace_set_clr_event);
 
+/**
+ * trace_array_set_clr_event - enable or disable an event for a trace array
+ * @system: system name to match (NULL for any system)
+ * @event: event name to match (NULL for all events, within system)
+ * @set: 1 to enable, 0 to disable
+ *
+ * This is a way for other parts of the kernel to enable or disable
+ * event recording to instances.
+ *
+ * Returns 0 on success, -EINVAL if the parameters do not match any
+ * registered events.
+ */
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, int set)
+{
+	if (!tr)
+		return -ENODEV;
+
+	return __ftrace_set_clr_event(tr, NULL, system, event, set);
+}
+EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
+
 /* 128 should be much more than enough */
 #define EVENT_BUF_SIZE		127
 
-- 
1.8.3.1

