Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C08AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9172133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367832;
	bh=4u3j2GUjzwUbikH7y5MSpux58vNLlKk5vF1owd59SC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lInpXzJIhjDRQTs5RSVtDyiY7dxuQapTkynI3RTfxcR4hMQQao35MnLJC1DPXlbig
	 O30LV3ZJrz7zbfJhiO4qMXNtZjJsm7uUPEkqbwqvJ7Ebof16MC3OYtXlZ9cqVqO/CO
	 3HREDkQcpDYPptaPS1Ybk7SJ7jcgWjAKr51U7PAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfB1Paa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387540AbfB1PJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 841AA218AE;
        Thu, 28 Feb 2019 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366566;
        bh=4u3j2GUjzwUbikH7y5MSpux58vNLlKk5vF1owd59SC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEuwOJs+FT72/1M8Lr9gIz71o8cZ7pXoDvP4QZbPRpiDlQr7yKbLQVHng1RABVV9V
         IZMC5sKUC0djESFyGG18ZodfT2Vzc4rX2OGRU5NpGRaTuTIe30k/SyKgR7CkPEAaqe
         v5fW/qBqT4wUaOYtWQjbcKIMNXpKUSuJ756TZ5as=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 46/81] bpf: run bpf programs with preemption disabled
Date:   Thu, 28 Feb 2019 10:07:38 -0500
Message-Id: <20190228150813.10256-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 6cab5e90ab2bd323c9f3811b6c70a4687df51e27 ]

Disabled preemption is necessary for proper access to per-cpu maps
from BPF programs.

But the sender side of socket filters didn't have preemption disabled:
unix_dgram_sendmsg->sk_filter->sk_filter_trim_cap->bpf_prog_run_save_cb->BPF_PROG_RUN

and a combination of af_packet with tun device didn't disable either:
tpacket_snd->packet_direct_xmit->packet_pick_tx_queue->ndo_select_queue->
  tun_select_queue->tun_ebpf_select_queue->bpf_prog_run_clear_cb->BPF_PROG_RUN

Disable preemption before executing BPF programs (both classic and extended).

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h | 21 ++++++++++++++++++---
 kernel/bpf/cgroup.c    |  2 +-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b776626aeb849..958eddbc44d32 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -591,8 +591,8 @@ static inline u8 *bpf_skb_cb(struct sk_buff *skb)
 	return qdisc_skb_cb(skb)->data;
 }
 
-static inline u32 bpf_prog_run_save_cb(const struct bpf_prog *prog,
-				       struct sk_buff *skb)
+static inline u32 __bpf_prog_run_save_cb(const struct bpf_prog *prog,
+					 struct sk_buff *skb)
 {
 	u8 *cb_data = bpf_skb_cb(skb);
 	u8 cb_saved[BPF_SKB_CB_LEN];
@@ -611,15 +611,30 @@ static inline u32 bpf_prog_run_save_cb(const struct bpf_prog *prog,
 	return res;
 }
 
+static inline u32 bpf_prog_run_save_cb(const struct bpf_prog *prog,
+				       struct sk_buff *skb)
+{
+	u32 res;
+
+	preempt_disable();
+	res = __bpf_prog_run_save_cb(prog, skb);
+	preempt_enable();
+	return res;
+}
+
 static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 					struct sk_buff *skb)
 {
 	u8 *cb_data = bpf_skb_cb(skb);
+	u32 res;
 
 	if (unlikely(prog->cb_access))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
-	return BPF_PROG_RUN(prog, skb);
+	preempt_disable();
+	res = BPF_PROG_RUN(prog, skb);
+	preempt_enable();
+	return res;
 }
 
 static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9425c2fb872f7..6c24b1fb2db8e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -572,7 +572,7 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 	bpf_compute_and_save_data_end(skb, &saved_data_end);
 
 	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], skb,
-				 bpf_prog_run_save_cb);
+				 __bpf_prog_run_save_cb);
 	bpf_restore_data_end(skb, saved_data_end);
 	__skb_pull(skb, offset);
 	skb->sk = save_sk;
-- 
2.19.1

