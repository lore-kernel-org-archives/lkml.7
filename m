Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D378220820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369188;
	bh=mtWPuwVZNQZKpfcsyJ/RTEFunbmxHEDDWcg5SHi+Ep8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0dAKGa7aQSOgVEInuOn7dhFmLH5ipEr80S4PrkDTAXoQKcWTQ+58KocgsFl3T1YN
	 IvD6EEtiXtHKISJO4GqxarsK5barzh1S/cVeeCaL0Jr0wgUEvvlNFfTnhegVBYMmWM
	 Q8QH1hSZJaxF9IrVp8P81K3LjySzdBNn7ZQRZV3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfDDJNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733195AbfDDJNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ED4E20820;
        Thu,  4 Apr 2019 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369184;
        bh=mtWPuwVZNQZKpfcsyJ/RTEFunbmxHEDDWcg5SHi+Ep8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRf8Bct1eZjYzHPDAh3kTCHeCHJjQDiWm3Gzd1ylLgaQTUINFWjvRq9xiS1U3UoWg
         aUelQYSMWZgI5aoXFVGVv0uBBMXY3FgIFkO2V2sqcDj1tWieq7m7N6EtWJJ38hHKQ9
         aZdL4cVbFHitkAT2uMnqGwHhidlYRhjTF/VKZjGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 115/246] media: rockchip/rga: Correct return type for mem2mem buffer helpers
Date:   Thu,  4 Apr 2019 10:46:55 +0200
Message-Id: <20190404084623.179549872@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit da2d3a4e4adabc6ccfb100bc9abd58ee9cd6c4b7 ]

Fix the assigned type of mem2mem buffer handling API.
Namely, these functions:

 v4l2_m2m_next_buf
 v4l2_m2m_last_buf
 v4l2_m2m_buf_remove
 v4l2_m2m_next_src_buf
 v4l2_m2m_next_dst_buf
 v4l2_m2m_last_src_buf
 v4l2_m2m_last_dst_buf
 v4l2_m2m_src_buf_remove
 v4l2_m2m_dst_buf_remove

return a struct vb2_v4l2_buffer, and not a struct vb2_buffer.

Fixing this is necessary to fix the mem2mem buffer handling API,
changing the return to the correct struct vb2_v4l2_buffer instead
of a void pointer.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rga/rga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 5c653287185f..b096227a9722 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -43,7 +43,7 @@ static void device_run(void *prv)
 {
 	struct rga_ctx *ctx = prv;
 	struct rockchip_rga *rga = ctx->rga;
-	struct vb2_buffer *src, *dst;
+	struct vb2_v4l2_buffer *src, *dst;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rga->ctrl_lock, flags);
@@ -53,8 +53,8 @@ static void device_run(void *prv)
 	src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
 
-	rga_buf_map(src);
-	rga_buf_map(dst);
+	rga_buf_map(&src->vb2_buf);
+	rga_buf_map(&dst->vb2_buf);
 
 	rga_hw_start(rga);
 
-- 
2.19.1



