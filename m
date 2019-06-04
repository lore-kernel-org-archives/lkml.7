Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC32C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929A424A6F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="scZjURia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfFDHPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:15:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFDHPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xzbkZnggl86In8iKc2cY++i9jccLsYRm3rlAVSElsm8=; b=scZjURia6NcQYUZfZX07jPb7LO
        Au4CN3T5juF6eKGQX/dktaPLO5860Bo7jy95PFs5v4SLJEj8fARTg/rhDvAwE7dfrAQLK15ZGGqtS
        GyqlEdeyUizv28WC97lni4jkeLE7Ry6PcS6TtNPvvUBa82Gcr1khzNSE01GrY6+DUbIOJFZyeFSib
        M5CW2gHNuZ0m5X1UCemMCOs0luvhz14cc76a/cFTPxZh9mkO6uYYnLRWrQMFZ5JFA4wMgCXyl0+E6
        qhJqwfMwS9jWTCQKwL3vZ2PiA6QZNHqilFun0oyrcqN8Gt9HT9KdTQ6mWQg4WKLPTLz2hau1VYT4H
        NjlXZjTA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY3fO-0004E9-1G; Tue, 04 Jun 2019 07:15:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/fpu: Simplify kernel_fpu_end
Date:   Tue,  4 Jun 2019 09:15:22 +0200
Message-Id: <20190604071524.12835-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604071524.12835-1-hch@lst.de>
References: <20190604071524.12835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two little helpers and merge them into kernel_fpu_end to
streamline the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/fpu/core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 466fca686fb9..1d09af1158e1 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -49,12 +49,6 @@ static void kernel_fpu_disable(void)
 	this_cpu_write(in_kernel_fpu, true);
 }
 
-static void kernel_fpu_enable(void)
-{
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
-	this_cpu_write(in_kernel_fpu, false);
-}
-
 static bool kernel_fpu_disabled(void)
 {
 	return this_cpu_read(in_kernel_fpu);
@@ -115,11 +109,6 @@ static void __kernel_fpu_begin(void)
 	__cpu_invalidate_fpregs_state();
 }
 
-static void __kernel_fpu_end(void)
-{
-	kernel_fpu_enable();
-}
-
 void kernel_fpu_begin(void)
 {
 	preempt_disable();
@@ -129,7 +118,9 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
 void kernel_fpu_end(void)
 {
-	__kernel_fpu_end();
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+
+	this_cpu_write(in_kernel_fpu, false);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
-- 
2.20.1

