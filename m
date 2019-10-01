Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3816ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E6B20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948170;
	bh=ri0y+tcaOShXS+LvXq26MlFByM5jdC+qr44td80hKS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HCJ8uKndXtZEIwjZIQoYM0sjhu3cWXgp9WHesXNT1wB59ipTpX6o7G6sMzX321Qkx
	 BePz4uqxhvif7wtuBRjHANWT5vbnhkhg4+BWdVuft/kU0Tvwyd3QVOBhxKqy7ebWg7
	 Rj0ivd5M9QfQtYLlhO3nNieBrjI0h9tLEpXhNVhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbfJAQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbfJAQmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:42:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F27222C2;
        Tue,  1 Oct 2019 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948158;
        bh=ri0y+tcaOShXS+LvXq26MlFByM5jdC+qr44td80hKS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVbs8aD4A/S096lFMtGeJ9GSAqSKc5KFaWxldQ7IxjH6grMeuQZAhUVzW8t9FPezk
         ETfQurHu736i236YdstWJsYQlptkXhuq7HVvoYoLR5nQwPiMANvl0z0Czir4QsTJRD
         FRSRfONrkWAaMLP5AVt9oICARp7pf0gP4qvSdPg8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, kexec@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 47/63] kexec: bail out upon SIGKILL when allocating memory.
Date:   Tue,  1 Oct 2019 12:41:09 -0400
Message-Id: <20191001164125.15398-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 7c3a6aedcd6aae0a32a527e68669f7dd667492d1 ]

syzbot found that a thread can stall for minutes inside kexec_load() after
that thread was killed by SIGKILL [1].  It turned out that the reproducer
was trying to allocate 2408MB of memory using kimage_alloc_page() from
kimage_load_normal_segment().  Let's check for SIGKILL before doing memory
allocation.

[1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e

Link: http://lkml.kernel.org/r/993c9185-d324-2640-d061-bed2dd18b1f7@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d5870723b8ada..15d70a90b50dc 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -300,6 +300,8 @@ static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	struct page *pages;
 
+	if (fatal_signal_pending(current))
+		return NULL;
 	pages = alloc_pages(gfp_mask & ~__GFP_ZERO, order);
 	if (pages) {
 		unsigned int count, i;
-- 
2.20.1

