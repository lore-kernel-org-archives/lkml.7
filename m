Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C62EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BEB2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQw8tgsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbfHGX3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:29:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37840 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbfHGX3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:29:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so42940933pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=msMiwPQbzw7bcXWIhwUZPrx/lErY0rUZloSGaKEVR2Y=;
        b=dQw8tgsv0/uE1sOyWPobXmz8TiSNjzZ1p2z3Zy/LTUjE0E7HCLxHPb/RZLOtdH9OOK
         Yb6jfTY0M9TTllw7vj/7gd9PnyCmcIHwQBV8/BWsD6kbkJI1ggapEGlKFsV3HOTbd/5d
         vaFPOpaJq8xluZqxDKWrR0SiM6FS1EkhWJEiZUT8iW4pbwmWQTxvVpaLe7S6RomKLEHU
         6kZGNjSdNFXAC2cZobyj6TCxRElNUK6J/6n0SjCOuG4mOWpIQPfxLMLG+5Yg1CiQ07O/
         UtI9L7eB5HVVUIN73n3yy1Del+1p62SE9smSThWgYHzRmzN69t81XTRTliBYHb/3zIGH
         BTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=msMiwPQbzw7bcXWIhwUZPrx/lErY0rUZloSGaKEVR2Y=;
        b=OKd+77Zjy9+sVmr44eC/tvUG4/d6zNNLRh9EpIeR/qbQ3s3/0oLApyGR2YGJmI2/2r
         nObEyJBBY+om31R8Yn3ADUDbNFggoFFzBx8YcEdPU2rfuXI5CtaElbvBBrix8rdUXFHl
         7D6+Bj25BCwxTlgJE627PmQfI7t8k7/gNiS1RbnutiSAlXdZf/FOkuRv8rpjNCrpO9OJ
         YbfoXN2btFIrTbKX+7L/tpXlDy7FJ6awid0YMDGivfsU54S4HzJDuFImgnGXBKIrloTa
         Qw58nBh4icGnAIzeVRAaPGQqb52C4dJgYSRxsk3QVRF5iqEoC4OZRB87fKzXoaN1BXnI
         R3og==
X-Gm-Message-State: APjAAAVQHNdiI8+U904XCAENXbqEsA5fAgHiO5I7D1uX4Xzo8aw9AWIr
        w62/BpUEjw3pBgLEbJxzUUs=
X-Google-Smtp-Source: APXvYqw9Rlet3GbehNJKN6v4ewaZ9N0yP4f2mhqz6Dh8+db7aQV0HqJ+Yq8Cm8wAeavrEGI+6npDcA==
X-Received: by 2002:a65:6547:: with SMTP id a7mr9780248pgw.65.1565220580496;
        Wed, 07 Aug 2019 16:29:40 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([218.189.25.30])
        by smtp.gmail.com with ESMTPSA id a128sm105321815pfb.185.2019.08.07.16.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 16:29:39 -0700 (PDT)
From:   Xinpeng Liu <danielliu861@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Xinpeng Liu <danielliu861@gmail.com>
Subject: [PATCH] tracing/probe: Fix null pointer dereference
Date:   Thu,  8 Aug 2019 07:29:23 +0800
Message-Id: <1565220563-980-1-git-send-email-danielliu861@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: KASAN: null-ptr-deref in trace_probe_cleanup+0x8d/0xd0
Read of size 8 at addr 0000000000000000 by task syz-executor.0/9746
trace_probe_cleanup+0x8d/0xd0
free_trace_kprobe.part.14+0x15/0x50
alloc_trace_kprobe+0x23e/0x250

Signed-off-by: Xinpeng Liu <danielliu861@gmail.com>
---
 kernel/trace/trace_probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dbef0d1..fb6bfbc 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -895,7 +895,8 @@ void trace_probe_cleanup(struct trace_probe *tp)
 	for (i = 0; i < tp->nr_args; i++)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
-	kfree(call->class->system);
+	if (call->class)
+		kfree(call->class->system);
 	kfree(call->name);
 	kfree(call->print_fmt);
 }
-- 
1.8.3.1

