Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDB9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B8220855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370729;
	bh=9JryHmtGTA/Ig+O7TjYWCSMn7omrbVpBAFJ0w2Nc1K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZpbsM19Hc/QSJptTsRVEXQe44shPC90aowJ7TBnGsYa7rqJLQU+B4ajvPowBFB2F
	 xLwMthXvv/EaWiGnNydim4n/iHApnXyz7NAdL3gYSrQg1BZ0txtuYr+9CKIfkYGzBg
	 Epsu/PF+4XVsW7I9tC+wXiuQQJI+Lr+2AqzTtwgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbfDDJir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731888AbfDDJED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8332147C;
        Thu,  4 Apr 2019 09:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368642;
        bh=9JryHmtGTA/Ig+O7TjYWCSMn7omrbVpBAFJ0w2Nc1K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TISwC0JXyD/+mk1m7keOauPxUw/984N8HR6ejef2IEsdyZ7sP6XhX/xNNO0EQVLfp
         4JcixDlbTnmNoTfH16PQfwnsQ8Oi8xUODC2GJCzBOphulkkooZiXXEh7RpdM41Lvyb
         AIdphK87xkoFqM2PC0gsJitExjyEUJeNs4hyBf7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/187] media: mx2_emmaprp: Correct return type for mem2mem buffer helpers
Date:   Thu,  4 Apr 2019 10:47:06 +0200
Message-Id: <20190404084607.274137097@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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
index 64195c4ddeaf..419e1cb10dc6 100644
--- a/drivers/media/platform/mx2_emmaprp.c
+++ b/drivers/media/platform/mx2_emmaprp.c
@@ -274,7 +274,7 @@ static void emmaprp_device_run(void *priv)
 {
 	struct emmaprp_ctx *ctx = priv;
 	struct emmaprp_q_data *s_q_data, *d_q_data;
-	struct vb2_buffer *src_buf, *dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct emmaprp_dev *pcdev = ctx->dev;
 	unsigned int s_width, s_height;
 	unsigned int d_width, d_height;
@@ -294,8 +294,8 @@ static void emmaprp_device_run(void *priv)
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



