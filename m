Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C230FC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967A520848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZLFFRMIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgAGTn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:43:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34212 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbgAGTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:43:55 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6CBD20B479A;
        Tue,  7 Jan 2020 11:43:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6CBD20B479A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578426234;
        bh=yA5LFjSLBWVUP9TbZOq+D/2tmitmwjc/aS91KwfLW6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLFFRMIhtrM0dtheX1wT/8OLGYBWwcScPXgBiIpgLm2I0onLHlwuo5o5p7jJmIxql
         N0wLB85js/eg5T/7HST8Ui+ZZS1wROO7siJsssn5EVcAU4lGe6mMDTIcuvoj0wkkQW
         MjMJDkjJ9BMG+iaevZLcLUUzy/JiE4T6iBkX7/I4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH 2/4] KEYS: Call the IMA hook to measure keys
Date:   Tue,  7 Jan 2020 11:43:48 -0800
Message-Id: <20200107194350.3782-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107194350.3782-1-nramas@linux.microsoft.com>
References: <20200107194350.3782-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the IMA hook from key_create_or_update() function to measure
the payload when a new key is created or an existing key is updated.

This patch adds the call to the IMA hook from key_create_or_update()
function to measure the key on key create or update.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reported-by: kbuild test robot <lkp@intel.com> # ima_asymmetric_keys.c
is built as a kernel module when it is actually not.
Fixes: cb1aa3823c92 ("KEYS: Call the IMA hook to measure keys")
---
 include/linux/ima.h | 14 ++++++++++++++
 security/keys/key.c | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6d904754d858..f4644c54f648 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -101,6 +101,20 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 {}
 #endif
 
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+extern void ima_post_key_create_or_update(struct key *keyring,
+					  struct key *key,
+					  const void *payload, size_t plen,
+					  unsigned long flags, bool create);
+#else
+static inline void ima_post_key_create_or_update(struct key *keyring,
+						 struct key *key,
+						 const void *payload,
+						 size_t plen,
+						 unsigned long flags,
+						 bool create) {}
+#endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
+
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct dentry *dentry);
diff --git a/security/keys/key.c b/security/keys/key.c
index 764f4c57913e..718bf7217420 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/random.h>
+#include <linux/ima.h>
 #include <linux/err.h>
 #include "internal.h"
 
@@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	ima_post_key_create_or_update(keyring, key, payload, plen,
+				      flags, true);
+
 	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
 
 error_link_end:
@@ -965,6 +969,12 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 
 	key_ref = __key_update(key_ref, &prep);
+
+	if (!IS_ERR(key_ref))
+		ima_post_key_create_or_update(keyring, key,
+					      payload, plen,
+					      flags, false);
+
 	goto error_free_prep;
 }
 EXPORT_SYMBOL(key_create_or_update);
-- 
2.17.1

