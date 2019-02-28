Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BC4218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366856;
	bh=R4Ibw4xwOaOwUXtb89iDuGlYMo8gQCFV4j1HHjQffYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tX1PF5E+nCcLR1pU5SWBlkUcgF0R+faG1VW6bZXDZWytIYFfoMUNMInif6qHvwxus
	 SpEXb8mi2DEejfFgmPGjHo7sPh2st2tkOrHQ2H0a7Z+NpQ0eT5APnBuo47ZJp+xxf4
	 Kgm8pOZ7kJUPq6pUZmgUVsqysAsgcEqMvLAPPzF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbfB1POP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbfB1POJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:14:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AED220C01;
        Thu, 28 Feb 2019 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366848;
        bh=R4Ibw4xwOaOwUXtb89iDuGlYMo8gQCFV4j1HHjQffYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NhfVoGMzxzk7m4137IdcQnthBnQf1xT3yy0tyBn7LpTwio1lkM72FVxPbv5omqT2N
         Nf7nNLKIpj5gca7jInk7hE7b83cW17yJ7Ar9IdrH7IUWA7L1EbPxyLBrEJYSOvYGiH
         M5jmtNT0cOJhl1QafA8JkeUmyOBnvd7xkEAK9cCQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 16/36] relay: check return of create_buf_file() properly
Date:   Thu, 28 Feb 2019 10:13:17 -0500
Message-Id: <20190228151337.12176-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 2c1cf00eeacb784781cf1c9896b8af001246d339 ]

If create_buf_file() returns an error, don't try to reference it later
as a valid dentry pointer.

This problem was exposed when debugfs started to return errors instead
of just NULL for some calls when they do not succeed properly.

Also, the check for WARN_ON(dentry) was just wrong :)

Reported-by: Kees Cook <keescook@chromium.org>
Reported-and-tested-by: syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/relay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 1537158c67b38..61d37e6da22dd 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -427,6 +427,8 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 	dentry = chan->cb->create_buf_file(tmpname, chan->parent,
 					   S_IRUSR, buf,
 					   &chan->is_global);
+	if (IS_ERR(dentry))
+		dentry = NULL;
 
 	kfree(tmpname);
 
@@ -460,7 +462,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 		dentry = chan->cb->create_buf_file(NULL, NULL,
 						   S_IRUSR, buf,
 						   &chan->is_global);
-		if (WARN_ON(dentry))
+		if (IS_ERR_OR_NULL(dentry))
 			goto free_buf;
 	}
 
-- 
2.19.1

