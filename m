Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4505C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845312192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255925;
	bh=W3R0H/osxmZswlZ8lpgINOQOY5etppCBdq3PRPZBaBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A74WsNZ6QlcUkylMPIvK921sp5Uw5aoGI2ramCT1x5cFSXDWfN4y9BSEHskuPnCFz
	 9hDb0moZQIAlTCHB055GuQ6NKtUNR/9zTt7+tWu1CG5Etdfd86LuqmuQR07c8pLl+F
	 AuydhXKIXtpka5c01Fev1e1aPk3u7hPFI+Yo+1DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfCVL6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387864AbfCVL6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CACE20850;
        Fri, 22 Mar 2019 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255917;
        bh=W3R0H/osxmZswlZ8lpgINOQOY5etppCBdq3PRPZBaBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAkW9cIbAfCFIetrsCspyMHRu/uceYI1H/UBWHfbEVNlFUPTlKQzrscdp8xwzoibM
         tQt6USK+s4UOkHxcMBVh1uDedMLVTCWxbocsAbI31x/Ob0E9lL4ICK8ablFUsd+gDd
         ZLvKOTamMJ4imBSwTsHEDVCkrNqPiRogJdH1PpeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/280] xprtrdma: Make sure Send CQ is allocated on an existing compvec
Date:   Fri, 22 Mar 2019 12:13:27 +0100
Message-Id: <20190322111309.327834156@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a4cb5bdb754afe21f3e9e7164213e8600cf69427 ]

Make sure the device has at least 2 completion vectors
before allocating to compvec#1

Fixes: a4699f5647f3 (xprtrdma: Put Send CQ in IB_POLL_WORKQUEUE mode)
Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3d6bf790cf1f..5ddbf227e7c6 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -546,7 +546,8 @@ rpcrdma_ep_create(struct rpcrdma_ep *ep, struct rpcrdma_ia *ia,
 
 	sendcq = ib_alloc_cq(ia->ri_device, NULL,
 			     ep->rep_attr.cap.max_send_wr + 1,
-			     1, IB_POLL_WORKQUEUE);
+			     ia->ri_device->num_comp_vectors > 1 ? 1 : 0,
+			     IB_POLL_WORKQUEUE);
 	if (IS_ERR(sendcq)) {
 		rc = PTR_ERR(sendcq);
 		dprintk("RPC:       %s: failed to create send CQ: %i\n",
-- 
2.19.1



