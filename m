Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91638218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126238;
	bh=kt5+POFzrSvoKTTNSNhSkpb7uzWAzClZaooK0WjVXu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O7IvbCM5K1Z6nR9sc1szpptwFNqIdH2LI6+WGamgvbX8CL1Tigch8SJ4c4e35v39W
	 hAWRAPKyON3m5SiSFwyNIX2OvujJgllcwfWKAtguczK4m9seQWkQxEN9nJyqZs/CVw
	 kJlu/8KMdLhINuMiKHpR3rvoj+YoLhp+UQkRrHew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbfDXRRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388587AbfDXRRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:15 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94AD921907;
        Wed, 24 Apr 2019 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126235;
        bh=kt5+POFzrSvoKTTNSNhSkpb7uzWAzClZaooK0WjVXu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNhKg3CoFblMRMK118UNr/VFHfgz7M2E/3zNamTGTr+v9DZdWFaIhcM1fvgC+mt4Z
         LkMr9Bn8tZuRmNrlaCrs9KM2avCrSqOyohcxATuhLabVSyr8xi9cnLcDCljkmdtFbS
         VZwIenFRAhqmOo9yZfGnwBtL3isAsM4a9qO8qyI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 038/168] media: sh_veu: Correct return type for mem2mem buffer helpers
Date:   Wed, 24 Apr 2019 19:08:02 +0200
Message-Id: <20190424170926.020502338@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 43c145195c7fc3025ee7ecfc67112ac1c82af7c2 ]

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
 drivers/media/platform/sh_veu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sh_veu.c b/drivers/media/platform/sh_veu.c
index d6ab33e7060a..b9f4cdee555e 100644
--- a/drivers/media/platform/sh_veu.c
+++ b/drivers/media/platform/sh_veu.c
@@ -277,13 +277,13 @@ static void sh_veu_process(struct sh_veu_dev *veu,
 static void sh_veu_device_run(void *priv)
 {
 	struct sh_veu_dev *veu = priv;
-	struct vb2_buffer *src_buf, *dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 
 	src_buf = v4l2_m2m_next_src_buf(veu->m2m_ctx);
 	dst_buf = v4l2_m2m_next_dst_buf(veu->m2m_ctx);
 
 	if (src_buf && dst_buf)
-		sh_veu_process(veu, src_buf, dst_buf);
+		sh_veu_process(veu, &src_buf->vb2_buf, &dst_buf->vb2_buf);
 }
 
 		/* ========== video ioctls ========== */
-- 
2.19.1



