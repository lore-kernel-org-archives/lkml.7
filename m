Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF9C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA799206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519797;
	bh=c+qMZz+4LQ98rQvO6c0U67L6JaEmdi0MzflveXY0soQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BJ63sBAV5/s1S73pbxPVBPLt552uYE5vrzYPHX9o+O/pCq4g0sA1mACvjL+onVvR0
	 QpSW/kSXOKdAM5INMloWbimgEohAzbRyn8dXv3CM/xpYk8n8FyW9WprHncpYP8i1lp
	 DULzqg37HlEwWyaAh+t4IpdgVfdX7i4UugdUWp/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfLPSJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:09:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730521AbfLPSJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:09:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5445620700;
        Mon, 16 Dec 2019 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519793;
        bh=c+qMZz+4LQ98rQvO6c0U67L6JaEmdi0MzflveXY0soQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0kXqxsSg1bZvvMwclLEUhMZp97qS71KOHfyNZZ9rINQLKe2615ZieSNEugs8cJpVh
         BiG8v4fvDjJ3K7Ia96uGndESHD4CLrWmg5CLJgFGJ5pq2X3PiYKCF6/P8GT68t+YnZ
         3kVorxzefrs6RtWtUS2nc2J9FZKtCHFV4Nd/xX+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.3 069/180] ovl: relax WARN_ON() on rename to self
Date:   Mon, 16 Dec 2019 18:48:29 +0100
Message-Id: <20191216174830.135531745@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

commit 6889ee5a53b8d969aa542047f5ac8acdc0e79a91 upstream.

In ovl_rename(), if new upper is hardlinked to old upper underneath
overlayfs before upper dirs are locked, user will get an ESTALE error
and a WARN_ON will be printed.

Changes to underlying layers while overlayfs is mounted may result in
unexpected behavior, but it shouldn't crash the kernel and it shouldn't
trigger WARN_ON() either, so relax this WARN_ON().

Reported-by: syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com
Fixes: 804032fabb3b ("ovl: don't check rename to self")
Cc: <stable@vger.kernel.org> # v4.9+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1170,7 +1170,7 @@ static int ovl_rename(struct inode *oldd
 	if (newdentry == trap)
 		goto out_dput;
 
-	if (WARN_ON(olddentry->d_inode == newdentry->d_inode))
+	if (olddentry->d_inode == newdentry->d_inode)
 		goto out_dput;
 
 	err = 0;


