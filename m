Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F3721738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710116;
	bh=GK8+cVgwfM3w9VNxvgVmifwkxrWnTW3JgOjveMew0iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5nqwazWrgmlewzWPwwZUXor0tejleZ6Sn6l6gwkD9CBMF6ZJZFyMNeEBZfI1JVUH
	 Cle4DxL+4dGf+qpcXmawQPtVbv0rsppSEvzWrHd9bYvoux5PrMjTtyua0i7bEUA5ls
	 ECdRoDcEclCSD0KN9iklAP1XhLlZq87reEJByPAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbfC0SIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfC0SIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F32F521734;
        Wed, 27 Mar 2019 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710110;
        bh=GK8+cVgwfM3w9VNxvgVmifwkxrWnTW3JgOjveMew0iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmH2oSrMBgrvHc4h5VPSblci8spBic/DrFUL3T/+3Rqsjy2RxxcICOlfte1uXfHf3
         Qa9q2cGSxGQXjW2SAKWSi43rnnlNXM+HY3JL8y2Z1DY2mZsKcEkGrLFMP5n2nML9GB
         80OIQ5+h4ZRjKOPLkkGY+/tKSdX5Nb/qczNLEFP0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 200/262] bpf: fix missing prototype warnings
Date:   Wed, 27 Mar 2019 14:00:55 -0400
Message-Id: <20190327180158.10245-200-sashal@kernel.org>
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

From: Valdis Kletnieks <valdis.kletnieks@vt.edu>

[ Upstream commit 116bfa96a255123ed209da6544f74a4f2eaca5da ]

Compiling with W=1 generates warnings:

  CC      kernel/bpf/core.o
kernel/bpf/core.c:721:12: warning: no previous prototype for ?bpf_jit_alloc_exec_limit? [-Wmissing-prototypes]
  721 | u64 __weak bpf_jit_alloc_exec_limit(void)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
kernel/bpf/core.c:757:14: warning: no previous prototype for ?bpf_jit_alloc_exec? [-Wmissing-prototypes]
  757 | void *__weak bpf_jit_alloc_exec(unsigned long size)
      |              ^~~~~~~~~~~~~~~~~~
kernel/bpf/core.c:762:13: warning: no previous prototype for ?bpf_jit_free_exec? [-Wmissing-prototypes]
  762 | void __weak bpf_jit_free_exec(void *addr)
      |             ^~~~~~~~~~~~~~~~~

All three are weak functions that archs can override, provide
proper prototypes for when a new arch provides their own.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index e532fcc6e4b5..3358646a8e7a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -874,7 +874,9 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns);
 void bpf_jit_binary_free(struct bpf_binary_header *hdr);
-
+u64 bpf_jit_alloc_exec_limit(void);
+void *bpf_jit_alloc_exec(unsigned long size);
+void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 
 int bpf_jit_get_func_addr(const struct bpf_prog *prog,
-- 
2.19.1

