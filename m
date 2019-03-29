Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF54C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785372184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FClaHhqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfC2WIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:08:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42006 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfC2WIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:08:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so1631197plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kUZQQA2GKtWxHBBxz17LTPFGb44NhvGeaaZASMGEJI=;
        b=FClaHhqwekpccXxPTnFyyYo5NWMFrwMCToOCLvDm0QQfpoAYOXiMKNQjI1jNokFj21
         SOHXNYjt0V1ib2KDT+z4wUOAXN/z9MBR3U8vJ/pdOcHJYmDtS6H+OPgVxLROaOfF7Kb0
         xpFo07GHOxNm62iF/ia8ECDO+7LpYDmAJ2AC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kUZQQA2GKtWxHBBxz17LTPFGb44NhvGeaaZASMGEJI=;
        b=UcKoWnHGZS/jxGF9TS5PUBzgAc+khZmmm9z5magUFlYOYY/bMWJv3Tu9fog+FKSNU/
         wsSpxZ09NP5OZDs1axgMcQj6175Ecg4H0PbxxBctZhuwp0LGvSRq7qwaLlJm5ZLB+p3h
         vvdWQXPrjRfmN+RvxZhiSN9gI+BTgtpACYX2KEiTqW+M+pkfnwsdZ3bHaU8wAG6EXr6V
         RQx90L7ipGN6VeHxdhEgC185heL0Z17CmHsWyGSAr6IQo6nbWTUS1GMZo4Pys/Xc0fhe
         wb9zNvtyH0KPvcPqTQ/3+VIKLBkEW0XoPAUe1DI6RhkbJUCvD/hxPNEzaz17ihtTsoKJ
         sZZQ==
X-Gm-Message-State: APjAAAU9R/xp1r7+INbYzzzkyMt7zLtOsliqpErqvwAeBRHbdQ7FSuim
        nivMTM2k4LACc0qonFFILy8qNg==
X-Google-Smtp-Source: APXvYqwK1mjFhNJvxzc5btNMBliNGKZnYN+9RLY9S5E3mRfwa+ssalH0/nj0n7l5wjV2AHv4yQGUcA==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr26756223plr.251.1553897328332;
        Fri, 29 Mar 2019 15:08:48 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b7sm8925514pfj.67.2019.03.29.15.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:08:47 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v2 2/5] scripts/gdb: Add kernel config dumping command
Date:   Fri, 29 Mar 2019 15:08:41 -0700
Message-Id: <20190329220844.38234-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190329220844.38234-1-swboyd@chromium.org>
References: <20190329220844.38234-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lx-configdump <file> dumps the contents of the gzipped .config to a text
file when the config is included in the kernel with CONFIG_IKCONFIG. By
default, the file written is called config.txt, but it can be any user
supplied filename as well. If the kernel config is in a module
(configs.ko), then it can be loaded along with symbols for the module
loaded with 'lx-symbols' and then this command will still work.

Obviously if you have the whole vmlinux then this can also be achieved
with scripts/extract-ikconfig, but this gdb script can be useful to
confirm that the memory contents of the config in memory and the vmlinux
contents on disk match what is expected.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/gdb/linux/config.py | 44 +++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py  |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 scripts/gdb/linux/config.py

diff --git a/scripts/gdb/linux/config.py b/scripts/gdb/linux/config.py
new file mode 100644
index 000000000000..90e1565b1967
--- /dev/null
+++ b/scripts/gdb/linux/config.py
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2019 Google LLC.
+
+import gdb
+import zlib
+
+from linux import utils
+
+
+class LxConfigDump(gdb.Command):
+    """Output kernel config to the filename specified as the command
+       argument. Equivalent to 'zcat /proc/config.gz > config.txt' on
+       a running target"""
+
+    def __init__(self):
+        super(LxConfigDump, self).__init__("lx-configdump", gdb.COMMAND_DATA,
+                                           gdb.COMPLETE_FILENAME)
+
+    def invoke(self, arg, from_tty):
+        if len(arg) == 0:
+            filename = "config.txt"
+        else:
+            filename = arg
+
+        try:
+            py_config_ptr = gdb.parse_and_eval("kernel_config_data + 8")
+            py_config_size = gdb.parse_and_eval(
+                    "sizeof(kernel_config_data) - 1 - 8 * 2")
+        except gdb.error as e:
+            raise gdb.GdbError("Can't find config, enable CONFIG_IKCONFIG?")
+
+        inf = gdb.inferiors()[0]
+        zconfig_buf = utils.read_memoryview(inf, py_config_ptr,
+                                            py_config_size).tobytes()
+
+        config_buf = zlib.decompress(zconfig_buf, 16)
+        with open(filename, 'wb') as f:
+            f.write(config_buf)
+
+        gdb.write("Dumped config to " + filename + "\n")
+
+
+LxConfigDump()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 6e0b0afd888a..be0efb5dda5b 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -27,6 +27,7 @@ else:
     import linux.modules
     import linux.dmesg
     import linux.tasks
+    import linux.config
     import linux.cpus
     import linux.lists
     import linux.proc
-- 
Sent by a computer through tubes

