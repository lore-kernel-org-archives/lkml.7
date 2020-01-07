Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D8AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A3C2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431893;
	bh=26pRNXp4y9ynyMwAZNrOVO5Yl5vRpAbkefRc+U5H31I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rKjD6bmo8dwCh85legWpBLsuKSSyRd9dKBa3C25Uir1X3e8sajtCuWxMGx3ar2j7Z
	 EVqyioTmy7hD+oTnWhaK/YnbAYLchWzhy+DBprydOxTp2XPMLw67sCe76pjJmQ5TaT
	 KJ600MR9qXeFqbrpbQNSDoEOh9wPnq0CUyZl27+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgAGVSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbgAGVFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:05:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F31F2081E;
        Tue,  7 Jan 2020 21:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431114;
        bh=26pRNXp4y9ynyMwAZNrOVO5Yl5vRpAbkefRc+U5H31I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHwKKzVfnlJuVWx8jSspxVZ/hjDmsLVuJFUPqKHFOilaNc+K3T7s8js+XzGb5XXXi
         FySW3Zp/vaNATbUTr7dzPjXxf9nX/6B/TyHG292aMhATDRzymazrvT/oEvQW1IGmOo
         Mwc3cm98VZFOGTPt0jhpgSzTXsW5l6h5Rr1vv8f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c732f8644185de340492@syzkaller.appspotmail.com,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/115] xfs: fix mount failure crash on invalid iclog memory access
Date:   Tue,  7 Jan 2020 21:54:08 +0100
Message-Id: <20200107205301.648935842@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit 798a9cada4694ca8d970259f216cec47e675bfd5 ]

syzbot (via KASAN) reports a use-after-free in the error path of
xlog_alloc_log(). Specifically, the iclog freeing loop doesn't
handle the case of a fully initialized ->l_iclog linked list.
Instead, it assumes that the list is partially constructed and NULL
terminated.

This bug manifested because there was no possible error scenario
after iclog list setup when the original code was added.  Subsequent
code and associated error conditions were added some time later,
while the original error handling code was never updated. Fix up the
error loop to terminate either on a NULL iclog or reaching the end
of the list.

Reported-by: syzbot+c732f8644185de340492@syzkaller.appspotmail.com
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index c3b610b687d1..7bba551cbf90 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1578,6 +1578,8 @@ xlog_alloc_log(
 		if (iclog->ic_bp)
 			xfs_buf_free(iclog->ic_bp);
 		kmem_free(iclog);
+		if (prev_iclog == log->l_iclog)
+			break;
 	}
 	spinlock_destroy(&log->l_icloglock);
 	xfs_buf_free(log->l_xbuf);
-- 
2.20.1



