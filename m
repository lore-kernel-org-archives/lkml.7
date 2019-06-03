Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B38C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D98927F6A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8TntvGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfFCJRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:17:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46553 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbfFCJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:11:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id m15so7126030ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XNaoGruNIsOtSVFYVpHUufh5QsS/no9n1jDse4Rp8w=;
        b=m8TntvGGhp0nYiHzaLLgTeZH1zwY5/yRgl2nyz0ER5PyLel0dSm+tojV8of8NrYXdJ
         ROgD6B+fEUl11Un8LTOvnK0YL4ds+DV47qkf7zOGLYh6wdxK8n9kXbpwYFjBIFTlaFy/
         1uCrd7uKIBnt9W56O4f46yzLjALCSg0JRomG/rMTW7uDkv6GC/YbQkPUzHmGgxjnNee4
         wWqlpepwZGd3i5/tiyZxjndumPxjtBYxA3m6Dl7QX0egpCHIWc3oXuK9c5O9vXTH9ti9
         zVKRf77SGa+OKdPBJ//O0CfKalF8FMz9GDRFiOvoJffLCLwlwy+ccbi6HjbSDdJj4aVL
         M31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XNaoGruNIsOtSVFYVpHUufh5QsS/no9n1jDse4Rp8w=;
        b=Oq1nq9tTDdb2OeGpqK8XRWtGnBcrKIII1lhEkxGLNNx2xoABloL3wtL6tcLZ1x0eup
         //uxTc/3CwLArLtLgMZUkkKnTduybjS0u6xXkWypjxW9IOChq1rsM4fx+mQEeaX0XCZO
         OBMv2LSoMv+NA2PSDsk6tTACk96O7LAi/w6ewWX8Kqjbldaaer6eZ6lJqDbQgEqCFWIr
         vYdhpJMt4wVsgGSCs5hPsEQD1Im+9p+Fx8C/dh6bye3Rp4L0W99hEobzC/eDR209+ppC
         6EuaHO7343DGXft4A3BmF8OTyCwQwX5pJ62RmrO67vEng1p5bMWnvOdsNhLhiHINvPRS
         151g==
X-Gm-Message-State: APjAAAXOVtod2Z9nCNz0wjM/Ib8/hLfHlNIlKUCwGozL7v5sUjf/tFP7
        8bdAYPBWwaT+43UwqQT0i4bzAw==
X-Google-Smtp-Source: APXvYqz0nK8j9w8+kGKqX2cJgLQC6n+s4vTFl2Evus/yUMhfrH/qQzL0327hx3BN5Ar4ER05Wijy9w==
X-Received: by 2002:a2e:984a:: with SMTP id e10mr5408494ljj.113.1559553114060;
        Mon, 03 Jun 2019 02:11:54 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id y127sm3040022lff.34.2019.06.03.02.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 02:11:53 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     aryabinin@virtuozzo.com
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] mm: kasan: mark file report so ftrace doesn't trace it
Date:   Mon,  3 Jun 2019 11:11:48 +0200
Message-Id: <20190603091148.24898-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kasan_report() triggers ftrace and the preempt_count() in ftrace
causes a call to __asan_load4(), breaking the circular dependency by
making report as no trace for ftrace.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 mm/kasan/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 08b43de2383b..2b2da731483c 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -3,12 +3,14 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE_common.o := n
 UBSAN_SANITIZE_generic.o := n
 UBSAN_SANITIZE_generic_report.o := n
+UBSAN_SANITIZE_report.o := n
 UBSAN_SANITIZE_tags.o := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_generic.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_generic_report.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
@@ -17,6 +19,7 @@ CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
 CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 obj-$(CONFIG_KASAN) := common.o init.o report.o
-- 
2.20.1

