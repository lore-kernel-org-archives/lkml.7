Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DB4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D98218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lv6Gu8ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfC2WJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:09:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46212 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbfC2WIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:08:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so1655234pfj.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2YQOYspJ2byrBgs9Jhml4Q1eg8eEADDA3sFm44l9/z8=;
        b=Lv6Gu8ZJBAJnnhiTeArKZl66MO2yAgRLdE0WlCJ8XYXh+1Zd3hKPDe+DEBkUsjOfGN
         YsWDP+q2gP78FiLOJwPLFVynGUuUIX6HzibZK6W8bFUU8mB72kbnD4Wpy7hSP0IEC6ax
         /ZK79hT7H1sO57ggqPGKr0avjMDoc1od6lwOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YQOYspJ2byrBgs9Jhml4Q1eg8eEADDA3sFm44l9/z8=;
        b=QOhvGeCXWf0CcR+lb1O69QhUoTY3OCyv7iOb5TeUvSiKtfhCyTVABeffCHRQpfYLzm
         fX8mb2zV3fnNWamNo98rASZb9b3ECzxfxryd13Eh5hDcpNdnGwoa6gviJfNS4aQ03ioi
         2goTA44ISx8PKUPNP6EXhIp7aaY3Rwh6YXK2uS8BbKcM5HBsfO6e7/rmryVF7Hk5can5
         JUwR+yjjq3vU19AWk7GMLMFgLJBfSPkHLD+TSvWqLxkxD7qzXoUpgTxboqkz9NjMlu18
         HFGMb2aBpNAdBDN8IAil2eBGoanCz51CcWwkzldQnpScbWTVwSrTL/9LKDf7ynCH0KHK
         zNxg==
X-Gm-Message-State: APjAAAWhd93npOG3BiPiQIspIShwqOSdsa5/jGda45/qPAVV7PIdWWVI
        nK9rhNGqlCucNqKIZa0znYfWnA==
X-Google-Smtp-Source: APXvYqxCms4Z+kzGVu2z0w9GdNo4xjnmiB98FGxGjluQPNN5nD5zp3TmNKeBRG4fNnxzDUBtSl/G/w==
X-Received: by 2002:a65:6489:: with SMTP id e9mr32445881pgv.364.1553897329280;
        Fri, 29 Mar 2019 15:08:49 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b7sm8925514pfj.67.2019.03.29.15.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:08:48 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v2 3/5] scripts/gdb: Add rb tree iterating utilities
Date:   Fri, 29 Mar 2019 15:08:42 -0700
Message-Id: <20190329220844.38234-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190329220844.38234-1-swboyd@chromium.org>
References: <20190329220844.38234-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement gdb functions for rb_first(), rb_last(), rb_next(), and
rb_prev(). These can be useful to iterate through the kernel's red-black
trees.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/gdb/linux/rbtree.py | 177 ++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py  |   1 +
 2 files changed, 178 insertions(+)
 create mode 100644 scripts/gdb/linux/rbtree.py

