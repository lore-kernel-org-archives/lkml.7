Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1F1C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF2320700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/UVp40u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfCYSpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:45:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33364 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbfCYSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:45:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id bg8so365607plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kmsHVHwRW2GoUjDq2HMnJ2B6KfhAjdgdc6GgqJtMbY=;
        b=W/UVp40u5rpLdWo11qSsK1lLhrrnjrGZ2Qu0ID3ehdNvlRg6FF6W8AoIgFfIqhQYmh
         9uHggIvfbF/HzSo5LrfI0nbgkK9bRF5Bq7seJnxU8HhEF6g5Fc7k4HiTM1I+VN/BtOFW
         brOTKy7Ac+QR0cwOzjkytiaervP+N1SsscRIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kmsHVHwRW2GoUjDq2HMnJ2B6KfhAjdgdc6GgqJtMbY=;
        b=I3ulXM78y9y/T/rDr7jYDTr1pLFUd2RV5IQNWBi13Dd0zGn5rqGA86I35GpRQZg+2A
         AgV0affocQkzf0nRZnfIbYjSEv+D5uBBcmkx2V3kzTMvektboF2xfcSb4G1umPzVR3dr
         vp5dz99KUZ+WnTECKCJSEY8AkZQML79G+FAJlo1AWHoeNDzAZjoXRYuEhS30bO3kEKrg
         al2bKCvqsu81j/GYQo8ePiRWi44/LSOP0IShcEn6gWQ0h1RQzqa8ofCDaBiBMzeJ28Nr
         tPtqjJa/LJtb920Up+cdSQloGdINZudmKoDWOp1jFfjCGtR0T6K/F2eUfWLh5Q9m2TzB
         Xl6Q==
X-Gm-Message-State: APjAAAWB5fYhSsrYFexKeNbV3XXvsVVyAQm7AjWtqoSNa4KyCPD1rz2W
        zUb4cnT26toOexlQXenUV5m3mQ==
X-Google-Smtp-Source: APXvYqwWgUxC/tyW+5KDXQlOhGy5c+v1BE4kRzaPRDI8uis1jyNs8dxgjh84Dj93HNDHo2sLnJmEOg==
X-Received: by 2002:a17:902:848f:: with SMTP id c15mr26795259plo.240.1553539527172;
        Mon, 25 Mar 2019 11:45:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h3sm27505108pfb.31.2019.03.25.11.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:45:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 3/4] scripts/gdb: Add rb tree iterating utilities
Date:   Mon, 25 Mar 2019 11:45:21 -0700
Message-Id: <20190325184522.260535-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325184522.260535-1-swboyd@chromium.org>
References: <20190325184522.260535-1-swboyd@chromium.org>
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
 scripts/gdb/linux/rbtree.py | 169 ++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py  |   1 +
 2 files changed, 170 insertions(+)
 create mode 100644 scripts/gdb/linux/rbtree.py

diff --git a/scripts/gdb/linux/rbtree.py b/scripts/gdb/linux/rbtree.py
new file mode 100644
index 000000000000..fd7b0b961ca1
--- /dev/null
+++ b/scripts/gdb/linux/rbtree.py
@@ -0,0 +1,169 @@
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
+        raise gdb.GdbError("Must be struct rb_root not {}"
+                .format(root.type))
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
+def rb_last(root):
+    if root.type == rb_root_type.get_type():
+        node = node.address.cast(rb_root_type.get_type().pointer())
+    elif root.type != rb_root_type.get_type().pointer():
+        raise gdb.GdbError("Must be struct rb_root not {}"
+                .format(root.type))
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
+def rb_parent(node):
+    parent = gdb.Value(node['__rb_parent_color'] & ~3)
+    return parent.cast(rb_node_type.get_type().pointer())
+
+def rb_empty_node(node):
+    return node['__rb_parent_color'] == node.address
+
+def rb_next(node):
+    if node.type == rb_node_type.get_type():
+        node = node.address.cast(rb_node_type.get_type().pointer())
+    elif node.type != rb_node_type.get_type().pointer():
+        raise gdb.GdbError("Must be struct rb_node not {}"
+                .format(node.type))
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
+def rb_prev(node):
+    if node.type == rb_node_type.get_type():
+        node = node.address.cast(rb_node_type.get_type().pointer())
+    elif node.type != rb_node_type.get_type().pointer():
+        raise gdb.GdbError("Must be struct rb_node not {}"
+                .format(node.type))
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
+LxRbFirst()
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
+LxRbLast()
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
+LxRbNext()
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

