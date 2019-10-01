Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D0ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054102086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569949445;
	bh=Kk6XxuN59+qbkbLJtVxcjtqKExqw2JI0CVGdOUTiFQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2X9GKalSuxc+g/Mp+fSfRN+Oxqx774w+accIBXiAlRScJKtpf+6Wc6xepZR517zvE
	 7tmRUIRTg3v2bVM2pb5iksVxJmpTDuQjmjQhminBWmZahWOfx8Oj+0mhREPQsQvY/0
	 FnlBwtevNrh9vblz1bNCClmm5xY3Hq4EVidiBOiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfJAREE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbfJAQjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:39:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3379E2168B;
        Tue,  1 Oct 2019 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569947976;
        bh=Kk6XxuN59+qbkbLJtVxcjtqKExqw2JI0CVGdOUTiFQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHC3a5aaFE0DoHdowBpbtVras53K1YvO0V1EhB5FHMn6uBnlrLl6KSpjXgFlgNBsG
         SHTIV89AjHY5y8k0SYCnyIaSRUqUcxmkQT+5tP7VbBWgivCsDhGLcrDgJHpgoVZyDZ
         pUfxDK/TfUGHn6ZtVhrhImE8G70T9KhSCiJzQVD0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bharath Vedartham <linux.bhar@gmail.com>,
        syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.3 09/71] 9p/cache.c: Fix memory leak in v9fs_cache_session_get_cookie
Date:   Tue,  1 Oct 2019 12:38:19 -0400
Message-Id: <20191001163922.14735-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharath Vedartham <linux.bhar@gmail.com>

[ Upstream commit 962a991c5de18452d6c429d99f3039387cf5cbb0 ]

v9fs_cache_session_get_cookie assigns a random cachetag to v9ses->cachetag,
if the cachetag is not assigned previously.

v9fs_random_cachetag allocates memory to v9ses->cachetag with kmalloc and uses
scnprintf to fill it up with a cachetag.

But if scnprintf fails, v9ses->cachetag is not freed in the current
code causing a memory leak.

Fix this by freeing v9ses->cachetag it v9fs_random_cachetag fails.

This was reported by syzbot, the link to the report is below:
https://syzkaller.appspot.com/bug?id=f012bdf297a7a4c860c38a88b44fbee43fd9bbf3

Link: http://lkml.kernel.org/r/20190522194519.GA5313@bharath12345-Inspiron-5559
Reported-by: syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index 995e332eee5c0..eb2151fb60494 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -51,6 +51,8 @@ void v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses)
 	if (!v9ses->cachetag) {
 		if (v9fs_random_cachetag(v9ses) < 0) {
 			v9ses->fscache = NULL;
+			kfree(v9ses->cachetag);
+			v9ses->cachetag = NULL;
 			return;
 		}
 	}
-- 
2.20.1

