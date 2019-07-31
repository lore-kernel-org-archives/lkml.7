Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17A0C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875FD206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YaTXMBHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfGaPVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:21:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45426 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfGaPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:21:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so60135667eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=giiClMAwHghspubxRJeU98UBj4kcy5uaSNNQ5yHBQr8=;
        b=YaTXMBHevd+rhxg7oKsHgnNx749IFnPZBGV8uL7sZwZst8GkM7+TgJ5hOEwl+8ch77
         0SnQ660ccq3nonm+oPVfiPClF1RSRdsFcsOmiSCMAee/860JmulRtpJu6ZVUPIXxPpab
         A4HPUmoMK+oL/ZYU5z/0aKIN4ZyJj82QmP1VUkYEBl9uw4vslQvBcp1bM5ghPUhjzxVC
         giBVV/0crRxnqKUVAJjYi7W4wag0HivWwFFhHGvLdDIRmm1PDwxpL1ZVySWrGgKoEpQY
         GhlGRvNmW51GC9GcIML/xNJIoQeLdRe0qiR4tweLB/NiOTOi4OWFj5nMUqbAYuKnK/j8
         MnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=giiClMAwHghspubxRJeU98UBj4kcy5uaSNNQ5yHBQr8=;
        b=ue5f7so3GcV8Y31qriidPSjXXV7DM9VFS9uVxzitctmVTnFRIxdBAXphV5fFXYzEQZ
         DmpX5Lq/QSmiVhxVzSwQcsTW3cPdVxi9aoiMZISGs/4Td306yMPFUnbHa4BNsNIbJ6r4
         FwwVekuTg+8Q3Hnyvtwmd2Jj4YDYGf4ZIMQINzzPj8xYoPodmkEZqHOwJXgdW1JdVmVt
         ZLHnD8ueKZxfAT287MNOR1SQays1tQYie7BoH1RhFTErakF5cYkB3/EWhev7u23PRo1s
         NsyF8gtbQlOUG+gRjAa3/EbGtDYJ5pMWawVCknBiZ5X4UCm+BYqnUEjvG5akxVuxDpnj
         jR+w==
X-Gm-Message-State: APjAAAUc9QvdWfPL3AlqHfLCy2H+bGSAROgQB2DIsst+2CnGBxgH1Gmj
        r5GArl2hzGPrseMPuJab+4s=
X-Google-Smtp-Source: APXvYqwa7uk1eoCfkAn/mJHFtQFBKd5911qUgdeykZm3YPTTj3MkDFh75r+Wsq0y3PI0U1ZEMWspDg==
X-Received: by 2002:aa7:dd09:: with SMTP id i9mr109849959edv.193.1564586036906;
        Wed, 31 Jul 2019 08:13:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t13sm17047248edd.13.2019.07.31.08.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:53 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 8EA5E1048AA; Wed, 31 Jul 2019 18:08:17 +0300 (+03)
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
Subject: [PATCHv2 58/59] x86/mktme: Document the MKTME API for anonymous memory encryption
Date:   Wed, 31 Jul 2019 18:08:12 +0300
Message-Id: <20190731150813.26289-59-kirill.shutemov@linux.intel.com>
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

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/x86/mktme/index.rst         |  1 +
 Documentation/x86/mktme/mktme_encrypt.rst | 56 +++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/x86/mktme/mktme_encrypt.rst

diff --git a/Documentation/x86/mktme/index.rst b/Documentation/x86/mktme/index.rst
index 8cf2b7d62091..ca3c76adc596 100644
--- a/Documentation/x86/mktme/index.rst
+++ b/Documentation/x86/mktme/index.rst
@@ -9,3 +9,4 @@ Multi-Key Total Memory Encryption (MKTME)
    mktme_mitigations
    mktme_configuration
    mktme_keys
+   mktme_encrypt
diff --git a/Documentation/x86/mktme/mktme_encrypt.rst b/Documentation/x86/mktme/mktme_encrypt.rst
new file mode 100644
index 000000000000..6dc8ae11f1cb
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_encrypt.rst
@@ -0,0 +1,56 @@
+MKTME API: system call encrypt_mprotect()
+=========================================
+
+Synopsis
+--------
+int encrypt_mprotect(void \*addr, size_t len, int prot, key_serial_t serial);
+
+Where *key_serial_t serial* is the serial number of a key allocated
+using the MKTME Key Service.
+
+Description
+-----------
+    encrypt_mprotect() encrypts the memory pages containing any part
+    of the address range in the interval specified by addr and len.
+
+    encrypt_mprotect() supports the legacy mprotect() behavior plus
+    the enabling of memory encryption. That means that in addition
+    to encrypting the memory, the protection flags will be updated
+    as requested in the call.
+
+    The *addr* and *len* must be aligned to a page boundary.
+
+    The caller must have *KEY_NEED_VIEW* permission on the key.
+
+    The memory that is to be protected must be mapped *ANONYMOUS*.
+
+Errors
+------
+    In addition to the Errors returned from legacy mprotect()
+    encrypt_mprotect will return:
+
+    ENOKEY *serial* parameter does not represent a valid key.
+
+    EINVAL *len* parameter is not page aligned.
+
+    EACCES Caller does not have *KEY_NEED_VIEW* permission on the key.
+
+EXAMPLE
+--------
+  Allocate an MKTME Key::
+        serial = add_key("mktme", "name", "type=cpu algorithm=aes-xts-128" @u
+
+  Map ANONYMOUS memory::
+        ptr = mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+
+  Protect memory::
+        ret = syscall(SYS_encrypt_mprotect, ptr, size, PROT_READ|PROT_WRITE,
+                      serial);
+
+  Use the encrypted memory
+
+  Free memory::
+        ret = munmap(ptr, size);
+
+  Free the key resource::
+        ret = keyctl(KEYCTL_INVALIDATE, serial);
-- 
2.21.0

