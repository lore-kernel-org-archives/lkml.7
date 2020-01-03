Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02DBC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1939222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rw7JBD1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgACTys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:54:48 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35998 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgACTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:54:43 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7EFA120B479C;
        Fri,  3 Jan 2020 11:54:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EFA120B479C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578081282;
        bh=kCXGKFIMaJwcgp6FQFBvBNIEREa+54US7CB8LxGdbpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rw7JBD1oGIhgYX3fdn6AzkPx+hS4Kk/DyCR9XngRpoOoaQfGJGbXjsWt/4IYFvgr5
         XUAQkQN4sHRN2KvRtUFcxzSPSQ3kWAdRGKzAXrJO10m5mlLy6K8i5QarLaqAUUOmXx
         nAUnV1veyRVexyVzmpvfB9PBCXAM13WiVOYNeZWM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     James.Bottomley@HansenPartnership.com, eric.snowberg@oracle.com,
        dhowells@redhat.com, mathew.j.martineau@linux.intel.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v7 3/3] IMA: Defined timer to free queued keys
Date:   Fri,  3 Jan 2020 11:54:35 -0800
Message-Id: <20200103195435.2647-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103195435.2647-1-nramas@linux.microsoft.com>
References: <20200103195435.2647-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

keys queued for measurement should be freed if a custom IMA policy
was not loaded. Otherwise, the keys will remain queued forever
consuming kernel memory.

This patch defines a timer to handle the above scenario. The timer
is setup to expire 5 minutes after IMA initialization is completed.

If a custom IMA policy is loaded before the timer expires, the timer
is removed and any queued keys are processed for measurement.
But if a custom policy was not loaded, on timer expiration
queued keys are just freed.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <rong.a.chen@intel.com> # sleeping
function called from invalid context
---
 security/integrity/ima/ima.h                 |  2 +
 security/integrity/ima/ima_asymmetric_keys.c | 42 ++++++++++++++++++--
 security/integrity/ima/ima_init.c            |  8 +++-
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 97f8a4078483..c483215a9ee5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -216,8 +216,10 @@ struct ima_key_entry {
 	char *keyring_name;
 };
 void ima_process_queued_keys(void);
+void ima_init_key_queue(void);
 #else
 static inline void ima_process_queued_keys(void) {}
+static inline void ima_init_key_queue(void) {}
 #endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
 
 /* LIM API function definitions */
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index eb71cbf224c1..d1fa1706e03f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/timer.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
@@ -26,6 +27,36 @@ static bool ima_process_keys;
 static DEFINE_SPINLOCK(ima_keys_lock);
 static LIST_HEAD(ima_keys);
 
+/*
+ * If custom IMA policy is not loaded then keys queued up
+ * for measurement should be freed. This timer is used
+ * for handling this scenario.
+ */
+static long ima_key_queue_timeout = 300000; /* 5 Minutes */
+static struct timer_list ima_key_queue_timer;
+static bool timer_expired;
+
+/*
+ * This timer callback function frees keys that may still be
+ * queued up in case custom IMA policy was not loaded.
+ */
+static void ima_timer_handler(struct timer_list *timer)
+{
+	timer_expired = true;
+	ima_process_queued_keys();
+}
+
+/*
+ * This function sets up a timer to free queued keys in case
+ * custom IMA policy was never loaded.
+ */
+void ima_init_key_queue(void)
+{
+	timer_setup(&ima_key_queue_timer, ima_timer_handler, 0);
+	mod_timer(&ima_key_queue_timer,
+		  jiffies + msecs_to_jiffies(ima_key_queue_timeout));
+}
+
 static void ima_free_key_entry(struct ima_key_entry *entry)
 {
 	if (entry) {
@@ -120,10 +151,15 @@ void ima_process_queued_keys(void)
 	if (!process)
 		return;
 
+	del_timer(&ima_key_queue_timer);
+
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
-		process_buffer_measurement(entry->payload, entry->payload_len,
-					   entry->keyring_name, KEY_CHECK, 0,
-					   entry->keyring_name);
+		if (!timer_expired)
+			process_buffer_measurement(entry->payload,
+						   entry->payload_len,
+						   entry->keyring_name,
+						   KEY_CHECK, 0,
+						   entry->keyring_name);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..195cb4079b2b 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -131,5 +131,11 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
-	return ima_fs_init();
+	rc = ima_fs_init();
+	if (rc != 0)
+		return rc;
+
+	ima_init_key_queue();
+
+	return rc;
 }
-- 
2.17.1

