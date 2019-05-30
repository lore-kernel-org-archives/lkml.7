Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE03BC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957062553F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190502;
	bh=Ccf3TJwtMM4NcJB/LDU11Fx86Q+CHjGntLaWj4vFXDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cIFw9yVyKOLTTMH2ffWBgLgfJHUabNDXqpIJzM/Z9FOcT/vgVzjxQGyBTKfRBnRrV
	 kqGoL+jd9PT8Zgg2EgoCDRr1HpeN+hVThIxLgbvk3zBAq/nd0DGTngqjSU0jcc/l1g
	 SND0RfPrbHp+C6Adchkk+zcdN5/VoVQuHMBSjcbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbfE3E2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729781AbfE3DOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:15 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FBB24555;
        Thu, 30 May 2019 03:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186055;
        bh=Ccf3TJwtMM4NcJB/LDU11Fx86Q+CHjGntLaWj4vFXDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDC7ZB8Jw6gMA6is+5qDMKmZRyp8TtsGmAYXKt35/EpoSKYgGEiBvwDaeRX04H36p
         9W4B8HY9o3yRC/SQCBdBWMyZCf5WJVrcZ0suPj+6C1OjZKEjW0O+J6Mglz4Gds5wSm
         xMVozjuAIZpInNcHir490Jqn3f96ZFDH1KRKaBTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 153/346] sched/core: Check quota and period overflow at usec to nsec conversion
Date:   Wed, 29 May 2019 20:03:46 -0700
Message-Id: <20190530030548.935524112@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1a8b4540db732ca16c9e43ac7c08b1b8f0b252d8 ]

Large values could overflow u64 and pass following sanity checks.

 # echo 18446744073750000 > cpu.cfs_period_us
 # cat cpu.cfs_period_us
 40448

 # echo 18446744073750000 > cpu.cfs_quota_us
 # cat cpu.cfs_quota_us
 40448

After this patch they will fail with -EINVAL.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/155125502079.293431.3947497929372138600.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 62cc29364fba9..55c1061b5aeb1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6605,8 +6605,10 @@ int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
 	if (cfs_quota_us < 0)
 		quota = RUNTIME_INF;
-	else
+	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
 		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
+	else
+		return -EINVAL;
 
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
@@ -6628,6 +6630,9 @@ int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period;
 
+	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
 	period = (u64)cfs_period_us * NSEC_PER_USEC;
 	quota = tg->cfs_bandwidth.quota;
 
-- 
2.20.1



