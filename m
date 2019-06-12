Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE7C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC0121721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="F2bLr6Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfFLT1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:27:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35162 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfFLT1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:27:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so18175690wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gc99P+6N6+xSxQKHKwT0OD+Dx6Ni+QOkx9u56EzlVmA=;
        b=F2bLr6Usjp0SS+YH0qbHW4ub7lF+EA48coYkSUubqCXi4L86a8pbijVIRgDvpuSUsF
         ZrK1Shovt+bDl648RmoiYd0gtNwx38PveHrl2akp0/4gVW6L1gdnFMajsh3iPjGadno4
         0w+RVcfN1Az3gqf8b2lwzW/qAfl1AeEaqkzUE8yrXIb0ZD+g6RdrTckRWUM0PhWrh2oF
         jusm5g5Vb6YDoIbI3gf+RwyYIJ0n0S8J7fniaqQsd3uOABGpnTgA2gFyawsrYMQJbKbD
         hsRJOs43wENKcjTM9+yzTYzgj4XFg6jPN7rkBT7t0taep/aGmnhvlMKjsoLzm5ssPtn7
         fTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gc99P+6N6+xSxQKHKwT0OD+Dx6Ni+QOkx9u56EzlVmA=;
        b=aoCiLeFcMaQbg699mITRrRJ5CTscDHN86+0RQKJ7GxFs9zEvhHNsifPJMXtTdcFzK3
         e7YgNGWY5cL+5duehQXBYW1K32BE1h4Vo2YLolm5JSRoukg1Rxt4jgochtAhRO47PMX8
         S3cBKRYR0QLaHaCQ1XWXrDE45pIfH9G8t9OWaOK5n1C3Da0Bt8XuUENbR7QWIrmmYH00
         yTwa+A5/x+OZlcMcMu3DuiI7zzqwOYXX0AtDwF9G/jVSBRztnLvflCYnQPEA9YsrSajs
         K/t0PLUFUKLCjXeIZJ8MeY6NEolSDom4TuEbE0Kr2i6qVBIK2gK6CFEW7/nzX5hmdUPu
         YsPw==
X-Gm-Message-State: APjAAAV/dcDg2ckcQ+R3w3cWw0+cFK5/BoKva4MyXj4JkhYxXb1HBort
        IJXFr5gnbov9APAC+TpCOVEaLftsFBU=
X-Google-Smtp-Source: APXvYqxIsPY4F76dTJDcOjFZdmSdKlq0GPIonqcAmCK2zG2wSLgAsYvCqwuGTkiuPGkT6q30d63hgw==
X-Received: by 2002:adf:ee42:: with SMTP id w2mr42257126wro.253.1560367627677;
        Wed, 12 Jun 2019 12:27:07 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.27.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:27:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 26/28] x86/vdso: Align VDSO functions by CPU L1 cache line
Date:   Wed, 12 Jun 2019 20:26:25 +0100
Message-Id: <20190612192628.23797-27-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

After performance testing VDSO patches a noticeable 20% regression was
found on gettime_perf selftest with a cold cache.
As it turns to be, before time namespaces introduction, VDSO functions
were quite aligned to cache lines, but adding a new code to adjust
timens offset inside namespace created a small shift and vdso functions
become unaligned on cache lines.

Add align to vdso functions with gcc option to fix performance drop.

Coping the resulting numbers from cover letter:

Hot CPU cache (more gettime_perf.c cycles - the better):
        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
cycles  | 139887013  | 139453003        | 139899785   | 128792458
diff (%)| 100        | 99.7             | 100         | 92

Cold cache (lesser tsc per gettime_perf_cold.c cycle - the better):
        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
tsc     | 6748       | 6718             | 6862        | 12682
diff (%)| 100        | 99.6             | 101.7       | 188

Measured on Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b58d34120fd8..c7bfd62d1fc3 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -4,6 +4,7 @@
 #
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_X86_L1_CACHE_SHIFT)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.22.0

