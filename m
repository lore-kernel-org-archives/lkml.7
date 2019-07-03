Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F0FC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C00218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="efDzZwBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfGCWCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:02:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGCWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DUoOwqjnTji0F9t1TBg521OpvLvqwX3Vlrvz0Ntypso=; b=efDzZwBeFkuXGAumAQiTxGRxkt
        7D+YalkdI4VpAhWfDiCr5acuRvXk3B2P6XcIKBXGzEPBierDhh0ydQYTRtK5O3oYNgb0CXsCluMgO
        z+4eQkFrCU1ogAFWQxXUO2itnHdgd5PstKF1fjC/mYhkALtlWktGH2LwfMkR3X+J+Iw2eeduXoBiZ
        TEUf3el0yJeHxkqoV3zcOygMbjfNtIkcYb7c/dNlmPWjVJG+bE00JuSW1bMeOcQZS+bZRWiWATVGf
        UdIM1NJZPbkyv3mt3mrXrTmNhpRloE/IABs8wxj3gLRGIvAGR1uw8u+PcvwC2w+8wtER9Birgc/wh
        KZgk5nNw==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hinKS-0004Ek-JE; Wed, 03 Jul 2019 22:02:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] nouveau: return -EBUSY when hmm_range_wait_until_valid fails
Date:   Wed,  3 Jul 2019 15:02:13 -0700
Message-Id: <20190703220214.28319-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703220214.28319-1-hch@lst.de>
References: <20190703220214.28319-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-EAGAIN has a magic meaning for non-blocking faults, so don't overload
it.  Given that the caller doesn't check for specific error codes this
change is purely cosmetic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index d97d862e8b7d..26853f59b0f4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -508,7 +508,7 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 
 	if (!hmm_range_wait_until_valid(range, NOUVEAU_RANGE_FAULT_TIMEOUT)) {
 		up_read(&range->vma->vm_mm->mmap_sem);
-		return -EAGAIN;
+		return -EBUSY;
 	}
 
 	ret = hmm_range_fault(range, true);
-- 
2.20.1

