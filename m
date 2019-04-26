Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AB5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED04208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqQF5uy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfDZPdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:33:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35180 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDZPd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:33:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so1758253plp.2;
        Fri, 26 Apr 2019 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk9nZS7LGFvUdGAy8fxGcY6/ybb9v25OpTL3KOWjoH8=;
        b=EqQF5uy7qsW0PGF1LkdXZzoEGDoVfFmOhfiDFjurvJUy5ghsp+rFXx4M+07H7fIRXy
         2eEP6LWttmqm3zpkstc/yD+n9evDEZQ81LeBKgROOLzXQnxMvH4e9IYtwBDdvnzt5wlP
         NnM2LF9r/phBCN+MZmIGZnlmBnpibDLgQkZiJi4DrCSuaMV6eNIcs4OkYDdicC0r6wO9
         qSXLj30kOkzooPcFcn815oOR8cpViIhor4i1IdXEgWDB93BinDFkjUWqyc1guZWaMvVE
         uzwNfKbZx7rK26g+7SzjYbkWotDRjbVY02XqrRJxPZDWlVc+IH64Hygm/oFzygadq96p
         LSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk9nZS7LGFvUdGAy8fxGcY6/ybb9v25OpTL3KOWjoH8=;
        b=UCB5a2COh0ww5We7NH1CThKSy5Rl5uXZ9AZ2CLheBI3Q6ePqz74WPjGjIlbMlHN7D4
         MM7Heg/utUG0eWjYQzEC9MYd1IOsQmRdcpFwSLRfUDutt2qTa7PdLQvkXNYnHs9RGMMv
         y/F5HzuwWBZp3xj+pXRE/bNt10xBeR7QX6xLGqB83SQ0Y5/FpDRzmJ8evn1bjUWGCVDc
         Hs22CJBK3KTlyEXF+/eYo642cZ2W9ADmfvSThiwq5NhtuziXzigpxR4o5QkB5julsK6c
         9W0c5IszEkh7+muuxUaLJO4wRwYS//Qq0cUX6vcKh9/mbNthVtOqGzsnolnSY5Eg5meb
         sLlw==
X-Gm-Message-State: APjAAAUeDILpjeKYye16oa3I3lLZ3irAXPIR2+M5Et0vJJZS3ycNX1uk
        s85KI0zuwxas76icljuR5Aq5OS7A
X-Google-Smtp-Source: APXvYqxoonTp3pjZZeHZUhcR5IM0oxIevA7h4d38raQjkDOE5t9MRwCdWaMYO/oqeoIpIdbr5/n4bw==
X-Received: by 2002:a17:902:29e9:: with SMTP id h96mr27827612plb.258.1556292809152;
        Fri, 26 Apr 2019 08:33:29 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:33:28 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 14/27] Documentation: x86: convert amd-memory-encryption.txt to reST
Date:   Fri, 26 Apr 2019 23:31:37 +0800
Message-Id: <20190426153150.21228-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
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
index 20091d3e5d97..a0426ab156bd 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -20,3 +20,4 @@ Linux x86 Support
    pat
    protection-keys
    intel_mpx
+   amd-memory-encryption
-- 
2.20.1

