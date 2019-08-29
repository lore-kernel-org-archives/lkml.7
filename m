Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E244CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02E1205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103624;
	bh=j1DhezeBNuS/QPGHTZtbVwNwMe4iNqsCArHRdJU0aEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BrGLU37Ut59mLod64oaih9r6i/wgcqKZCC2U8M999qyWFhQRr/HORqQhAILbTDnee
	 qZvaZK9gwPrMIiwz8wkWHYXg1yOjvR/GZCE5nS8JtWjX7Q+z9pIyZQa5JlDLSqG/NI
	 dFPvD1/PzdjmIszR+JJHzpNlBgMwdS3V6JNr+hC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfH2Sdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbfH2SNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:13:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F050C23407;
        Thu, 29 Aug 2019 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102421;
        bh=j1DhezeBNuS/QPGHTZtbVwNwMe4iNqsCArHRdJU0aEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vmqo0Qzw9+3q5uJMHeiqQ/XgpBgfoZCgSrpFWb/x1hX+UNj4pY399PNml1xH3HOUE
         8iwbu3fWEcpAwq2jWvIJO9pWdwe420WYtHmAbry+34iZizhBYOrGranAREoFGyCEj+
         5S8I/3baJ8jppJLQkH1wfAZRhFCMR2plt2+IeKBU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 14/76] tools: bpftool: fix error message (prog -> object)
Date:   Thu, 29 Aug 2019 14:12:09 -0400
Message-Id: <20190829181311.7562-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit b3e78adcbf991a4e8b2ebb23c9889e968ec76c5f ]

Change an error message to work for any object being
pinned not just programs.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index f7261fad45c19..647d8a4044fbd 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -236,7 +236,7 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
 
 	fd = get_fd_by_id(id);
 	if (fd < 0) {
-		p_err("can't get prog by id (%u): %s", id, strerror(errno));
+		p_err("can't open object by id (%u): %s", id, strerror(errno));
 		return -1;
 	}
 
-- 
2.20.1

