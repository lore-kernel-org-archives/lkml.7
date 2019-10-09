Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90019C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBE820659
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570664655;
	bh=ttUVmrIzuf0w22zjSvNcVAQBL4zgFKEq3DaArSdKV2Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=evP25ublzzUSJrGGYYF1d4FPpw8o9n9qzDbCNdF5EMzfZSPVXqjjZVsX80q003Sdy
	 SgWoBbsIb+cR8pNqpezFSg+ESLYGdMgUkP+KZOfKsD6OiPD2gYGPA54TVkYr0qvL11
	 k/jbEeHvdjSwBh36fPenxeiSB0CF7oji86Xdc5dY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfJIXoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbfJIXoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:14 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653C120659;
        Wed,  9 Oct 2019 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570664653;
        bh=ttUVmrIzuf0w22zjSvNcVAQBL4zgFKEq3DaArSdKV2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=v/OYP3CyOlLnK2h3sAFmFUGU3iqw5O5dngP0EVdfJjPUZ/ArystkmFd08w34mNqSz
         pjiomgybOGYsjelIiBb3dYzL6k9NlbeQIHJ7JfQdKraMPjd1qngnEmM3MMI0nz26Mc
         4YdJTHcNq5ANvLpldLMsgV9LJAN6GWGIfFbZnkLc=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fscrypt: avoid data race on fscrypt_mode::logged_impl_name
Date:   Wed,  9 Oct 2019 16:43:37 -0700
Message-Id: <20191009234337.225469-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The access to logged_impl_name is technically a data race, which tools
like KCSAN could complain about in the future.  See:
https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE

Fix by using xchg(), which also ensures that only one thread does the
logging.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keysetup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 8eb5a0e762ec6..df3e1c8653884 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -81,15 +81,13 @@ struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
 			    mode->cipher_str, PTR_ERR(tfm));
 		return tfm;
 	}
-	if (unlikely(!mode->logged_impl_name)) {
+	if (!xchg(&mode->logged_impl_name, true)) {
 		/*
 		 * fscrypt performance can vary greatly depending on which
 		 * crypto algorithm implementation is used.  Help people debug
 		 * performance problems by logging the ->cra_driver_name the
-		 * first time a mode is used.  Note that multiple threads can
-		 * race here, but it doesn't really matter.
+		 * first time a mode is used.
 		 */
-		mode->logged_impl_name = true;
 		pr_info("fscrypt: %s using implementation \"%s\"\n",
 			mode->friendly_name,
 			crypto_skcipher_alg(tfm)->base.cra_driver_name);
-- 
2.23.0.581.g78d2f28ef7-goog

