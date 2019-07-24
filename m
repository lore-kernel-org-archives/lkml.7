Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50472C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238FB2238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996798;
	bh=F+8EmJejqOpRpK8Viro3WnVsxOnaTLw0Ge4pF4WAdvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sUMQbqxtIiBKZjfR6yYkPNWcyRViN5oZK1rGZdrEQOBEawPArd0WU2kPlHaFvrjPr
	 VsJBDSr2gYanDEQoMdU+Zgi2yyYNLzkExHlO4weOQgheNzxJrUSIoHECdqJZOMdSbi
	 MMSBrxkBUKFsA6ToPhydKAJTcp+fBy+WpG3NnazY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbfGXTdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388808AbfGXTdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:33:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A9722ADB;
        Wed, 24 Jul 2019 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996793;
        bh=F+8EmJejqOpRpK8Viro3WnVsxOnaTLw0Ge4pF4WAdvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4C+QgG5FUGcPqGIfpEECTZWOYOkpKs9Tvw8A3gEglmBkFw3RILsfCPxbJSSNtGys
         U2SNG0zubReAmDWoK4H6ZZjyCFV22H/ypZSuz5TvPdP+s42MboCllbgzXPagghr1HX
         00oOSkRZWdd23YaPsT6WfDY+CIuiCyH6dUibgHKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 219/413] bpf, libbpf, smatch: Fix potential NULL pointer dereference
Date:   Wed, 24 Jul 2019 21:18:30 +0200
Message-Id: <20190724191750.367082697@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 33bae185f74d49a0d7b1bfaafb8e959efce0f243 ]

Based on the following report from Smatch, fix the potential NULL
pointer dereference check:

  tools/lib/bpf/libbpf.c:3493
  bpf_prog_load_xattr() warn: variable dereferenced before check 'attr'
  (see line 3483)

  3479 int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
  3480                         struct bpf_object **pobj, int *prog_fd)
  3481 {
  3482         struct bpf_object_open_attr open_attr = {
  3483                 .file           = attr->file,
  3484                 .prog_type      = attr->prog_type,
                                         ^^^^^^
  3485         };

At the head of function, it directly access 'attr' without checking
if it's NULL pointer. This patch moves the values assignment after
validating 'attr' and 'attr->file'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 151f7ac1882e..3865a5d27251 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3487,10 +3487,7 @@ int bpf_prog_load(const char *file, enum bpf_prog_type type,
 int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 			struct bpf_object **pobj, int *prog_fd)
 {
-	struct bpf_object_open_attr open_attr = {
-		.file		= attr->file,
-		.prog_type	= attr->prog_type,
-	};
+	struct bpf_object_open_attr open_attr = {};
 	struct bpf_program *prog, *first_prog = NULL;
 	enum bpf_attach_type expected_attach_type;
 	enum bpf_prog_type prog_type;
@@ -3503,6 +3500,9 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 	if (!attr->file)
 		return -EINVAL;
 
+	open_attr.file = attr->file;
+	open_attr.prog_type = attr->prog_type;
+
 	obj = bpf_object__open_xattr(&open_attr);
 	if (IS_ERR_OR_NULL(obj))
 		return -ENOENT;
-- 
2.20.1



