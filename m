Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A57C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B30D218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610798;
	bh=FkcgN0sC8JjFHDxYbEilXDzWfhUtVmz57J6VhZtk63s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0MWtiG3TUFjumFpjq8FaLlicAjt52rXMichLygMrbwrayKliA+r+8+tkkssV2sRZ9
	 bF47XVd+OnPXrCZSZO9t6sct2nisp+HJEcRj/3FzP99bsrBPymsAOLoQnPD6x2be87
	 vORH9vRdyC+1qQ8x5x2yvpNaoAqn9baXR4e1dSa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391507AbfDRSGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391118AbfDRSGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C712B218A1;
        Thu, 18 Apr 2019 18:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610792;
        bh=FkcgN0sC8JjFHDxYbEilXDzWfhUtVmz57J6VhZtk63s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdFmLa7zliFL8Pv1UishobdncBzQZ9d59yrNsW97B2o0rRPlNCSn9iq5rKY51P+On
         23Har0QGXCdC28jDaCOTBrA7xACWd8lfWhbZboD/2sZP/zelttJclIvTMKQ6Inztsj
         OTPUhMki8IDVGUdWxe7mK3ZS8hp/AmMR39J0wtiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Vallish Vaidyeshwara <vallish@amazon.com>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 86/92] bpf: fix inner map masking to prevent oob under speculation
Date:   Thu, 18 Apr 2019 19:57:44 +0200
Message-Id: <20190418160438.021404394@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit 9d5564ddcf2a0f5ba3fa1c3a1f8a1b59ad309553 upstream.

During review I noticed that inner meta map setup for map in
map is buggy in that it does not propagate all needed data
from the reference map which the verifier is later accessing.

In particular one such case is index masking to prevent out of
bounds access under speculative execution due to missing the
map's unpriv_array/index_mask field propagation. Fix this such
that the verifier is generating the correct code for inlined
lookups in case of unpriviledged use.

Before patch (test_verifier's 'map in map access' dump):

  # bpftool prog dump xla id 3
     0: (62) *(u32 *)(r10 -4) = 0
     1: (bf) r2 = r10
     2: (07) r2 += -4
     3: (18) r1 = map[id:4]
     5: (07) r1 += 272                |
     6: (61) r0 = *(u32 *)(r2 +0)     |
     7: (35) if r0 >= 0x1 goto pc+6   | Inlined map in map lookup
     8: (54) (u32) r0 &= (u32) 0      | with index masking for
     9: (67) r0 <<= 3                 | map->unpriv_array.
    10: (0f) r0 += r1                 |
    11: (79) r0 = *(u64 *)(r0 +0)     |
    12: (15) if r0 == 0x0 goto pc+1   |
    13: (05) goto pc+1                |
    14: (b7) r0 = 0                   |
    15: (15) if r0 == 0x0 goto pc+11
    16: (62) *(u32 *)(r10 -4) = 0
    17: (bf) r2 = r10
    18: (07) r2 += -4
    19: (bf) r1 = r0
    20: (07) r1 += 272                |
    21: (61) r0 = *(u32 *)(r2 +0)     | Index masking missing (!)
    22: (35) if r0 >= 0x1 goto pc+3   | for inner map despite
    23: (67) r0 <<= 3                 | map->unpriv_array set.
    24: (0f) r0 += r1                 |
    25: (05) goto pc+1                |
    26: (b7) r0 = 0                   |
    27: (b7) r0 = 0
    28: (95) exit

After patch:

  # bpftool prog dump xla id 1
     0: (62) *(u32 *)(r10 -4) = 0
     1: (bf) r2 = r10
     2: (07) r2 += -4
     3: (18) r1 = map[id:2]
     5: (07) r1 += 272                |
     6: (61) r0 = *(u32 *)(r2 +0)     |
     7: (35) if r0 >= 0x1 goto pc+6   | Same inlined map in map lookup
     8: (54) (u32) r0 &= (u32) 0      | with index masking due to
     9: (67) r0 <<= 3                 | map->unpriv_array.
    10: (0f) r0 += r1                 |
    11: (79) r0 = *(u64 *)(r0 +0)     |
    12: (15) if r0 == 0x0 goto pc+1   |
    13: (05) goto pc+1                |
    14: (b7) r0 = 0                   |
    15: (15) if r0 == 0x0 goto pc+12
    16: (62) *(u32 *)(r10 -4) = 0
    17: (bf) r2 = r10
    18: (07) r2 += -4
    19: (bf) r1 = r0
    20: (07) r1 += 272                |
    21: (61) r0 = *(u32 *)(r2 +0)     |
    22: (35) if r0 >= 0x1 goto pc+4   | Now fixed inlined inner map
    23: (54) (u32) r0 &= (u32) 0      | lookup with proper index masking
    24: (67) r0 <<= 3                 | for map->unpriv_array.
    25: (0f) r0 += r1                 |
    26: (05) goto pc+1                |
    27: (b7) r0 = 0                   |
    28: (b7) r0 = 0
    29: (95) exit


Fixes: b2157399cc98 ("bpf: prevent out-of-bounds speculation")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Vallish Vaidyeshwara <vallish@amazon.com>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/map_in_map.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -12,6 +12,7 @@
 struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 {
 	struct bpf_map *inner_map, *inner_map_meta;
+	u32 inner_map_meta_size;
 	struct fd f;
 
 	f = fdget(inner_map_ufd);
@@ -34,7 +35,12 @@ struct bpf_map *bpf_map_meta_alloc(int i
 		return ERR_PTR(-EINVAL);
 	}
 
-	inner_map_meta = kzalloc(sizeof(*inner_map_meta), GFP_USER);
+	inner_map_meta_size = sizeof(*inner_map_meta);
+	/* In some cases verifier needs to access beyond just base map. */
+	if (inner_map->ops == &array_map_ops)
+		inner_map_meta_size = sizeof(struct bpf_array);
+
+	inner_map_meta = kzalloc(inner_map_meta_size, GFP_USER);
 	if (!inner_map_meta) {
 		fdput(f);
 		return ERR_PTR(-ENOMEM);
@@ -44,9 +50,16 @@ struct bpf_map *bpf_map_meta_alloc(int i
 	inner_map_meta->key_size = inner_map->key_size;
 	inner_map_meta->value_size = inner_map->value_size;
 	inner_map_meta->map_flags = inner_map->map_flags;
-	inner_map_meta->ops = inner_map->ops;
 	inner_map_meta->max_entries = inner_map->max_entries;
 
+	/* Misc members not needed in bpf_map_meta_equal() check. */
+	inner_map_meta->ops = inner_map->ops;
+	if (inner_map->ops == &array_map_ops) {
+		inner_map_meta->unpriv_array = inner_map->unpriv_array;
+		container_of(inner_map_meta, struct bpf_array, map)->index_mask =
+		     container_of(inner_map, struct bpf_array, map)->index_mask;
+	}
+
 	fdput(f);
 	return inner_map_meta;
 }


