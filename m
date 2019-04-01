Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A8420850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfDAKZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:25:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33331 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDAKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:25:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so11285136wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxKBcW26rWDzJ50nBBK2OmMkZ1pasv8tsZhbSDCEQtI=;
        b=nWmwR3Ir8Vs/WZFPq8WjPAQvtTVYUDI2iWRw/cNUBb1NIBwMp7lFV4bZ18IEqPjmHU
         9Gr8XilagUvgxqYQWx8T4rddkh+2bneI4Oy8rz7LUXgj9TBYC99a81QQXy9i1RlH0oVV
         7vYvWZGNHdlPUSD4KDawYCfYXlrwfSYJwgHNzGcQuzTDZlOPhl9l8qV0N6vAJCMKh3si
         0o26QU9x44uZoClKlf879mQtJbGRi9GIFsyG0YKGuUoPuRZn/qpu5/HzBnIqkBGsFjGo
         Hy47VYUBmsnRDecYZQYNdcuq274/1mQEWWk147sd6m04kIIuYm/oEW4u7LsVhQ1U2jRl
         hFUw==
X-Gm-Message-State: APjAAAWbVdNPwL8bwnr2d0yRsZRS6+RrloQjvyzbthyfJDIpBc4EgS0Q
        WdpxxepHk3MHwGfdW7og3rNaBg==
X-Google-Smtp-Source: APXvYqzAKzKUoluq5/8HnbM41j1QFyEIHYPZ0sIQIFyHGVS+U79pKcmqBYAw3nEWjYtBTNotGI+2+Q==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr28715378wro.244.1554114343867;
        Mon, 01 Apr 2019 03:25:43 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id q4sm11869071wrx.25.2019.04.01.03.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:25:43 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 4/4] oops: use the aural error reporting framework to report oopses
Date:   Mon,  1 Apr 2019 12:24:55 +0200
Message-Id: <20190401102456.11162-5-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401102456.11162-1-mcroce@redhat.com>
References: <20190401102456.11162-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new aural error reporting framework when reporting an oops. The
sound is emitted at the end of oops_exit(), to avoid interfering with other
oops actions, like stack dump.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 kernel/panic.c    | 18 ++++++++++++++++++
 lib/Kconfig.debug | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index b87c4403924d..ea34f93ce410 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -97,6 +97,23 @@ static struct note warn_sound[] = {
 };
 #endif
 
+#ifdef CONFIG_AUDIBLE_OOPS
+static struct note oops_sound[] = {
+	{ 494, 100 },
+	{ 698, 100 },
+	{   0, 100 },
+	{ 698, 100 },
+	{ 698, 133 },
+	{ 659, 133 },
+	{ 587, 133 },
+	{ 523, 100 },
+	{ 330, 100 },
+	{ 262, 100 },
+	{ 330, 100 },
+	{ 262, 100 },
+};
+#endif
+
 static long no_blink(int state)
 {
 	return 0;
@@ -575,6 +592,7 @@ void oops_exit(void)
 	do_oops_enter_exit();
 	print_oops_end_marker();
 	kmsg_dump(KMSG_DUMP_OOPS);
+	play(oops_sound, ARRAY_SIZE(oops_sound));
 }
 
 struct warn_args {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 909c271d283b..74745ef386ce 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1017,6 +1017,16 @@ config AUDIBLE_WARN
 	  the system buzzer and not via any soundcard.
 	  Not available on all platforms.
 
+config AUDIBLE_OOPS
+	bool "Aural oops"
+	select PLAY_LIB
+	default n
+	help
+	  If you say Y here, oops will play a sound just
+	  after the stacktrace and registers dump. The sound is played via
+	  the system buzzer and not via any soundcard.
+	  Not available on all platforms.
+
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
-- 
2.20.1

