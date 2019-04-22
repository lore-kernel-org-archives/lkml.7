Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D22C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115FA21907
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962507;
	bh=JpA2mO2WMpN+Rom/s1oZfZbNv8BEv/pZVkOnXty7Dq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iiuecAeqAnu3AysaMOA7G/nBIe/VNiJ+Vo5liSj60OoQ/jeoSrbmGUPfxCyVSV60r
	 SPGE7zFzsMEe/afKpxg4eHt42j69ttYE0bF/1ex/u9nWzM/Vrmei3KWpdFJg0Ugod6
	 WEJA4ErVpah+Rujws6sGG2CRCXVbqw0bpuPeDEDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfDVTs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbfDVTsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69EC218FD;
        Mon, 22 Apr 2019 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962502;
        bh=JpA2mO2WMpN+Rom/s1oZfZbNv8BEv/pZVkOnXty7Dq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zn2Fj5Utiz/M/GzeBShDFCtO1HZsDp9D4mDcdbSnMt9M0cnFQL2Ap7EnmAPs4Rd1I
         Yhah4uCyteFyyYXqICzt7dVIH8q/oMIzB0Fb64tAodF32iRtXEoKtXaOVwupH8UGe8
         nNIr2vWHeyX3q7sjsXuFuDYFwPHuec9urPsWQ+p0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 25/43] NFS: Fix a typo in nfs_init_timeout_values()
Date:   Mon, 22 Apr 2019 15:47:09 -0400
Message-Id: <20190422194727.12495-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 5a698243930c441afccec04e4d5dc8febfd2b775 ]

Specifying a retrans=0 mount parameter to a NFS/TCP mount, is
inadvertently causing the NFS client to rewrite any specified
timeout parameter to the default of 60 seconds.

Fixes: a956beda19a6 ("NFS: Allow the mount option retrans=0")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 fs/nfs/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 7d6ddfd60271..a98d64a6eda5 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -459,7 +459,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
 	case XPRT_TRANSPORT_RDMA:
 		if (retrans == NFS_UNSPEC_RETRANS)
 			to->to_retries = NFS_DEF_TCP_RETRANS;
-		if (timeo == NFS_UNSPEC_TIMEO || to->to_retries == 0)
+		if (timeo == NFS_UNSPEC_TIMEO || to->to_initval == 0)
 			to->to_initval = NFS_DEF_TCP_TIMEO * HZ / 10;
 		if (to->to_initval > NFS_MAX_TCP_TIMEOUT)
 			to->to_initval = NFS_MAX_TCP_TIMEOUT;
-- 
2.19.1

