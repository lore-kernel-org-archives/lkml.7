Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F610C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C39218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366566;
	bh=Y7heQ6sGPC7qDyM2CpigzX2e8ntRSCTu7au0f8DSAyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ymTKdvN85sld5TB3MuwBJZhgCtWv1DwkpNKSYPeSmxp9RGzn93Ixr6XyHUx1NIx4r
	 kZVR76mK8UtrG4r+w7YMq0bjPPB2Kn+XdDLYhMO70tlJC/6Ez2/yH3QvAC5xJvs/lE
	 HZmc2gjCKuFRSvv97h6Iw9WYRccaWsnodZV2QoTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfB1PJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387518AbfB1PJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9089218AE;
        Thu, 28 Feb 2019 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366561;
        bh=Y7heQ6sGPC7qDyM2CpigzX2e8ntRSCTu7au0f8DSAyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5RFENKP8y6O4Rka9xoJY9f+fVuCKE3LU0UvwgG2dwkXjd1LYynL4nt/DlCQbJFsO
         mAWnvbqVLPbENI5x5elsZGLyBMkQYazc6gQK5/1onXKximFGZu6SWhOQZD++O69FYK
         T+mK9FLVte4w9Y9gl8GkanSQK0ikYDc5kNejI0KY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 42/81] relay: check return of create_buf_file() properly
Date:   Thu, 28 Feb 2019 10:07:34 -0500
Message-Id: <20190228150813.10256-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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
index 04f248644e065..9e0f52375487d 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -428,6 +428,8 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 	dentry = chan->cb->create_buf_file(tmpname, chan->parent,
 					   S_IRUSR, buf,
 					   &chan->is_global);
+	if (IS_ERR(dentry))
+		dentry = NULL;
 
 	kfree(tmpname);
 
@@ -461,7 +463,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 		dentry = chan->cb->create_buf_file(NULL, NULL,
 						   S_IRUSR, buf,
 						   &chan->is_global);
-		if (WARN_ON(dentry))
+		if (IS_ERR_OR_NULL(dentry))
 			goto free_buf;
 	}
 
-- 
2.19.1

