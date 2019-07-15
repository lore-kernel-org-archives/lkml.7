Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA178C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF26B20868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200161;
	bh=Or5fkyrHCu6o0bcEQBO1LjvdT2tSsXdqbmk9EnRmhg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2WdwNAKW9m3TKMDnN/M6AM+Jd5wMOnvLeK+5uH2hgedAjO78HmvrYltW7tbdflEwv
	 NFVjLGHU8yPROvjEurjgl5aH0pwuv0g18tU7LOJu3ixCcoGzmK07CqnDuPiSvJIiQe
	 ncJM77OK2OHI2NnCVf4TwjiHqOHHRNUvFbxU+yK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389653AbfGOOQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389638AbfGOOP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:15:57 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99F642083D;
        Mon, 15 Jul 2019 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200156;
        bh=Or5fkyrHCu6o0bcEQBO1LjvdT2tSsXdqbmk9EnRmhg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chxTZAmRjqXCfCB9ibC3jKSVro6nUfBuF6ePdSb+QWcjpidq1+Kh14ImgrMgGYnn2
         EFn/hUZ5Kk2gnXDVL6icILsAeZDDz3wpqc9MDeF5Lls3HfhUZbbfTkZEMrVooJUSbr
         bmLCkzec+l0BMM/1+g7VPzEb0n3OcSUDybH5k8gU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 197/219] bpf, libbpf, smatch: Fix potential NULL pointer dereference
Date:   Mon, 15 Jul 2019 10:03:18 -0400
Message-Id: <20190715140341.6443-197-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

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
index 11c25d9ea431..43dc8a8e9105 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2897,10 +2897,7 @@ int bpf_prog_load(const char *file, enum bpf_prog_type type,
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
@@ -2913,6 +2910,9 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
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