diff --git a/scripts/gdb/linux/rbtree.py b/scripts/gdb/linux/rbtree.py
new file mode 100644
index 000000000000..39db889b874c
--- /dev/null
+++ b/scripts/gdb/linux/rbtree.py
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2019 Google LLC.
+
+import gdb
+
+from linux import utils
+
+rb_root_type = utils.CachedType("struct rb_root")
+rb_node_type = utils.CachedType("struct rb_node")
+
+
+def rb_first(root):
+    if root.type == rb_root_type.get_type():
+        node = node.address.cast(rb_root_type.get_type().pointer())
+    elif root.type != rb_root_type.get_type().pointer():
+        raise gdb.GdbError("Must be struct rb_root not {}".format(root.type))
+
+    node = root['rb_node']
+    if node is 0:
+        return None
+
+    while node['rb_left']:
+        node = node['rb_left']
+
+    return node
+
+
+def rb_last(root):
+    if root.type == rb_root_type.get_type():
+        node = node.address.cast(rb_root_type.get_type().pointer())
+    elif root.type != rb_root_type.get_type().pointer():
+        raise gdb.GdbError("Must be struct rb_root not {}".format(root.type))
+
+    node = root['rb_node']
+    if node is 0:
+        return None
+
+    while node['rb_right']:
+        node = node['rb_right']
+
+    return node
+
+
+def rb_parent(node):
+    parent = gdb.Value(node['__rb_parent_color'] & ~3)
+    return parent.cast(rb_node_type.get_type().pointer())
+
+
+def rb_empty_node(node):
+    return node['__rb_parent_color'] == node.address
+
+
+def rb_next(node):
+    if node.type == rb_node_type.get_type():
+        node = node.address.cast(rb_node_type.get_type().pointer())
+    elif node.type != rb_node_type.get_type().pointer():
+        raise gdb.GdbError("Must be struct rb_node not {}".format(node.type))
+
+    if rb_empty_node(node):
+        return None
+
+    if node['rb_right']:
+        node = node['rb_right']
+        while node['rb_left']:
+            node = node['rb_left']
+        return node
+
+    parent = rb_parent(node)
+    while parent and node == parent['rb_right']:
+            node = parent
+            parent = rb_parent(node)
+
+    return parent
+
+
+def rb_prev(node):
+    if node.type == rb_node_type.get_type():
+        node = node.address.cast(rb_node_type.get_type().pointer())
+    elif node.type != rb_node_type.get_type().pointer():
+        raise gdb.GdbError("Must be struct rb_node not {}".format(node.type))
+
+    if rb_empty_node(node):
+        return None
+
+    if node['rb_left']:
+        node = node['rb_left']
+        while node['rb_right']:
+            node = node['rb_right']
+        return node.dereference()
+
+    parent = rb_parent(node)
+    while parent and node == parent['rb_left'].dereference():
+            node = parent
+            parent = rb_parent(node)
+
+    return parent
+
+
+class LxRbFirst(gdb.Function):
+    """Lookup and return a node from an RBTree
+
+$lx_rb_first(root): Return the node at the given index.
+If index is omitted, the root node is dereferenced and returned."""
+
+    def __init__(self):
+        super(LxRbFirst, self).__init__("lx_rb_first")
+
+    def invoke(self, root):
+        result = rb_first(root)
+        if result is None:
+            raise gdb.GdbError("No entry in tree")
+
+        return result
+
+
+LxRbFirst()
+
+
+class LxRbLast(gdb.Function):
+    """Lookup and return a node from an RBTree.
+
+$lx_rb_last(root): Return the node at the given index.
+If index is omitted, the root node is dereferenced and returned."""
+
+    def __init__(self):
+        super(LxRbLast, self).__init__("lx_rb_last")
+
+    def invoke(self, root):
+        result = rb_last(root)
+        if result is None:
+            raise gdb.GdbError("No entry in tree")
+
+        return result
+
+
+LxRbLast()
+
+
+class LxRbNext(gdb.Function):
+    """Lookup and return a node from an RBTree.
+
+$lx_rb_next(node): Return the node at the given index.
+If index is omitted, the root node is dereferenced and returned."""
+
+    def __init__(self):
+        super(LxRbNext, self).__init__("lx_rb_next")
+
+    def invoke(self, node):
+        result = rb_next(node)
+        if result is None:
+            raise gdb.GdbError("No entry in tree")
+
+        return result
+
+
+LxRbNext()
+
+
+class LxRbPrev(gdb.Function):
+    """Lookup and return a node from an RBTree.
+
+$lx_rb_prev(node): Return the node at the given index.
+If index is omitted, the root node is dereferenced and returned."""
+
+    def __init__(self):
+        super(LxRbPrev, self).__init__("lx_rb_prev")
+
+    def invoke(self, node):
+        result = rb_prev(node)
+        if result is None:
+            raise gdb.GdbError("No entry in tree")
+
+        return result
+
+
+LxRbPrev()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index be0efb5dda5b..89e4aa4f8966 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -30,5 +30,6 @@ else:
     import linux.config
     import linux.cpus
     import linux.lists
+    import linux.rbtree
     import linux.proc
     import linux.constants
-- 
Sent by a computer through tubes

