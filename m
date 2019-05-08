Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1C3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD1F20644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oidDpitR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfEHPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:23:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41052 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfEHPXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:23:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so6563314pgp.8;
        Wed, 08 May 2019 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NC8m/jDpU0Uzaq9jOe9QnHWhLNtfwXpLgED1uBMCHW4=;
        b=oidDpitRVmgKwgxpVrAvewjUoX++MpTvVkSTasmiEb4Lu4LRHvJGfTkZIMsLhT2agv
         GaNxvXp20nOj5yQGItn/pKRZNBtVc6+bBQX6fN2cB8EeR2HZVOFZVdrYOOblC/1mJQ5P
         AAV5z2hGjLL8mjY9jimCTx5oChjafQzCjoRiX1EbHIRFO15sKlHFfqEmvy5meUtfL2uV
         FK8Feex2mrM2gp0IBHxbwAHM4efrXCEC6pWtcbI/2eM/MgUfhJRMqg/Ba+kjSanp5WpE
         eGiMDDClFaRXcENULoWvfoOe5RTQ+tZ8XvLHjUB/vTlkBIOqzNfA89/jZWtFFaKzBTWA
         TCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NC8m/jDpU0Uzaq9jOe9QnHWhLNtfwXpLgED1uBMCHW4=;
        b=WUNLn82XQ/CAjYR24SXFiCpc1g0TTdqM2jOFXnzXXj2iKoBXuOrMGeC2EYK/cPcJPG
         /cIVDRTD800GyCIUnTa2gB6wLoO/EDz3zMslNTZ+6edNaDC7h+I2MbhRP4eTxlfNRYGQ
         7o9AY80MuP1vtKSBIAcJZKgQs16g1kHXtNS3vogNu98dyFVNiemAYpsp5JFnoJSAZD97
         Wp0VcNWkFZR5SC2CdSDvgrJ9BcO0zAailigxMgT9Gzt/gNWyM6lCjDzKekHLovTw8MG7
         m4H22LKhpNM+suJF4B2PZYgVJRnnw8XQcEdUPvUjpe7h8w2QYEMpS1CXbBpzBUs27nfN
         qYoA==
X-Gm-Message-State: APjAAAWWPX8IeHxrFgVXl0U6Dgx9jJJAbJs3oGa5LCTKzYY/FM2AIezR
        MbY0xD9R+WkMhzoQipzHQcs=
X-Google-Smtp-Source: APXvYqyN6bbxcHzgbdpNM6+O5qrEfDa6dwhQn3zxE+eXOlk3FXjT8dEB6EOpaieIWqeO7u+OD69s5Q==
X-Received: by 2002:a63:1d4f:: with SMTP id d15mr46128975pgm.347.1557329009468;
        Wed, 08 May 2019 08:23:29 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.23.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:23:28 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 14/27] Documentation: x86: convert amd-memory-encryption.txt to reST
Date:   Wed,  8 May 2019 23:21:28 +0800
Message-Id: <20190508152141.8740-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 ...ory-encryption.txt => amd-memory-encryption.rst} | 13 ++++++++++---
 Documentation/x86/index.rst                         |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)
 rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)

diff --git a/Documentation/x86/amd-memory-encryption.txt b/Documentation/x86/amd-memory-encryption.rst
similarity index 94%
rename from Documentation/x86/amd-memory-encryption.txt
rename to Documentation/x86/amd-memory-encryption.rst
index afc41f544dab..c48d452d0718 100644
--- a/Documentation/x86/amd-memory-encryption.txt
+++ b/Documentation/x86/amd-memory-encryption.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+AMD Memory Encryption
+=====================
+
 Secure Memory Encryption (SME) and Secure Encrypted Virtualization (SEV) are
 features found on AMD processors.
 
@@ -34,7 +40,7 @@ is operating in 64-bit or 32-bit PAE mode, in all other modes the SEV hardware
 forces the memory encryption bit to 1.
 
 Support for SME and SEV can be determined through the CPUID instruction. The
-CPUID function 0x8000001f reports information related to SME:
+CPUID function 0x8000001f reports information related to SME::
 
 	0x8000001f[eax]:
 		Bit[0] indicates support for SME
@@ -48,14 +54,14 @@ CPUID function 0x8000001f reports information related to SME:
 			   addresses)
 
 If support for SME is present, MSR 0xc00100010 (MSR_K8_SYSCFG) can be used to
-determine if SME is enabled and/or to enable memory encryption:
+determine if SME is enabled and/or to enable memory encryption::
 
 	0xc0010010:
 		Bit[23]   0 = memory encryption features are disabled
 			  1 = memory encryption features are enabled
 
 If SEV is supported, MSR 0xc0010131 (MSR_AMD64_SEV) can be used to determine if
-SEV is active:
+SEV is active::
 
 	0xc0010131:
 		Bit[0]	  0 = memory encryption is not active
@@ -68,6 +74,7 @@ requirements for the system.  If this bit is not set upon Linux startup then
 Linux itself will not set it and memory encryption will not be possible.
 
 The state of SME in the Linux kernel can be documented as follows:
+
 	- Supported:
 	  The CPU supports SME (determined through CPUID instruction).
 
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index b5cdc0d889b3..85f1f44cc8ac 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -20,3 +20,4 @@ x86-specific Documentation
    pat
    protection-keys
    intel_mpx
+   amd-memory-encryption
-- 
2.20.1

