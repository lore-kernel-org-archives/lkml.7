Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB25C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC96217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369397;
	bh=g98lJnzl7z1yu/6IaGP4+0vDTvDFHiO1c/NhU0TVhAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VTNtmVOUESbkODNQW2I686V8tyXij/DlXXzVqj0VwNdp6PbuaiA3N0a7hGPhJkOWi
	 KVqR1ZD1vFc71RH4hcSmjHy73auKxOZYUU/c3H3EMhAKF0OOXyOXvD5V8WGTzwdmWV
	 cGKt+66aUTH+u9r+scmy6J5A2THXUD4jcudW4js8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfDDJQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388040AbfDDJQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 856172054F;
        Thu,  4 Apr 2019 09:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369385;
        bh=g98lJnzl7z1yu/6IaGP4+0vDTvDFHiO1c/NhU0TVhAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igtblQhyE/SR2fTR/Rywp9JQCdxbBrFwOu2N7X4IFXAo0JZ7aQm49zb55NUIFAkUv
         sVhPkOYk8UzoGbOjxAPdTKdyxsaPNE/EfEnIGqhVOLAJqcShoH4hjxxqtu/tNYTZHR
         TBeUgLQ9DX19AXlhuZ+rmtJD7IZ4weXmnjrqXZzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 188/246] bpf: fix missing prototype warnings
Date:   Thu,  4 Apr 2019 10:48:08 +0200
Message-Id: <20190404084625.767186914@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



