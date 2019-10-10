Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DA7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E2621D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696940;
	bh=sYY95Hr5Vx7uYLpkaAUKFT7rsKYr+ZKBrBYfbzCeno0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JTXWs8GR72uk/B4JDTxhJnkNvoYGJK5HgVAPpsb5qYQjeCw0P8aQ6gLKwNyFlgtQ1
	 WT9IdYkNsq2GeLdkQHjMzAqxA19wQ/lxP/O4Fiuz9b4Dlz0HNWguJ4WMopkX5EuuQr
	 fO2c7Lfy0KAHgaAqtg6LWlCoKBQw8kqHZikuChgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbfJJImS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388511AbfJJImR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:42:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D71621BE5;
        Thu, 10 Oct 2019 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696936;
        bh=sYY95Hr5Vx7uYLpkaAUKFT7rsKYr+ZKBrBYfbzCeno0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFpj4IeO7dW0YE87fjvz349bwSlJOgFFtXL3eGZpHJWtvdyUhuycbgCaSlp+SEUNV
         m+h5zUhzORPEkkkHHM5/RAjgL502a8ZTsqrPq3bM8iMW1K6XTNjl/5skfs/E/FwIf2
         C8elT/R/HY7B/urcL44YUdQDE3sS3XfOOubhLP5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 107/148] pNFS: Ensure we do clear the return-on-close layout stateid on fatal errors
Date:   Thu, 10 Oct 2019 10:36:08 +0200
Message-Id: <20191010083617.658814199@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
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
index 4525d5acae386..0418b198edd3e 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1449,10 +1449,15 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
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



