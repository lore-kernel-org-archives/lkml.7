Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D62C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA1E20850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDAKZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:25:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38478 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfDAKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:25:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so11285608wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PZs3tnG+oChvFnAzez0PCW1+F33VtcOpKbbfmVAZG8=;
        b=eh76BABVTuKwZMk7JZYK+BWtRBMn+V0AbAEkhvxh0xGBCE4XK0xYS4HRU1+WTxMmcW
         j8GCsq6fDKEt6qbLvZD+Idp83MN6spMUB/lBhzPagsexpw+9DMrp/eppdvbSHFV45YyT
         Izw+lnMflCo9SKarmEpQS0Y1YoYVjU5qCy6h5noml9vDWy4Gvfvn7jGfU4HfuuFp1OZk
         HxkfXT2zKnxbiTvM21xYApMwuvxOkT+xrt3YDWwQt6pshfapSsNAQvsyX5FfQCi6eluU
         ZoH75ETPI/qFv5v+tYVu2qIy1Wq3BIJ6F1iqVzfpnFjRX/y14nCTwXV8yeIGQriF22aM
         rZBw==
X-Gm-Message-State: APjAAAWT6CBCXCeMN85ot2bSN1CnzXkodLdBb2/PsBEG6LLWSd4946fb
        oXMEaJ7quPbjTDXqj7gr+b4oDA==
X-Google-Smtp-Source: APXvYqzq/2GLBNkP55y+Mu/c3hkX+oePOZjy+FkwnJD9W4lHZoCpALJstxLzox2tyuGLChxJdRuGRQ==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr28452777wru.299.1554114355255;
        Mon, 01 Apr 2019 03:25:55 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id r9sm8947247wmh.38.2019.04.01.03.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:25:54 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 5/4] procfs: utility handler to trigger different errors
Date:   Mon,  1 Apr 2019 12:24:56 +0200
Message-Id: <20190401102456.11162-6-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401102456.11162-1-mcroce@redhat.com>
References: <20190401102456.11162-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a /proc/crashtest handler which triggers different kernel errors.
Just write a single character (if many are written, only the first one
is read), to trigger different errors:
- p: raise a kernel panic
- w: generate a warning
- o: raise an oops
The handler permissions are set to 0220 to avoid non root users to crash
the system.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 fs/proc/Makefile    |  1 +
 fs/proc/crashtest.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 fs/proc/crashtest.c

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index ead487e80510..df99d3245ad9 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -15,6 +15,7 @@ proc-$(CONFIG_TTY)      += proc_tty.o
 proc-y	+= cmdline.o
 proc-y	+= consoles.o
 proc-y	+= cpuinfo.o
+proc-y	+= crashtest.o
 proc-y	+= devices.o
 proc-y	+= interrupts.o
 proc-y	+= loadavg.o
diff --git a/fs/proc/crashtest.c b/fs/proc/crashtest.c
new file mode 100644
index 000000000000..ad7d21cc9d98
--- /dev/null
+++ b/fs/proc/crashtest.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+
+static ssize_t crashtest_write(struct file *file, const char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	char cmd;
+
+	if (!count)
+		return 0;
+
+	if (get_user(cmd, buf))
+		return -EFAULT;
+
+	switch (cmd) {
+	case 'p':
+		panic("crashtest");
+		break;
+	case 'w':
+		WARN(1, "crashtest");
+		break;
+	case 'o':
+		*(int*)0 = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations proc_crashtest_ops = {
+	.write	= crashtest_write,
+};
+
+static int __init proc_crashtest_init(void)
+{
+	return !proc_create("crashtest", 0220, NULL, &proc_crashtest_ops);
+}
+fs_initcall(proc_crashtest_init);
-- 
2.20.1

