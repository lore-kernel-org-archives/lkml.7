Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63459CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A72020874
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g7lu73QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfJaBTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:19:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34404 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfJaBTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:17 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id B0CB22010AC0;
        Wed, 30 Oct 2019 18:19:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0CB22010AC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572484756;
        bh=RqMz75eioSPQPfWpUYryf90rJHg/WjOPYhEZZl7VA8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7lu73QSWsjqmDPwqqNimRTunhhlVKf5Rp4COY+BU9Ybmcem+q4On7oOhJZ7ePvTz
         iuQj3HMspram5CCthGBj0zoS6W/pyMLv1tYbt7r0dFI2YtKgbTED+s9z4qXWO1jS8w
         914I0vofydvtlGiInXeChrf25Xm5c33kiRy6O1Qw=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Subject: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key create or update
Date:   Wed, 30 Oct 2019 18:19:02 -0700
Message-Id: <20191031011910.2574-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asymmetric keys used for verifying file signatures or certificates
are currently not included in the IMA measurement list.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure asymmetric keys.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h      |  2 ++
 security/integrity/ima/ima_main.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 997a57137351..22d0628faf56 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -21,6 +21,8 @@
 #include <linux/tpm.h>
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
 
 #include "../integrity.h"
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 492b8f241d39..18e1bc105be7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -635,6 +635,9 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	if (!ima_policy_flag)
+		return;
+
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(NULL, current_cred(), secid, 0, func,
@@ -695,6 +698,29 @@ void ima_kexec_cmdline(const void *buf, int size)
 	}
 }
 
+/**
+ * ima_post_key_create_or_update - measure asymmetric keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   unsigned long flags, bool create)
+{
+	const struct public_key *pk;
+
+	if (key->type != &key_type_asymmetric)
+		return;
+
+	pk = key->payload.data[asym_crypto];
+	process_buffer_measurement(pk->key, pk->keylen,
+				   keyring->description,
+				   NONE, 0);
+}
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.17.1

