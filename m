Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C83C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7174C2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127658;
	bh=eh6lIBAXDpsw2b52R9Pjo6gZXMHMR62LSLtu9wqG9a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cIxKXMDvlt4xa0BCkYsCAawQnsP96aBoxaJq+Ne4xLnGCn5C/IAqh2BO8VZ5MyzLf
	 JUVZVbb7hUHYv/oB3P8GRG2Zt3WawvgwYWb8gg2boNYBX1vXU2pXuiFU+CbtG3xl31
	 r2zMwPdaZ9LvOPPevhUTtPx/dadWMGmwWkhC2H8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403953AbfDXRhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403930AbfDXRg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:59 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6DD21905;
        Wed, 24 Apr 2019 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127418;
        bh=eh6lIBAXDpsw2b52R9Pjo6gZXMHMR62LSLtu9wqG9a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DGsbQXgn452APQ4C21spJw1vYk8Owg46fa5zk0dsn2+TZTqpj26Rsyb/SQBfoUom
         oHjdILMwO3DXcqtzoOnuM1BxV2i57y1gO215PCQx+pTKX8/zkkKa168YPl+ZAmdYO8
         XbLWZglUa78HFtuwXUH8OknADO94Wst5GcO6jL+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.0 085/115] drm/ttm: fix out-of-bounds read in ttm_put_pages() v2
Date:   Wed, 24 Apr 2019 19:10:21 +0200
Message-Id: <20190424170929.882488036@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

commit a66477b0efe511d98dde3e4aaeb189790e6f0a39 upstream.

When ttm_put_pages() tries to figure out whether it's dealing with
transparent hugepages, it just reads past the bounds of the pages array
without a check.

v2: simplify the test if enough pages are left in the array (Christian).

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 5c42c64f7d54 ("drm/ttm: fix the fix for huge compound pages")
Cc: stable@vger.kernel.org
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ttm/ttm_page_alloc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -730,7 +730,8 @@ static void ttm_put_pages(struct page **
 			}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			if (!(flags & TTM_PAGE_FLAG_DMA32)) {
+			if (!(flags & TTM_PAGE_FLAG_DMA32) &&
+			    (npages - i) >= HPAGE_PMD_NR) {
 				for (j = 0; j < HPAGE_PMD_NR; ++j)
 					if (p++ != pages[i + j])
 					    break;
@@ -759,7 +760,7 @@ static void ttm_put_pages(struct page **
 		unsigned max_size, n2free;
 
 		spin_lock_irqsave(&huge->lock, irq_flags);
-		while (i < npages) {
+		while ((npages - i) >= HPAGE_PMD_NR) {
 			struct page *p = pages[i];
 			unsigned j;
 


