Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC0C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6060217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="BRLtr4tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfGaPJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:09:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33637 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388574AbfGaPIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:08:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so2524898edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2C449KSjT4bbSwYYn5oh0t+GvJgUUHqBrjpFSTJaVMM=;
        b=BRLtr4tgYn50QM+JIDHN/iYJHDA/eYrOUmJYvQptXTzwrBNdmFzt8zjJULLektK/VA
         AL/NZPGusMjazLlBev7xe67PdKIfQ1ifpZNsX3n6tVVOa4ud/9OwxtjEEiXleT0dww34
         btnUPhOQ9ej+n+IZzfuH/c2u7wLSynBdGbkIYgwm/zx9aTR7AirSR8kauZtQI1eG36ut
         GrY5WSOyefYNkH38KCUyy7rpU+qfA4Tow+UQHZI/00wFfW7zf53dLyFQhYvsbF2QDkKz
         HwKhJkV1eHDK+DsnsDoJNeFWLsnZIxfo/PjZHwoQIcsO8/FwvmZXcMuwGCHQNeY7A0V3
         GE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2C449KSjT4bbSwYYn5oh0t+GvJgUUHqBrjpFSTJaVMM=;
        b=tb2C/XYurje6a0weaA4Ph8IXcuMhwQofr8oNtsTc4ZV+eL5N9QwjhDwmyOidMNaceX
         hBVvl15bZkMqWdYuXFMS+01DPi3ehlBWVZD6JCJx/lUY9VxpZdEZ19Bxlm9N+cXTGou3
         S2aMpx6sf5JmS/tUedJbqp3KEtmzVwGn5lrq78arQqqhIWBc+0nQnvgQ5A69xEG6OLCP
         BHVUl+xjcRnMCT9tNOivZttLWTPZtOuGI/+K53nIvfFNSU47ksYgYNNeYRm7zOKEFZAr
         1a/VeXVS0j6Z+s0mwj871MpGgcf7LGSk62ruaXDfOZcER9fsZDNOPYiP6cKgeBBK6jwW
         PANQ==
X-Gm-Message-State: APjAAAVmJTGsaprngpiXAQ200qGD56cApk814/4dni2P29pOPreYA/E4
        ck1LdruIW1Pmy/2OzRgz+js=
X-Google-Smtp-Source: APXvYqxMBwDpewyfIfpy++jLBpP8UloTaXPGrZ8I/eqCpEpkmrEfDx2SZR3u/YrZv24UsUCPRBrhkw==
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr42072938edv.11.1564585709289;
        Wed, 31 Jul 2019 08:08:29 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id jt17sm12600191ejb.90.2019.07.31.08.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:08:28 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 8E3561030BE; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 23/59] x86/pconfig: Set an activated algorithm in all MKTME commands
Date:   Wed, 31 Jul 2019 18:07:37 +0300
Message-Id: <20190731150813.26289-24-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The Intel MKTME architecture specification requires an activated
encryption algorithm for all command types.

For commands that actually perform encryption, SET_KEY_DIRECT and
SET_KEY_RANDOM, the user specifies the algorithm when requesting the
key through the MKTME Key Service.

For CLEAR_KEY and NO_ENCRYPT commands, do not require the user to
specify an algorithm. Define a default algorithm, that is 'any
activated algorithm' to cover those two special cases.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/intel_pconfig.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/intel_pconfig.h b/arch/x86/include/asm/intel_pconfig.h
index 3cb002b1d0f9..4f27b0c532ee 100644
--- a/arch/x86/include/asm/intel_pconfig.h
+++ b/arch/x86/include/asm/intel_pconfig.h
@@ -21,14 +21,20 @@ enum pconfig_leaf {
 
 /* Defines and structure for MKTME_KEY_PROGRAM of PCONFIG instruction */
 
+/* mktme_key_program::keyid_ctrl ENC_ALG, bits [23:8] */
+#define MKTME_AES_XTS_128	(1 << 8)
+#define MKTME_ANY_ACTIVATED_ALG	(1 << __ffs(mktme_algs) << 8)
+
 /* mktme_key_program::keyid_ctrl COMMAND, bits [7:0] */
 #define MKTME_KEYID_SET_KEY_DIRECT	0
 #define MKTME_KEYID_SET_KEY_RANDOM	1
-#define MKTME_KEYID_CLEAR_KEY		2
-#define MKTME_KEYID_NO_ENCRYPT		3
 
-/* mktme_key_program::keyid_ctrl ENC_ALG, bits [23:8] */
-#define MKTME_AES_XTS_128	(1 << 8)
+/*
+ * CLEAR_KEY and NO_ENCRYPT require the COMMAND in bits [7:0]
+ * and any activated encryption algorithm, ENC_ALG, in bits [23:8]
+ */
+#define MKTME_KEYID_CLEAR_KEY  (2 | MKTME_ANY_ACTIVATED_ALG)
+#define MKTME_KEYID_NO_ENCRYPT (3 | MKTME_ANY_ACTIVATED_ALG)
 
 /* Return codes from the PCONFIG MKTME_KEY_PROGRAM */
 #define MKTME_PROG_SUCCESS	0
-- 
2.21.0

