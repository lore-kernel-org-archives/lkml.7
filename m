Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D73BC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE9524697
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012240;
	bh=3AM9J6092mMIJf2OThqbFrul+9FIZQKAy6B6VFY0Je8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2OOMnAHXgJQ4OLpJ3Ot4FE4cBeJI+Oc9haaz56BZqPD9e6SOWswBbIDA8QLKr8ZA
	 yob4bQj/mhcV16i8Frdl/8Wkt4hVuYCTASXQBemDuNjcELrWyiopmwNfL/rz+1pEkA
	 ggnToo6I4J/zsN5rbOA9QQ9FW+dsqj3eIAfs9sB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfLJVKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbfLJVKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7113E246B2;
        Tue, 10 Dec 2019 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012234;
        bh=3AM9J6092mMIJf2OThqbFrul+9FIZQKAy6B6VFY0Je8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFpRtxAPcRguWkaEPf/RZTEDvxTtfP/sJtkIJI97P+BYmqpLqPZYlqO1eqXCl1M4J
         1rflT0qCvKUNr1cprE15Sw9V+HhEFCCvbxhi3wE9AKYc1Bf1izZEU7cKOpHh8Ae20r
         E+BUhC/T5AFGwqwLQVNDpvw/PtahiSWyJLS5O7Tw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 183/350] s390: add error handling to perf_callchain_kernel
Date:   Tue, 10 Dec 2019 16:04:48 -0500
Message-Id: <20191210210735.9077-144-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit effb83ccc83a97dbbe5214f4c443522719f05f3a ]

perf_callchain_kernel stops neither when it encounters a garbage
address, nor when it runs out of space. Fix both issues using x86
version as an inspiration.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_event.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index fcb6c2e92b071..1e75cc9835468 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -224,9 +224,13 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
 	struct unwind_state state;
+	unsigned long addr;
 
-	unwind_for_each_frame(&state, current, regs, 0)
-		perf_callchain_store(entry, state.ip);
+	unwind_for_each_frame(&state, current, regs, 0) {
+		addr = unwind_get_return_address(&state);
+		if (!addr || perf_callchain_store(entry, addr))
+			return;
+	}
 }
 
 /* Perf definitions for PMU event attributes in sysfs */
-- 
2.20.1

