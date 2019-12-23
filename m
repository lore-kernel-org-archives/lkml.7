Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEB3C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EF02081E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG1zyt/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLWDbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 22:31:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34495 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfLWDbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:31:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so1634684pfc.1;
        Sun, 22 Dec 2019 19:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDk9eb7F2WxO7x5adDBGN43VlmnnZ5rDg1TMYWO8AcU=;
        b=aG1zyt/Z2Phm31nUAnlEmVfeRFW3Z+k9xOf+fSEYyBZY5LrxUHcY1bS+MCadB8+8/x
         bIz+JJ6jlbNazR81bTamAfPf8AvcG/vg9haZ0nqQi7ZcCyFEpSNbf43VKITHz/Ae3KIa
         bgC/v0FvhIx9PpJaMX7kD9md5juR0gh/DArWT6JjlqzISemtbE/me29ooDk6cE559fb9
         /G/ZK/GHaAwvTEmqfQ8S1yGFNjRHJdT46P8DAFKrF250/5i1h5bxPbaY1glSndVYRLmf
         ikDSmZpSS9H6vxURj2gM6gJvJQu6mJhkLNroEuzuaPSbWfmVYBj20NDqrHvsfwbZ7o18
         bqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDk9eb7F2WxO7x5adDBGN43VlmnnZ5rDg1TMYWO8AcU=;
        b=geBKH095oLAzVEb3utvN2tQYtwfoGWiiXwH8JoJAYjMVTNDGB95S3p40b/qefzDmzn
         A36VXod+QPKJqGT/xEgEXsHSYMCmRKens8Jc9pdavI5bzpFMUms42U66PCC+crEftNwI
         lKaor8QDfQIFRqS6jDdddxnb2y46eZUIeB7JzZR19MYX4yMnDDhmz8aVgls4D/WbHA5Q
         wfpSLXsi8pze9OIOfszmsUUk4kN63/jNGAqEihRzCmrVhn0sdBpMOCspDemEpeDjkvwo
         1C6K7VUaCY8R0C9V/RFlCThpcVPl0/UpQ2iM0+zxmS2RBjTlKQ1kJXyupMgL6+vuSHHJ
         BY+w==
X-Gm-Message-State: APjAAAXkKD917Wty7q3OQR9U9mKox3pU+OKIIrFGRc+f5WT8dwlStDDr
        NE92eFmV9jMgQS0jrIOyXzw=
X-Google-Smtp-Source: APXvYqw6cYeESIHewXsTj5ZOMfVsL360DyEGQXE+t1uEQIKtnZ5cv7gAEB6mPAUShLtobJ5UD0k7Gw==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr29174948pgl.246.1577071895412;
        Sun, 22 Dec 2019 19:31:35 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id f30sm19932481pga.20.2019.12.22.19.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 19:31:34 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Documentation: boot.rst: fix warnings
Date:   Mon, 23 Dec 2019 00:31:21 -0300
Message-Id: <20191223033121.1584930-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix WARNING: Inline emphasis start-string without end-string.
This warning was due to wrong syntax being used.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/x86/boot.rst | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 90bb8f5ab384..94c2a2775a31 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -834,14 +834,14 @@ Protocol:	2.09+
   chunks of memory are occupied by kernel data.
 
   Thus setup_indirect struct and SETUP_INDIRECT type were introduced in
-  protocol 2.15.
+  protocol 2.15::
 
-  struct setup_indirect {
-    __u32 type;
-    __u32 reserved;  /* Reserved, must be set to zero. */
-    __u64 len;
-    __u64 addr;
-  };
+    struct setup_indirect {
+      __u32 type;
+      __u32 reserved;  /* Reserved, must be set to zero. */
+      __u64 len;
+      __u64 addr;
+    };
 
   The type member is a SETUP_INDIRECT | SETUP_* type. However, it cannot be
   SETUP_INDIRECT itself since making the setup_indirect a tree structure
@@ -849,19 +849,19 @@ Protocol:	2.09+
   and stack space can be limited in boot contexts.
 
   Let's give an example how to point to SETUP_E820_EXT data using setup_indirect.
-  In this case setup_data and setup_indirect will look like this:
-
-  struct setup_data {
-    __u64 next = 0 or <addr_of_next_setup_data_struct>;
-    __u32 type = SETUP_INDIRECT;
-    __u32 len = sizeof(setup_data);
-    __u8 data[sizeof(setup_indirect)] = struct setup_indirect {
-      __u32 type = SETUP_INDIRECT | SETUP_E820_EXT;
-      __u32 reserved = 0;
-      __u64 len = <len_of_SETUP_E820_EXT_data>;
-      __u64 addr = <addr_of_SETUP_E820_EXT_data>;
+  In this case setup_data and setup_indirect will look like this::
+
+    struct setup_data {
+      __u64 next = 0 or <addr_of_next_setup_data_struct>;
+      __u32 type = SETUP_INDIRECT;
+      __u32 len = sizeof(setup_data);
+      __u8 data[sizeof(setup_indirect)] = struct setup_indirect {
+        __u32 type = SETUP_INDIRECT | SETUP_E820_EXT;
+        __u32 reserved = 0;
+        __u64 len = <len_of_SETUP_E820_EXT_data>;
+        __u64 addr = <addr_of_SETUP_E820_EXT_data>;
+      }
     }
-  }
 
 .. note::
      SETUP_INDIRECT | SETUP_NONE objects cannot be properly distinguished
@@ -964,7 +964,7 @@ expected to copy into a setup_data chunk.
 All kernel_info data should be part of this structure. Fixed size data have to
 be put before kernel_info_var_len_data label. Variable size data have to be put
 after kernel_info_var_len_data label. Each chunk of variable size data has to
-be prefixed with header/magic and its size, e.g.:
+be prefixed with header/magic and its size, e.g.::
 
   kernel_info:
           .ascii  "LToP"          /* Header, Linux top (structure). */
-- 
2.24.1

