Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A288FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BC0206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="tW+zNphq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfGaPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:20:16 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:37344 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbfGaPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:19:54 -0400
Received: by mail-ed1-f47.google.com with SMTP id w13so66095408eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I5PL3KEd8NdLoJF+LQ8UkD4dkMItZA8rJO7OBoBpg0o=;
        b=tW+zNphqnZbkGHkrMBxx1TXe9FglfbohupscPg50rqzrfHLWW9Hl0Z+CMMOXjE/R2+
         NcyfhCCsOWXcuwckjmfDmtUusVsnWuowFpyaegX4gCHmyqrGBy+MQMUADGcZpvVKZ512
         11xIjMWWAyW63Hda6ArgtSMycjMggoGiwik1SYPbJausNlmbXMmpld6k3+d5JCJ4LZJP
         gwHYjVnbIrQYu9TGb2+5XJG8HpaJESPi+R23zoUlviPx31pjGUmVrMYLiGF/H3Dcw0QM
         E2t8w4UFu33JUkrOE5ctmB9g/FhPzqGB/iO94n+xj19M9EujxQQ7zv77d7Yw2DGds/F/
         6oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5PL3KEd8NdLoJF+LQ8UkD4dkMItZA8rJO7OBoBpg0o=;
        b=BCM6eaRLA2aNVhlVVxsXO0HvpTeiNcr/wIN37bLyqDvx4zutVzuVI44/zS070sZvqi
         PRuUqWO7KRiItePYwLKATn5Ugm8udBlA7pmMzgHXt1mQd/kRukIFUv2I582Lxx0OlVPb
         zO84wlsQXTNndtUdnQFM+VglMEHUfPezBowWS1gwIP9ifLP9ZG6hWWsWiRu4fys8Axof
         yWWDxLpvNkp0ja9GTGmcWbS3NXkBCzEsYv0K2c1H/EyDXWYizfaCtb6WTM8PhNYcdaoE
         XeEBQOpdsA6t2sjlUI+9cnR08g+DFOfdurnlyAvia6hl5clHe80PZphs4Y8qcC7RxWE2
         qd6Q==
X-Gm-Message-State: APjAAAXCBJr2bicOiqIW0aJT6ADLow1YpUrkXtBJUoqCzjBbKwteUiED
        EhhxpXZOCLaCt9/4qgQVPV4=
X-Google-Smtp-Source: APXvYqzcY0rGlEFl7gKQAV09OPdwNja6Zvxs45AN38Cu6T9Con7khC9d8WVErECQGCkC99X7sSihKQ==
X-Received: by 2002:a17:906:2557:: with SMTP id j23mr93846289ejb.228.1564586035522;
        Wed, 31 Jul 2019 08:13:55 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p43sm17365793edc.3.2019.07.31.08.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:53 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 809A21048A8; Wed, 31 Jul 2019 18:08:17 +0300 (+03)
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
Subject: [PATCHv2 56/59] x86/mktme: Document the MKTME kernel configuration requirements
Date:   Wed, 31 Jul 2019 18:08:10 +0300
Message-Id: <20190731150813.26289-57-kirill.shutemov@linux.intel.com>
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
 Documentation/x86/mktme/index.rst               | 1 +
 Documentation/x86/mktme/mktme_configuration.rst | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 Documentation/x86/mktme/mktme_configuration.rst

diff --git a/Documentation/x86/mktme/index.rst b/Documentation/x86/mktme/index.rst
index a3a29577b013..0f021cc4a2db 100644
--- a/Documentation/x86/mktme/index.rst
+++ b/Documentation/x86/mktme/index.rst
@@ -7,3 +7,4 @@ Multi-Key Total Memory Encryption (MKTME)
 
    mktme_overview
    mktme_mitigations
+   mktme_configuration
diff --git a/Documentation/x86/mktme/mktme_configuration.rst b/Documentation/x86/mktme/mktme_configuration.rst
new file mode 100644
index 000000000000..7d56596360cb
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_configuration.rst
@@ -0,0 +1,6 @@
+MKTME Configuration
+===================
+
+CONFIG_X86_INTEL_MKTME
+        MKTME is enabled by selecting CONFIG_X86_INTEL_MKTME on Intel
+        platforms supporting the MKTME feature.
-- 
2.21.0

