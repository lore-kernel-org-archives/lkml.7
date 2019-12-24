Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45346C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A8E206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="Fs7DuRlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXMMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:12:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33777 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfLXMMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:12:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so4380264otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nuj6skKKOSXoepbWtc0CFCcS4QOs8J8LbLB12xHwxa0=;
        b=Fs7DuRlCQC843Lu6y8avEFr8ox7jlqvyPSH35euGTdussEwAU7yKOm/xhW5SKVHuDw
         l8aG4qKWLRBNnVMP/s9L5cejP6L4kEYRSy1zF0VOL6dfrxs4PC691jkflW92osANUkk+
         IiJYQjkFPSnqRUq80p7N2snXUk5nl8kQqK244XRc3UjprtBoaFkIzM/VfKhAYAaWEF43
         yCVHRLcyMdsPPCI1RsIXp5LCnTcbXD1MKsztzZIc2LrnfzgO2eAyehZzD/++IitAh6mU
         48+2lxk4/pdFlr4qY+jfvTdtYSDUmIwZWudSTsnO6hEiEvNxpgi2hNCcUmbBAZU4Kh0o
         GQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nuj6skKKOSXoepbWtc0CFCcS4QOs8J8LbLB12xHwxa0=;
        b=GjjGYYVVRLZAwFaWQ0XOCRoCf28Cd/+kg/FZQtDyMoNdNWHamI3qKRXYBLTtKESxK/
         jU4A4vdUqrVAqol5HSsjFbZsb80q3lkCd57yeFHUksInkQe7xscrZHUr/7NqgG3Y7rrB
         P/QJhqEQZTuRpWWyZ77U1Y+NujuVhpSEselyDVVEWD/52bJbleVp2oHSNPtCrF9x8mBQ
         vZJf3S6BMQwdQ+zgbEymRJVamnjRJRZtWnmOyqH0j3zygUkoxHO4GLNPSVY56dLXMJMu
         ewX4nM19Xrz/dIPa51IWMzV2fRi7DfAnjBSvCdz35dLjHeyPJBBIpLojxowFVxpUJKT8
         4Xxg==
X-Gm-Message-State: APjAAAVcZbICeJzcc9ICbyMV3NsA1BYMvCZD+o6opB/qfaRGC2UL0FFw
        54OkeCkTh0eIUs7H3xPi3goOPHtKsAI=
X-Google-Smtp-Source: APXvYqxRx+0AEAZrAlelqDOlUu2q/FWmETxE+YVmvI/p+/CnnZG8CfTArLYkRhxdOPRu+JQ+sGbKyQ==
X-Received: by 2002:a05:6830:184:: with SMTP id q4mr20457049ota.232.1577189543484;
        Tue, 24 Dec 2019 04:12:23 -0800 (PST)
Received: from hev-sbc.hz.ali.com ([47.89.83.53])
        by smtp.gmail.com with ESMTPSA id m12sm3778206otq.15.2019.12.24.04.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 04:12:22 -0800 (PST)
From:   Heiher <r@hev.cc>
To:     linux-kernel@vger.kernel.org
Cc:     Heiher <r@hev.cc>, Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 1/3] selftests: add rbtree selftests
Date:   Tue, 24 Dec 2019 20:12:08 +0800
Message-Id: <20191224121210.29713-1-r@hev.cc>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the selftest for rbtree. It will reproduce the crash at earsing.

Signed-off-by: hev <r@hev.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michel Lespinasse <walken@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/lib/rbtree/.gitignore |  1 +
 tools/testing/selftests/lib/rbtree/Makefile   | 29 ++++++++
 .../selftests/lib/rbtree/rbtree_test.c        | 70 +++++++++++++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/lib/rbtree/.gitignore
 create mode 100644 tools/testing/selftests/lib/rbtree/Makefile
 create mode 100644 tools/testing/selftests/lib/rbtree/rbtree_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b001c602414b..0e84ca3f207f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -25,6 +25,7 @@ TARGETS += kcmp
 TARGETS += kexec
 TARGETS += kvm
 TARGETS += lib
