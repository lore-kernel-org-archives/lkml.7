Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A2AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14402072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431538;
	bh=TN0Xg0tfqAJShMc5DcrjvYCa3ZyOiw15uPq6nILt9qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GAJcpOEzo8UJRlX3TMZP2I3gDFklfhwubgHqe4tgSkVvko42YFDTjlELq4DhI5965
	 /iho07+Xz25iby23yQtgerfMChaHk7mcUTKyujvSOyEk6KziFxvvbf+c7LAjxewNFg
	 5ijkc5gKcNOldmmBOMaOtMCSQ6QioV3D/mzEGVKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgAGVMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:12:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgAGVLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:11:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B143C2077B;
        Tue,  7 Jan 2020 21:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431471;
        bh=TN0Xg0tfqAJShMc5DcrjvYCa3ZyOiw15uPq6nILt9qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KM1rxavjO/WGUB1KtNGryASa2lcvQYISLIIYKQCizxPJrqlVdzTb1tYglf5kSl4Vo
         6bgoIF7pU6wm+hxa2ufHtkVOdnXhKo64mRQyywPdLBAIMI6OjmDCo1sKKu8ucjBdCj
         xQez4pFduBuuxuLDzymLXI6dImmUmn1a2z08/HIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Lukas Wunner <lukas@wunner.de>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.14 33/74] dmaengine: Fix access to uninitialized dma_slave_caps
Date:   Tue,  7 Jan 2020 21:54:58 +0100
Message-Id: <20200107205202.697434811@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit 53a256a9b925b47c7e67fc1f16ca41561a7b877c upstream.

dmaengine_desc_set_reuse() allocates a struct dma_slave_caps on the
stack, populates it using dma_get_slave_caps() and then accesses one
of its members.

However dma_get_slave_caps() may fail and this isn't accounted for,
leading to a legitimate warning of gcc-4.9 (but not newer versions):

   In file included from drivers/spi/spi-bcm2835.c:19:0:
   drivers/spi/spi-bcm2835.c: In function 'dmaengine_desc_set_reuse':
>> include/linux/dmaengine.h:1370:10: warning: 'caps.descriptor_reuse' is used uninitialized in this function [-Wuninitialized]
     if (caps.descriptor_reuse) {

Fix it, thereby also silencing the gcc-4.9 warning.

The issue has been present for 4 years but surfaces only now that
the first caller of dmaengine_desc_set_reuse() has been added in
spi-bcm2835.c. Another user of reusable DMA descriptors has existed
for a while in pxa_camera.c, but it sets the DMA_CTRL_REUSE flag
directly instead of calling dmaengine_desc_set_reuse(). Nevertheless,
tag this commit for stable in case there are out-of-tree users.

Fixes: 272420214d26 ("dmaengine: Add DMA_CTRL_REUSE")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.3+
Link: https://lore.kernel.org/r/ca92998ccc054b4f2bfd60ef3adbab2913171eac.1575546234.git.lukas@wunner.de
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/dmaengine.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1362,8 +1362,11 @@ static inline int dma_get_slave_caps(str
 static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
 {
 	struct dma_slave_caps caps;
+	int ret;
 
-	dma_get_slave_caps(tx->chan, &caps);
+	ret = dma_get_slave_caps(tx->chan, &caps);
+	if (ret)
+		return ret;
 
 	if (caps.descriptor_reuse) {
 		tx->flags |= DMA_CTRL_REUSE;


