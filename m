Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE0AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CE32081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554149;
	bh=zbMQSssgxEcMncoTrO0Isv+fTsVyLkzY3aAYQXjwqlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R2knFFkIJmAEDXl/zj6DUPA+U71xrIYVrkoH211YXUeZqMVEITYs0dz6mi6ypeALn
	 4z3oi2pzNlH4ZFoRLFDNOFeJC/u+BfdCTTOVNCanfUJrSXa9rIOcVOmJ3wXVjtXarl
	 BEomhSv7aPlgp/ekFaWum82jiO3esTzkkUNP2n+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfEVT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbfEVT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:28:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E07421473;
        Wed, 22 May 2019 19:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553309;
        bh=zbMQSssgxEcMncoTrO0Isv+fTsVyLkzY3aAYQXjwqlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfyrfakpPBUCTqVYy/WPZehIxKuKshGnXr0xYEYovJgkQrYcTK9KEvq/0hG3kwzO4
         m1cxcuJHwofpuckk1r976tAvxur3ri33PInSXDd1tMoMxKLAkpOTU450YuqgIOb/fx
         Ws5yzHNfMnN1if2EYXKqFc8Yas30uA3YHl1AmWJ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 075/244] smpboot: Place the __percpu annotation correctly
Date:   Wed, 22 May 2019 15:23:41 -0400
Message-Id: <20190522192630.24917-75-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit d4645d30b50d1691c26ff0f8fa4e718b08f8d3bb ]

The test robot reported a wrong assignment of a per-CPU variable which
it detected by using sparse and sent a report. The assignment itself is
correct. The annotation for sparse was wrong and hence the report.
The first pointer is a "normal" pointer and points to the per-CPU memory
area. That means that the __percpu annotation has to be moved.

Move the __percpu annotation to pointer which points to the per-CPU
area. This change affects only the sparse tool (and is ignored by the
compiler).

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: f97f8f06a49fe ("smpboot: Provide infrastructure for percpu hotplug threads")
Link: http://lkml.kernel.org/r/20190424085253.12178-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/smpboot.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index d0884b5250010..9d1bc65d226cc 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -29,7 +29,7 @@ struct smpboot_thread_data;
  * @thread_comm:	The base name of the thread
  */
 struct smp_hotplug_thread {
-	struct task_struct __percpu	**store;
+	struct task_struct		* __percpu *store;
 	struct list_head		list;
 	int				(*thread_should_run)(unsigned int cpu);
 	void				(*thread_fn)(unsigned int cpu);
-- 
2.20.1

