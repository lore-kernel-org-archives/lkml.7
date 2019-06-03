Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0AC28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9B208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9xhNEil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfFCC3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 22:29:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37202 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFCC3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:29:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id 20so7375621pgr.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EbAkFbzj7asqzMx0lCKUIa7fYjy/CiRMnQkWMnimH0U=;
        b=j9xhNEilCLHSflMXyxctstiYcHmdlw2INKrZg14b8uki7tM7xv6mj+Ot5+qDQP2rWP
         QmHpEwbydAfbaK8szNXNn+ESpPZP9DkYVH2BX6+2F2gcQQyPR2s1PoxJ4BlJ6z9lJd/Y
         xbBJhkBJ2IXOvk1znG+0MQplEoWJIV4EJE63l6WCvT6+J+YgE5i3l2w2oBeq4/BNMSs3
         3TiQuRoK76z+JA1jHTx4WKq/c+VXi3KWfXM4OfFi37i34MPgyUtiWrEoY/zXPLNFAb5b
         5jguBRzcshZMXEqc3il2u8wttizH3oim9OOtjywApbz3/JXnWv9a/f0DDd6IWQx1jUDy
         /XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EbAkFbzj7asqzMx0lCKUIa7fYjy/CiRMnQkWMnimH0U=;
        b=S+WZqVDR9iRg56NxCEdl4cm39MGHlTUUCKbSEmN06a+uq8g1bTsRRmpcsTS9et6GfY
         P0KXgx079HqDAJXDap5JxD1XFs663ywQjQS2nEBs+LmEpNvqIP+Nj/yoyNxtjHVXGZTX
         y4EcFn1KWJOtJHIHnJCiKEOirW62XYc1vF5I9oWS+rMW7JxV/A0SuOJV7BK9ihN7oEw4
         KvOVtSW9hwrXoibgXB5zw0MOh8yQEOgZ5WIYnFRt34cwPGCxx4YOeBX6VcSLFQr087Z/
         NGYb54mAIuVJ+fKg/dhHCR0tSwQYAqKrEpFIcet/L6R1ncJkf0QqrbxbQE/NLKy8Xjws
         SjVA==
X-Gm-Message-State: APjAAAW23/QBwPGvYIA26O0PY10qpxJZKGuA/cEL2QKgQYqpv61qA2PA
        /uTdpjVpKfVHuO5NM1CHgtoYZQswozg=
X-Google-Smtp-Source: APXvYqxZi1NUAeNWfKKDc2F1DLEofoWamA18Q+p7kK5t0Bs0SGfRnOa/8dImkpc42n3Lq7r8nW42/w==
X-Received: by 2002:a63:ec42:: with SMTP id r2mr26171766pgj.262.1559528939974;
        Sun, 02 Jun 2019 19:28:59 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id g3sm13857513pfm.150.2019.06.02.19.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Jun 2019 19:28:59 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     gxt@pku.edu.cn, linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] unicore32: check stack pointer in get_wchan
Date:   Mon,  3 Jun 2019 10:30:03 +0800
Message-Id: <1559529003-10725-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_wchan() is lockless. Task may wakeup at any time and change its own 
stack, thus each next stack frame may be overwritten and filled with 
random stuff.

This patch fixes oops in unwind_frame() by adding stack pointer validation
on each step (as x86 code do), unwind_frame() already checks frame pointer.

See commit 1b15ec7a7427 ("ARM: 7912/1: check stack pointer in get_wchan")
for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 arch/unicore32/kernel/process.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/kernel/process.c b/arch/unicore32/kernel/process.c
index 2bc10b8..1899ebc 100644
--- a/arch/unicore32/kernel/process.c
+++ b/arch/unicore32/kernel/process.c
@@ -277,6 +277,7 @@ EXPORT_SYMBOL(dump_fpu);
 unsigned long get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
+	unsigned long stack_page;
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
@@ -285,9 +286,11 @@ unsigned long get_wchan(struct task_struct *p)
 	frame.sp = thread_saved_sp(p);
 	frame.lr = 0;			/* recovered from the stack */
 	frame.pc = thread_saved_pc(p);
+	stack_page = (unsigned long)task_stack_page(p);
 	do {
-		int ret = unwind_frame(&frame);
-		if (ret < 0)
+		if (frame.sp < stack_page ||
+		    frame.sp >= stack_page + THREAD_SIZE ||
+		    unwind_frame(&frame) < 0)
 			return 0;
 		if (!in_sched_functions(frame.pc))
 			return frame.pc;
-- 
2.7.4

