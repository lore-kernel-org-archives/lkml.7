Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D20C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0E6205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370602;
	bh=m1chJ3oGxsatMQf5Zt1rKaUxtrZX/6F+yXkExyWmBTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYkFcBFARLBqgBloMJGWfSJAlhxO1GgguUcoj7HGJbg9x6bxT4YWi1FdfgKQuhcf7
	 I7696nttqSZCy7+BgLmDlWvbOFFiSQVUnP8Izwo4AFFCkjArwAQ7UCtcZ1Lh7hVqCX
	 4arRmMaI70yacHPSFZc6WpFXUANcTfoj45oj4tq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfDDJgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbfDDJFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3674A2186A;
        Thu,  4 Apr 2019 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368736;
        bh=m1chJ3oGxsatMQf5Zt1rKaUxtrZX/6F+yXkExyWmBTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Caqs9e3YOT1h7E2GDgRQG0BlkFrqE6pSS8cu+FMewupanoTzYEkDqCfJ6UnQupNkV
         mlouFpciCgk5Boxi2mTeTQG78OyMnlgug9TAphcbhM78FfNE773q5qP2H9paMWXaUf
         7evlja0UMLvy/1Azx5Ll4EwdX8qkC5NO2Oc47rek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 143/187] bpf: fix missing prototype warnings
Date:   Thu,  4 Apr 2019 10:48:00 +0200
Message-Id: <20190404084609.903142625@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



