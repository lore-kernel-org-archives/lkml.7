Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94837C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634EE2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697224;
	bh=q5BxtsgnxxA6emR9f+27ejh2u61bFo5fC+LFUQ3QRZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0592cjK+lWWsMafolAJgnUDJgHmocJGMgCfwtkCch/Fz1ed5zaWJK25POGF03b05L
	 t5PABxPt6Flexgu15SMUYrMJYS+TF4C4y7QY+hm1Fn0gYNtCwYBje6Cv9bQNM8xGi6
	 fU5Hup0BC5KTRo08h510YDQrz/EDyX0aieKvmWcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbfJJIrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389405AbfJJIq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:46:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293B721BE5;
        Thu, 10 Oct 2019 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697217;
        bh=q5BxtsgnxxA6emR9f+27ejh2u61bFo5fC+LFUQ3QRZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spiqjNozBZIZ7ICqUaBOI/iqduODoiukn49rtdcVPRkVxfp8u7TkNRSt2Fdf5lOq/
         UNXy7R6PSmNSZx2v5XwcCSS93WpIP5Mnb1yBiKB544yIwGLFsACkSGQVJ+E1PQ88b8
         limt1XwCBereCcGyR6lxtcgYIupckGrszv8EIuYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 061/114] pNFS: Ensure we do clear the return-on-close layout stateid on fatal errors
Date:   Thu, 10 Oct 2019 10:36:08 +0200
Message-Id: <20191010083609.492793822@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

[ Upstream commit 9c47b18cf722184f32148784189fca945a7d0561 ]

IF the server rejected our layout return with a state error such as
NFS4ERR_BAD_STATEID, or even a stale inode error, then we do want
to clear out all the remaining layout segments and mark that stateid
as invalid.

Fixes: 1c5bd76d17cca ("pNFS: Enable layoutreturn operation for...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pnfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4931c3a75f038..c818f9886f618 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1426,10 +1426,15 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 	const nfs4_stateid *res_stateid = NULL;
 	struct nfs4_xdr_opaque_data *ld_private = args->ld_private;
 
-	if (ret == 0) {
-		arg_stateid = &args->stateid;
+	switch (ret) {
+	case -NFS4ERR_NOMATCHING_LAYOUT:
+		break;
+	case 0:
 		if (res->lrs_present)
 			res_stateid = &res->stateid;
+		/* Fallthrough */
+	default:
+		arg_stateid = &args->stateid;
 	}
 	pnfs_layoutreturn_free_lsegs(lo, arg_stateid, &args->range,
 			res_stateid);
-- 
2.20.1



