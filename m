Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA472C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887CE205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330029;
	bh=ZiDI3Dt5mYEtv9kuG8rDQe8/ZVaAN+P6S4mZU5ltY+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K68193ZClxTCOblUMYYnUmouNKsmvgzXlSUT7OJkqpgT0TzxZtlZrlycaDo0PFiN+
	 wBdYRbXDJp0j2nZpTwCLM5sIfBwMKDnGIgj5chc9OTK8216POhaAU43GG3iza2TCKC
	 +Iv+4CMpgIAMHDadcBFRjibjQ5lk+lpMG+cFgkGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfD0Bxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfD0Bj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 747DF214AE;
        Sat, 27 Apr 2019 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329198;
        bh=ZiDI3Dt5mYEtv9kuG8rDQe8/ZVaAN+P6S4mZU5ltY+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nr59P8JDPYtQx1ekfq8BtYjkWCApCciE8ch9qdXk9kNiFXwdUilsPLBX3+9TzX+0V
         e4ViaPstuEuz8d/Yd6jelA8+se7ANhHnNQRBPbY7RGJdGfrFdL9hsRydYCGeLMtZCu
         eWRpG1TDZfY9uk7UNmexXPIVO2Lk7JacmX0wygPk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 52/79] KEYS: trusted: fix -Wvarags warning
Date:   Fri, 26 Apr 2019 21:38:11 -0400
Message-Id: <20190427013838.6596-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "ndesaulniers@google.com" <ndesaulniers@google.com>

[ Upstream commit be24b37e22c20cbaa891971616784dd0f35211e8 ]

Fixes the warning reported by Clang:
security/keys/trusted.c:146:17: warning: passing an object that
undergoes default
      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
        va_start(argp, h3);
                       ^
security/keys/trusted.c:126:37: note: parameter of type 'unsigned
char' is declared here
unsigned char *h2, unsigned char h3, ...)
                               ^
Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
standards explicitly call this out as undefined behavior:

The parameter parmN is the identifier of the rightmost parameter in
the variable parameter list in the function definition (the one just
before the ...). If the parameter parmN is declared with ... or with a
type that is not compatible with the type that results after
application of the default argument promotions, the behavior is
undefined.

Link: https://github.com/ClangBuiltLinux/linux/issues/41
Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
Suggested-by: David Laight <David.Laight@aculab.com>
Suggested-by: Denis Kenzior <denkenz@gmail.com>
Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/keys/trusted.h  | 2 +-
 security/keys/trusted.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/keys/trusted.h b/include/keys/trusted.h
index adbcb6817826..0071298b9b28 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted.h
@@ -38,7 +38,7 @@ enum {
 
 int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned char h3, ...);
+			unsigned char *h2, unsigned int h3, ...);
 int TSS_checkhmac1(unsigned char *buffer,
 			  const uint32_t command,
 			  const unsigned char *ononce,
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 4d98f4f87236..94d2b28c7c22 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -123,7 +123,7 @@ out:
  */
 int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned char h3, ...)
+			unsigned char *h2, unsigned int h3, ...)
 {
 	unsigned char paramdigest[SHA1_DIGEST_SIZE];
 	struct sdesc *sdesc;
@@ -139,7 +139,7 @@ int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 		return PTR_ERR(sdesc);
 	}
 
-	c = h3;
+	c = !!h3;
 	ret = crypto_shash_init(&sdesc->shash);
 	if (ret < 0)
 		goto out;
-- 
2.19.1

