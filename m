Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B762183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504278;
	bh=M90tyzwbXJdW7WZmz/ARiMvMIIwtoaKSJk56xlcEmX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXTrGgZ+yVC1nkIhYDHwaQpWMLrnIvcoC3G0OIpQHozZBahkpp0ya+AkngWxPENCR
	 apDPop5E+zqVxcxA6uhE4G1xFMNnQ62+YRmZXrSERnxFEYzpAWNU0Bht/YfaoeIO0a
	 DhaUJ5SwcrDRJELs8rX1hv1BrGW7K6WaPKbs9UJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfCMTLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfCMTLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7912D2075C;
        Wed, 13 Mar 2019 19:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504271;
        bh=M90tyzwbXJdW7WZmz/ARiMvMIIwtoaKSJk56xlcEmX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCwZKRwMP3ijMCTt/rAYjAeMC9tBlxyv7QT3udv9L0J0rIDIVvTADTeQVLjeX1/q+
         qKmzhYm5ljcmFgMTu/U02jwG5oWublriWNi6OugRPfkBlb2M5kDd592r2vNxkK13G7
         76U6zQtcNP1d3/sEHMaa/zZQGQ4KAPv5KdGXLAAg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 24/60] bpf/test_run: fix unkillable BPF_PROG_TEST_RUN
Date:   Wed, 13 Mar 2019 15:09:45 -0400
Message-Id: <20190313191021.158171-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit df1a2cb7c74b3d3abc8d8c2d690f82c8ebc3490a ]

Syzbot found out that running BPF_PROG_TEST_RUN with repeat=0xffffffff
makes process unkillable. The problem is that when CONFIG_PREEMPT is
enabled, we never see need_resched() return true. This is due to the
fact that preempt_enable() (which we do in bpf_test_run_one on each
iteration) now handles resched if it's needed.

Let's disable preemption for the whole run, not per test. In this case
we can properly see whether resched is needed.
Let's also properly return -EINTR to the userspace in case of a signal
interrupt.

See recent discussion:
http://lore.kernel.org/netdev/CAH3MdRWHr4N8jei8jxDppXjmw-Nw=puNDLbu1dQOFQHxfU2onA@mail.gmail.com

I'll follow up with the same fix bpf_prog_test_run_flow_dissector in
bpf-next.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bpf/test_run.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 25001913d03b..14a631817e12 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -13,27 +13,13 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 
-static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
-		struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
-{
-	u32 ret;
-
-	preempt_disable();
-	rcu_read_lock();
-	bpf_cgroup_storage_set(storage);
-	ret = BPF_PROG_RUN(prog, ctx);
-	rcu_read_unlock();
-	preempt_enable();
-
-	return ret;
-}
-
-static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *ret,
-			u32 *time)
+static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
+			u32 *retval, u32 *time)
 {
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { 0 };
 	enum bpf_cgroup_storage_type stype;
 	u64 time_start, time_spent = 0;
+	int ret = 0;
 	u32 i;
 
 	for_each_cgroup_storage_type(stype) {
@@ -48,25 +34,42 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *ret,
 
 	if (!repeat)
 		repeat = 1;
+
+	rcu_read_lock();
+	preempt_disable();
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		*ret = bpf_test_run_one(prog, ctx, storage);
+		bpf_cgroup_storage_set(storage);
+		*retval = BPF_PROG_RUN(prog, ctx);
+
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
 		if (need_resched()) {
-			if (signal_pending(current))
-				break;
 			time_spent += ktime_get_ns() - time_start;
+			preempt_enable();
+			rcu_read_unlock();
+
 			cond_resched();
+
+			rcu_read_lock();
+			preempt_disable();
 			time_start = ktime_get_ns();
 		}
 	}
 	time_spent += ktime_get_ns() - time_start;
+	preempt_enable();
+	rcu_read_unlock();
+
 	do_div(time_spent, repeat);
 	*time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
 	for_each_cgroup_storage_type(stype)
 		bpf_cgroup_storage_free(storage[stype]);
 
-	return 0;
+	return ret;
 }
 
 static int bpf_test_finish(const union bpf_attr *kattr,
-- 
2.19.1

