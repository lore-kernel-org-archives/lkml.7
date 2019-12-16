Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79355C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CDA206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520710;
	bh=fNccwqWA+SRuS5QnXcv5KmJy7FvExzlUIFIQAkUaYT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MNggt5Om7CqT2y+Uvemp/OX/0vVTAIaPMJWG4roeQ5pHh1vFVN+DFB1x6DzvHto7Z
	 rKkrc2NlhQe6Nznfchotumu60lbbpjPHedEYlbD2+p1kwhiF63HUq2G0sjjsulJO7v
	 loBYn01lbZl7Eo2pNQJFR6DKUyst+WSCTw3aGPqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbfLPSZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731463AbfLPSS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:18:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA9620717;
        Mon, 16 Dec 2019 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520305;
        bh=fNccwqWA+SRuS5QnXcv5KmJy7FvExzlUIFIQAkUaYT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISreGVuwUH+dcYoJPLu3HKzIn5q9Ppwfxu7xtGP8rIIeMwHs52Cq054QZ5ZHwSn02
         y0vG9E4eKC3gKRCfsoVxqdi3T9Ev4QTOneSO8+IXfuNwl+u1OQJCbkPhX6P3OTpy5+
         3B1S2f0zfJ4JrIhYC+MYnpn2HGfrtnC8cIX4kdTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 5.4 101/177] media: bdisp: fix memleak on release
Date:   Mon, 16 Dec 2019 18:49:17 +0100
Message-Id: <20191216174841.065452598@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 11609a7e21f8cea42630350aa57662928fa4dc63 upstream.

If a process is interrupted while accessing the video device and the
device lock is contended, release() could return early and fail to free
related resources.

Note that the return value of the v4l2 release file operation is
ignored.

Fixes: 28ffeebbb7bd ("[media] bdisp: 2D blitter driver using v4l2 mem2mem framework")
Cc: stable <stable@vger.kernel.org>     # 4.2
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -651,8 +651,7 @@ static int bdisp_release(struct file *fi
 
 	dev_dbg(bdisp->dev, "%s\n", __func__);
 
-	if (mutex_lock_interruptible(&bdisp->lock))
-		return -ERESTARTSYS;
+	mutex_lock(&bdisp->lock);
 
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 