+TARGETS += lib/rbtree
 TARGETS += livepatch
 TARGETS += membarrier
 TARGETS += memfd
diff --git a/tools/testing/selftests/lib/rbtree/.gitignore b/tools/testing/selftests/lib/rbtree/.gitignore
new file mode 100644
index 000000000000..4c9f82761fad
--- /dev/null
+++ b/tools/testing/selftests/lib/rbtree/.gitignore
@@ -0,0 +1 @@
+rbtree_test
diff --git a/tools/testing/selftests/lib/rbtree/Makefile b/tools/testing/selftests/lib/rbtree/Makefile
new file mode 100644
index 000000000000..68fa9dad24a1
--- /dev/null
+++ b/tools/testing/selftests/lib/rbtree/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../../../../include/
+
+include ../../lib.mk
+
+# lib.mk TEST_CUSTOM_PROGS var is for custom tests that need special
+# build rules. lib.mk will run and install them.
+
+TEST_CUSTOM_PROGS := $(OUTPUT)/rbtree_test
+all: $(TEST_CUSTOM_PROGS)
+
+OBJS = rbtree_test.o
+
+LIBS = ../../../../lib/rbtree.o
+
+OBJS := $(patsubst %,$(OUTPUT)/%,$(OBJS))
+LIBS := $(patsubst %,$(OUTPUT)/%,$(LIBS))
+
+$(TEST_CUSTOM_PROGS): $(LIBS) $(OBJS)
+	$(CC) -o $(TEST_CUSTOM_PROGS) $(OBJS) $(LIBS) $(CFLAGS) $(LDFLAGS)
+
+$(OBJS): $(OUTPUT)/%.o: %.c
+	$(CC) -c $^ -o $@ $(CFLAGS)
+
+$(LIBS): $(OUTPUT)/%.o: %.c
+	$(CC) -c $^ -o $@ $(CFLAGS)
+
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(OBJS) $(LIBS)
diff --git a/tools/testing/selftests/lib/rbtree/rbtree_test.c b/tools/testing/selftests/lib/rbtree/rbtree_test.c
new file mode 100644
index 000000000000..11420541071a
--- /dev/null
+++ b/tools/testing/selftests/lib/rbtree/rbtree_test.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdlib.h>
+#include <linux/rbtree.h>
+#include "../../kselftest_harness.h"
+
+struct node {
+	struct rb_node node;
+	int key;
+};
+
+static int _insert(struct rb_root *tree, int key)
+{
+	struct rb_node **new = &tree->rb_node, *parent = NULL;
+	struct node *node;
+
+	while (*new) {
+		struct node *this = container_of(*new, struct node, node);
+
+		if (key < this->key)
+			new = &((*new)->rb_left);
+		else if (key > this->key)
+			new = &((*new)->rb_right);
+		else
+			return 0;
+	}
+
+	node = malloc(sizeof(struct node));
+	if (!node)
+		return 0;
+
+	node->key = key;
+	rb_link_node(&node->node, parent, new);
+	rb_insert_color(&node->node, tree);
+
+	return 1;
+}
+
+static void _remove(struct rb_root *tree, int key)
+{
+	struct rb_node **node = &tree->rb_node;
+
+	while (*node) {
+		struct node *this = container_of(*node, struct node, node);
+
+		if (key < this->key) {
+			node = &((*node)->rb_left);
+		} else if (key > this->key) {
+			node = &((*node)->rb_right);
+		} else {
+			rb_erase(&this->node, tree);
+			free(this);
+			return;
+		}
+	}
+}
+
+TEST(rbtree)
+{
+	struct rb_root tree = { 0 };
+
+	_insert(&tree, 2);
+	_insert(&tree, 1);
+	_insert(&tree, 4);
+	_insert(&tree, 3);
+
+	_remove(&tree, 2);
+}
+
+TEST_HARNESS_MAIN
-- 
2.24.1

