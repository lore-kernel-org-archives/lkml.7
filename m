Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357AAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17952183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710912;
	bh=OHA+uy2nrCWE74pWn7XAh3ATSHXusEDNrJ/mO0g3SGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yBZVKEWh1m2TBb9qnvJAajWfN7rF5BPIDLpGwoLDMfNLI8w/I6mVyi+v5273xAsko
	 /7owqADU7lH97Pm7ax8+W25HKwgxVbwP5Y79Mb1gFQ2axd+tFtdFoYJ8qIEg09VL5/
	 rJmo917Vzps4LqBOzVW7Mrzl6HODwmwGz0VSlttg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391239AbfC0SVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390938AbfC0SVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:21:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7740620651;
        Wed, 27 Mar 2019 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710906;
        bh=OHA+uy2nrCWE74pWn7XAh3ATSHXusEDNrJ/mO0g3SGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXqIOWkxzj23pkmNwrOSusMyCD5Dmd7Ro3yas4J0qFto4QqN4qFBs3uaYFI0HgdVK
         Sa7hvtDzmsA22KrWp0xXD/WbKU0VgZogRsYhXAYj2mP4+ymtRo9Xazq6msjxKjlmWF
         hpj8Q7AD/8mT0KfEfa36KyTpyHU21Hksr6iND9Ng=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 39/87] media: sh_veu: Correct return type for mem2mem buffer helpers
Date:   Wed, 27 Mar 2019 14:19:52 -0400
Message-Id: <20190327182040.17444-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

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
index 15a562af13c7..a4f593220ef0 100644
--- a/drivers/media/platform/sh_veu.c
+++ b/drivers/media/platform/sh_veu.c
@@ -276,13 +276,13 @@ static void sh_veu_process(struct sh_veu_dev *veu,
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

