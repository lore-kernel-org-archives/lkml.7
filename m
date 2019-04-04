Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E16206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371323;
	bh=PAoyYTfYa6NtOVtSBk5fjLPKR4dTa+PHSH+j0fFnMyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJatP+JHbWgS8joqwPqZOc2qyol2l7J4OYFZiPMFRUn/7ra8w3HqVQmGACfYbpFLg
	 0THZ6ySIiqjFe3PWaWVd5UBBuwgRW7TQSk8hpOL1rYRHkvuVcoEIQBscSJ4zenbLkh
	 4OGvJ/q/vuqXxIgTrmftOQbXByp090i3WWgUI7Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfDDJsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730235AbfDDI5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:57:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5F520882;
        Thu,  4 Apr 2019 08:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368227;
        bh=PAoyYTfYa6NtOVtSBk5fjLPKR4dTa+PHSH+j0fFnMyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izzx+dCi9mvupxxnT0wOvwn0Um81vj47YIk5eEDAxi3eoeujCfoEbRwJTwmQjKTqz
         N7f9UH6HooYvtYV39//0BFIob3Y2juqabitTgUwTl2oYUB+g2Xw9Zak+xZ4fbW1VDz
         z9gmEcKpAjOfPi06u+2aBURgQIiMUfmS+Zs7JCkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 059/121] media: sh_veu: Correct return type for mem2mem buffer helpers
Date:   Thu,  4 Apr 2019 10:47:27 +0200
Message-Id: <20190404084548.455431833@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



