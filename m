Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E096C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C5A2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plMzkZ2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHKSt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:49:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42198 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfHKSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:49:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id 15so4676338ljr.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAzxUIh+F3vyPVqhjFc/DJxcezBxry9v7OnC5t1hVac=;
        b=plMzkZ2QMZblSXmGPP4mHFOaGUWc5TWrDtPJ1limo7EGe6D/+1jgDfPpiVEBQ+744F
         7hSqoU+53D03QTvqToghkFYT2ewGvVxFNpVkmnjcMP49UrhEkR8nn062JYJnF89hWlll
         xAdNyM//p+WX6Uu/OIxi2wJcQO/T9QDgdvmEFsmZyOBFpdXPQm4uBECnVYXi0XLkxMrI
         2TibcHrL+PNc0kMV0S4+IZOwBMJQcB0i9zrHkWQh81oeM06X/jJZGryAltsQplnG5jJ4
         KGGQExadxrZ2WywvA/999Fm6i+mntOmaRKHIN3aJQgZgMvW54Te4uA2xPoCLqPM3iSYj
         7BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAzxUIh+F3vyPVqhjFc/DJxcezBxry9v7OnC5t1hVac=;
        b=Km9KmwywRwyp2uOs+kFEDO8Ca2YU9yFYJS3x6wrDrzt0TdHTK1WmeGhukG2qyMswht
         e+94339Zvl7cfE5OyS0r+wwtLtI6cnTBpNpIESmoTZtFYrw+ApRQ72m8PxSa0jtlO64S
         g5gZGNxfAvHiBDSSFJKKL9RBtF5+DxybPFvMbr8G8J93d3vWqsYSYFohCC3FbicNp0yl
         8969cTYlAACAA2iI8MEyhQY6X9/5oNq1yq1i5E8FYpEpAspZ2O684fsFylVmEzlaRx4p
         QdSUMBvBFI7urEuJIpKTYmkT0jSVAZKdUNXuBPraF2QPnIqvnB/MDmaNnpUU77fKenTY
         KU+w==
X-Gm-Message-State: APjAAAV8tmmX5wKe3xVPZn7isDzHD7BEp8XmphurVeyZFla7Wv9TL+ON
        XGmz2PQoEzmqfoKzLow5E90=
X-Google-Smtp-Source: APXvYqzlHdUeOxCOYse1sYa4OgV1J54zLR1O70z+HRG7YbfybQsA5rc9GlxXOKglSbJ70CaduAeTcQ==
X-Received: by 2002:a2e:8986:: with SMTP id c6mr8823621lji.59.1565549394387;
        Sun, 11 Aug 2019 11:49:54 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id r21sm5250117lfi.32.2019.08.11.11.49.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 11:49:53 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v3 1/3] x86/boot: Use common BUILD_BUG_ON
Date:   Sun, 11 Aug 2019 20:49:36 +0200
Message-Id: <20190811184938.1796-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining BUILD_BUG_ON causes redefinition warnings when adding includes
of include/linux/build_bug.h in files unrelated to x86/boot.
For example, adding an include of build_bug.h to include/linux/bits.h
shows the following warnings:

  CC      arch/x86/boot/cpucheck.o
  In file included from ./include/linux/bits.h:22,
                   from ./arch/x86/include/asm/msr-index.h:5,
                   from arch/x86/boot/cpucheck.c:28:
  ./include/linux/build_bug.h:49: warning: "BUILD_BUG_ON" redefined
     49 | #define BUILD_BUG_ON(condition) \
        |
  In file included from arch/x86/boot/cpucheck.c:22:
  arch/x86/boot/boot.h:31: note: this is the location of the previous definition
     31 | #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
        |

The macro was added to boot.h in commit 62bd0337d0c4 ("Top header file
for new x86 setup code"). At that time, BUILD_BUG_ON was defined in
kernel.h. Presumably BUILD_BUG_ON was redefined to avoid pulling in
kernel.h. Since then, BUILD_BUG_ON and similar macros have been split to
a separate header file.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/x86/boot/boot.h | 2 --
 arch/x86/boot/main.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 19eca14b49a0..ca866f1cca2e 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -28,8 +28,6 @@
 #include "cpuflags.h"
 
 /* Useful macros */
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 
 extern struct setup_header hdr;
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index 996df3d586f0..c5e55d2c55d0 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -13,6 +13,7 @@
 
 #include "boot.h"
 #include "string.h"
+#include <linux/build_bug.h>
 
 struct boot_params boot_params __attribute__((aligned(16)));
 
-- 
2.22.0

