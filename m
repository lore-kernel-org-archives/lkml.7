Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60278C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323B7214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eHBTuM6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfHFNH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:07:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHFNH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:07:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x76D7Gco2187833
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 6 Aug 2019 06:07:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x76D7Gco2187833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565096836;
        bh=nFkwO3MPmvQPUIRJfnPMzdxaHARS7dPdvCVPr6Ef8Y4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eHBTuM6BB2rgr7xx9hNrDERRlcvl1L7A3h1ZTceJPc5O4lb+hw00Ypb101NmvMmfd
         JoME26TadCt4Zkwu99YsYmMQPLCVOVFtwaowUJDVTeEU2C16zL2gzcHyDzYvrm6v3Z
         BmOWblODjVnTHe0fbslxJgSfg3mnC1ZHDbnvj1YtAcrfQ3C5gTpjhBFyT5SD5WbEp6
         LOQpW8ml5M26T6sNYk91APQ9RILPk0xDp1U7pyyBJBcNsW8LvaaKPQsrA5mrxB1IPX
         LFORKaBeOTPqEVjU0l75JijdUXJLX5Hm0Wfe0HE0EDZFXhA4v1ZKrfGjGiiXIotfJX
         S0XX9ceR8S51A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x76D7FVW2187830;
        Tue, 6 Aug 2019 06:07:15 -0700
Date:   Tue, 6 Aug 2019 06:07:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mukesh Ojha <tipbot@zytor.com>
Message-ID: <tip-a037d269221c0ae15f47046757afcbd1a7177bbf@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mojha@codeaurora.org, hpa@zytor.com
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          mojha@codeaurora.org
In-Reply-To: <1564585504-3543-2-git-send-email-mojha@codeaurora.org>
References: <1564585504-3543-2-git-send-email-mojha@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/mutex: Use mutex flags macro instead of
 hard code
Git-Commit-ID: a037d269221c0ae15f47046757afcbd1a7177bbf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a037d269221c0ae15f47046757afcbd1a7177bbf
Gitweb:     https://git.kernel.org/tip/a037d269221c0ae15f47046757afcbd1a7177bbf
Author:     Mukesh Ojha <mojha@codeaurora.org>
AuthorDate: Wed, 31 Jul 2019 20:35:04 +0530
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 6 Aug 2019 12:49:16 +0200

locking/mutex: Use mutex flags macro instead of hard code

Use the mutex flag macro instead of hard code value inside
__mutex_owner().

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: mingo@redhat.com
Cc: will@kernel.org
Link: https://lkml.kernel.org/r/1564585504-3543-2-git-send-email-mojha@codeaurora.org
---
 kernel/locking/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index ac4929f1e085..b4bcb0236d7a 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -85,7 +85,7 @@ EXPORT_SYMBOL(__mutex_init);
  */
 static inline struct task_struct *__mutex_owner(struct mutex *lock)
 {
-	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
 }
 
 static inline struct task_struct *__owner_task(unsigned long owner)
