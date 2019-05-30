Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F376C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B96F25AE7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191475;
	bh=Qo4uhTRuwdTgrgWmIGr4DOtuQXlL6wBHRQOi1G4vB5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y25KFvN5dJ8gxfFOu6wPRFFW7qI6XVfeCC7gDAvLPoOpn5Q8Z56H6Q+fEtS6ctvRN
	 67yeTuLLqyDJY8k+/wrEdqMrTGgvBIRSQtiAA6RUe/9WAH0zQjkMPlVV8pgZASoV6Y
	 p+2oASyzbgmDVKH4urSQVLj4V9c3SEbdpO8k73Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbfE3Eoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfE3DMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:01 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BA024516;
        Thu, 30 May 2019 03:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185921;
        bh=Qo4uhTRuwdTgrgWmIGr4DOtuQXlL6wBHRQOi1G4vB5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaAY5HskRixk/BSuAA57LqUjAqvgJfTemUDaaVN3aVt4z6SdCf5l0XzHlFvMcdI/q
         4a8snNqCJxbXtv1VJLHdYcXl8McKP2+ElD7HHS/fvtJRh/kWh6EFqE2LmIli2zYK/O
         tZebnTjFAAG+AnreLpPhYAisi0+wwJ4hljJJCeik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 308/405] rcuperf: Fix cleanup path for invalid perf_type strings
Date:   Wed, 29 May 2019 20:05:06 -0700
Message-Id: <20190530030556.389622669@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ad092c027713a68a34168942a5ef422e42e039f4 ]

If the specified rcuperf.perf_type is not in the rcu_perf_init()
function's perf_ops[] array, rcuperf prints some console messages and
then invokes rcu_perf_cleanup() to set state so that a future torture
test can run.  However, rcu_perf_cleanup() also attempts to end the
test that didn't actually start, and in doing so relies on the value
of cur_ops, a value that is not particularly relevant in this case.
This can result in confusing output or even follow-on failures due to
attempts to use facilities that have not been properly initialized.

This commit therefore sets the value of cur_ops to NULL in this case and
inserts a check near the beginning of rcu_perf_cleanup(), thus avoiding
relying on an irrelevant cur_ops value.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcuperf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index c297611528744..7a6890b23c5f5 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -494,6 +494,10 @@ rcu_perf_cleanup(void)
 
 	if (torture_cleanup_begin())
 		return;
+	if (!cur_ops) {
+		torture_cleanup_end();
+		return;
+	}
 
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
@@ -614,6 +618,7 @@ rcu_perf_init(void)
 		pr_cont("\n");
 		WARN_ON(!IS_MODULE(CONFIG_RCU_PERF_TEST));
 		firsterr = -EINVAL;
+		cur_ops = NULL;
 		goto unwind;
 	}
 	if (cur_ops->init)
-- 
2.20.1



