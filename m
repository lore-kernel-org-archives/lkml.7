Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6FFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A392D2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414715;
	bh=Pka+lXoDr+s+sZS29RUn+cHLuNV95s0ZySHpb5Z2xWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tnUzBxeA7IT4e7wTph0aT742ZBD7TTN91WI6dh/58bBr4Hq53DHAjqbZUWRtsO8gb
	 oFPPnf+YE9hjvVj8MUVHniX3ahOJVBGyE84zkJDkCMeCCeoTMF242ERmo1UeDHtWIw
	 7CmO4eTOtbennRRb8pXRd9jOmHflkSp2rU9MAMWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfLCXLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbfLCWkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF5A20803;
        Tue,  3 Dec 2019 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412836;
        bh=Pka+lXoDr+s+sZS29RUn+cHLuNV95s0ZySHpb5Z2xWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVkb+XPoAD50iVLPNK9+fHd1sIwJJSBsSBx/uOwRVdwrrOTd1B3l0jt2B5t4ni1gL
         90lYWJuRgNs4/yMyD0SH8FT7C0xEcZ6CnymERQJSRevPGJP+xgh1eX31NPa6r/OzyZ
         P+pRUv/VpUtCi43thwfiDSUzBX2K64sKOIU9B5YE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 034/135] bpf: Change size to u64 for bpf_map_{area_alloc, charge_init}()
Date:   Tue,  3 Dec 2019 23:34:34 +0100
Message-Id: <20191203213013.072938572@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

[ Upstream commit ff1c08e1f74b6864854c39be48aa799a6a2e4d2b ]

The functions bpf_map_area_alloc() and bpf_map_charge_init() prior
this commit passed the size parameter as size_t. In this commit this
is changed to u64.

All users of these functions avoid size_t overflows on 32-bit systems,
by explicitly using u64 when calculating the allocation size and
memory charge cost. However, since the result was narrowed by the
size_t when passing size and cost to the functions, the overflow
handling was in vain.

Instead of changing all call sites to size_t and handle overflow at
the call site, the parameter is changed to u64 and checked in the
functions above.

Fixes: d407bd25a204 ("bpf: don't trigger OOM killer under pressure with map alloc")
Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Link: https://lore.kernel.org/bpf/20191029154307.23053-1-bjorn.topel@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h  | 4 ++--
 kernel/bpf/syscall.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 18f4cc2c6acd4..5d177c0c7fe37 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -651,11 +651,11 @@ void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
 int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
 void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
-int bpf_map_charge_init(struct bpf_map_memory *mem, size_t size);
+int bpf_map_charge_init(struct bpf_map_memory *mem, u64 size);
 void bpf_map_charge_finish(struct bpf_map_memory *mem);
 void bpf_map_charge_move(struct bpf_map_memory *dst,
 			 struct bpf_map_memory *src);
-void *bpf_map_area_alloc(size_t size, int numa_node);
+void *bpf_map_area_alloc(u64 size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index aac966b32c42e..ee3087462bc97 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -126,7 +126,7 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 	return map;
 }
 
-void *bpf_map_area_alloc(size_t size, int numa_node)
+void *bpf_map_area_alloc(u64 size, int numa_node)
 {
 	/* We really just want to fail instead of triggering OOM killer
 	 * under memory pressure, therefore we set __GFP_NORETRY to kmalloc,
@@ -141,6 +141,9 @@ void *bpf_map_area_alloc(size_t size, int numa_node)
 	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
 	void *area;
 
+	if (size >= SIZE_MAX)
+		return NULL;
+
 	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
 		area = kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
 				    numa_node);
@@ -197,7 +200,7 @@ static void bpf_uncharge_memlock(struct user_struct *user, u32 pages)
 		atomic_long_sub(pages, &user->locked_vm);
 }
 
-int bpf_map_charge_init(struct bpf_map_memory *mem, size_t size)
+int bpf_map_charge_init(struct bpf_map_memory *mem, u64 size)
 {
 	u32 pages = round_up(size, PAGE_SIZE) >> PAGE_SHIFT;
 	struct user_struct *user;
-- 
2.20.1



