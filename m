Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4819CC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5EC251E8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189622;
	bh=GsArPxxXUNMTSolPrYNzpqOWlGbn7QMpvOKGuFK/054=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QuPU0VCBmTFTCJ60qwiysqwIBV4ywvVgBZMKCT7wnbea9mTIewq0bYToMGQupIYyY
	 f3KXtxcgSjzcO9z0eD1b62M308V0p3Jcqc1XQuhUnGdpVmvFd9CRW+NxFVu+uey14z
	 WBZuFUw1Mui6QW+e9jeRkkOGk7iK6i3C9DdrQDHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfE3ENl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfE3DQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:21 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9B6245CA;
        Thu, 30 May 2019 03:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186181;
        bh=GsArPxxXUNMTSolPrYNzpqOWlGbn7QMpvOKGuFK/054=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNvtgElKhoM31BCVv1/ZWs1awmmFGU9aD3D0dlf+F4KGf9Lx8HW6Ih0Lj69XPiyLO
         eLivoWJsULYwZP64+MLGlJ1HsHrF698zBGg8TSuh68/Qi0zVuuYKgDqcRLWDtwBGls
         xnHQQsKqFUbz5QlZqbqmc/90LbM7TPCJ/QCLgy5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/276] NFS: make nfs_match_client killable
Date:   Wed, 29 May 2019 20:03:24 -0700
Message-Id: <20190530030527.549336028@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 950a578c6128c2886e295b9c7ecb0b6b22fcc92b ]

    Actually we don't do anything with return value from
    nfs_wait_client_init_complete in nfs_match_client, as a
    consequence if we get a fatal signal and client is not
    fully initialised, we'll loop to "again" label

    This has been proven to cause soft lockups on some scenarios
    (no-carrier but configured network interfaces)

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/client.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 751ca65da8a35..846d45cb1a3c8 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -290,6 +290,7 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
 	struct nfs_client *clp;
 	const struct sockaddr *sap = data->addr;
 	struct nfs_net *nn = net_generic(data->net, nfs_net_id);
+	int error;
 
 again:
 	list_for_each_entry(clp, &nn->nfs_client_list, cl_share_link) {
@@ -302,8 +303,10 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
 		if (clp->cl_cons_state > NFS_CS_READY) {
 			refcount_inc(&clp->cl_count);
 			spin_unlock(&nn->nfs_client_lock);
-			nfs_wait_client_init_complete(clp);
+			error = nfs_wait_client_init_complete(clp);
 			nfs_put_client(clp);
+			if (error < 0)
+				return ERR_PTR(error);
 			spin_lock(&nn->nfs_client_lock);
 			goto again;
 		}
@@ -413,6 +416,8 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 		clp = nfs_match_client(cl_init);
 		if (clp) {
 			spin_unlock(&nn->nfs_client_lock);
+			if (IS_ERR(clp))
+				return clp;
 			if (new)
 				new->rpc_ops->free_client(new);
 			return nfs_found_client(cl_init, clp);
-- 
2.20.1



