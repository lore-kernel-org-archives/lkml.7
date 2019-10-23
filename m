Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B53FC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D702084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KwrDmZZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408068AbfJWXj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 19:39:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51392 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392754AbfJWXj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:39:57 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8BC3F2010AC5;
        Wed, 23 Oct 2019 16:39:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BC3F2010AC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571873996;
        bh=oW+D4pzJ9HOm7aty1xLpBXhe3vkoiV3VtOmUq5zybZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwrDmZZIX88BVDaFpk62/UTRFfg8vDbcNg/bsMUDBiNi77P2GSx4LNT8y4J9GKkym
         Wtc46DQVk8VizdzAXeO6xaHmLPoewvNihz/8v19k4v5pUqILUk7NKyUv39pJZE02hz
         ER9MYfNKYCwEu+SdZkqeHNokHzuArKR4libWkqHk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v2 4/4] KEYS: Enabled ima policy to measure keys added to builtin_trusted_keys keyring
Date:   Wed, 23 Oct 2019 16:39:50 -0700
Message-Id: <20191023233950.22072-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023233950.22072-1-nramas@linux.microsoft.com>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated ima policy handler to check if the ima policy enables
measurement of keys added to the builtin_trusted_keys keyring.

With this patch measurement of keys added to the builtin_trusted_keys
keyring is enabled end-to-end.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6df7f641ff66..944636076152 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -370,7 +370,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEXEC_CMDLINE) {
+	if ((func == KEXEC_CMDLINE) || (func == BUILTIN_TRUSTED_KEYS)) {
 		if ((rule->flags & IMA_FUNC) && (rule->func == func))
 			return true;
 		return false;
@@ -959,6 +959,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = POLICY_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
 				entry->func = KEXEC_CMDLINE;
+			else if (strcmp(args[0].from,
+					"BUILTIN_TRUSTED_KEYS") == 0)
+				entry->func = BUILTIN_TRUSTED_KEYS;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.17.1

