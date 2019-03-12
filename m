Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949FB2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410935;
	bh=/woZIn+hBoixAdLXaF6zHUH3PDdkEW6WLWZyDawngfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SeRD8vlbwpy2cg3w+UPgCqvBdNqqIeu41hdA8yTflI6k8fyEptvjHk7V+Wh6LKm8t
	 yh77Jymt/SkSae2myIJd3fqIeloKUhQK5f2hNUd44DVFUraYzDTcHrYz1ZAbhIV9QP
	 rXND2Bj/+cPt2R2pQ4kgYppDD+92118rugkLg+Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfCLRPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbfCLROp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:45 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7492186A;
        Tue, 12 Mar 2019 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410885;
        bh=/woZIn+hBoixAdLXaF6zHUH3PDdkEW6WLWZyDawngfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UN03aVVUTnfCpBpo5vhjTiu33XutxGGZEsEh1lyKOiDVm/8WquXo2HcJBydcvZ+83
         hd9CQLbXUzxN6XdlJK9E0b6cM1I3I6RW7gKxUS9IkdhVi/uhtJelQbjmomBJFL2kNp
         UOtjqBeFPGFciVBnhQ6AuFRdCiAeq/5zQqrkSE9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com
Subject: [PATCH 4.19 092/149] relay: check return of create_buf_file() properly
Date:   Tue, 12 Mar 2019 10:08:30 -0700
Message-Id: <20190312170357.398810898@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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
index 04f248644e06..9e0f52375487 100644
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



