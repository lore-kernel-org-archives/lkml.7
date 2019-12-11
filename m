Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39671C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113182464B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L/rDi9jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfLKSvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:51:22 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57306 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKSvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:51:22 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1743420B718B;
        Wed, 11 Dec 2019 10:51:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1743420B718B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576090281;
        bh=JXcaJWRtMHzI+YncpvA5z0porrWb2hzaFcDdpjNMbq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/rDi9jYTLNRZ5MRbIDQ96GGZ6leSGWtgwqzvFF44SFKKDpfAfNalBQARd/VHEqN3
         DpPguyVn46cInn5mkg+8JUpoCbtI0aznnzuRrJfx8zx/dPn7VO3RynPM8fFLPTN6fM
         DTevOSeWdnCf85jUXK6JVLxa6s/lCdFfWyHoKy8w=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v2 2/2] IMA: Call workqueue functions to measure queued keys
Date:   Wed, 11 Dec 2019 10:51:16 -0800
Message-Id: <20191211185116.2740-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211185116.2740-1-nramas@linux.microsoft.com>
References: <20191211185116.2740-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Measuring keys requires a custom IMA policy to be loaded.
Keys should be queued for measurement if a custom IMA policy
is not yet loaded. Keys queued for measurement, if any, should be
processed when a custom IMA policy is loaded.

This patch updates the IMA hook function ima_post_key_create_or_update()
to queue the key if a custom IMA policy has not yet been loaded.
And, ima_update_policy() function, which is called when
a custom IMA policy is loaded, is updated to process queued keys.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 8 ++++++++
 security/integrity/ima/ima_policy.c          | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index ba01e04ec025..61b801ff3747 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -140,6 +140,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	bool queued = false;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
@@ -147,6 +149,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len == 0))
 		return;
 
+	if (!ima_process_keys)
+		queued = ima_queue_key(keyring, payload, payload_len);
+
+	if (queued)
+		return;
+
 	/*
 	 * keyring->description points to the name of the keyring
 	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a4dde9d575b2..04b9c6c555de 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -807,6 +807,9 @@ void ima_update_policy(void)
 		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
+
+	/* Custom IMA policy has been loaded */
+	ima_process_queued_keys();
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
-- 
2.17.1

