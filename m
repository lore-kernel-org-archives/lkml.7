Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7FCC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240DC21537
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200503;
	bh=tOpREwC9ptswgJC0xfpd7gAJ0c2qFXk1QPaIcgZfPME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SsoDSvCR/knfi4V8Q9H+RBvjj2XCws6C9oo6+zpltpzdNW8IzWeEW4/sK+2tsVneN
	 AP66m0MsHp53Es9RpbkMLjgEeXelGrq+CiEC/tTZOpqmaGbVs/xtVwxLkUVPA0tLN2
	 l2VbrUDY7AhTiyTpMRiPQk74fDVCcyv84hAzqE70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbfGOOVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390342AbfGOOVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:21:37 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 550E9217F4;
        Mon, 15 Jul 2019 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200497;
        bh=tOpREwC9ptswgJC0xfpd7gAJ0c2qFXk1QPaIcgZfPME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efPimlsdyQpU1K1xRjqytuRC8/acwVtNrhpSyBnJIjtF3Oymo3pveE37dXXT5HNHb
         eS5LpbchMmqMvseU+bQgZNJOt9YUgQsQ2fK+2E2coxpQJXPA07pxmEAyKNY7u+cYvA
         +FdFGvBaasuhTfK7xW8BdQSJt2+QMLZUZ/vTzJo4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 062/158] bpf: silence warning messages in core
Date:   Mon, 15 Jul 2019 10:16:33 -0400
Message-Id: <20190715141809.8445-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis Klētnieks <valdis.kletnieks@vt.edu>

[ Upstream commit aee450cbe482a8c2f6fa5b05b178ef8b8ff107ca ]

Compiling kernel/bpf/core.c with W=1 causes a flood of warnings:

kernel/bpf/core.c:1198:65: warning: initialized field overwritten [-Woverride-init]
 1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
      |                                                                 ^~~~
kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
 1087 |  INSN_3(ALU, ADD,  X),   \
      |  ^~~~~~
kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
 1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
      |   ^~~~~~~~~~~~
kernel/bpf/core.c:1198:65: note: (near initialization for 'public_insntable[12]')
 1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
      |                                                                 ^~~~
kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
 1087 |  INSN_3(ALU, ADD,  X),   \
      |  ^~~~~~
kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
 1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
      |   ^~~~~~~~~~~~

98 copies of the above.

The attached patch silences the warnings, because we *know* we're overwriting
the default initializer. That leaves bpf/core.c with only 6 other warnings,
which become more visible in comparison.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0488b8258321..ffc39a7e028d 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y := core.o
+CFLAGS_core.o += $(call cc-disable-warning, override-init)
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
-- 
2.20.1

