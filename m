Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F8C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F85621882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RUsDHnlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfKFDI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33586 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388234AbfKFDIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so3739328plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxgbTiejYBo7/1mqSq8S6enB8DpZaW/Z0tH3a73frYE=;
        b=RUsDHnlHj5OX2FkJMl4HO4OTDKo21VNVKxbNBWSkdB54TcJt+mxMTlscvrd0FdCzJH
         ElEUCChqKIdZieoYavAkGeo5IWT1xUUGX6giv1XqYskDqZ/eEYZyRqssdF4TgPsuzSdz
         tQO3kEj39bKSuQhyWb4jfiKIkj+Vxx7XVVCGxgak3n3JVgD1gccGCH71dhHy2fM9ldcD
         0y4109hwl1LU6L1RGNziH643/68eln7xOYBr+0ilFfxgURzcBGDys109fJhZCiEpGneh
         m5tJAOYGThV//35vj/00zrOh7SPMqHxXxVAqmhyBToRD+V40aaUE4tv1GF0q1lG5APGJ
         C24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxgbTiejYBo7/1mqSq8S6enB8DpZaW/Z0tH3a73frYE=;
        b=IA1ObtJHEUf+FmM/DHHdJgPHYbNE8ophHfmZmDOoSyrCjaNHf3zY31fMNhOye8DVoK
         qmhzhX8acJ/jRs2GiwrREdtKQiTHZBPKDa+b1LxLw/mWJNDGXPo2MHI05YsXe+8Hy05g
         gCaJk8Ii60tG3ewZ7wiFsDuC4jrJpzj3MOog5SB1FyDXpoulRAMbidPbI/6kCMo4YFko
         CJokv65+i4zVmygSaF5qXc+Lg7ahE0eLtGyjdcu1FTKMVZBz7MdFMg+tdRmmsg5Yc0V6
         Cw3GgyZG+j3TAKb5BxJ2PFXrc9fbF8s2YFq8WLgCVzkTl248NGJBGPirLb0TFX0KHOt/
         PRrQ==
X-Gm-Message-State: APjAAAVWo7AKoC8g/bayP/J1SEmjVa/aUhEOfwI5i7lMqamDlt//u0Yf
        EhtHgjo+gYBI1OyonMcMm8cOPgJqswM=
X-Google-Smtp-Source: APXvYqxAMcDnc7INtQXgA05d4KhhN6NCRfKLQwBG0t6uM/nx7dNbrex8NEIZcIlC6qRtK/3rv5h4rw==
X-Received: by 2002:a17:902:6a8a:: with SMTP id n10mr192466plk.146.1573009701404;
        Tue, 05 Nov 2019 19:08:21 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:20 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCH 35/50] um/sysrq: Remove needless variable sp
Date:   Wed,  6 Nov 2019 03:05:26 +0000
Message-Id: <20191106030542.868541-36-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`sp' is a needless excercise here.

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/um/kernel/sysrq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index c71b5ef7ea8c..c831a1c2eb94 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -27,7 +27,6 @@ static const struct stacktrace_ops stackops = {
 
 void show_stack(struct task_struct *task, unsigned long *stack)
 {
-	unsigned long *sp = stack;
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
 
@@ -38,10 +37,9 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	}
 
 	if (!stack)
-		sp = get_stack_pointer(task, segv_regs);
+		stack = get_stack_pointer(task, segv_regs);
 
 	pr_info("Stack:\n");
-	stack = sp;
 	for (i = 0; i < 3 * STACKSLOTS_PER_LINE; i++) {
 		if (kstack_end(stack))
 			break;
-- 
2.23.0

