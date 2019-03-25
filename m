Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E8C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6770020700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b/qmNqaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfCYSpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:45:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35598 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfCYSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:45:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id p19so365020plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HU7yuDm8Y1RRdsoUGwsej4fqxozu4cJsDeGBIryMkHY=;
        b=b/qmNqaY1Sneu02VrFzYXfLnTX4W3+n6LQE8UZvUtWTr9Uai7zgvAqY9rLCSWmYiKi
         TQKQGC8V9iXNg4siXEdtNjkFKe7apc7pDoDheRFh0CsbmWyAZyo66AbKCouv8vQ576R2
         1eZUJjS8LFlQrbH9oMmMLIsuhx5K1ZVKzJnaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HU7yuDm8Y1RRdsoUGwsej4fqxozu4cJsDeGBIryMkHY=;
        b=ge3JzXyjZjTCjIrJhV+DxT+oXCWxmynWJPmKCbK8sO6uPNVNAZKk3pMOovUajSIJfu
         9ccY/Tb5NiODXcRYIKiWRyQlGczIQ1s20ePvA3VLXMuamTJqr6EXC9hgeG0ZhxLoXJro
         LqY3Z+yuJp4+eQcTGmktJG8vNGQjfDeUAOtltlMO35gb0nhhOw7aClK9aHjPvP3DmYST
         LL25T9hTZVNvjyAvJngHHzlsO6JTv/XYNZ/1HMU3EtuHDGCTVSNKS1UKV/b6cX35eZwi
         RCnEs7LZD0EJDHFTg8SG+VEREFx1gM3Gi4rHMNw0MPrag8WsL2KA4IcN29glQ33wEA1y
         CA3A==
X-Gm-Message-State: APjAAAV3w/4Lvy5pojy3ePKBgO9XwLHcM5sNOvov5CO+qHmC49nXc1Kx
        9G0XrOZkPFV5T3b53Lzo5Tpk7g==
X-Google-Smtp-Source: APXvYqwzIsTQ12Af8tucvjP1WMRJqPzNmgYegWhY+TyKe4r3Gbldkl5PB4G4kHfCiXqSyWmwsUpMng==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr27385924pll.66.1553539526223;
        Mon, 25 Mar 2019 11:45:26 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h3sm27505108pfb.31.2019.03.25.11.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:45:25 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 2/4] scripts/gdb: Add kernel config dumping command
Date:   Mon, 25 Mar 2019 11:45:20 -0700
Message-Id: <20190325184522.260535-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325184522.260535-1-swboyd@chromium.org>
References: <20190325184522.260535-1-swboyd@chromium.org>
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
 scripts/gdb/linux/config.py | 48 +++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py  |  1 +
 2 files changed, 49 insertions(+)
 create mode 100644 scripts/gdb/linux/config.py

diff --git a/scripts/gdb/linux/config.py b/scripts/gdb/linux/config.py
new file mode 100644
index 000000000000..400f09bb2665
--- /dev/null
+++ b/scripts/gdb/linux/config.py
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2019 Google LLC.
+
+import gdb
+import zlib
+
+from linux import utils
+
+class LxConfigDump(gdb.Command):
+    """Output kernel config to the filename specified as the command
+       argument. Equivalent to 'zcat /proc/config.gz > config.txt' on
+       a running target"""
+
+    def __init__(self):
+        super(LxConfigDump, self).__init__("lx-configdump", gdb.COMMAND_DATA,
+                                        gdb.COMPLETE_FILENAME)
+
+    def invoke(self, arg, from_tty):
+        if len(arg) == 0:
+            filename = "config.txt"
+        else:
+            filename = arg
+
+        try:
+            py_config_ptr = gdb.parse_and_eval(
+                "kernel_config_data + 8")
+            py_config_size = gdb.parse_and_eval(
+                "sizeof(kernel_config_data) - 2 - 8 * 2")
+        except:
+            raise gdb.GdbError("Can't find config, enable CONFIG_IKCONFIG?")
+
+        inf = gdb.inferiors()[0]
+        zconfig_buf = utils.read_memoryview(inf, py_config_ptr,
+                                        py_config_size).tobytes()
+
+        config_buf = zlib.decompress(zconfig_buf, 16)
+        try:
+            f = open(filename, 'wb')
+        except:
+            raise gdb.GdbError("Could not open file to dump config")
+
+        f.write(config_buf)
+        f.close()
+
+        gdb.write("Dumped config to " + filename + "\n")
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

