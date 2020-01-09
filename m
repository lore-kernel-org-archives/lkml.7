Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D1C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F03205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nTeh8Vkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbgAIRuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:50:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36508 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgAIRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:50:51 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8DEDF2007679;
        Thu,  9 Jan 2020 09:50:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DEDF2007679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578592250;
        bh=cu2JveRyQuDPFRB2esVGRwjQJkbQO22sfT40nDoRZYU=;
        h=From:To:Cc:Subject:Date:From;
        b=nTeh8VkrEkVm/QzF3jvtCpMXBK7fCmy9Mp3wGWQwB1xdwwI/Aq2lmLu7o56vZtOkg
         96UFm1ZHE/ZNLdwREKjAsrn3TxtHagf3g/asHM8jdwI24I1FtZ3Mm5mPH7TJMnHsMd
         MgU9mjSmW3xtvahE/H32fn6tRwD+DYzqAwTjDw7s=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, arnd@arndb.de, matthewgarrett@google.com,
        sashal@kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH] IMA: fix measuring early boot asymmetric keys
Date:   Thu,  9 Jan 2020 09:50:46 -0800
Message-Id: <20200109175046.4024-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of the asymmetric public keys subtype being defined as a
tristate, with the existing IMA Makefile, ima_asymmetric_keys.c could
be built as a kernel module. To prevent this from happening,
an intermediate Kconfig boolean option named
IMA_MEASURE_ASYMMETRIC_KEYS has been defined.

This patch uses this new config CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
to declare the early boot key measurement functions.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kbuild test robot <lkp@intel.com> # redefinition of
ima_init_key_queue() function.
Suggested-by: James.Bottomley <James.Bottomley@HansenPartnership.com>
Fixes: e164a1695a57 ("IMA: Define workqueue for early boot key measurements")
Fixes: 1df595b4e120 ("IMA: Defined timer to free queued keys")
---
 security/integrity/ima/ima.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c483215a9ee5..6bb3152b3e24 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,7 +205,7 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
-#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
 /*
  * To track keys that need to be measured.
  */
@@ -220,7 +220,7 @@ void ima_init_key_queue(void);
 #else
 static inline void ima_process_queued_keys(void) {}
 static inline void ima_init_key_queue(void) {}
-#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
+#endif /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
 
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-- 
2.17.1

