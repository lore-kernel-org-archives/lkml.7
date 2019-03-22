Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243C72082F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260744;
	bh=eGT4yrVlNJAg+5r4spQW/vtYpmx5V5HpYbNkGBvPYXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UkVoY+Nbw5+q6vQpgLBU4BqIwUOOQEEa1hbXyV4ZNn/fzKUDFCcUPlz/XspWZh0+Q
	 ac7xmM0HUH07bTJksQ5gfSSYaSwdghX+ZVijfQlaZa66v4/pn+4/qkA6lmh1Iy0wyE
	 KNYW79iJ+Nw/MdR6UxkXAADTFNLtXvxxbPXRbE80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfCVNTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbfCVLXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:23:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FCD72190A;
        Fri, 22 Mar 2019 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253781;
        bh=eGT4yrVlNJAg+5r4spQW/vtYpmx5V5HpYbNkGBvPYXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRe8Gq8N1ex6JYsKYnqw+66H6NHfUoreht/Rv/tsDbde9iA8YagDYbykkwoJGuJSc
         g0SIbu5QpaDd5NuqNyjg1HlzW2MMcjTIRuiPEZaEJyb6XiM9cYu73z1Tl1/Y4Avv7o
         Tnsol1t8FdfNLdafWVh6EDCLEBlAzji6pmTQXGeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 070/134] autofs: drop dentry reference only when it is never used
Date:   Fri, 22 Mar 2019 12:14:43 +0100
Message-Id: <20190322111215.144967332@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 63ce5f552beb9bdb41546b3a26c4374758b21815 ]

autofs_expire_run() calls dput(dentry) to drop the reference count of
dentry.  However, dentry is read via autofs_dentry_ino(dentry) after
that.  This may result in a use-free-bug.  The patch drops the reference
count of dentry only when it is never used.

Link: http://lkml.kernel.org/r/154725122396.11260.16053424107144453867.stgit@pluto-themaw-net
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs4/expire.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 513b8e5d151c..4cd4b20c69db 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -570,7 +570,6 @@ int autofs4_expire_run(struct super_block *sb,
 	pkt.len = dentry->d_name.len;
 	memcpy(pkt.name, dentry->d_name.name, pkt.len);
 	pkt.name[pkt.len] = '\0';
-	dput(dentry);
 
 	if ( copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)) )
 		ret = -EFAULT;
@@ -583,6 +582,8 @@ int autofs4_expire_run(struct super_block *sb,
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
 
+	dput(dentry);
+
 	return ret;
 }
 
-- 
2.19.1



