Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BFAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19E22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714938;
	bh=2K1NsZ8pgY0DBWjO3DAoYyXaNrz4IRlgOMiO/ylmQ8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rny1XePYMB7ixERg5Llaj5Q2hDzeV9NbH2SrYQ3TtRXiRJCFhWMuYiiOu0lzsvr2X
	 XbCIw2F4xmuLpF/dRQ2txtDAEDKDoyXk0IN+3EWN4+JzdbecUOa/03dtpOEbp8Y6Jl
	 9+iopi5ncgap8idySzlOFGu0CiFN9ZzHEy6f6dxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfC0T24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733098AbfC0SEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECEDD21738;
        Wed, 27 Mar 2019 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709841;
        bh=2K1NsZ8pgY0DBWjO3DAoYyXaNrz4IRlgOMiO/ylmQ8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJ6jy/Cs87GGh/X8LImttaagJEOFjdlO9Tq3Vh3shEGXB/NHQ2+dsuVmndNUsNYAi
         fpg3fE/23MFIhRCwPVzlWz8ZmDmEC4t/EVPjGnld8piu3ba0NHuUun5NMDSJ+TEDJy
         UTIF/aQsKDC5WNlXv0evSYOCEzKa4FQvL6rxfyQs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 069/262] tools/bpf: selftests: add map lookup to test_map_in_map bpf prog
Date:   Wed, 27 Mar 2019 13:58:44 -0400
Message-Id: <20190327180158.10245-69-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 9eca5083757b679b37f210092c871916c2c222d0 ]

The bpf_map_lookup_elem is added in the bpf program.
Without previous patch, the test change will trigger the
following error:
  $ ./test_maps
  ...
  ; value_p = bpf_map_lookup_elem(map, &key);
  20: (bf) r1 = r7
  21: (bf) r2 = r8
  22: (85) call bpf_map_lookup_elem#1
  ; if (!value_p || *value_p != 123)
  23: (15) if r0 == 0x0 goto pc+16
   R0=map_value(id=2,off=0,ks=4,vs=4,imm=0) R6=inv1 R7=map_ptr(id=0,off=0,ks=4,vs=4,imm=0)
   R8=fp-8,call_-1 R10=fp0,call_-1 fp-8=mmmmmmmm
  ; if (!value_p || *value_p != 123)
  24: (61) r1 = *(u32 *)(r0 +0)
   R0=map_value(id=2,off=0,ks=4,vs=4,imm=0) R6=inv1 R7=map_ptr(id=0,off=0,ks=4,vs=4,imm=0)
   R8=fp-8,call_-1 R10=fp0,call_-1 fp-8=mmmmmmmm
  bpf_spin_lock cannot be accessed directly by load/store

With the kernel fix in the previous commit, the error goes away.

Signed-off-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_map_in_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_map_in_map.c b/tools/testing/selftests/bpf/test_map_in_map.c
index ce923e67e08e..2985f262846e 100644
--- a/tools/testing/selftests/bpf/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/test_map_in_map.c
@@ -27,6 +27,7 @@ SEC("xdp_mimtest")
 int xdp_mimtest0(struct xdp_md *ctx)
 {
 	int value = 123;
+	int *value_p;
 	int key = 0;
 	void *map;
 
@@ -35,6 +36,9 @@ int xdp_mimtest0(struct xdp_md *ctx)
 		return XDP_DROP;
 
 	bpf_map_update_elem(map, &key, &value, 0);
+	value_p = bpf_map_lookup_elem(map, &key);
+	if (!value_p || *value_p != 123)
+		return XDP_DROP;
 
 	map = bpf_map_lookup_elem(&mim_hash, &key);
 	if (!map)
-- 
2.19.1

