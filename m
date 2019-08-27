Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFA6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74B620828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892650;
	bh=Uf8LcxK1x529NuDSkh7wCF7Hwgb6L9jUZwGpYF8IrnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z67n6sB38h7RrZFDtoa4djEdjjolva3bqTtRT1JWnBItsAJk+ypVg0FvM6tZiTRui
	 aZ70hynxK22mnRD6hWskH/ycsagHAUjat9yDm06T68i1FCLNwmr435UCU5HbCrdmf2
	 yjpMuDF+TPhBDGqf+8+zchVZ1BFDQY7eem0D035Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfH0H53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730791AbfH0H5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:57:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB746206BF;
        Tue, 27 Aug 2019 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892642;
        bh=Uf8LcxK1x529NuDSkh7wCF7Hwgb6L9jUZwGpYF8IrnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uu8tb3/cJ4Z3GqqF3VmRYtrphFcUnHdAhcRPmRT9hlR6Op7Lo+f1mMuxQFmkVq2x4
         RtX68N5/W19y4O9MrpqQ3xfkBYiZEnrbA6oeTcAz4I2Gx9CKE5ntcbMAwypjmG6Jgl
         fGEIUdaSvnI8wY+Ydd8NZLpgN7+umprq6VceHsXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hector Martin <hector@marcansoft.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.19 64/98] ceph: dont try fill file_lock on unsuccessful GETFILELOCK reply
Date:   Tue, 27 Aug 2019 09:50:43 +0200
Message-Id: <20190827072721.686695513@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 28a282616f56990547b9dcd5c6fbd2001344664c upstream.

When ceph_mdsc_do_request returns an error, we can't assume that the
filelock_reply pointer will be set. Only try to fetch fields out of
the r_reply_info when it returns success.

Cc: stable@vger.kernel.org
Reported-by: Hector Martin <hector@marcansoft.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/locks.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -111,8 +111,7 @@ static int ceph_lock_message(u8 lock_typ
 		req->r_wait_for_completion = ceph_lock_wait_for_completion;
 
 	err = ceph_mdsc_do_request(mdsc, inode, req);
-
-	if (operation == CEPH_MDS_OP_GETFILELOCK) {
+	if (!err && operation == CEPH_MDS_OP_GETFILELOCK) {
 		fl->fl_pid = -le64_to_cpu(req->r_reply_info.filelock_reply->pid);
 		if (CEPH_LOCK_SHARED == req->r_reply_info.filelock_reply->type)
 			fl->fl_type = F_RDLCK;


