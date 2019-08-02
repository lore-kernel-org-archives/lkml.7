Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C18C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF47020880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738974;
	bh=cq3po24IzPnFbopWCD/dSWmd2JNvYqSC8uQEjnVlWEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/epgxn4oarjbNB4RWCKlsF/jANuWSgPmI+0Ka36KWEssLFKEqYrOVakJlXzBQjaw
	 Ayu02LSnCvlJntQQkrrWwkjtkcOc73BJvOf4Q4IeNTk/xpoDMuk/r3D2fbQhmcqyFH
	 OWAtYF6lOm9wSGnn6GAibhwXPooO38QdMZ27m1W8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405003AbfHBJmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404986AbfHBJmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:42:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51712173E;
        Fri,  2 Aug 2019 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738969;
        bh=cq3po24IzPnFbopWCD/dSWmd2JNvYqSC8uQEjnVlWEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kffxoh9CSlMmBp2OZzlm3W7JjF/YGWHQCC19APkNBxVZlPMEPmJrast68IuxlMUN0
         /ny5ekN7GSXOZcGVv92KCLRM049WUVyIpqqWeBn++vP5UASxkJ7t/PWl1eTa0ho8O0
         vVCKfu84JMhVPffKcyKhAxoNEWsOdmcfll+arY4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 051/223] media: coda: increment sequence offset for the last returned frame
Date:   Fri,  2 Aug 2019 11:34:36 +0200
Message-Id: <20190802092242.199403362@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
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
index 1b8024f86b0f..df4643956c96 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -1967,6 +1967,9 @@ static void coda_finish_decode(struct coda_ctx *ctx)
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



