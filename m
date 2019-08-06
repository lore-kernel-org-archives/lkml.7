Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF41C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E942A2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLzdWuiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfHFVNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:13:22 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53942 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfHFVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:13:22 -0400
Received: by mail-pl1-f201.google.com with SMTP id y22so49045328plr.20
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a29LgJr2OVNgNdoTJtcopFf7qnnTbwaGIZqViSAu3/k=;
        b=NLzdWuiCXL7c0/dtL69GVOr2Y63qNgQ+sCoXTw5/DacbxJ/IGbROhYZ3ObSBXAq6q8
         2hxY7491HJ22D4YaH/n5icGPjX3DdFJTWgLw/FNkw7pWT7OS/UOYO0MqMxVk3kAS6Pcc
         Co7bMNmQVZuGQybu72NrTWqVBs0gxUDzKXJiTzaGlhYIyYlddQxcsUJVQfDayFM1LyB/
         QHCwpQ1l4aNaVooWK88K/I1UdYZKc12S2WN1d0SROT9ThZJ4bAe1fSmnxBdnCk+uFK0Z
         mEulgzOHXV18SdoceNA8bCLf6ToNHdSLjiSko1wjx5A2EW6JnTcc/ihF1SMmPdPWBUQw
         TQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a29LgJr2OVNgNdoTJtcopFf7qnnTbwaGIZqViSAu3/k=;
        b=gDUm4LLosiI962okJ3zeAvhd4AKHZZvOfJq6HEkvcaE7IS616OdStXgjPbhEn8Pks8
         O5aIPi4FBMm/LtxjqDNx6aA2npXsae6R+xGdRTE9SUICKCZTKHhFovRPMmR98Z+KQIUd
         JUxixOknhisGO5SYtFf9ydM4RK5U72X/3yjPzhqprCM7kjIUbrCfnD6Lvu//Mu/nC3rM
         Kyjce0QAWbg5pCsGHQgc1nExFtLDb5J7Vj9KCugEXBt7jmgBaKiAa2dSQcdcSc6W2Zec
         63CzsDO8YpdnDWOrVkw3LiuqtFDOUvIcEB681g9k9ryJ3rQRF/GcF7Hr+1ksrTPl/wkX
         tsAw==
X-Gm-Message-State: APjAAAVzM0qWgFWAltw0mCW8hNU9KPiqkXrsDVQFwKW/ZpxmbBro1ARv
        z9iLHUWCo1eCkXewVeYvAQbEDUWSZA==
X-Google-Smtp-Source: APXvYqz7QBtDtaXLR5iNw8IILGOdYiseG9OIezrHeW8Ibpw3dPeu/OQrEHvPnp9cujI51MmNw1JvVKirlw==
X-Received: by 2002:a65:5183:: with SMTP id h3mr4783468pgq.250.1565126000981;
 Tue, 06 Aug 2019 14:13:20 -0700 (PDT)
Date:   Tue,  6 Aug 2019 14:10:46 -0700
Message-Id: <20190806211047.232709-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [RFC PATCH 1/2] Add clang-tidy and static analyzer support to makefile
From:   Nathan Huckleberry <nhuck@google.com>
To:     mark.rutland@arm.com
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
These patches add clang-tidy and the clang static-analyzer as make
targets. The goal of these patches is to make static analysis tools
usable and extendable by any developer or researcher who is familiar
with basic c++.

The current static analysis tools require intimate knowledge of the internal
workings of the static analysis.  Clang-tidy and the clang static analyzers
expose an easy to use api and allow users unfamiliar with clang to
write new checks with relative ease.

===Clang-tidy===

