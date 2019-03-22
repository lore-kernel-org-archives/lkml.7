Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FD1218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254721;
	bh=U/eXxMtCikT9/HJbCoYnbEtAU5anNatq9Zts6aV60eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h1a45Rb9Kip4+z+QT3+J3iI93KZ9VZY5vEbMkWpLbgrAvMwIRCUZ2atZDTRb/qE14
	 MODvJLee2DJZ3JTBgEU6FuRVLvpsNCNOhISgVfLoOh/5XwqjK2AecJsz1VUbfM4/+S
	 gA3qZeD/D6rot4+YCfVfQWgzedKyDGXASvnTJl4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfCVLik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbfCVLij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E6F2082C;
        Fri, 22 Mar 2019 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254718;
        bh=U/eXxMtCikT9/HJbCoYnbEtAU5anNatq9Zts6aV60eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sO766XqC5D6AtIM7bJtlRoHyYi7iVJ6YfRFNTVAway8GNNhkkivA+UiPVk1WbhK7J
         X0c8Eff2P9s5+ICoDP92bjdYrOefGMhfP6nOnd68v7NUBW1dXH4amOQ8BHnJZrVWyk
         noE078hjZkuPUKYRP58xAPX1QBRGJy0Ye5T935hY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.4 221/230] NFS: Dont recoalesce on error in nfs_pageio_complete_mirror()
Date:   Fri, 22 Mar 2019 12:15:59 +0100
Message-Id: <20190322111252.421797067@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 8127d82705998568b52ac724e28e00941538083d upstream.

If the I/O completion failed with a fatal error, then we should just
exit nfs_pageio_complete_mirror() rather than try to recoalesce.

Fixes: a7d42ddb3099 ("nfs: add mirroring support to pgio layer")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pagelist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1202,7 +1202,7 @@ static void nfs_pageio_complete_mirror(s
 		desc->pg_mirror_idx = mirror_idx;
 	for (;;) {
 		nfs_pageio_doio(desc);
-		if (!mirror->pg_recoalesce)
+		if (desc->pg_error < 0 || !mirror->pg_recoalesce)
 			break;
 		if (!nfs_do_recoalesce(desc))
 			break;


