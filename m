Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958F3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBBA206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999480;
	bh=aQtz8Xi7ImXOGjaoYE7o1JBarrm7WLfR2oS70q+ToZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2BmL/OKGIwhUkn+1N4NHcvPteyVMzoGTZxwPEPWKHuZEIF2A9tVNSez8REeCMivDe
	 rn+HDgYKsaVuD7YO1p9wIR8IzjMJIeGr1MvVf09GCahcqT/ezXIduNGL/b6eDn/1ET
	 Doe+Ki7nYjakziyxeFZUgoqXxeiFkRlTdSP0+4oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390699AbfGXTtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391534AbfGXTtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:49:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BAD205C9;
        Wed, 24 Jul 2019 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997771;
        bh=aQtz8Xi7ImXOGjaoYE7o1JBarrm7WLfR2oS70q+ToZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2lZUU3N0jFJQc+XZ2FQkes5v7K24yQCUpwdxZVCMSRR14e/p1uSj8OUh7SscUkXfO
         pElOzbRV2YP0+1xCAjS/qhhwmHr7WaKl4Otssp0YPCeyzSCOOIoeklC4ZCHcg7I19l
         LY2Q25VkKSL+uOiVZnv88mb2jMm3EuVUzIVBi7ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 137/371] media: coda: increment sequence offset for the last returned frame
Date:   Wed, 24 Jul 2019 21:18:09 +0200
Message-Id: <20190724191735.268472168@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b3b7d96817cdb8b6fc353867705275dce8f41ccc ]

If no more frames are decoded in bitstream end mode, and a previously
decoded frame has been returned, the firmware still increments the frame
number. To avoid a sequence number mismatch after decoder restart,
increment the sequence_offset correction parameter.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/coda/coda-bit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index 5eb93ac060d5..8648a6bd8809 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -2151,6 +2151,9 @@ static void coda_finish_decode(struct coda_ctx *ctx)
 		else if (ctx->display_idx < 0)
 			ctx->hold = true;
 	} else if (decoded_idx == -2) {
+		if (ctx->display_idx >= 0 &&
+		    ctx->display_idx < ctx->num_internal_frames)
+			ctx->sequence_offset++;
 		/* no frame was decoded, we still return remaining buffers */
 	} else if (decoded_idx < 0 || decoded_idx >= ctx->num_internal_frames) {
 		v4l2_err(&dev->v4l2_dev,
-- 
2.20.1



