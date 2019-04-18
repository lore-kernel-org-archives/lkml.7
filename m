Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF57C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002DB21871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610933;
	bh=8RwdhNu0g0nIe+g7ofHWU6Cdf6aGp0tp+B0Qd2kzXSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pwd8M1+dTyFejXixzHR0/yuCvfF4XFEXr4hN+bww0UkiNEClqBb1L8zAok7UZcOJ4
	 rCHJwEWQXloV+kUHIKgQG0rsEU6MO6eKD8CuMoXHWn5YnYH46l8oAWdz/VUcr5x05N
	 6zftotn+FUss4fCjgC665+LG4Ct8lz/d/mDPAkBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391800AbfDRSIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391789AbfDRSIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:08:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03AAD21872;
        Thu, 18 Apr 2019 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610928;
        bh=8RwdhNu0g0nIe+g7ofHWU6Cdf6aGp0tp+B0Qd2kzXSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdkA2QmOHoq7y5MSDwc9yrGXBkYNCwqthQ1imUpNkplAYSmGMRjdSUYYi5LHeDyf7
         RxPE0yUsxvsXixjsnMba59qU3mqOXmkmOSMZJbDwNfreXN3mZgtra5/cC2b3ZCd2Ly
         HAnarLQFztY7AefcFe2a5tpLj6FMcFO5tmWhIp3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Shi <yang.shi@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 44/50] ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t
Date:   Thu, 18 Apr 2019 19:57:55 +0200
Message-Id: <20190418160427.778810744@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 143c2a89e0e5fda6c6fd08d7bc1126438c19ae90 ]

When running kprobe on -rt kernel, the below bug is caught:

|BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:931
|in_atomic(): 1, irqs_disabled(): 128, pid: 14, name: migration/0
|Preemption disabled at:[<802f2b98>] cpu_stopper_thread+0xc0/0x140
|CPU: 0 PID: 14 Comm: migration/0 Tainted: G O 4.8.3-rt2 #1
|Hardware name: Freescale LS1021A
|[<8025a43c>] (___might_sleep)
|[<80b5b324>] (rt_spin_lock)
|[<80b5c31c>] (__patch_text_real)
|[<80b5c3ac>] (patch_text_stop_machine)
|[<802f2920>] (multi_cpu_stop)

Since patch_text_stop_machine() is called in stop_machine() which
disables IRQ, sleepable lock should be not used in this atomic context,
 so replace patch_lock to raw lock.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/patch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 69bda1a5707e..1f665acaa6a9 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -15,7 +15,7 @@ struct patch {
 	unsigned int insn;
 };
 
-static DEFINE_SPINLOCK(patch_lock);
+static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	__acquires(&patch_lock)
@@ -32,7 +32,7 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 		return addr;
 
 	if (flags)
-		spin_lock_irqsave(&patch_lock, *flags);
+		raw_spin_lock_irqsave(&patch_lock, *flags);
 	else
 		__acquire(&patch_lock);
 
@@ -47,7 +47,7 @@ static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
 	clear_fixmap(fixmap);
 
 	if (flags)
-		spin_unlock_irqrestore(&patch_lock, *flags);
+		raw_spin_unlock_irqrestore(&patch_lock, *flags);
 	else
 		__release(&patch_lock);
 }
-- 
2.19.1



