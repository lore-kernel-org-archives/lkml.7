Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A2EC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F055206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbiyr6oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfG3MZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:25:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37909 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbfG3MZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:25:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so21165059pgu.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihVno30NiTJ4nXlPwk0p1JArXGGwnpn9XYnN+QyiMz4=;
        b=qbiyr6oe9qmKjEI/E2pv/fDSjK/fIiWbv00GPWqkaY7IeiYE3b93IixfbKgrbfOki4
         TKD9IEJlrA1TANkylWk2FpXKR6F1NYac7MjvuQH0ePRjZXsDj5u1NMDXKTKJ8apiLru+
         H1UmLUZhxay6j2lrbQeVp1PPfhxGTe4BYfbu07PKWrQJyOCerjM4U6lHiVMBOixJhlKz
         mZtYAZwHgvnITkIA3MnfqHcC0lDX2Fb3uW9K3OsNn5mt7dlLXuCpoHG9etCaZ+IWoc92
         RQtiGHprKKQqEFEkbz4b2fCaojhnl4idmkaR7k+HPZ3TMHUTAX0MuFD8tqHBqJ3HvCv+
         e4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ihVno30NiTJ4nXlPwk0p1JArXGGwnpn9XYnN+QyiMz4=;
        b=RlHr8NtGrjZb1JZfVAiaLn8Ra2E/fIrbbUclHJiqo80UMz89nl6X3bBYM0DRvacTJw
         cXQgesNU7LXeF59Qm8LCRSdc8DO/cOovgKIVL0VdN7M2HJueD2xVcUaGD3BMhOxIfJxs
         ANiCA9UmLJMIAjluYlRQ8Vjirt9ZnFHuDlOc79SNfnU9Oi5WwymnFbmd1nA75UYd98yD
         W6J1ItMZK7MSEazsWVXWBltwF3rDJG+rxKSyo19hatikm/jJrtT7abKiKsS6EsU149xk
         gsIVRyJFfz9g0ineqXFu2Ebes64Fai3Xhl63WGli6uq/9N7hvVE7LjhlkoOLvhDtUGmS
         yNtA==
X-Gm-Message-State: APjAAAVloTEu7AyfMqDmpfj7C6Az4MsyaQIyo/LEebRMHAWVAqM6pnyf
        f3e3TaTt1z8UqRLI2AtgO88P8g==
X-Google-Smtp-Source: APXvYqzBpML/+RG6mX83dkrKgyogoRedECvKNQJNISkarkVtJCD+BTonb8A1Odg1bhwhsgBxg6rmqw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr43312932pfc.110.1564489506754;
        Tue, 30 Jul 2019 05:25:06 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id v8sm54895462pgs.82.2019.07.30.05.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 05:25:06 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC v2 5/6] doc: keys: Document usage of TEE based Trusted Keys
Date:   Tue, 30 Jul 2019 17:53:39 +0530
Message-Id: <1564489420-677-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide documentation for usage of TEE based Trusted Keys via existing
user-space "keyctl" utility. Also, document various use-cases.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/security/keys/index.rst       |  1 +
 Documentation/security/keys/tee-trusted.rst | 93 +++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/security/keys/tee-trusted.rst

diff --git a/Documentation/security/keys/index.rst b/Documentation/security/keys/index.rst
index 647d58f..f9ef557 100644
--- a/Documentation/security/keys/index.rst
+++ b/Documentation/security/keys/index.rst
@@ -9,3 +9,4 @@ Kernel Keys
    ecryptfs
    request-key
    trusted-encrypted
+   tee-trusted
diff --git a/Documentation/security/keys/tee-trusted.rst b/Documentation/security/keys/tee-trusted.rst
new file mode 100644
index 0000000..ef03745
--- /dev/null
+++ b/Documentation/security/keys/tee-trusted.rst
@@ -0,0 +1,93 @@
+======================
+TEE based Trusted Keys
+======================
+
+TEE based Trusted Keys provides an alternative approach for providing Trusted
+Keys in case TPM chip isn't present.
+
+Trusted Keys use a TEE service/device both to generate and to seal the keys.
+Keys are sealed under a hardware unique key in the TEE, and only unsealed by
+the TEE.
+
+For more information about TEE, refer to ``Documentation/tee.txt``.
+
+Usage::
+
+    keyctl add trusted name "new keylen" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+"keyctl print" returns an ascii hex copy of the sealed key, which is in format
+specific to TEE device implementation.  The key length for new keys are always
+in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
+Examples of trusted key and its usage as 'master' key for encrypted key usage:
+
+More details about encrypted keys can be found here:
+``Documentation/security/keys/trusted-encrypted.rst``
+
+Create and save a trusted key named "kmk" of length 32 bytes::
+
+    $ keyctl add trusted kmk "new 32" @u
+    754414669
+
+    $ keyctl show
+    Session Keyring
+     827385718 --alswrv      0 65534  keyring: _uid_ses.0
+     274124851 --alswrv      0 65534   \_ keyring: _uid.0
+     754414669 --als-rv      0     0       \_ trusted: kmk
+
+    $ keyctl print 754414669
+    15676790697861b422175596ae001c2f505cea2c6f3ebbc5fb08eeb1f343a07e
+
+    $ keyctl pipe 754414669 > kmk.blob
+
+Load a trusted key from the saved blob::
+
+    $ keyctl add trusted kmk "load `cat kmk.blob`" @u
+    491638700
+
+    $ keyctl print 491638700
+    15676790697861b422175596ae001c2f505cea2c6f3ebbc5fb08eeb1f343a07e
+
+The initial consumer of trusted keys is EVM, which at boot time needs a high
+quality symmetric key for HMAC protection of file metadata.  The use of a
+TEE based trusted key provides security that the EVM key has not been
+compromised by a user level problem and tied to particular hardware.
+
+Create and save an encrypted key "evm" using the above trusted key "kmk":
+
+option 1: omitting 'format'::
+
+    $ keyctl add encrypted evm "new trusted:kmk 32" @u
+    608915065
+
+option 2: explicitly defining 'format' as 'default'::
+
+    $ keyctl add encrypted evm "new default trusted:kmk 32" @u
+    608915065
+
+    $ keyctl print 608915065
+    default trusted:kmk 32 f380ac588a925f488d5be007cf23e4c900b8b652ab62241c8
+    ed54906189b6659d139d619d4b51752a2645537b11fd44673f13154a65b3f595d5fb2131
+    2fe45529ea0407c644ea4026f2a1a75661f2c9b66
+
+    $ keyctl pipe 608915065 > evm.blob
+
+Load an encrypted key "evm" from saved blob::
+
+    $ keyctl add encrypted evm "load `cat evm.blob`" @u
+    831684262
+
+    $ keyctl print 831684262
+    default trusted:kmk 32 f380ac588a925f488d5be007cf23e4c900b8b652ab62241c8
+    ed54906189b6659d139d619d4b51752a2645537b11fd44673f13154a65b3f595d5fb2131
+    2fe45529ea0407c644ea4026f2a1a75661f2c9b66
+
+Other uses for trusted and encrypted keys, such as for disk and file encryption
+are anticipated.  In particular the 'ecryptfs' encrypted keys format can be used
+to mount an eCryptfs filesystem.  More details about the usage can be found in
+the file ``Documentation/security/keys/ecryptfs.rst``.
+
+Another format 'enc32' can be used to support encrypted keys with payload size
+of 32 bytes.
-- 
2.7.4

