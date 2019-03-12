Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8857C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95F2205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413733;
	bh=qI5WBH9y5QDOP1ttNISPMn1Xn8eegTsYr9tfQmNLf+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d0iqtezKOo987odHZvSZMFj/ITx6XekyosfeaFxLt5VB+v2KhKPUBYg8PHE/2Xjkd
	 Z6Afi9xBeWsmUXmTSlpqTnn6P61eD4KEv+sAiqA5pb29BJ5CTey42XyDssjjGD4mA+
	 Kbagrd+I68jiCzorm+/WEsr6lRLpbta+npTOg0e8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCLSCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfCLRNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:07 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AD6217D4;
        Tue, 12 Mar 2019 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410786;
        bh=qI5WBH9y5QDOP1ttNISPMn1Xn8eegTsYr9tfQmNLf+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvjRzaQc//18DVsvQO4Gyfb1o3ZgXTUXHHr/dx8s+AZYz6+Bm19nOq4/AMcrU+FAc
         yaYDgA2KkMdsmftqbVUGiAKePR2y6Jb+Du3NW3Jrr522S9Ee0se4pbokJf5JNb12vu
         7zI2CTK8Xh1IYLGFw4+VJ2lziRDxhYYoC/Tj8O6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com
Subject: [PATCH 4.20 108/171] relay: check return of create_buf_file() properly
Date:   Tue, 12 Mar 2019 10:08:08 -0700
Message-Id: <20190312170357.296627486@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



