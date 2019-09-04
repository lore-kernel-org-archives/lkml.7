Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00987C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF8E23400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620274;
	bh=azGO1qmg/UaSPqmktxHgfqCnVRUIkWMbvB4vhJz8qWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hszzsRdtqPQc2N1gYO/HZdWdpwrVc2uSB/OejIDnr0wTdTyklradEBP3VxGJrSCJL
	 RhoQn2D2gmysm/598PUSY7cnvV4wAOOSIkw3CRTNn+ctUUUYfJW5N0tCv/xa9H8QVR
	 j4ERFeCpCVzNc25QoEbvglW/IH7Qn2GCllhn2h1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbfIDSEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389082AbfIDSE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:04:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847F822CEA;
        Wed,  4 Sep 2019 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620268;
        bh=azGO1qmg/UaSPqmktxHgfqCnVRUIkWMbvB4vhJz8qWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCJrQehFKgElasCJ96d1B4H+/WIq6ljdbQGr2vV5dy9A3D7/20AR3PTu7yFw8ZV4V
         oNl8ddM48A18bXn9GfWV9fljEi2stCzSp/NNxzFVCE60HAajSye0NsODNfI46fWLo7
         5ngZnD1+gczgieLysWJWNY4Wum0euL6+hF9Y8LAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 53/57] NFSv4/pnfs: Fix a page lock leak in nfs_pageio_resend()
Date:   Wed,  4 Sep 2019 19:54:21 +0200
Message-Id: <20190904175307.112494039@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f4340e9314dbfadc48758945f85fc3b16612d06f ]

If the attempt to resend the pages fails, we need to ensure that we
clean up those pages that were not transmitted.

Fixes: d600ad1f2bdb ("NFS41: pop some layoutget errors to application")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.5+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pagelist.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index a7aa028a5b0bb..ae598e45b2df0 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1231,20 +1231,22 @@ static void nfs_pageio_complete_mirror(struct nfs_pageio_descriptor *desc,
 int nfs_pageio_resend(struct nfs_pageio_descriptor *desc,
 		      struct nfs_pgio_header *hdr)
 {
-	LIST_HEAD(failed);
+	LIST_HEAD(pages);
 
 	desc->pg_io_completion = hdr->io_completion;
 	desc->pg_dreq = hdr->dreq;
-	while (!list_empty(&hdr->pages)) {
-		struct nfs_page *req = nfs_list_entry(hdr->pages.next);
+	list_splice_init(&hdr->pages, &pages);
+	while (!list_empty(&pages)) {
+		struct nfs_page *req = nfs_list_entry(pages.next);
 
 		if (!nfs_pageio_add_request(desc, req))
-			nfs_list_move_request(req, &failed);
+			break;
 	}
 	nfs_pageio_complete(desc);
-	if (!list_empty(&failed)) {
-		list_move(&failed, &hdr->pages);
-		return desc->pg_error < 0 ? desc->pg_error : -EIO;
+	if (!list_empty(&pages)) {
+		int err = desc->pg_error < 0 ? desc->pg_error : -EIO;
+		hdr->completion_ops->error_cleanup(&pages, err);
+		return err;
 	}
 	return 0;
 }
-- 
2.20.1



