Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F000C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C945206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jqiS0ZFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfIPIrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:47:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33863 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfIPIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:47:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so19449174pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3CZpSwxadNRSj1Aew/i7dMbdAcGWIfP93unPiLM5ZaA=;
        b=jqiS0ZFSBSprWyva+JnlQenT6igdLwqK1epfj9V9uLdYC6+tCap43V5J04SE/VvZgs
         wa3xeqG1Woik3lm8qJHsIPCNfaeMhcsEMjbWqZesf9lXSxEQDB5M8hhiZ5cmw6cifXBN
         wWENpDjdbNQDJbS4fYwQRAcJiKJ+YR0ITzZss4pLrlxjmAJkRnysEHr5mwKMZ7+7KHgk
         NpGxkz2KqgSVOsCkOTdInWYGmZjaeEIdDh0bl5M0yj51v34N5Q1iphu2Nl0sVtHG8kuT
         QpTIh7L7Y84+NG5hJuLslpEb66nB5qDo6N1Pb09bEAc0w0bJ+MEc1FsjulJ3Ay81JYWj
         z+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3CZpSwxadNRSj1Aew/i7dMbdAcGWIfP93unPiLM5ZaA=;
        b=ANfPOs0v9PtiCsbloKbw3a90BikQW+8hOyeIVKsNk9U3diYri362e8473DmXhUdJCY
         JRZJo9tQI/EDfIRrIwdPM/yRVVW4qrGoPp+qZhRL5eejzrQc2KyW9Hrvui/zJEdPKK8r
         kq/8nSQHbrzKdJwUbGmDg3vkGQYGd7j7aM5ZoIWr9FhnA2NTlfCjMV6ECy9nUqjZO6e/
         OhFWhmiiK6ovGfBSYjWW0XwuL8dlxUUMBg6czBjAPdKvRCM3gUxTs2jt6jeT6WFsbm7c
         wq+IPzGM5e/4C73F2PDWScwO4I4oNb3yVaEY4HjkVF8H59daSIHL+L4kSr5saH0Imkps
         TlAQ==
X-Gm-Message-State: APjAAAVaB9fRnUj5YG+bIoAK+fMjr5Uq0oPdL2xF2mwXWiSnheZz78Pw
        TU7oE4BtMoUFTmZEaJJwrwAj5Q==
X-Google-Smtp-Source: APXvYqzF3P7Xmee+L5UWCWLQSIUPCOGlHYeDGEd4arwppxKxhnB7L78TUmaDyka2mnGECkrKSP4tnA==
X-Received: by 2002:a62:e106:: with SMTP id q6mr12426391pfh.14.1568623666402;
        Mon, 16 Sep 2019 01:47:46 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id p20sm29599296pgj.47.2019.09.16.01.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 01:47:45 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH] riscv: Avoid interrupts being erroneously enabled in handle_exception()
Date:   Mon, 16 Sep 2019 16:47:41 +0800
Message-Id: <1568623661-16779-1-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the handle_exception function addresses an exception, the interrupts
will be unconditionally enabled after finishing the context save. However,
It may erroneously enable the interrupts if the interrupts are disabled
before entering the handle_exception.

For example, one of the WARN_ON() condition is satisfied in the scheduling
where the interrupt is disabled and rq.lock is locked. The WARN_ON will
trigger a break exception and the handle_exception function will enable the
interrupts before entering do_trap_break function. During the procedure, if
a timer interrupt is pending, it will be taken when interrupts are enabled.
In this case, it may cause a deadlock problem if the rq.lock is locked
again in the timer ISR.

Hence, the handle_exception() can only enable interrupts when the state of
sstatus.SPIE is 1.

This patch is tested on HiFive Unleashed board.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

---
 arch/riscv/kernel/entry.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index bc7a56e1ca6f..80444f1e57bb 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -166,9 +166,12 @@ ENTRY(handle_exception)
 	move a0, sp /* pt_regs */
 	tail do_IRQ
 1:
-	/* Exceptions run with interrupts enabled */
+	/* Exceptions run with interrupts enabled or disabled
+	   depending on the state of sstatus.SR_SPIE */
+	andi t0, s1, SR_SPIE
+	beqz t0, 1f
 	csrs sstatus, SR_SIE
-
+1:
 	/* Handle syscalls */
 	li t0, EXC_SYSCALL
 	beq s4, t0, handle_syscall
-- 
2.7.4

