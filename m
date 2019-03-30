Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37669C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF357205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908237;
	bh=Y0DyrFn/Mj3oz8YPrEBmNZGX9FX9trbQvcL6o5posys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XdblSOWyCYlZZpZZgmM0OJZMs1YZRDB/qoP+lHkdMUuH+Z5N9veLkeHC3hgvTF2nq
	 tknTrd14ZdefXo24Ubf9Gf+wId0Lc3jfsEHDp3YZIgkEX/1wDZ09UGj6pITvQsfL9v
	 s/4TsbpLU3qU+fKL8PfFayIhI+iCEnMET4ukr08A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfC3BKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbfC3Avd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972EB218AC;
        Sat, 30 Mar 2019 00:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907093;
        bh=Y0DyrFn/Mj3oz8YPrEBmNZGX9FX9trbQvcL6o5posys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eu6/R1AYFBSStc1sO6MF2Hmq1kdu7xs6v1y8XwufAJ8rnFTIsLNTDOLo3ddBPzdMq
         4HAvgwzg5h8oF+DbpAduNXnpR8CCzuQ7cvQXksSDJ38PLnHEQ+/runOJIPnT3DGBAn
         qLfg5ZYCUPA3vXk+U/gYACsgKpoH7xWfnxJJ5dnI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 28/67] sched/core: Fix buffer overflow in cgroup2 property cpu.max
Date:   Fri, 29 Mar 2019 20:50:08 -0400
Message-Id: <20190330005047.25998-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit 4c47acd824aaaa8fc6dc519fb4e08d1522105b7a ]

Add limit into sscanf format string for on-stack buffer.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified hierarchy")
Link: https://lkml.kernel.org/r/155189230232.2620.13120481613524200065.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8d76a65cfdd..e843fbd9012e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6941,7 +6941,7 @@ static int __maybe_unused cpu_period_quota_parse(char *buf,
 {
 	char tok[21];	/* U64_MAX */
 
-	if (!sscanf(buf, "%s %llu", tok, periodp))
+	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
 		return -EINVAL;
 
 	*periodp *= NSEC_PER_USEC;
-- 
2.19.1

