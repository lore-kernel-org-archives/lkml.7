Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA039C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700FE2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkLWdaWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEBHK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:10:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42935 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfEBHK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:10:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id 13so370618pfw.9;
        Thu, 02 May 2019 00:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NC8m/jDpU0Uzaq9jOe9QnHWhLNtfwXpLgED1uBMCHW4=;
        b=hkLWdaWrxraY8lEyxYHiSBkSU0z0lBlDRT1xqzK5Maz72AgpeG2UWtXdmI1grfvxJ1
         uNhMvp5wGSoOQATtjuUeuCUtXpIEkK7lyhgH9eFmw80+uXQfRNYqdBc+E1gwLLe9yudf
         klNYflD1S1rzARsYq62GY97HrsRPfk/mHfnyRCFIzIk/CMkaQehr0lEzvfhOEX/avYwR
         wnNg3YcDiueVrkBSEcVn1L4VymT24LZzWGMd43sUACQ02A+t2dt5TegErlZ1BRaznqd9
         kevYCYoHoRcVGouQH9uJoydLWzW4o2wgpSfkjowvG28oKVWVVAFXAzcP/NlkGccEkWIy
         390w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NC8m/jDpU0Uzaq9jOe9QnHWhLNtfwXpLgED1uBMCHW4=;
        b=QYl0NYhO5gwrUyZCF4thzIi8eIhqivVA7D0FRWi35soSe/doVvD8JAea8gvXIQ5zE4
         4WYofqY+5Eu4Onc+K3FeD9f/Y6Rj5/rJ6rX8R/w24NGkpmxk2mTGceA3BrzRUH6oxwd9
         AO3ISvh2pcWZ6u6z3yfAmmyQPnm6ZgESBJppRYLWPv8etIqFEg+h5iX1USiyYglvpYes
         w5htw0VBmzTfEOTuM4aKD6pJx8YNLrp3PvlSl8bYP/HBv3veut109BExlUbgq7Vghv2q
         1VOU7znmvVoPoJfXbpG3a4y6cn94yles/CWqqP/bX+yr79RlGCPFr4GkCXwPNXvgQyqp
         WV4g==
X-Gm-Message-State: APjAAAXnkMzkoZEptCxoAwXCiFv8OG32yPG+KGf966jE64TOn1Ilf36g
        s0RdmqWsXrBlnTpGAdg0+tQ=
X-Google-Smtp-Source: APXvYqwc2vJKnaJal1+JnFLru+jxJvvEHqBGpLl4ugClbGsQv15AzZ69XuUL+6XyQnORfF6Z/hDGLA==
X-Received: by 2002:aa7:8851:: with SMTP id k17mr2426888pfo.121.1556781057607;
        Thu, 02 May 2019 00:10:57 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:10:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 14/27] Documentation: x86: convert amd-memory-encryption.txt to reST
Date:   Thu,  2 May 2019 15:06:20 +0800
Message-Id: <20190502070633.9809-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
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

