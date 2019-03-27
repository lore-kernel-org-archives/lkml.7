Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9CEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F67206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713197;
	bh=H1Q3UTz9+NVrsikrO78D3/zIdMEBARu4F+GwfKWfWXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P/xzz///KLeed52UIahNStYbxTRynqnpr9H6NdnQP4b6SEUWXInAXsTuIUyrnAb3J
	 N7W/GeUgG0VO9EDRCN6AP8zLA9feTTTlQPHc60Q2b6a5+FD2b7KrbcfG0APneHzf3o
	 rkbooYQwk07ZjvOMMsXlt9zXiwhKsgs3plHYSGJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbfC0S74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389730AbfC0SPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E495A2177E;
        Wed, 27 Mar 2019 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710499;
        bh=H1Q3UTz9+NVrsikrO78D3/zIdMEBARu4F+GwfKWfWXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSPXw22k5yjZ2jnK1MwH6tOl6kUTShH8ewpsvJrHX1l+qx3i3FXHK4EvCR7es7pGf
         /Y5mRkSJvFKwQq0msBbSyBpfTCqHGIVmLfJumqJB+iNEALC8UERI+tEgRZFEF9M5i1
         Zu/AVzLwB1fpWHnf9xOrjkXV6jjr2ypRLbN3xSg4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 146/192] bpf: fix missing prototype warnings
Date:   Wed, 27 Mar 2019 14:09:38 -0400
Message-Id: <20190327181025.13507-146-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
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
index 1a39d57eb88f..037610845892 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -844,7 +844,9 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns);
 void bpf_jit_binary_free(struct bpf_binary_header *hdr);
-
+u64 bpf_jit_alloc_exec_limit(void);
+void *bpf_jit_alloc_exec(unsigned long size);
+void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *fp);
-- 
2.19.1

