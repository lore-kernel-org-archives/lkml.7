Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF81CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875E0216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KYIg3iFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfFXFxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:53:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfFXFxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sTbD0BMyp++GtKpbwxEzwjWlE79K//OSQy3quq05cq8=; b=KYIg3iFcmgdyuQCHmLfvTro9LX
        RrIzZ4DVnUDYsob/Ng45rZea36+HjyiUqgqXuQ++PiuSQ+KPHlU755vAqdjOg3yLqgURrrE7itaeJ
        OwvJ2xAU2r/xXxH1wZqMJhNxUwHiQrFf83Jfanu7JtWZtdgtiWXpT8tt96WTxaUM1RXOEtzu0ej54
        rL51k/dsWwEzB2l+eUQUjNIDSXr1QfefByNjegiU9sIe50vVYYEy2GyjRMJO2jobilPLOU9XMsIsb
        BkxtfAUyjnWSxWWIk1irVkV5AAltmFSUAj6QehQkpKS77vKPpn6pyXkVgAINExRoqLQSnjeDDuEuQ
        0WqlXmmQ==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHua-00043T-VL; Mon, 24 Jun 2019 05:53:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] xfs: fix a comment typo in xfs_submit_ioend
Date:   Mon, 24 Jun 2019 07:52:44 +0200
Message-Id: <20190624055253.31183-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624055253.31183-1-hch@lst.de>
References: <20190624055253.31183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fail argument is long gone, update the comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 9cceb90e77c5..dc60aec0c5a7 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -626,7 +626,7 @@ xfs_map_blocks(
  * reference to the ioend to ensure that the ioend completion is only done once
  * all bios have been submitted and the ioend is really done.
  *
- * If @fail is non-zero, it means that we have a situation where some part of
+ * If @status is non-zero, it means that we have a situation where some part of
  * the submission process has failed after we have marked paged for writeback
  * and unlocked them. In this situation, we need to fail the bio and ioend
  * rather than submit it to IO. This typically only happens on a filesystem
-- 
2.20.1