Clang-tidy is an easily extendable 'linter' that runs on the AST.
Clang-tidy checks are easy to write and understand. A check consists of
two parts, a matcher and a checker. The matcher is created using a
domain specific language that acts on the AST
(https://clang.llvm.org/docs/LibASTMatchersReference.html).  When AST
nodes are found by the matcher a callback is made to the checker. The
checker can then execute additional checks and issue warnings.

Here is an example clang-tidy check to report functions that have calls
to local_irq_disable without calls to local_irq_enable and vice-versa.
Functions flagged with __attribute((annotation("ignore_irq_balancing")))
are ignored for analysis.

The full patch can be found here (https://reviews.llvm.org/D65828)

```
void IrqUnbalancedCheck::registerMatchers(MatchFinder *Finder) {
  // finds calls to "arch_local_irq_disable" in a function body
  auto disable =
              forEachDescendant(
                  callExpr(
                      hasDeclaration(
                          namedDecl(
                              hasName("arch_local_irq_disable")))).bind("disable"));

  // finds calls to "arch_local_irq_enable" in a function body
  auto enable =
              forEachDescendant(
                  callExpr(
                      hasDeclaration(
                          namedDecl(
                              hasName("arch_local_irq_enable")))).bind("enable"));

  // Looks for function body that has the following property:
  // ((disable && !enable) || (enable && !disable))
  auto matcher = functionDecl(
      anyOf(allOf(disable, unless(enable)), allOf(enable, unless(disable))));

  Finder->addMatcher(matcher.bind("func"), this);
}

std::string annotation = "ignore_irq_balancing";
void IrqUnbalancedCheck::check(const MatchFinder::MatchResult &Result) {
  const auto *MatchedDecl = Result.Nodes.getNodeAs<FunctionDecl>("func");
  const auto *DisableCall = Result.Nodes.getNodeAs<CallExpr>("disable");
  const auto *EnableCall = Result.Nodes.getNodeAs<CallExpr>("enable");

  // If the function has __attribute((annotate("ignore_irq_balancing"))
  for (const auto *Attr : MatchedDecl->attrs()) {
    if (Attr->getKind() == clang::attr::Annotate) {
      if(dyn_cast<AnnotateAttr>(Attr)->getAnnotation().str() == annotation) {
        return;
      }
    }
  }

  if(EnableCall) {
    diag(MatchedDecl->getLocation(), "call to 'enable_local_irq' without 'disable_local_irq' in %0 ")
        << MatchedDecl;
    diag(EnableCall->getBeginLoc(), "call to 'enable_local_irq'", DiagnosticIDs::Note)
        << MatchedDecl;
  }

  if(DisableCall) {
    diag(MatchedDecl->getLocation(), "call to 'disable_local_irq' without 'enable_local_irq' in %0 ")
        << MatchedDecl;
    diag(DisableCall->getBeginLoc(), "call to 'disable_local_irq'", DiagnosticIDs::Note)
        << MatchedDecl;
  }
}
```

===Clang static analyzer===

The clang static analyzer is a more powerful static analysis tool that
uses symbolic execution to find bugs. Currently there is a check that
looks for potential security bugs from invalid uses of kmalloc and
kfree. There are several more general purpose checks that are useful for
the kernel.

The clang static analyzer is well documented and designed to be
extensible.
(https://clang-analyzer.llvm.org/checker_dev_manual.html)
(https://github.com/haoNoQ/clang-analyzer-guide/releases/download/v0.1/clang-analyzer-guide-v0.1.pdf)


Why add clang-tidy and the clang static analyzer when other static
analyzers are already in the kernel?

The main draw of the clang tools is how accessible they are. The clang
documentation is very nice and these tools are built specifically to be
easily extendable by any developer. They provide an accessible method of
bug-finding and research to people who are not overly familiar with the
kernel codebase.

 Makefile                                      |  3 ++
 scripts/clang-tools/Makefile.clang-tools      | 35 ++++++++++++++
 .../{ => clang-tools}/gen_compile_commands.py |  0
 scripts/clang-tools/parse_compile_commands.py | 47 +++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 scripts/clang-tools/Makefile.clang-tools
 rename scripts/{ => clang-tools}/gen_compile_commands.py (100%)
 create mode 100755 scripts/clang-tools/parse_compile_commands.py

diff --git a/Makefile b/Makefile
index fabc127d127f..49f1d3fa48a8 100644
--- a/Makefile
+++ b/Makefile
@@ -709,6 +709,7 @@ KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
 
 include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins
+include scripts/clang-tools/Makefile.clang-tools
 
 ifdef CONFIG_READABLE_ASM
 # Disable optimizations that make assembler listings hard to read.
@@ -1470,6 +1471,8 @@ help:
 	@echo  '  headers_check   - Sanity check on exported headers'
 	@echo  '  headerdep       - Detect inclusion cycles in headers'
 	@echo  '  coccicheck      - Check with Coccinelle'
+	@echo  '  clang-analyzer  - Check with clang static analyzer'
+	@echo  '  clang-tidy      - Check with clang-tidy'
 	@echo  ''
 	@echo  'Kernel selftest:'
 	@echo  '  kselftest       - Build and run kernel selftest (run as root)'
diff --git a/scripts/clang-tools/Makefile.clang-tools b/scripts/clang-tools/Makefile.clang-tools
new file mode 100644
index 000000000000..0adb6df20777
--- /dev/null
+++ b/scripts/clang-tools/Makefile.clang-tools
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0
+PHONY += clang-tidy
+HAS_PARALLEL := $(shell (parallel --version 2> /dev/null) | grep 'GNU parallel' 2> /dev/null)
+clang-tidy:
+ifdef CONFIG_CC_IS_CLANG
+	$(PYTHON3) scripts/clang-tools/gen_compile_commands.py
+ifdef HAS_PARALLEL
+	#Xargs interleaves multiprocessed output. GNU Parallel does not.
+	scripts/clang-tools/parse_compile_commands.py compile_commands.json \
+		| parallel -k -j $(shell nproc) 'echo {} && clang-tidy -p . "-checks=-*,linuxkernel-*" {}'
+else
+	@echo "GNU parallel is not installed. Defaulting to non-parallelized runs"
+	scripts/clang-tools/parse_compile_commands.py compile_commands.json \
+		| xargs -L 1 -I@ sh -c "echo '@' && clang-tidy -p . '-checks=-*,linuxkernel-*' @"
+endif
+else
+	$(error Clang-tidy requires CC=clang)
+endif
+
+PHONY += clang-analyzer
+clang-analyzer:
+ifdef CONFIG_CC_IS_CLANG
+	$(PYTHON3) scripts/clang-tools/gen_compile_commands.py
+ifdef HAS_PARALLEL
+	#Xargs interleaves multiprocessed output. GNU Parallel does not.
+	scripts/clang-tools/parse_compile_commands.py compile_commands.json \
+		| parallel -k -j $(shell nproc) 'echo {} && clang-tidy -p . "-checks=-*,clang-analyzer-*" {}'
+else
+	@echo "GNU parallel is not installed. Defaulting to non-parallelized runs"
+	scripts/clang-tools/parse_compile_commands.py compile_commands.json \
+		| xargs -L 1 -I@ sh -c "echo '@' && clang-tidy -p . '-checks=-*,clang-analyzer-*' @"
+endif
+else
+	$(error Clang-analyzer requires CC=clang)
+endif
diff --git a/scripts/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
similarity index 100%
rename from scripts/gen_compile_commands.py
rename to scripts/clang-tools/gen_compile_commands.py
diff --git a/scripts/clang-tools/parse_compile_commands.py b/scripts/clang-tools/parse_compile_commands.py
new file mode 100755
index 000000000000..d6bc1bf9951e
--- /dev/null
+++ b/scripts/clang-tools/parse_compile_commands.py
@@ -0,0 +1,47 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) Google LLC, 2019
+#
+# Author: Nathan Huckleberry <nhuck@google.com>
+#
+"""A helper routine for make clang-tidy to parse compile_commands.json."""
+
+import argparse
+import json
+import logging
+import os
+import re
+
+def parse_arguments():
+  """Set up and parses command-line arguments.
+  Returns:
+    file_path: Path to compile_commands.json file
+  """
+  usage = """Parse a compilation database and return a list of files
+  included in the database"""
+  parser = argparse.ArgumentParser(description=usage)
+
+  file_path_help = ('Path to the compilation database to parse')
+  parser.add_argument('file',  type=str, help=file_path_help)
+
+  args = parser.parse_args()
+
+  return args.file
+
+
+def main():
+  filename = parse_arguments()
+
+  #Read JSON data into the datastore variable
+  if filename:
+    with open(filename, 'r') as f:
+      datastore = json.load(f)
+
+      #Use the new datastore datastructure
+      for entry in datastore:
+        print(entry['file'])
+
+
+if __name__ == '__main__':
+    main()
-- 
2.22.0.709.g102302147b-goog

