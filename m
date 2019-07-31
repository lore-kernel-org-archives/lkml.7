Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33219C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F044F206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QS83uU5z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jn353ww6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbfGaPF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:05:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388412AbfGaPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:05:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 531A56083C; Wed, 31 Jul 2019 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564585522;
        bh=4h7hzmrRHwRmGDBSz2gyZ3IitaxH8rSJcLUs5VAWXfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QS83uU5zFThZ0xBy8hnm9PAZKXyxtwWwH0d05QUuGcHPHZDO6zJTshqwwa5/4Et9Z
         Px1j0WHqnQtKZ7LLfypFXx37RWornHROAmVuILzZog0oKT6PLqezikiFwjCH6UOz7c
         DaCPYjhQ+PCh89AqeSYfV/ePhEwv0BPiKKxO2mbs=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A260602F1;
        Wed, 31 Jul 2019 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564585521;
        bh=4h7hzmrRHwRmGDBSz2gyZ3IitaxH8rSJcLUs5VAWXfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jn353ww6Sh0VROubihZ6x6P20BK7LuY1NXOFhpfvn3I0ssni/6/SdBSMfsCpgxsHM
         KuEA7iR6urRIUK5/mbtgErdNsP9qAqD8O/oYWMxoNGVQrASBWrP8SPp8d9X2GpcKTq
         lvku32mAtYRFTrYxl9Ui5rAD8BpjLeQqAQebBUVE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A260602F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 2/2 v3] locking/mutex: Use mutex flags macro instead of hard code
Date:   Wed, 31 Jul 2019 20:35:04 +0530
Message-Id: <1564585504-3543-2-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564585504-3543-1-git-send-email-mojha@codeaurora.org>
References: <1564585504-3543-1-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the mutex flag macro instead of hard code value inside
__mutex_owner().

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
Changes in v3:
 - no change.

Changes in v2:
 - Framed the commit according the changes done in 1/2 of
   the patchset.

 kernel/locking/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index ac4929f..b4bcb02 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -85,7 +85,7 @@ struct mutex_waiter {
  */
 static inline struct task_struct *__mutex_owner(struct mutex *lock)
 {
-	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
 }
 
 static inline struct task_struct *__owner_task(unsigned long owner)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

