Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D96C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B9420645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjovT+sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfDWHjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:39:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44921 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDWHjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:39:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id y5so7956290qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iqNLDX+FI8AN/XsgRv/2WERG/OrpPSckCjXExlYZk28=;
        b=IjovT+sM086kF7tCxEfIYNuKIAuGLNHaazMrV43Ou/fxRZssFuJdn6/PCMNvXAkQAc
         Yrva2HettC0PghB3duyV1TZ4G2K7tlBnaFOUHzLtUGIW3/3DhW035643QWJaejocBUZX
         btCZuDzj13M0FdhWqjU6WBoNiyAsSVblun8/YewXu8X6BM2enQRSVpYp08EEBh8TYtW3
         fNdHUQkWCQrsMHWK67EE2JXcDkYRyBmyQq+siKkPnTloDoSZitH7ussa1751CwyWSCmm
         gTaVss65cfClIO4UqV/uielPJvcrFh1v+ze9YDRPVn9n9qFHAq5W0N/PLClF8XactOWP
         MW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iqNLDX+FI8AN/XsgRv/2WERG/OrpPSckCjXExlYZk28=;
        b=steEXAIhGOeh5dxqiruPpxnI5gO7Ul7D0NWMBwJXYJZOLmzSpsyQePUCottcZubCLK
         AkwaJipuBIYHG0ZNZJ2zkFxarhPw4HeBVoOojZETlCBTJChhSZQ7RRy4NavUSfRvApMe
         KyqT5gpigji8VZiTVTeW/13mg7H+tCJbDFRlF1cikgZThCBTNOdErUnwz37zfSpMsWIz
         n50FDZZSw1pcugxgi0vKjWQZ30kOuMgdBGm4BkQi6YWzsk1jZeymWfBpZLWs1r2Hmz40
         UwWyA9Upu7hYdFTlz8EMOaeUGx1V7r+XGT6G5MMCPgEmmQhSqMkdObRnIVg24riRq8OQ
         j0kw==
X-Gm-Message-State: APjAAAVo7iwEhtQ3dUyJQBkZ+ewPzVbdsfp7WkabpzP8O6pLpvJqoikT
        lKeb23ZdayYYyAo9g8Q3pO8=
X-Google-Smtp-Source: APXvYqxIF7d3N00C/noe7sjNZJlYtKST4Kcy090a0LsmjT5Qrw1HZ4CiI+uG5xRZN+Ai/byG7M0SDA==
X-Received: by 2002:a37:4ad4:: with SMTP id x203mr17812818qka.21.1556005191237;
        Tue, 23 Apr 2019 00:39:51 -0700 (PDT)
Received: from ip-172-31-41-192.ec2.internal (ec2-34-234-71-227.compute-1.amazonaws.com. [34.234.71.227])
        by smtp.gmail.com with ESMTPSA id v54sm3432282qth.19.2019.04.23.00.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 00:39:50 -0700 (PDT)
From:   Robert Holmes <robeholmes@gmail.com>
To:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Holmes <robeholmes@gmail.com>
Subject: [PATCH] KEYS: Make use of platform keyring for module signature verify
Date:   Tue, 23 Apr 2019 07:39:29 +0000
Message-Id: <1556005169-4139-1-git-send-email-robeholmes@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch completes commit 278311e417be ("kexec, KEYS: Make use of
platform keyring for signature verify") which, while adding the
platform keyring for bzImage verification, neglected to also add
this keyring for module verification.

As such, kernel modules signed with keys from the MokList variable
were not successfully verified.

Signed-off-by: Robert Holmes <robeholmes@gmail.com>
---
 kernel/module_signing.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 6b9a926fd86b..cf94220e9154 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -49,6 +49,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
 	size_t sig_len, modlen = info->len;
+	int ret;
 
 	pr_devel("==>%s(,%zu)\n", __func__, modlen);
 
@@ -82,8 +83,15 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	}
+	return ret;
 }
-- 
2.20.1

