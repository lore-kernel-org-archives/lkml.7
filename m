Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D485EC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF4D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aznYrOcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfF0KtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:49:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfF0KtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cnuZT4OO0ob1C2zJXF5M8LbSGOx6gZLow7UomC2W2hw=; b=aznYrOcXfLv8n88K8HVQm0PHZf
        KTzfML83o8uWNtPXGKgZEb76kHAZf3VCdi4Jtui/Hm29kWDACz9HM765EcOOu/m/IIxJctfX173cg
        3GWXFLj8VsjDSVb3qf5jx+VCttLVa+gvt1mNdyjt3DBzjnTDaTIFYBNiW72p3LiBFe9MV/TBSIVFC
        Hmb8ZVvYBgUiLhourQBNqRkw8b5WXEcrzM4ARhCFIZKHOzUFuTVnRpJcEU3st2NsPPP3Td36bgIFw
        J5lRoXHIZc6z+PMiSYPKe9hymXNc50Tzy+21Z/weqAVNOVRQxv8oG+opfoIrqXpgc28WBZbPr6wC/
        UTdz4cHA==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxe-00057X-6R; Thu, 27 Jun 2019 10:49:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] xfs: simplify xfs_ioend_can_merge
Date:   Thu, 27 Jun 2019 12:48:31 +0200
Message-Id: <20190627104836.25446-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627104836.25446-1-hch@lst.de>
References: <20190627104836.25446-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compare the block layer status directly instead of converting it to
an errno first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 4ef8343c3759..cd839f24c7ef 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -299,13 +299,9 @@ xfs_end_ioend(
 static bool
 xfs_ioend_can_merge(
 	struct xfs_ioend	*ioend,
-	int			ioend_error,
 	struct xfs_ioend	*next)
 {
-	int			next_error;
-
-	next_error = blk_status_to_errno(next->io_bio->bi_status);
-	if (ioend_error != next_error)
+	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
 		return false;
 	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
 		return false;
@@ -343,17 +339,11 @@ xfs_ioend_try_merge(
 	struct list_head	*more_ioends)
 {
 	struct xfs_ioend	*next_ioend;
-	int			ioend_error;
-
-	if (list_empty(more_ioends))
-		return;
-
-	ioend_error = blk_status_to_errno(ioend->io_bio->bi_status);
 
 	while (!list_empty(more_ioends)) {
 		next_ioend = list_first_entry(more_ioends, struct xfs_ioend,
 				io_list);
-		if (!xfs_ioend_can_merge(ioend, ioend_error, next_ioend))
+		if (!xfs_ioend_can_merge(ioend, next_ioend))
 			break;
 		list_move_tail(&next_ioend->io_list, &ioend->io_list);
 		ioend->io_size += next_ioend->io_size;
-- 
2.20.1

