Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD1C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F902133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfHXGFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:05:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35189 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfHXGFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:05:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id d85so8059578pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rgzPUBWWFXcEB0kpmGg07sbQ4NrSDKWt+6h0aUZjV2I=;
        b=RWZMQphaGQocrYOY/Me10PN/0/PPNnw2U0Uj4hP7w1HzN0DbA6NGLwy16E0ZYcfZIV
         MqcXJkljhzOggryLxVan+8qSgVMouCda2Zjh8zvYUmGoeF7jFFkoXnssvvu54bXNVz41
         F+SWo8DbUJdZcbhz91rNmFM59MGE02NMK6R7EBw0GVqMUl5xyIU+ew80PTKDiMsyFh3F
         trJfb25z0zHO5KWjdnrnCuGqHzljuWeCpAyV6G8s0afzTlOJSw/uewpwpYteM3f0RsWp
         X8Yq/DvodQiENJrbbt0Wm2ULCnwB+o4nJ9uR8cwhcubZBv0fQvZ0jwAgqvvA5ADzscQA
         rIfw==
X-Gm-Message-State: APjAAAXkbLc6e/4pFlEYGKTmUtNShzcQOWifEMNGBgXt8MDzFC02o6Kj
        LkoWs/o87aeEmut1ttlBv5U=
X-Google-Smtp-Source: APXvYqy2i6o4571WTiXoJ3Ap8qsqvTok7hBsXzd214XO87Jg/kYicSMTHgMEt8aySQzQpMLzuEq50g==
X-Received: by 2002:a62:754a:: with SMTP id q71mr9127824pfc.15.1566626714033;
        Fri, 23 Aug 2019 23:05:14 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w2sm4300882pjr.27.2019.08.23.23.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:05:12 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 1/7] compiler: Report x86 segment support
Date:   Fri, 23 Aug 2019 15:44:18 -0700
Message-Id: <20190823224424.15296-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224424.15296-1-namit@vmware.com>
References: <20190823224424.15296-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC v6+ supports x86 segment qualifiers (__seg_gs and __seg_fs). Define
COMPILER_HAS_X86_SEG_SUPPORT when it is supported.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/compiler-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6bad48..5967590a18c6 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -149,6 +149,10 @@
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
 
+#if GCC_VERSION >= 60000
+#define COMPILER_HAS_X86_SEG_SUPPORT 1
+#endif
+
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
-- 
2.17.1

