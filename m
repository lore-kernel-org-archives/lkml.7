Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D0D21E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497359;
	bh=itA/gofEKBXl+aHgWT2pDgX3eQRUWSUJzmUvvslkKBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ouohKxGWWuK2FF6poM7XYE69MBgeaAB6zjpT8XKO26SCiG3ADqmeckZc14hrQ651l
	 GXLSSc1AaxdagfmV/YYt+WchYk6zK1M+Hj/ZkHv97RPRaQSRHaYM1od/lHGrtt13Zr
	 PF7R7Ongu9miweH88DALEHgDaulQQcecZFb07ETY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfKKSf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:35:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbfKKSfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:35:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46CF21655;
        Mon, 11 Nov 2019 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497354;
        bh=itA/gofEKBXl+aHgWT2pDgX3eQRUWSUJzmUvvslkKBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6QHH/CgHUebMlkby/lc9mj1mXmFSosLyPPt2loGN1ke7Rm3qVE9eCg6lHLlBAk+o
         QCi81/MquDC/BjeXHhZV3Hwi1XjVlzkzvWvJcxCMrx+DLlGrGWqnllMlw3kFENRYEL
         OcSq+7TAOFoZlcYnFUse/jXELNhBGStQANAPrgDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.14 025/105] ceph: add missing check in d_revalidate snapdir handling
Date:   Mon, 11 Nov 2019 19:27:55 +0100
Message-Id: <20191111181437.535498809@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit 1f08529c84cfecaf1261ed9b7e17fab18541c58f upstream.

We should not play with dcache without parent locked...

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1347,6 +1347,7 @@ retry_lookup:
 		dout(" final dn %p\n", dn);
 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
 		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
+	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
 		   !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 		struct dentry *dn = req->r_dentry;
 		struct inode *dir = req->r_parent;


