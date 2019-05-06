Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C731AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976422053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV13cYWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfEFRLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:11:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46933 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEFRK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:10:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id t187so2637629pgb.13;
        Mon, 06 May 2019 10:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NC8m/jDpU0Uzaq9jOe9QnHWhLNtfwXpLgED1uBMCHW4=;
        b=cV13cYWUy3iY7w3QWmjVqCZ0wqwflzohqli4qJdrYAr/odBZuBSQudVyLnawz9ZJDM
         w0r5XSkY1cIuJjx3tw4xhR/j5LUSGUzO0xTIjjdWm9WlmpqZFpTLy0sbac4P7Xg5M02z
         +oGKM7jMnK1Y764mRtwYZCYZAkitWKUFtlTTOmu1C985taJSzve4vt/QJL75iYdJjolF
         LtsiL69jY6s+fTAxgfi5lyhRQGn9k8Nl5EiSHKvOEyMQSFT4Sy4e0wXsQHOxCv48/qFY
         j9jajwJYfUKllpbpXkn7XkNTpcGQWXSMjVDvePBxBhqXCTuRBdqh/Wx/xr24T1KnRsRA
         aUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NC8m/jDpU0Uzaq9jOe9QnHWhLNtfwXpLgED1uBMCHW4=;
        b=ZqONdrkcSJH/3wQGoUff0iYF/WyUiDZ+BmnDqUMrGCTegQALRYPH+GyhQ095FND5CO
         1aWqi0kBdmg7xMFXo58IPO4ccCphSIvuPtGwB8oee9RLwsFE8hVNl3U8Kr4Pg6sT111P
         vjAWOk0i/QmtbqAmvTUTKORAb3Tx0rN3ogNimg3kGgTsRIsqa8xHybNImkjK3wj36Ip8
         NhK3ZkMg9XDDc2S2AyrU8n/DwzYd9RX6NJNWPitk+K/5lMUhfweIQxlrVWT4e+EJ603K
         qW+8Da5hzZHw1PNTfVqIAvnizJZk8tz6XmFcJ/ECOkwgeCopgNSfdt4rOy7AzOnROp5t
         zSgQ==
X-Gm-Message-State: APjAAAUiPi2nWnFUH2sknJEmrWmIeYnBGjSCcpd9jWMI2l9uAbZneYq5
        /3AKDe4mMD2kiX4FWCn0JLw=
X-Google-Smtp-Source: APXvYqz7HOX8CKfHLWxJixaaV8zCs3fD6FjWBrUH3N92BEcaeCifE8CkHNMjR8pBxgapbfWXYoPkvQ==
X-Received: by 2002:a63:d756:: with SMTP id w22mr5414127pgi.382.1557162658166;
        Mon, 06 May 2019 10:10:58 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.10.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:10:57 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 14/27] Documentation: x86: convert amd-memory-encryption.txt to reST
Date:   Tue,  7 May 2019 01:09:10 +0800
Message-Id: <20190506170923.7117-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506170923.7117-1-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
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

