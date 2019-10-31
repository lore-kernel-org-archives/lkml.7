Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9F6CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28302086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrVgbkIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfJaNw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:52:58 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36953 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJaNw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:52:58 -0400
Received: by mail-wm1-f53.google.com with SMTP id q130so5989827wme.2;
        Thu, 31 Oct 2019 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Vi0yZSx1Lco5Hwdo0pJ66ma188kEsC572xx00JXapM=;
        b=KrVgbkImc5E5SbO9CepXmFbXlttT7+anaqi6oyANUDoTHO4Tlk0srADEJvLOSp/iGE
         6CjiQlV4BJyB9q5boslqLc6FYfVOZGCam/UTkcmCgTp/RhhJKM159qFY7gj+1DihBRwo
         zDmlMb7SL5bkkEHKL9/lMHwFg1stKbxy31XHwffkVoUzULHrwlYq5jhZfsuRJxeQxAaO
         plAXfrIU/ju7bNqgW9hLhyO6nb7MGlDmAcGo4v5APebPPxnzeoMzNPIeDTnY2Ubb/SXE
         IDdiZ3oC9i6Z6AhMnE5/t4N9MgQee/Vj7Vm4/xSfigbykLJ/yb58eUbWZpT2Insub5vN
         LZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Vi0yZSx1Lco5Hwdo0pJ66ma188kEsC572xx00JXapM=;
        b=Ax9Wq4Nla0abXTfvurUnx4C0eSqTUit5qEy902gXLqbSD0/7SnZpL/80c1C3XdcbJD
         oZY8GKyOq2moShn1Ztuvi0hh/W293xSiPfVn8w2EICKqUddMWsNX6LUsY0Kbr9ZQiPHs
         MtEXERhPeEL41rz/6eDRa7TD4HjrW2Pd6QKCJLMMirRGBozsB3j5EDHeJVUsLTmLedPC
         WYYEx/dGq0PzJfpHgDMMcUPmRvjtD6lDo5rxGM3BtY0Yyf5t6tuV135lk02k2MjKg0A+
         CiIg+LzsIycEEBzMEDENMo7sv9oTs9VNWV9qH+KHtIf1iSJWr0zUNzmf7jQaA8AZpSM9
         /f9A==
X-Gm-Message-State: APjAAAWkb/yBM7+IoJbl1M/v1lpbD2NHQvJU3kWRIhGubDsnTYizbIHJ
        k2Ri5LBaM9CSic6N+ERRpMQ=
X-Google-Smtp-Source: APXvYqxKusZVXVc8qGqkgM9KheV0aq/A0DEMQRz3SuWCyOqGZpHs58y4IRPSHcY9wfo0n7sLCC66GQ==
X-Received: by 2002:a05:600c:2551:: with SMTP id e17mr5618470wma.51.1572529975101;
        Thu, 31 Oct 2019 06:52:55 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id n3sm4036112wrr.50.2019.10.31.06.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 06:52:54 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3] kernel-doc: rename the kernel-doc directive 'functions' to 'identifiers'
Date:   Thu, 31 Oct 2019 21:52:45 +0800
Message-Id: <20191031135245.7984-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'functions' directive is not only for functions, but also works for
structs/unions. So the name is misleading. This patch renames it to
'identifiers', which specific the functions/types to be included in
documentation. We keep the old name as an alias of the new one before
all documentation are updated.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2:
  o use 'identifiers' as the new directive name.
---
 Documentation/doc-guide/kernel-doc.rst | 29 ++++++++++++++------------
 Documentation/sphinx/kerneldoc.py      | 17 +++++++++------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 192c36af39e2..fff6604631ea 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -476,6 +476,22 @@ internal: *[source-pattern ...]*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :internal:
 
+identifiers: *[ function/type ...]*
+  Include documentation for each *function* and *type* in *source*.
+  If no *function* is specified, the documentation for all functions
+  and types in the *source* will be included.
+
+  Examples::
+
+    .. kernel-doc:: lib/bitmap.c
+       :identifiers: bitmap_parselist bitmap_parselist_user
+
+    .. kernel-doc:: lib/idr.c
+       :identifiers:
+
+functions: *[ function/type ...]*
+  This is an alias of the 'identifiers' directive and deprecated.
+
 doc: *title*
   Include documentation for the ``DOC:`` paragraph identified by *title* in
   *source*. Spaces are allowed in *title*; do not quote the *title*. The *title*
@@ -488,19 +504,6 @@ doc: *title*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :doc: High Definition Audio over HDMI and Display Port
 
-functions: *[ function ...]*
-  Include documentation for each *function* in *source*.
-  If no *function* is specified, the documentation for all functions
-  and types in the *source* will be included.
-
-  Examples::
-
-    .. kernel-doc:: lib/bitmap.c
-       :functions: bitmap_parselist bitmap_parselist_user
-
-    .. kernel-doc:: lib/idr.c
-       :functions:
-
 Without options, the kernel-doc directive includes all documentation comments
 from the source file.
 
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 1159405cb920..4bcbd6ae01cd 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -59,9 +59,10 @@ class KernelDocDirective(Directive):
     optional_arguments = 4
     option_spec = {
         'doc': directives.unchanged_required,
-        'functions': directives.unchanged,
         'export': directives.unchanged,
         'internal': directives.unchanged,
+        'identifiers': directives.unchanged,
+        'functions': directives.unchanged,
     }
     has_content = False
 
@@ -77,6 +78,10 @@ class KernelDocDirective(Directive):
 
         tab_width = self.options.get('tab-width', self.state.document.settings.tab_width)
 
+        # 'function' is an alias of 'identifiers'
+        if 'functions' in self.options:
+            self.options['identifiers'] = self.options.get('functions')
+
         # FIXME: make this nicer and more robust against errors
         if 'export' in self.options:
             cmd += ['-export']
@@ -86,11 +91,11 @@ class KernelDocDirective(Directive):
             export_file_patterns = str(self.options.get('internal')).split()
         elif 'doc' in self.options:
             cmd += ['-function', str(self.options.get('doc'))]
-        elif 'functions' in self.options:
-            functions = self.options.get('functions').split()
-            if functions:
-                for f in functions:
-                    cmd += ['-function', f]
+        elif 'identifiers' in self.options:
+            identifiers = self.options.get('identifiers').split()
+            if identifiers:
+                for i in identifiers:
+                    cmd += ['-function', i]
             else:
                 cmd += ['-no-doc-sections']
 
-- 
2.20.1

