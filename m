Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226A6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E495920857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sUw9QIFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbfCAQJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:09:22 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37039 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfCAQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:09:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id a48so28344223qtb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tUTcdFJpn3In6T+iaMar4GvTuGhsqDUqTo6MJRj8sI=;
        b=sUw9QIFnN2LrpfvVfFpST4G5uVljpmzsdyXRNB2d6DMD8mR5pytmy504BkpbtFIuTd
         g7CR8mD0edAKCM7GHP/+t8WHKqNXuWWLlFg7QhjKJqbf4GLGFBSzr+HXzB9GCJOnDo53
         MZQtEAUY6jNt6BO44pXLLmgqwsOH8CbZQGnr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tUTcdFJpn3In6T+iaMar4GvTuGhsqDUqTo6MJRj8sI=;
        b=I+zXVO8uiE1pC+45DcyH9UC0x4vyPQf1FK3FLIzAHj1IPEWjNrRziQMmkO7V3YNpRO
         +hO8T6Y13wBacvA+b4pha3+Gzo7Ajno6y3gBu6FApYoSeH6Hw4h7eCz/a1cF3BJI5Ge5
         DHGkiqjnCB8GVR2gQODbuyoyxq/4KXaZBEDW4rzXyZtrvvi1wq0AJtDMWKItLHQIyRhM
         rhkGgtrwAWZbZX/diwI37tURnPu5MsCKnKgGnv24Dznf8gcf5a2qehVR8bZCVNfZ2tSd
         ga2wAIDMkXsRhSlgJ9Xx4eU+j7KbpQ4A5+GfoLFCS2u7BL2khA+OpsND43IKK+WxElzj
         HTvw==
X-Gm-Message-State: APjAAAXCmy8G7fxFOek6EAJCuIhIagWRLH0itkx3WfDP82R6bLBTrQLW
        QxRYYcIxTp6Pbpvp8vWmP8i4e9Yb6xY=
X-Google-Smtp-Source: APXvYqwrpF3GxKEve06ijUFVBlAuHPWKJADUWB3w6qkI2dQQS4NtvvEPoO771XOvovLszirLk2DoLw==
X-Received: by 2002:ac8:fbb:: with SMTP id b56mr4684257qtk.41.1551456557165;
        Fri, 01 Mar 2019 08:09:17 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id h58sm15090062qtb.89.2019.03.01.08.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:09:16 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, gregkh@linuxfoundation.org,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        mhiramat@kernel.org, qais.yousef@arm.com, rdunlap@infradead.org,
        rostedt@goodmis.org, Shuah Khan <shuah@kernel.org>, yhs@fb.com
Subject: [PATCH v4 2/2] Add selftests for module build using in-kernel headers
Date:   Fri,  1 Mar 2019 11:08:56 -0500
Message-Id: <20190301160856.129678-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190301160856.129678-1-joel@joelfernandes.org>
References: <20190301160856.129678-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test tries to build a module successfully using the in-kernel
headers found in /proc/kheaders.tar.xz.

Verified pass and fail scenarios by running:
make -C tools/testing/selftests TARGETS=kheaders run_tests

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/kheaders/Makefile     |  5 +++++
 tools/testing/selftests/kheaders/config       |  1 +
 .../kheaders/run_kheaders_modbuild.sh         | 18 +++++++++++++++++
 .../selftests/kheaders/testmod/Makefile       |  3 +++
 .../testing/selftests/kheaders/testmod/test.c | 20 +++++++++++++++++++
 6 files changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/kheaders/Makefile
 create mode 100644 tools/testing/selftests/kheaders/config
 create mode 100755 tools/testing/selftests/kheaders/run_kheaders_modbuild.sh
 create mode 100644 tools/testing/selftests/kheaders/testmod/Makefile
 create mode 100644 tools/testing/selftests/kheaders/testmod/test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 400ee81a3043..5a9287fddd0d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -20,6 +20,7 @@ TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
+TARGETS += kheaders
 TARGETS += kvm
 TARGETS += lib
 TARGETS += membarrier
diff --git a/tools/testing/selftests/kheaders/Makefile b/tools/testing/selftests/kheaders/Makefile
new file mode 100644
index 000000000000..51035ab0732b
--- /dev/null
+++ b/tools/testing/selftests/kheaders/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := run_kheaders_modbuild.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/kheaders/config b/tools/testing/selftests/kheaders/config
new file mode 100644
index 000000000000..5221f9fb5e79
--- /dev/null
+++ b/tools/testing/selftests/kheaders/config
@@ -0,0 +1 @@
+CONFIG_IKHEADERS_PROC=y
diff --git a/tools/testing/selftests/kheaders/run_kheaders_modbuild.sh b/tools/testing/selftests/kheaders/run_kheaders_modbuild.sh
new file mode 100755
index 000000000000..f001568e08b0
--- /dev/null
+++ b/tools/testing/selftests/kheaders/run_kheaders_modbuild.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+HEADERS_XZ=/proc/kheaders.tar.xz
+TMP_DIR_HEADERS=$(mktemp -d)
+TMP_DIR_MODULE=$(mktemp -d)
+SPATH="$(dirname "$(readlink -f "$0")")"
+
+tar -xvf $HEADERS_XZ -C $TMP_DIR_HEADERS > /dev/null
+
+cp -r $SPATH/testmod $TMP_DIR_MODULE/
+
+pushd $TMP_DIR_MODULE/testmod > /dev/null
+make -C $TMP_DIR_HEADERS M=$(pwd) modules
+popd > /dev/null
+
+rm -rf $TMP_DIR_HEADERS
+rm -rf $TMP_DIR_MODULE
diff --git a/tools/testing/selftests/kheaders/testmod/Makefile b/tools/testing/selftests/kheaders/testmod/Makefile
new file mode 100644
index 000000000000..7083e28706e8
--- /dev/null
+++ b/tools/testing/selftests/kheaders/testmod/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-m += test.o
diff --git a/tools/testing/selftests/kheaders/testmod/test.c b/tools/testing/selftests/kheaders/testmod/test.c
new file mode 100644
index 000000000000..6eb0b8492ffa
--- /dev/null
+++ b/tools/testing/selftests/kheaders/testmod/test.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+static int __init hello_init(void)
+{
+	printk(KERN_INFO "Hello, world\n");
+	return 0;
+}
+
+static void __exit hello_exit(void)
+{
+	printk(KERN_INFO "Goodbye, world\n");
+}
+
+module_init(hello_init);
+module_exit(hello_exit);
+MODULE_LICENSE("GPL v2");
-- 
2.21.0.352.gf09ad66450-goog

