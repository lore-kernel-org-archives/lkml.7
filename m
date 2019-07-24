Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF05C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF45205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998514;
	bh=zAhXo+XxwekVmP5ztzPpytOVBqraW1kB57TckRhR+Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rcaSONI+oQ4qJIV7tc6IK0AFtIQ/Zj9d1QxVcKXrWX6nURe5tff1wjvEIpcrwzQsG
	 JDWeVp/qNl/i9e/+AI9H62AkZL2sXA81DGyDWBfCZO/09M84UwGpGBkbhVztrrwfXr
	 17+Cp3GOJwNvkam+3QHpQXIrgN/HXMgEMQAhA2u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392344AbfGXUBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392322AbfGXUBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:01:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0C721855;
        Wed, 24 Jul 2019 20:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998509;
        bh=zAhXo+XxwekVmP5ztzPpytOVBqraW1kB57TckRhR+Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qk1BjP/hGpspSFZNOQSHZKCTAs7D3OtxDKZ1oV9IGmoly/zMRbLKzqBDK/ayRqrZ/
         ktxsV+LrlBp8zb0VwnC46j3CX/mvEIghUN8DHd1Ewd9hh0qcBR06Ri41wEX6jvFiDA
         asxfY3yUgBV1vDpm3nc/166teSo9Q5AcQ2et3IMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 019/271] media: marvell-ccic: fix DMA s/g desc number calculation
Date:   Wed, 24 Jul 2019 21:18:08 +0200
Message-Id: <20190724191656.889248302@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0c7aa32966dab0b8a7424e1b34c7f206817953ec ]

The commit d790b7eda953 ("[media] vb2-dma-sg: move dma_(un)map_sg here")
left dma_desc_nent unset. It previously contained the number of DMA
descriptors as returned from dma_map_sg().

We can now (since the commit referred to above) obtain the same value from
the sg_table and drop dma_desc_nent altogether.

Tested on OLPC XO-1.75 machine. Doesn't affect the OLPC XO-1's Cafe
driver, since that one doesn't do DMA.

[mchehab+samsung@kernel.org: fix a checkpatch warning]

Fixes: d790b7eda953 ("[media] vb2-dma-sg: move dma_(un)map_sg here")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/marvell-ccic/mcam-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/media/platform/marvell-ccic/mcam-core.c
index dfdbd4354b74..eeee15ff007d 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.c
+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
@@ -200,7 +200,6 @@ struct mcam_vb_buffer {
 	struct list_head queue;
 	struct mcam_dma_desc *dma_desc;	/* Descriptor virtual address */
 	dma_addr_t dma_desc_pa;		/* Descriptor physical address */
-	int dma_desc_nent;		/* Number of mapped descriptors */
 };
 
 static inline struct mcam_vb_buffer *vb_to_mvb(struct vb2_v4l2_buffer *vb)
@@ -608,9 +607,11 @@ static void mcam_dma_contig_done(struct mcam_camera *cam, int frame)
 static void mcam_sg_next_buffer(struct mcam_camera *cam)
 {
 	struct mcam_vb_buffer *buf;
+	struct sg_table *sg_table;
 
 	buf = list_first_entry(&cam->buffers, struct mcam_vb_buffer, queue);
 	list_del_init(&buf->queue);
+	sg_table = vb2_dma_sg_plane_desc(&buf->vb_buf.vb2_buf, 0);
 	/*
 	 * Very Bad Not Good Things happen if you don't clear
 	 * C1_DESC_ENA before making any descriptor changes.
@@ -618,7 +619,7 @@ static void mcam_sg_next_buffer(struct mcam_camera *cam)
 	mcam_reg_clear_bit(cam, REG_CTRL1, C1_DESC_ENA);
 	mcam_reg_write(cam, REG_DMA_DESC_Y, buf->dma_desc_pa);
 	mcam_reg_write(cam, REG_DESC_LEN_Y,
-			buf->dma_desc_nent*sizeof(struct mcam_dma_desc));
+			sg_table->nents * sizeof(struct mcam_dma_desc));
 	mcam_reg_write(cam, REG_DESC_LEN_U, 0);
 	mcam_reg_write(cam, REG_DESC_LEN_V, 0);
 	mcam_reg_set_bit(cam, REG_CTRL1, C1_DESC_ENA);
-- 
2.20.1



