Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89027C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5634B22466
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498923;
	bh=Bu+uXoeGnACmyjuFJfj8RwZfUwF3IpUjwV0R6AsXDdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDWRwmw0tZRxTET21J0C7Gxk2VeuYk38uYNziiLzhNehfMO8IxbDBHB5O4eKWN0Sm
	 XzK6wFuID5ifZaQBU7UJg7dwI4mXCKR5/Qsg/WiozOBpH1gs4UYvEHvytOCK28NB6s
	 xSyWgilp1d91yNKP0OglwUWsVFsbXN1TOWM1WXLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfKKSuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfKKSuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:50:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED54F21655;
        Mon, 11 Nov 2019 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498209;
        bh=Bu+uXoeGnACmyjuFJfj8RwZfUwF3IpUjwV0R6AsXDdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7KC1A4giCUWW+APHJehXD3LDM1ppWJHJ8Vk5TwvU2lU6ZGLdsN8RiMcCOGoFmRz9
         dC+FaRgNyp34/cuV3EbK8qiWm61S+NBJVzx0zzN5aMkgqkMpkh6Jl9to2N07dumJEQ
         3OnlVvFAD2HGyCQtxDPR0qwNJl36DyU7QNFzZD4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.3 053/193] ceph: add missing check in d_revalidate snapdir handling
Date:   Mon, 11 Nov 2019 19:27:15 +0100
Message-Id: <20191111181504.894591335@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
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
@@ -1432,6 +1432,7 @@ retry_lookup:
 		dout(" final dn %p\n", dn);
 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
 		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
+	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
 		   !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 		struct inode *dir = req->r_parent;
 


