Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7151DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3986B20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJe2vQt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfCYNvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:51:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42946 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCYNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:51:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so6624581pgh.9;
        Mon, 25 Mar 2019 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GT4Bk9dT9oL1IWkeLESxHzy5fnOkv7rMx/vbuzd5IjA=;
        b=cJe2vQt5VACeXj3hzsSNgc5RCkAEph46QJg6wlGqUbIBUJ7X8dKEkQp2lxGsRB/8fZ
         b90yyVJrwrqYDzy5gsUtcrFmR5uO3nqv0Y6QctDZpXfdIv5Xk8SfG/Fdk1BwGUpnDYVM
         YPM/jO6fBrtqsGtsQH25wGszJWxSSoZbPezaPAUL5sIRUi3PEUW+oj7ysRIXK5twHV/d
         GiCaEQmy/bBYkCF4lAL9bC5VpcDs2ZV4fjiMgRlloQl/DQrrJ3R5l8d1PAK4Qwk3B3Nu
         w+P4cfNSg+jGHsgGMR5FJ/83G4E2xHePt1f02V/KZK/qWhOABHtoPdpHROZ1uZLMVHD1
         xIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GT4Bk9dT9oL1IWkeLESxHzy5fnOkv7rMx/vbuzd5IjA=;
        b=MtigBaMK3ONtwlmQWNXtO98LhHfieG6o9xgnOzEFlSbx1HYfT0vltztabLekZH0VQO
         ETscHOT9ON3uG4CN9X+zM4if1FhAF7tZpcOZijSrWpMdByurOWCNx5WDTSW4K9yxBiEi
         +PXfE3QOcZXxr15L7JE0nmLISIlwb1M/A3bt5qehXT7Fl0j9tlzu7QGtbfO4zh/Z9JHw
         X20L7knvUJBUt0dbg1egOa1NwBm+RfIdgri/y7/s9H04Vlo0BJjjcBk2qS2zkFJLBKGB
         06uE2C+Drr2sMBdZei9yOYD3MSxwGojuoj4hHNbsMK19tyRjz2iyy4w6IEqDTlPsI2OT
         sVLQ==
X-Gm-Message-State: APjAAAWsDY5nkBHm/yuLPuH6uOfaPmPQd81sVqRlmClWjgRXLZMHZA9s
        emBqRcgWpr3YRJV9fTVrJww=
X-Google-Smtp-Source: APXvYqxCLuXkjUOEkHeMoZ7z9nIev5tNidhjhPgHiaUyDo9Ia490YfKclBXPY6maQF02rFx1+NfRIQ==
X-Received: by 2002:a17:902:28e6:: with SMTP id f93mr25356170plb.264.1553521897966;
        Mon, 25 Mar 2019 06:51:37 -0700 (PDT)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id k72sm44694562pfb.122.2019.03.25.06.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 06:51:37 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     tglx@linutronix.de, mingo@kernel.org, konrad.wilk@oracle.com,
        jpoimboe@redhat.com, peterz@infraded.org, mojha@codeaurora.org,
        peterz@infradead.org, jkosina@suse.cz, riel@surriel.com,
        luto@kernel.org, Tianyu.Lan@microsoft.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [Fix PATCH] cpu/hotplug: Fix bug report when add "nosmt" parameter with CONFIG_HOTPLUG_CPU=N
Date:   Mon, 25 Mar 2019 21:51:23 +0800
Message-Id: <1553521883-20868-1-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

When add "nosmt" parameter, kernel still boots up all logical cpus once
and set CR4.MCE on each CPU. This is to avoid shutting down machine
when a broadacasted MCE is observed CR4.MCE=0b. (Detail please see comment
in the cpu_smt_allowed()). Smt cpus will bring up and bring down during
kernel boot with "nosmt" parameter.

When CONFIG_HOTPLUG_CPU=Y, CPU_DYING callbacks will be called inside
stop-machine and irq is disabled. This happens in the take_cpu_down()
callback. When CONFIG_HOTPLUG_CPU=N,CPU_DYING callbacks will be called
with irq enabled.

smpcfd_dying_cpu() is one of CPU_DYING callbacks and it assumes to be
called when irq is disabled. smpcfd_dying_cpu() calls flush_smp_call_
function_queue() which requires to be called with irq disabled.

When CONFIG_HOTPLUG_CPU=N and add "nosmt" parameter, smpcfd_dying_cpu()
is called with irq enalbed and this triggers BUG_ON(!irqs_disabled())
in the irq_work_run_list(). This patch is to fix the issue.

Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index f4cf1b0..33f1970 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -73,6 +73,8 @@ int smpcfd_dead_cpu(unsigned int cpu)
 
 int smpcfd_dying_cpu(unsigned int cpu)
 {
+	unsigned long flags;
+
 	/*
 	 * The IPIs for the smp-call-function callbacks queued by other
 	 * CPUs might arrive late, either due to hardware latencies or
@@ -82,7 +84,10 @@ int smpcfd_dying_cpu(unsigned int cpu)
 	 * ensure that the outgoing CPU doesn't go offline with work
 	 * still pending.
 	 */
+	local_irq_save(flags);
 	flush_smp_call_function_queue(false);
+	local_irq_restore(flags);
+
 	return 0;
 }
 
-- 
2.7.4

