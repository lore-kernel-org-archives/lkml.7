Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3BAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A712217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000306;
	bh=cftGLbMc/c+miiGQtWYV4i55E8ryNAmcnEeb8x6Ixwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ADxPunlpvHT91DP/dkN+4P8FnLRXtE1QrN597lSITobo3amBum0OnCqwivZAY/8Ao
	 SSJdHUkpCvJdNk55QQEL6tXNvlQixw8ELwo330tKN9qHYOouafedQeXP2PN/G3QZU0
	 u/yrVGcrbYAvVM1q9UPBz/bSEFK/CETFp9Jzc7Ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfGXTaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbfGXT3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:29:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 644E820659;
        Wed, 24 Jul 2019 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996592;
        bh=cftGLbMc/c+miiGQtWYV4i55E8ryNAmcnEeb8x6Ixwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIQz+33tOQPetX9hKb2jwl027zc/FDtA4tfsnOJStd2y4DMzv3XP3VShH7TuwcRjr
         fZbOL/JRo3SO4T7Ek3O9cufHzFkTgxNcYThH/KYKFvGXF+Ahy9kHHdmXsXqDKHbzyV
         VOylweBhE6o4WzG/TEXRhVRmKN5uivvcksUHE+ns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 149/413] media: coda: fix last buffer handling in V4L2_ENC_CMD_STOP
Date:   Wed, 24 Jul 2019 21:17:20 +0200
Message-Id: <20190724191745.606214139@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f3775f89852d167990b0d718587774cf00d22ac2 ]

coda_encoder_cmd() is racy, as the last scheduled picture run worker can
still be in-flight while the ENC_CMD_STOP command is issued. Depending
on the exact timing the sequence numbers might already be changed, but
the last buffer might not have been put on the destination queue yet.

In this case the current implementation would prematurely wake the
destination queue with last_buffer_dequeued=true, causing userspace to
call streamoff before the last buffer is handled.

Close this race window by synchronizing with the pic_run_worker before
doing the sequence check.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
[l.stach@pengutronix.de: switch to flush_work, reword commit message]
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/coda/coda-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 6238047273f2..68a585d3af91 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1024,6 +1024,8 @@ static int coda_encoder_cmd(struct file *file, void *fh,
 	/* Set the stream-end flag on this context */
 	ctx->bit_stream_param |= CODA_BIT_STREAM_END_FLAG;
 
+	flush_work(&ctx->pic_run_work);
+
 	/* If there is no buffer in flight, wake up */
 	if (!ctx->streamon_out || ctx->qsequence == ctx->osequence) {
 		dst_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-- 
2.20.1



