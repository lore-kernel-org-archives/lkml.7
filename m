Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8D8C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3678A2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596694;
	bh=XuGk9y4xY+BW0ROwuRtTEZchqOxHUPAD2XcLQnLPt4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgQ4YxQq7fHaOlUHigybI8VL4dzBka7rX0q1mMYYIDAxrYWwqrblZ0tH4p3k088Yk
	 JaItDcZqd9f+4TtmvxkBW+2OZV36tqTzoT4tiIZ37h10W6opt4Jjaohy1fRDumKsVb
	 S8h+bxqSrgKlZZ25zqinP6NMBwxqPQA2tGhIgi30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfF0Avc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfF0AeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:34:20 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245FA217F9;
        Thu, 27 Jun 2019 00:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595659;
        bh=XuGk9y4xY+BW0ROwuRtTEZchqOxHUPAD2XcLQnLPt4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDwxEe61Uv0AOqMoOPtCyR1V/F3OOx3Fkdq1DYlE+3N2yIel+VsxkJdh4OOWC0ldc
         Fe3BioNldi8Q/JOaC+KAfVle2fW78xOTV6E0UtRSQ0o6u9Y9j2WyGabIlbC1IYftf8
         xQ0pLW9buV97oGUHT98njQG0dvqYuuRWa3kuJxkI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 70/95] bpf, devmap: Add missing RCU read lock on flush
Date:   Wed, 26 Jun 2019 20:29:55 -0400
Message-Id: <20190627003021.19867-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toshiaki Makita <toshiaki.makita1@gmail.com>

[ Upstream commit 86723c8640633bee4b4588d3c7784ee7a0032f65 ]

.ndo_xdp_xmit() assumes it is called under RCU. For example virtio_net
uses RCU to detect it has setup the resources for tx. The assumption
accidentally broke when introducing bulk queue in devmap.

Fixes: 5d053f9da431 ("bpf: devmap prepare xdp frames for bulking")
Reported-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Toshiaki Makita <toshiaki.makita1@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a126d95d12de..1defea4b2755 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -282,6 +282,7 @@ void __dev_map_flush(struct bpf_map *map)
 	unsigned long *bitmap = this_cpu_ptr(dtab->flush_needed);
 	u32 bit;
 
+	rcu_read_lock();
 	for_each_set_bit(bit, bitmap, map->max_entries) {
 		struct bpf_dtab_netdev *dev = READ_ONCE(dtab->netdev_map[bit]);
 		struct xdp_bulk_queue *bq;
@@ -297,6 +298,7 @@ void __dev_map_flush(struct bpf_map *map)
 
 		__clear_bit(bit, bitmap);
 	}
+	rcu_read_unlock();
 }
 
 /* rcu_read_lock (from syscall and BPF contexts) ensures that if a delete and/or
@@ -389,6 +391,7 @@ static void dev_map_flush_old(struct bpf_dtab_netdev *dev)
 
 		int cpu;
 
+		rcu_read_lock();
 		for_each_online_cpu(cpu) {
 			bitmap = per_cpu_ptr(dev->dtab->flush_needed, cpu);
 			__clear_bit(dev->bit, bitmap);
@@ -396,6 +399,7 @@ static void dev_map_flush_old(struct bpf_dtab_netdev *dev)
 			bq = per_cpu_ptr(dev->bulkq, cpu);
 			bq_xmit_all(dev, bq, XDP_XMIT_FLUSH, false);
 		}
+		rcu_read_unlock();
 	}
 }
 
-- 
2.20.1

