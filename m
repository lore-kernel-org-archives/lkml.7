Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B37C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C621E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413794;
	bh=a0oytfARmBA8nk8UsHsNzcvQ3W99CX4ejXRxtke/j7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XxOHJ39C4S2eUYidtnSvg9zs7cFqkXjfAYGao7VyTOzbJBsjDPbLSkZY/0t/u7YTX
	 Iqcu7U+M8c1kDUIKYINJNYmRDzKUAvXy4sD0I0suhFElbgoK5TrPe5JoZnDV1tVqVU
	 GLNWStM1lG/XuEjLWFVLFlM7EEJ0GattBJjleKAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfCLSDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfCLRM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:56 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCEFC217F4;
        Tue, 12 Mar 2019 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410775;
        bh=a0oytfARmBA8nk8UsHsNzcvQ3W99CX4ejXRxtke/j7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ziPcqWAkzHHdDsBM1Ce/w3CelkhoVZCH40OtXSJOgpn5ULtJ1goIt5xcWqy3Om6Uj
         Yw6AZfIeJoveWhXJ4m32SX3x3gDsYl4TWST+sQNfZonz/MQnyEVNNKM/kyZGR/plg4
         j8rdKzVos1HhTKfvpYlaNCYDFGigKBqwALrGg99o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 114/171] bpf: Fix syscalls stackmap lookup potential deadlock
Date:   Tue, 12 Mar 2019 10:08:14 -0700
Message-Id: <20190312170357.712585962@linuxfoundation.org>
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

[ Upstream commit 7c4cd051add3d00bbff008a133c936c515eaa8fe ]

The map_lookup_elem used to not acquiring spinlock
in order to optimize the reader.

It was true until commit 557c0c6e7df8 ("bpf: convert stackmap to pre-allocation")
The syscall's map_lookup_elem(stackmap) calls bpf_stackmap_copy().
bpf_stackmap_copy() may find the elem no longer needed after the copy is done.
If that is the case, pcpu_freelist_push() saves this elem for reuse later.
This push requires a spinlock.

If a tracing bpf_prog got run in the middle of the syscall's
map_lookup_elem(stackmap) and this tracing bpf_prog is calling
bpf_get_stackid(stackmap) which also requires the same pcpu_freelist's
spinlock, it may end up with a dead lock situation as reported by
Eric Dumazet in https://patchwork.ozlabs.org/patch/1030266/

The situation is the same as the syscall's map_update_elem() which
needs to acquire the pcpu_freelist's spinlock and could race
with tracing bpf_prog.  Hence, this patch fixes it by protecting
bpf_stackmap_copy() with this_cpu_inc(bpf_prog_active)
to prevent tracing bpf_prog from running.

A later syscall's map_lookup_elem commit f1a2e44a3aec ("bpf: add queue and stack maps")
also acquires a spinlock and races with tracing bpf_prog similarly.
Hence, this patch is forward looking and protects the majority
of the map lookups.  bpf_map_offload_lookup_elem() is the exception
since it is for network bpf_prog only (i.e. never called by tracing
bpf_prog).

Fixes: 557c0c6e7df8 ("bpf: convert stackmap to pre-allocation")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cf5040fd5434..5f03ddf7b615 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -712,8 +712,13 @@ static int map_lookup_elem(union bpf_attr *attr)
 
 	if (bpf_map_is_dev_bound(map)) {
 		err = bpf_map_offload_lookup_elem(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
+		goto done;
+	}
+
+	preempt_disable();
+	this_cpu_inc(bpf_prog_active);
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value);
@@ -743,7 +748,10 @@ static int map_lookup_elem(union bpf_attr *attr)
 		}
 		rcu_read_unlock();
 	}
+	this_cpu_dec(bpf_prog_active);
+	preempt_enable();
 
+done:
 	if (err)
 		goto free_value;
 
-- 
2.19.1



