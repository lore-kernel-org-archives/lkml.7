Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A57C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AD221734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413711;
	bh=3l/lK/69KMYz3XILXGkh5EPwGQwtskJ/vIAMX5gEU18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ba+sdMIvVwVVkkNsQaBOEnjeL/K93shsow13OItTxbJh5LaRKZtaUOtVSViAsxg4w
	 hTdyqRfqo7hJR+JPvnqs3y35epPBFDGKSDo/07WosZ/krs4V9tNybuVU96kscIdIkA
	 RaH+RRutWr1esRVKpGDtgo7uC9byWdKcOzeYnkCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfCLSBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbfCLRNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:10 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DFDF2087C;
        Tue, 12 Mar 2019 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410789;
        bh=3l/lK/69KMYz3XILXGkh5EPwGQwtskJ/vIAMX5gEU18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9r65nfa3A8lTHPA8+HL9u8WFjLLQjz33c46bS8EuiOnUZHUFAyy5j2vviq2q0Cuf
         T4ZDdV/XfsFWMQmAQsE7ePQMoTVxCFeI6dxSQMg1b6KySWEuNzjEqsh0Yt46kce7ji
         3Dcjqh48Y80MAZAWH8ErCz2WgryYK8k2/2RVyz8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 111/171] bpf: run bpf programs with preemption disabled
Date:   Tue, 12 Mar 2019 10:08:11 -0700
Message-Id: <20190312170357.516315895@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b776626aeb84..958eddbc44d3 100644
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
index 9425c2fb872f..6c24b1fb2db8 100644
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



