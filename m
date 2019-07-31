Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B664C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF82208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="DRp4/04Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfGaPXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:23:50 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33129 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGaPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:23:49 -0400
Received: by mail-ed1-f49.google.com with SMTP id i11so2570759edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpVydprU+qUIbG2ieS0/pcejmTH1ILSgd/PE5xIU2l8=;
        b=DRp4/04Ql9tuwZ8HmklcrVGbpbwpqyiHWrb5OFmDW/SEC8peDq2WPBaUHFkAudB5fO
         O6QRunFSo/ysHy81uSqyDDbaDB0RbNas5DoSFJjERVndASSmEQlNkxI6m4UzvLb1lYXe
         HR9PxFKm/WpkDGRuHh7/II3kWjLslUMYjW15KfsW1uUXxZKw3qH1ykdFZqetYNR65uFr
         gcHNHUE6tyTdsEhVT4TE8EFJvr35k771sHCQxS/OJ1ZA0dTfkaCGA+sR1YMCZ/ySG35J
         zgO0k7b/GKJH49Q3m+NOFpVJ9izt7DqzZczYOnuYmoEesdA/OGp8B5vhT4m926rqes+k
         RWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpVydprU+qUIbG2ieS0/pcejmTH1ILSgd/PE5xIU2l8=;
        b=W6XPhwb6MbUeFAHJSC2rJAEy1sPIJWvMgnyaF5Zj08p1+GiWQhlyOvpNUPpRBH9kLb
         sdIxGvragIG8xd/9jPH1Enpj/xXmfm1dhExn9pf0W4dkao0rn4GC2BJT+JYT0pDGHOso
         UG9kRNql4yOHfVNpIEMszKwhhFn2pwZVHc/Ej2lP2ucMlwcw0fZHFex2HuLrUnPJNkww
         43U/KuxmWWo3bZiBnCehNd9wHpYjCa0VTCsWem9+0CGn5/3lNwnm85ZXHyfKsdBr14aF
         HNQvrC2kSjGh6f5C+o/WjcZWBJbRpTqUWTfg7+7YbzC/GLuem03TRGsgaf9AP8C7FFmg
         bz2A==
X-Gm-Message-State: APjAAAUgUcHzhAP+FEUpR2j0P2xQdEql/EYMITinWjye364FFRQDLN9h
        xMnGLMHFs0xUqPsPob+8WcE=
X-Google-Smtp-Source: APXvYqzHNAWdNlgTeKpfoNbFrJilyAoYtl9yAfdpOnAx37mkMd2b2DlC485Nke0u/zSmR8xGQJj0mw==
X-Received: by 2002:aa7:ca45:: with SMTP id j5mr106898585edt.217.1564586627658;
        Wed, 31 Jul 2019 08:23:47 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j12sm12429043ejd.30.2019.07.31.08.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:23:47 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 957D31048AB; Wed, 31 Jul 2019 18:08:17 +0300 (+03)
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
Subject: [PATCHv2 59/59] x86/mktme: Demonstration program using the MKTME APIs
Date:   Wed, 31 Jul 2019 18:08:13 +0300
Message-Id: <20190731150813.26289-60-kirill.shutemov@linux.intel.com>
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
 Documentation/x86/mktme/index.rst      |  1 +
 Documentation/x86/mktme/mktme_demo.rst | 53 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/x86/mktme/mktme_demo.rst

diff --git a/Documentation/x86/mktme/index.rst b/Documentation/x86/mktme/index.rst
index ca3c76adc596..3af322d13225 100644
--- a/Documentation/x86/mktme/index.rst
+++ b/Documentation/x86/mktme/index.rst
@@ -10,3 +10,4 @@ Multi-Key Total Memory Encryption (MKTME)
    mktme_configuration
    mktme_keys
    mktme_encrypt
+   mktme_demo
diff --git a/Documentation/x86/mktme/mktme_demo.rst b/Documentation/x86/mktme/mktme_demo.rst
new file mode 100644
index 000000000000..5af78617f887
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_demo.rst
@@ -0,0 +1,53 @@
+Demonstration Program using MKTME API's
+=======================================
+
+/* Compile with the keyutils library: cc -o mdemo mdemo.c -lkeyutils */
+
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <keyutils.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
+#define sys_encrypt_mprotect 434
+
+void main(void)
+{
+	char *options_CPU = "algorithm=aes-xts-128 type=cpu";
+	long size = PAGE_SIZE;
+        key_serial_t key;
+	void *ptra;
+	int ret;
+
+        /* Allocate an MKTME Key */
+	key = add_key("mktme", "testkey", options_CPU, strlen(options_CPU),
+                      KEY_SPEC_THREAD_KEYRING);
+
+	if (key == -1) {
+		printf("addkey FAILED\n");
+		return;
+	}
+        /* Map a page of ANONYMOUS memory */
+	ptra = mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (!ptra) {
+		printf("failed to mmap");
+		goto inval_key;
+	}
+        /* Encrypt that page of memory with the MKTME Key */
+	ret = syscall(sys_encrypt_mprotect, ptra, size, PROT_NONE, key);
+	if (ret)
+		printf("mprotect error [%d]\n", ret);
+
+        /* Enjoy that page of encrypted memory */
+
+        /* Free the memory */
+	ret = munmap(ptra, size);
+
+inval_key:
+        /* Free the Key */
+	if (keyctl(KEYCTL_INVALIDATE, key) == -1)
+		printf("invalidate failed on key [%d]\n", key);
+}
-- 
2.21.0

