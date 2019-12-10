Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2369C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7929A206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012889;
	bh=xsdow0IJ77bvirW4eYEduP638RtJRXOzATouebVsj6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nA5j3K3BKQTI/qZUxaTvM3O2Muu/0bFh0ROHFVlcXRDnGPrHkjyNhcsRGat3T23qo
	 I6sxJdz8OtoQzzX7IAiijWWebpJtX+DjpISxkakTvtf/NmtxNQHBe1QPBZMGTEqUsr
	 0rlasD4QVAZQmhLgviZMOBBBUNSb1C5QLHbhSAgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfLJVV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbfLJVLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:11:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A85F246B8;
        Tue, 10 Dec 2019 21:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012306;
        bh=xsdow0IJ77bvirW4eYEduP638RtJRXOzATouebVsj6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNUtXVrwa1LHxxt/ekDYJ9e5o2bmNZC3mTxWDawAzPx8w3kuN+mDOes45HxHL33jh
         WsdSX0bx+vB1gV2SKW5UTDFhH5dN/oorm6iz6D2/KlhwSyd3hXDET4qQ03O9oWxXED
         +62oMOQutYqcpYw4z3HkEZ+aYlJDwNc/EgJhoVy8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 242/350] libbpf: Fix negative FD close() in xsk_setup_xdp_prog()
Date:   Tue, 10 Dec 2019 16:05:47 -0500
Message-Id: <20191210210735.9077-203-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit 9656b346b280c3e49c8a116c3a715f966633b161 ]

Fix issue reported by static analysis (Coverity). If bpf_prog_get_fd_by_id()
fails, xsk_lookup_bpf_maps() will fail as well and clean-up code will attempt
close() with fd=-1. Fix by checking bpf_prog_get_fd_by_id() return result and
exiting early.

Fixes: 10a13bb40e54 ("libbpf: remove qidconf and better support external bpf programs.")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20191107054059.313884-1-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 9d53480862030..a73b79d293337 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -466,6 +466,8 @@ static int xsk_setup_xdp_prog(struct xsk_socket *xsk)
 		}
 	} else {
 		xsk->prog_fd = bpf_prog_get_fd_by_id(prog_id);
+		if (xsk->prog_fd < 0)
+			return -errno;
 		err = xsk_lookup_bpf_maps(xsk);
 		if (err) {
 			close(xsk->prog_fd);
-- 
2.20.1

