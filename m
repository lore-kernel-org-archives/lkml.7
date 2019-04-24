Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BE4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49752084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOvW8ubk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbfDXO76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:59:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36950 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbfDXOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id c1so10972399qkk.4;
        Wed, 24 Apr 2019 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fJTIaOdIev9BvM0qLvdFANKPpc3+WTqSLnBkM7F83AI=;
        b=oOvW8ubkWk2zvyg6CR9WdAJwduqcG+xrzkJcyQNxTwJA9eySoQr3fgzasvV8EPl2n6
         XOagzdR//evGDFQiDfVB7aIsZjvBR5X1K/uavNmMm2eKP5f6lIEzzPYORZl44Um8hAhn
         Yyhn8quMRdGpvBYaj42U3S3ABmFcsmmGmzjpkfAZ0yK46qrBF4gvvpsThAAGUG+zUsUw
         sPInAUxkvRJBMZHFR7Mc/7NBpTBYsf8OeBqs+Vfc9MvcdztPCP2sLPQqoIi/kd7lyVD7
         dr5ZHhw5o5ICrL7zdnkapRPh8MqsCXgzsY8Rew4puCf0AjUva9k1D8u3cMJ5JqabwYuZ
         rrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fJTIaOdIev9BvM0qLvdFANKPpc3+WTqSLnBkM7F83AI=;
        b=ggthkLXxCFFjAK95F/qoTjU5p61UicWjV6djbvcQ0LuxzJM30tiUkWG+R/nqfcp04A
         ZWrde5KRr8Hv5YO3tsVNd8B7y423lWL9bTcDXktg4w0N6bVMuSfkUJJVazqICiVTUdLd
         Ic5lJc5kbcioGNbNqhzc0gnvVKkihBqjIm6Sq7pX8XuvEdP9GiED78iJT8HeQygOGFWE
         zi2BGjsT6V7c+1pGytwe7xafYTZTVS2bk7Zjtllwg/Ea6bWnSrTr9RAhhXj9hH5IawZS
         AG2wTQuItjjyDS4gLRvjIPFe1ebH+hi+FwrR0LOcH8ktApI1wSOqOGWj8Cm3RiyFIg+1
         q3Ag==
X-Gm-Message-State: APjAAAUydMqKx09hWupfpLRhcw1E4butQk+jyNvWNcYgjBfAESSXGyX0
        SpamQbFsTttOy+GYfjyt03Hzf9HOxGh+CME7
X-Google-Smtp-Source: APXvYqwAEZCpIIEccuDT7fNLpcOSWVO6SLXykyuHAICGLODiGnUdL4cujp+1G+/Mf25r7kYK6lilpg==
X-Received: by 2002:a05:620a:138a:: with SMTP id k10mr23943391qki.188.1556116441686;
        Wed, 24 Apr 2019 07:34:01 -0700 (PDT)
Received: from ip-172-31-41-192.ec2.internal (ec2-34-234-71-227.compute-1.amazonaws.com. [34.234.71.227])
        by smtp.gmail.com with ESMTPSA id z3sm2581825qkc.76.2019.04.24.07.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 07:34:01 -0700 (PDT)
From:   Robert Holmes <robeholmes@gmail.com>
To:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Holmes <robeholmes@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] KEYS: Make use of platform keyring for module signature verify
Date:   Wed, 24 Apr 2019 14:33:51 +0000
Message-Id: <1556116431-7129-1-git-send-email-robeholmes@gmail.com>
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
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: stable@vger.kernel.org
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
2.21.0

