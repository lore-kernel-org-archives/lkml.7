Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24064C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E858A21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367887;
	bh=K+1WuSFZxd2JdPw6D1Qf9DkgZj3eSHut412qGPfGUB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NEYIvBnuLVAxXriQB+aR9xfRgUFQGDBON2yfiackbKp6v3FuMOO8wJRLlXhbDphC9
	 0/fiQtLqltnD4DAWda1lHWP82lMO/V99HzlM+AlqLfZbWJKDMk7EzToUX1CbhJKjQu
	 EK0moCPTWQezbbYoL6KGbbdjGkSiLCbx6DBqiA2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfDDIvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfDDIvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:51:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3FBE2177E;
        Thu,  4 Apr 2019 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367882;
        bh=K+1WuSFZxd2JdPw6D1Qf9DkgZj3eSHut412qGPfGUB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pkw3xo3BEVa4TMlN5lOWZXgA/dJRktt7FmK0O5vS5ye+FadCF/bDYI8EISkz/347n
         gAJYB7jQWMOkCOLSlmzF6qMmNZQD5KgF0f4WuljH3PQmLJ1nhM2piONLYjlj8kvssU
         3TUf8kej/CF3VbdOiy5LHJLcano2M93mHOyfjFzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 48/91] media: mx2_emmaprp: Correct return type for mem2mem buffer helpers
Date:   Thu,  4 Apr 2019 10:47:32 +0200
Message-Id: <20190404084538.264027859@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8d20dcefe471763f23ad538369ec65b51993ffff ]

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
 drivers/media/platform/mx2_emmaprp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mx2_emmaprp.c b/drivers/media/platform/mx2_emmaprp.c
index e68d271b10af..8354ad20865a 100644
--- a/drivers/media/platform/mx2_emmaprp.c
+++ b/drivers/media/platform/mx2_emmaprp.c
@@ -288,7 +288,7 @@ static void emmaprp_device_run(void *priv)
 {
 	struct emmaprp_ctx *ctx = priv;
 	struct emmaprp_q_data *s_q_data, *d_q_data;
-	struct vb2_buffer *src_buf, *dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct emmaprp_dev *pcdev = ctx->dev;
 	unsigned int s_width, s_height;
 	unsigned int d_width, d_height;
@@ -308,8 +308,8 @@ static void emmaprp_device_run(void *priv)
 	d_height = d_q_data->height;
 	d_size = d_width * d_height;
 
-	p_in = vb2_dma_contig_plane_dma_addr(src_buf, 0);
-	p_out = vb2_dma_contig_plane_dma_addr(dst_buf, 0);
+	p_in = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
+	p_out = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 	if (!p_in || !p_out) {
 		v4l2_err(&pcdev->v4l2_dev,
 			 "Acquiring kernel pointers to buffers failed\n");
-- 
2.19.1



