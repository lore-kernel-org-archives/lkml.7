Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22625CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E4020650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nQfxB7Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbfJWASZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:18:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45252 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbfJWASZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:18:25 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4E0AA2010AC3;
        Tue, 22 Oct 2019 17:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E0AA2010AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571789904;
        bh=ZxF80hLmpS4odHnXd8DZjntedVTyJ3tH1vjLMOXe8os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQfxB7Rh3YN88VbtVbjqd7vP5nGaCHsKqZgVYm3tXgm6uFu/1QF1Ovv9OhP0f3I2B
         3HOdT/Yjw3cGFebSmHU3Z17BB34MGPkkotsW/fghalngocZmk/mHAat/sfsasfq1qg
         W2JfR9lx+ZSRtYHRaRFTv+7GG2IomNjKpwzRHpIA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v1 1/6] KEYS: Helper function to check if the given keyring is builtin_trusted_keys
Date:   Tue, 22 Oct 2019 17:18:13 -0700
Message-Id: <20191023001818.3684-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helper function to check if the given keyring is
the builtin_trusted_keys keyring.

This function is used by ima to determine if a key is
added to the builtin_trusted_keys keyring.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 certs/system_keyring.c        | 5 +++++
 include/keys/system_keyring.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 1eba08a1af82..5533c7f92fef 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -283,3 +283,8 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+inline bool is_builtin_trusted_keyring(struct key *keyring)
+{
+	return (keyring == builtin_trusted_keys);
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c1a96fdf598b..2bc0aaa07f05 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -66,4 +66,6 @@ static inline void set_platform_trusted_keys(struct key *keyring)
 }
 #endif
 
+extern bool is_builtin_trusted_keyring(struct key *keyring);
+
 #endif /* _KEYS_SYSTEM_KEYRING_H */
-- 
2.17.1

