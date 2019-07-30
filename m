Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9563C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DF62171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LTrOfle7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z6YOImB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbfG3PuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:50:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55410 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfG3PuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:50:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 47DE7602BC; Tue, 30 Jul 2019 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564501816;
        bh=NFSJDHsvNcgma1AqAO7YILkTxwa/9aujCss4icGjbpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTrOfle7Tdlq3dfMJpX1XLGhiXotFpnpc1QtQOgvFAnM/K+jC6bEO22v0XcORf5Ro
         qQoyWQR/Dlihrg8Zp9qyqNWj5ryF9l3btQ3XbPNo+XWYUFi6Qci6D+cd7DtP5zSk+V
         K+JPc8T/6a2Rz5rAbZgfx2c7randDWYcgRLZJbc8=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3500660D0C;
        Tue, 30 Jul 2019 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564501815;
        bh=NFSJDHsvNcgma1AqAO7YILkTxwa/9aujCss4icGjbpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6YOImB7WqNkYO655VwI/WodNxpXvp3n3Ybgm43TIziP4ibVYQE9ArTeg8Y/teptw
         42Auiqq6qlmxMYOENUh7t1Mi2eradYtccMLTwtimiEQ+9l2ns2RX13DqGWIbIMJ8Gk
         vC2VxVYVjE6fDD6w0afNn0u9R2sQBRLmOrZKyJHQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3500660D0C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 2/2 v2] locking/mutex: Use mutex flags macro instead of hard code value
Date:   Tue, 30 Jul 2019 21:19:54 +0530
Message-Id: <1564501794-11379-2-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564501794-11379-1-git-send-email-mojha@codeaurora.org>
References: <20190730080308.GF31381@hirez.programming.kicks-ass.net>
 <1564501794-11379-1-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the mutex flag macro instead of hard code value inside
__mutex_owner().

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
Changes in v2:
 - Framed the commit according the changes done in 1/2 of
   the patchset.

 kernel/locking/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index f73250a..1c8f86a 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -72,7 +72,7 @@
  */
 static inline struct task_struct *__mutex_owner(struct mutex *lock)
 {
-	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
 }
 
 /**
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

