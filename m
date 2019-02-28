Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A182CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705D9218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366578;
	bh=PEq46RXqOKbnl8VFkq+bKB1gAldK5jVxzjJ5ET6KvAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ty2x9X8ClrFiCdjO2beEOZjXSF6ptRAr+9exTC/cPGgNv8wRBi7sqJse7PHs69+Dt
	 a6VbDCBSHjksUJQdxccBI2apqomh/EMP/s6Ghw1+S1Y97XTDsdwwWPlfTk9rEoKgdz
	 8XCAZfjej4NS8rEn+16Z09ytIXI8kVU5Mf+WTdrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfB1PJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387575AbfB1PJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15AD0218B0;
        Thu, 28 Feb 2019 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366569;
        bh=PEq46RXqOKbnl8VFkq+bKB1gAldK5jVxzjJ5ET6KvAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxNqbpJ1/A5QlGBE5fsxMdS/JX1fZA/uHd1ZT4/sNqUJKS4Uy3x+DXLFKS4kNaQHR
         XSA+WUUi+GA4ziS3BjHlrxJ7VmuTn05UF+BrgXQwZHs8S7vwXn2l/gOnbpd9REM7mA
         xSO4p6+TRLMDyWuq1ZXldus75GX4mDhESwmk01CE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 49/81] bpf: Fix syscall's stackmap lookup potential deadlock
Date:   Thu, 28 Feb 2019 10:07:41 -0500
Message-Id: <20190228150813.10256-49-sashal@kernel.org>
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

From: Martin KaFai Lau <kafai@fb.com>

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
index cf5040fd54344..5f03ddf7b6152 100644
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

