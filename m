Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D263218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gYF74FVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfC2WI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:08:59 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:44314 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfC2WIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:08:52 -0400
Received: by mail-pl1-f173.google.com with SMTP id g12so1630417pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iO/j6hu+52hK77yqW3gDnmljlHibOdMHzB9G1hKqcBI=;
        b=gYF74FVss7m4gBuaCRoW7jMu4b/rT33heLSHVx2QEKy4XAeaEspMbdYo9ajjOkVWO1
         9EGX31SaE58LNxxI8WgLS+VPuEr6bghiHQ/P2gsSRgJgwymGMdaCK76HO5NtX9swfUz0
         pntrtdWP8/RPUGCT+gu5dfkHM2Nga8JVzrhw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iO/j6hu+52hK77yqW3gDnmljlHibOdMHzB9G1hKqcBI=;
        b=tpcVCJ8LHJYdNBnjSNtgjA0YEyuS859/wbRX6EuJeGV+ARfKe2xMVwbEe2cCYZj1wv
         aFLrU3mp9htBXunQ72uri9OXfSIHXSN8u6y3h1JwoXcjF0vnUDJdHfrZDnCg1CwPyepx
         cB7Yu4CszJUv7NO0d8nnlCvXAQ6i+6ixxzX0ZNJNsrMLMr6oDAc8ZkGoUJUk4h1A/fYr
         RIMLFpR+hNTyuEgl7y2uNzP21FrS3Gk+JqH+h09jUAaVFiS+RC05lAZyS3+hXXXZ85r3
         FariizAphWfUKdNHzluysizE3I30254M82TBZWJlwMCJjl5YnbwKKOqv35adoIcPUpd3
         e9lQ==
X-Gm-Message-State: APjAAAXH8YO+x5L5RWFxIfj1Y7ySUEt5I+i1PgxeQuwXyoEY2DUmxDSw
        89b7HpQw/73tyD9jzNmwJQpzBw==
X-Google-Smtp-Source: APXvYqz6OIaYDKN7iaa7VXPjG0No67LxAsEEv5vfxWrlqNShxkO+PM0FQA0cRkp5yYtCoPt9FO8rlQ==
X-Received: by 2002:a17:902:968a:: with SMTP id n10mr52068045plp.283.1553897331172;
        Fri, 29 Mar 2019 15:08:51 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b7sm8925514pfj.67.2019.03.29.15.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:08:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v2 5/5] scripts/gdb: Silence pep8 checks
Date:   Fri, 29 Mar 2019 15:08:44 -0700
Message-Id: <20190329220844.38234-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190329220844.38234-1-swboyd@chromium.org>
References: <20190329220844.38234-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These scripts have some pep8 style warnings. Fix them up so that this
directory is all pep8 clean.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/gdb/linux/cpus.py  |  1 +
 scripts/gdb/linux/lists.py |  1 +
 scripts/gdb/linux/proc.py  | 10 ++++++++--
 scripts/gdb/linux/tasks.py |  2 ++
 scripts/gdb/linux/utils.py |  7 ++++---
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index ca11e8df31b6..008e62f3190d 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -135,6 +135,7 @@ and can help identify the state of hotplugged CPUs"""
         gdb.write("Online CPUs   : {}\n".format(list(each_online_cpu())))
         gdb.write("Active CPUs   : {}\n".format(list(each_active_cpu())))
 
+
 LxCpus()
 
 
diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
index 2f335fbd86fd..1987d756b36b 100644
--- a/scripts/gdb/linux/lists.py
+++ b/scripts/gdb/linux/lists.py
@@ -110,4 +110,5 @@ class LxListChk(gdb.Command):
             raise gdb.GdbError("lx-list-check takes one argument")
         list_check(gdb.parse_and_eval(argv[0]))
 
+
 LxListChk()
diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 2f01a958eb22..6a56bba233a9 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -29,6 +29,7 @@ class LxCmdLine(gdb.Command):
     def invoke(self, arg, from_tty):
         gdb.write(gdb.parse_and_eval("saved_command_line").string() + "\n")
 
+
 LxCmdLine()
 
 
@@ -43,6 +44,7 @@ class LxVersion(gdb.Command):
         # linux_banner should contain a newline
         gdb.write(gdb.parse_and_eval("(char *)linux_banner").string())
 
+
 LxVersion()
 
 
@@ -86,6 +88,7 @@ Equivalent to cat /proc/iomem on a running target"""
     def invoke(self, arg, from_tty):
         return show_lx_resources("iomem_resource")
 
+
 LxIOMem()
 
 
@@ -100,6 +103,7 @@ Equivalent to cat /proc/ioports on a running target"""
     def invoke(self, arg, from_tty):
         return show_lx_resources("ioport_resource")
 
+
 LxIOPorts()
 
 
@@ -149,7 +153,7 @@ values of that process namespace"""
         if len(argv) >= 1:
             try:
                 pid = int(argv[0])
-            except:
+            except gdb.error:
                 raise gdb.GdbError("Provide a PID as integer value")
         else:
             pid = 1
@@ -195,6 +199,7 @@ values of that process namespace"""
                         info_opts(FS_INFO, s_flags),
                         info_opts(MNT_INFO, m_flags)))
 
+
 LxMounts()
 
 
@@ -259,7 +264,7 @@ class LxFdtDump(gdb.Command):
 
         try:
             f = open(filename, 'wb')
-        except:
+        except gdb.error:
             raise gdb.GdbError("Could not open file to dump fdt")
 
         f.write(fdt_buf)
@@ -267,4 +272,5 @@ class LxFdtDump(gdb.Command):
 
         gdb.write("Dumped fdt blob to " + filename + "\n")
 
+
 LxFdtDump()
diff --git a/scripts/gdb/linux/tasks.py b/scripts/gdb/linux/tasks.py
index f6ab3ccf698f..0301dc1e0138 100644
--- a/scripts/gdb/linux/tasks.py
+++ b/scripts/gdb/linux/tasks.py
@@ -79,6 +79,7 @@ class LxPs(gdb.Command):
                 pid=task["pid"],
                 comm=task["comm"].string()))
 
+
 LxPs()
 
 
@@ -134,4 +135,5 @@ variable."""
         else:
             raise gdb.GdbError("No task of PID " + str(pid))
 
+
 LxThreadInfoByPidFunc()
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index 50805874cfc3..bc67126118c4 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -66,6 +66,7 @@ Note that TYPE and ELEMENT have to be quoted as strings."""
         return container_of(ptr, gdb.lookup_type(typename.string()).pointer(),
                             elementname.string())
 
+
 ContainerOf()
 
 
@@ -148,14 +149,14 @@ def get_gdbserver_type():
     def probe_qemu():
         try:
             return gdb.execute("monitor info version", to_string=True) != ""
-        except:
+        except gdb.error:
             return False
 
     def probe_kgdb():
         try:
             thread_info = gdb.execute("info thread 2", to_string=True)
             return "shadowCPU0" in thread_info
-        except:
+        except gdb.error:
             return False
 
     global gdbserver_type
@@ -172,7 +173,7 @@ def get_gdbserver_type():
 def gdb_eval_or_none(expresssion):
     try:
         return gdb.parse_and_eval(expresssion)
-    except:
+    except gdb.error:
         return None
 
 
-- 
Sent by a computer through tubes

