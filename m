Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C6FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6069206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642462;
	bh=XNyOjk7dOfMLbguby3+sfOAlqecK394eaclydOGdahQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yePoOd6iJ/YzK9DLuXXV3zdzijbZh4fVIehwDaGiV6da0txLAklcFDhaCaTKxXECs
	 NNqfcBfdxNAtzFACT7q+6jz+ffaPYjdEZWWkkkTkaqufI71tsAXbl3e6bqtCHnr0F6
	 hOUYGmeoz0YvLhih9lYf4k1QAczf1VPp4bOCvsnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbfL2R4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732829AbfL2R4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:56:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68F621D7E;
        Sun, 29 Dec 2019 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642194;
        bh=XNyOjk7dOfMLbguby3+sfOAlqecK394eaclydOGdahQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QNwgzdUhXWiWzvJJ0bHNSMWZF6IghWoidoA+X49hf29Fzt56qY14sriQ7a67lhjZ
         axQDs+hNjR/yt1cu1KtIbPruDLbVV0TKEeMyPS8AqnxBmLNArHUw6b66yBzC8DRbQl
         H1ou7Mor88SCWoIF5SAVhyTRxNNzBiuYJpytS89g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 382/434] drm/amdgpu: fix uninitialized variable pasid_mapping_needed
Date:   Sun, 29 Dec 2019 18:27:15 +0100
Message-Id: <20191229172727.519205177@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 17cf678a33c6196a3df4531fe5aec91384c9eeb5 ]

The boolean variable pasid_mapping_needed is not initialized and
there are code paths that do not assign it any value before it is
is read later.  Fix this by initializing pasid_mapping_needed to
false.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 6817bf283b2b ("drm/amdgpu: grab the id mgr lock while accessing passid_mapping")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7700c32dd743..c7514f743409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1035,7 +1035,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_
 		id->oa_size != job->oa_size);
 	bool vm_flush_needed = job->vm_needs_flush;
 	struct dma_fence *fence = NULL;
-	bool pasid_mapping_needed;
+	bool pasid_mapping_needed = false;
 	unsigned patch_offset = 0;
 	int r;
 
-- 
2.20.1



