Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC16C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5594E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103228;
	bh=pbhhtTjqHGaVTb6b/qL8/sUcq+cEXuTLSfp3vcATJdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Otq5emRXeI4oyqmhRWUzdf/ahSRz9khAAD0MPilxUmD/0tbhFdTm8xbNYbA4I5skI
	 TZLor4weVxVjlVuWEGy03CAsxOucyNy4jaBAGR8HkzQaOsqcltdfezYgWBHc+JpjBe
	 /nDu/4yzil2m1+Q+rd5FpH52seHv766fhZ3XXWfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfH2S1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbfH2SPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:15:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDED023427;
        Thu, 29 Aug 2019 18:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102537;
        bh=pbhhtTjqHGaVTb6b/qL8/sUcq+cEXuTLSfp3vcATJdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzsb+bDuGpQ76IWR2il2hw5XYHgeKCuTHhmUj4+ZW9+jEU8nLrHVq2M/nLOh5muM2
         f6c9IYLMVVPzL1u1qIRVwrnjpN26ZuzYJK31KfEVRlt1i3OjAsteOi+1Xf8x+EbCFe
         of3y+X9jUvS0eekvpVyvsycqqQblAF2O8WJbQsjs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 72/76] afs: use correct afs_call_type in yfs_fs_store_opaque_acl2
Date:   Thu, 29 Aug 2019 14:13:07 -0400
Message-Id: <20190829181311.7562-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 7533be858f5b9a036b9f91556a3ed70786abca8e ]

It seems that 'yfs_RXYFSStoreOpaqueACL2' should be use in
yfs_fs_store_opaque_acl2().

Fixes: f5e4546347bc ("afs: Implement YFS ACL setting")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/yfsclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 18722aaeda33a..a1baf3f1f14d1 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -2155,7 +2155,7 @@ int yfs_fs_store_opaque_acl2(struct afs_fs_cursor *fc, const struct afs_acl *acl
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	size = round_up(acl->size, 4);
-	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreStatus,
+	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreOpaqueACL2,
 				   sizeof(__be32) * 2 +
 				   sizeof(struct yfs_xdr_YFSFid) +
 				   sizeof(__be32) + size,
-- 
2.20.1

