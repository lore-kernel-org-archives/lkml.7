Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36647C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD63206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8WZqaHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfFMPeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:34:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41697 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfFMKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:32:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so11056624pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zAP35FMwIaJoHRTsWTgqlS+4eqrXf3lXTLZsbBgKALU=;
        b=I8WZqaHuq/yhoMfw5I5pMLLVxm8cNFa61hNwQ8JLEMlCB8EUyJDcawmklBfvxhPYCl
         5QfsPIYKqAlH9CKbXYD8qGVKPqgYgYNL5qFGx11M2gg4jknzMJ2je5vQxiIEo2GWD5G/
         RxhSDlH9Q9RQ/EG0N/XQAWCefLd9GHdFP0Ho9vndyKfvJW/F0y6GH3rSRSR/oA8ric1P
         KaJ5iam2I3ar+sVxc5p9E9Bfv94xReZjTfPJhJnUezS8g8jb+A8kp0qWVI4luHG7wWWh
         PrG1F5qZGOs5QlF8Jcng3xBuK+0z2rvPRMRUkxRXs3sbtmIRmZNB6mWw8sVkKHcVmOb8
         uK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zAP35FMwIaJoHRTsWTgqlS+4eqrXf3lXTLZsbBgKALU=;
        b=lNZH9B09WWvuKNAgVCyVk+Xiys5O+I7GZe0oNIkewNUWFp9STItt8d8VeN0NecczEf
         Dufvukn8D25B/GvQfDhCPHhZLf1z9LOXfmIqWyzvGARLaauBOfnOvFo/TTwLdOanieid
         x1f9FEKtLK5na4zwGIP2M5i5YACXcyqgAv7fMLR6lMFufJC3Vx4Kk8sT4+Dnpswi6OEz
         U2LGsF4R7R3GFJIsYBWMf6yXW0aHO9u8OSBrFUM9ITKoU4H/NLFoe+f2Vx2hBR0k5WCB
         XdysATJXc1IpemO9TdwZSDfb9uMliyhNW4KpTpFXScrnAhTB5xNQfwyILe34gAkHg8BL
         0Jog==
X-Gm-Message-State: APjAAAV2SOOWiXxqNnB7vxWSoCUH5RxbX3HjtCeo6L242LPkPcQ7Bo79
        VToP4XmdQ+Zqye2z2dOntKoEKA==
X-Google-Smtp-Source: APXvYqy9ZWJWVG2HSV4XCNQ97i8SPNUISZ00sFzqKzjXi5CJzuVmgDH7W765D0LXzkPhO24L9HPVDA==
X-Received: by 2002:a17:90a:2525:: with SMTP id j34mr383810pje.11.1560421945985;
        Thu, 13 Jun 2019 03:32:25 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:32:25 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 5/7] KEYS: encrypted: Allow TEE based trusted master keys
Date:   Thu, 13 Jun 2019 16:00:31 +0530
Message-Id: <1560421833-27414-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow search for TEE based trusted keys to act as master keys in case
TPM device is not present.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 security/keys/encrypted-keys/masterkey_trusted.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index c68528a..cfac27f 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -23,6 +23,9 @@
  * Trusted keys are sealed to PCRs and other metadata. Although userspace
  * manages both trusted/encrypted key-types, like the encrypted key type
  * data, trusted key type data is not visible decrypted from userspace.
+ *
+ * Also, check for alternate trusted keys provided via TEE in case there
+ * is no TPM available.
  */
 struct key *request_trusted_key(const char *trusted_desc,
 				const u8 **master_key, size_t *master_keylen)
@@ -31,8 +34,11 @@ struct key *request_trusted_key(const char *trusted_desc,
 	struct key *tkey;
 
 	tkey = request_key(&key_type_trusted, trusted_desc, NULL);
-	if (IS_ERR(tkey))
-		goto error;
+	if (IS_ERR(tkey)) {
+		tkey = request_key(&key_type_tee_trusted, trusted_desc, NULL);
+		if (IS_ERR(tkey))
+			goto error;
+	}
 
 	down_read(&tkey->sem);
 	tpayload = tkey->payload.data[0];
-- 
2.7.4

