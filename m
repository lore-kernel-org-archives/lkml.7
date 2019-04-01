Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B864C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEB820850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDAKZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:25:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37356 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDAKZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:25:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so10729787wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfZApv54X1yOM81Sacel9lwRATFsVJl+/olwmtAQ5MY=;
        b=t3LRaLt0q67BzPYUm69v0OhCdFtuttkZJmiehmIDjkzp9bsC4HQv79R5PuLJ1SQmLw
         az3KrQPl5lvcljxhkWTqHiYsuuV6/NgHPZubAcxPhdP4LDs375NRXi0f6uVYmD61LsN2
         n3wTUt6dOJxwfVz6D7qQ+knLfKNkkZLSbadHy/EnSt0/9HVXVv/ziBkhxhALco//NqRo
         Gkfvf7vORNgHrzoLM0IdpY7YEqMXKhz0jGaQ/7Q9lYTAOynfGzh6qDyStjXejxsjXoRO
         eCNyHqpJYm59h+hmSdo0M3lmXlCajjiMRb8drujsclUeGMtOBLZ2+A/Num1MAGAPWZ5q
         yueQ==
X-Gm-Message-State: APjAAAWgl0fjz968io5wnUfd4/xUQizYDMyjPB4iY1FkM3N8aMkV9OuH
        ub6ifMJ/YEKJwWlpD4B0hMszXg==
X-Google-Smtp-Source: APXvYqye5zSYUZd5tlXzOlgx1c5NPv2syNsV1Av5t5npQTBSDbDdq7x3ITt/hO7HTjYtmhfgAbzZpg==
X-Received: by 2002:a1c:c4c3:: with SMTP id u186mr11604973wmf.138.1554114309613;
        Mon, 01 Apr 2019 03:25:09 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id 13sm8266084wmj.33.2019.04.01.03.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:25:08 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/4] aural error reporting framework
Date:   Mon,  1 Apr 2019 12:24:52 +0200
Message-Id: <20190401102456.11162-2-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401102456.11162-1-mcroce@redhat.com>
References: <20190401102456.11162-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel has had verbal error reporting since the beginning.
Different error conditions trigger different error messages, with
different severity: from a simple warning to the most feared kernel panic.

While this detailed error reporting is much helpful to developers or end
users, there are some cases in which it's impossible to notice that an
error happened.
The most common case is headless devices, such as home servers without an
attached display, or routers without an exposed serial port. Needless
to say, logging into the machine via SSH is not an option after such
a severe error.
In other cases the monitor might be attached, but the system is unable to
display the error, probably because there is an X server running and
the KMS switch fails. Or simply the user is visually impaired.

These are all cases when the aural errors framework comes to help. This
framework adds to the kernel a generic library to play sounds, which can
be used to report errors or generic events.

As the sound card driver could, and most probably will, become unusable
during a kernel crash, the sounds are played via the system buzzer which
has been around since the dawn of time.
The buzzer driver is simple, requires just a few register writes to work,
the hardware is extremely cheap and is already present on most machines.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/x86/lib/Makefile |  1 +
 arch/x86/lib/play.c   | 75 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/play.h  | 34 ++++++++++++++++++++
 lib/Kconfig.debug     |  5 +++
 4 files changed, 115 insertions(+)
 create mode 100644 arch/x86/lib/play.c
 create mode 100644 include/linux/play.h

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 140e61843a07..fcd1ee6adfad 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -28,6 +28,7 @@ lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
+lib-$(CONFIG_PLAY_LIB) += play.o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
diff --git a/arch/x86/lib/play.c b/arch/x86/lib/play.c
new file mode 100644
index 000000000000..e798eeb144f8
--- /dev/null
+++ b/arch/x86/lib/play.c
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Aural kernel panic - x86 implementation
+ *
+ * Copyright (C) 2019 Matteo Croce <mcroce@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation;
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/timex.h>
+#include <linux/i8253.h>
+#include <linux/play.h>
+#include <asm/io.h>
+
+#define CONTROL_WORD_REG	0x43
+#define COUNTER2		0x42
+#define SPEAKER_PORT		0x61
+
+void arch_play_one(unsigned int ms, unsigned int hz)
+{
+	unsigned long flags;
+	u8 p61;
+
+	/* filter out non audible by humans freqs */
+	if (hz >= 16 && hz <= 22000) {
+		unsigned int count = PIT_TICK_RATE / hz;
+
+		raw_spin_lock_irqsave(&i8253_lock, flags);
+
+		/* set buzzer
+		 * 0xB6
+		 * 1 0		Counter 2
+		 * 1 1		2xRD/2xWR bits 0..7, 8..15 of counter value
+		 * 0 1 1	Mode 3: Square Wave
+		 * 0		Counter is a 16 bit binary counter
+		 */
+		outb_p(0xB6, CONTROL_WORD_REG);
+
+		/* select desired HZ with two writes in counter 2, port 42h */
+		outb_p(count, COUNTER2);
+		outb_p(count >> 8, COUNTER2);
+
+		/* start beep
+		 * set bit 0-1 (0: SPEAKER DATA; 1: OUT2) of GATE2 (port 61h)
+		 */
+		p61 = inb_p(SPEAKER_PORT);
+		if ((p61 & 3) != 3)
+			outb_p(p61 | 3, SPEAKER_PORT);
+
+		raw_spin_unlock_irqrestore(&i8253_lock, flags);
+	}
+
+	msleep(ms * 9 / 10);
+
+	raw_spin_lock_irqsave(&i8253_lock, flags);
+
+	/* stop beep
+	 * clear bit 0-1 of port 61h
+	 */
+	p61 = inb_p(SPEAKER_PORT);
+	if (p61 & 3)
+		outb(p61 & 0xFC, SPEAKER_PORT);
+
+	raw_spin_unlock_irqrestore(&i8253_lock, flags);
+
+	msleep(ms / 10);
+}
diff --git a/include/linux/play.h b/include/linux/play.h
new file mode 100644
index 000000000000..ae30cb8a0c1d
--- /dev/null
+++ b/include/linux/play.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * play.h - Definitions and headers for the aural error reporting framework.
+ *
+ * Copyright (C) 2019 Matteo Croce <mcroce@redhat.com>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#ifndef _LINUX_PLAY_H
+#define _LINUX_PLAY_H
+
+#ifdef CONFIG_PLAY_LIB
+
+struct note {
+	unsigned int freq;
+	unsigned int dur;
+};
+
+void arch_play_one(unsigned int ms, unsigned int hz);
+
+#define play(notes, len) do {						\
+		int i;							\
+		for (i = 0; i < len; i++)				\
+			arch_play_one(notes[i].dur, notes[i].freq);	\
+	} while (0)
+
+#else
+
+#define play(n, l)
+
+#endif
+
+#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..10d04b266aef 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -992,6 +992,11 @@ config PANIC_TIMEOUT
 	  value n > 0 will wait n seconds before rebooting, while a timeout
 	  value n < 0 will reboot immediately.
 
+config PLAY_LIB
+	bool
+	depends on HAVE_PCSPKR_PLATFORM
+	default n
+
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
-- 
2.20.1

