Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0330CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B4E20718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641611;
	bh=XWc3QtLsRVtPJY1lvZDiy5eR0heE6icEBNbltk31v/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NodmfkPMjOAVyJ6u0b06Wlj4PNw20drCdoTw3ICwFChrjtWwbB5qkIo548G35nHpw
	 pxfABxD3j/gAANTGvrB8GoUjzez+cN+IjrmMWfflkXFItlZO0xzvh8E6bWw4FL422A
	 xXYj1Ua25NE0xO3SMHTuw0OIZcnH1MMpVCHC/vUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfL2Rqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbfL2Rqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:46:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29A1206A4;
        Sun, 29 Dec 2019 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641598;
        bh=XWc3QtLsRVtPJY1lvZDiy5eR0heE6icEBNbltk31v/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIIrm07Me/GGAQ6BmLNBXGVW5UsZyZiOO1Yf4O3UuHTNEJ3sebobhasCyaG3BbDJN
         i+HkwOzOzfI3OqdAzjjOooWHCUKsdJAUg9hYm6HKLjYoKN2DM2MHNEWMUDfF3rIN4k
         wkAssVT/Zfw2x0Vw6m632qDK3UOsmpNW76TPp5AY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 131/434] media: ti-vpe: vpe: fix a v4l2-compliance failure causing a kernel panic
Date:   Sun, 29 Dec 2019 18:23:04 +0100
Message-Id: <20191229172710.405457190@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

[ Upstream commit a37980ac5be29b83da67bf7d571c6bd9f90f8e45 ]

v4l2-compliance fails with this message:

   warn: v4l2-test-formats.cpp(717): \
   	TRY_FMT cannot handle an invalid pixelformat.
   test VIDIOC_TRY_FMT: FAIL

This causes the following kernel panic:

Unable to handle kernel paging request at virtual address 56595561
pgd = ecd80e00
*pgd=00000000
Internal error: Oops: 205 [#1] PREEMPT SMP ARM
...
CPU: 0 PID: 930 Comm: v4l2-compliance Not tainted \
	4.14.62-01715-gc8cd67f49a19 #1
Hardware name: Generic DRA72X (Flattened Device Tree)
task: ece44d80 task.stack: ecc6e000
PC is at __vpe_try_fmt+0x18c/0x2a8 [ti_vpe]
LR is at 0x8

Because the driver fails to properly check the 'num_planes' values for
proper ranges it ends up accessing out of bound data causing the kernel
panic.

Since this driver only handle single or dual plane pixel format, make
sure the provided value does not exceed 2 planes.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/ti-vpe/vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index 2b731c8f5459..7b321c3b594f 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -1629,7 +1629,7 @@ static int __vpe_try_fmt(struct vpe_ctx *ctx, struct v4l2_format *f,
 			      &pix->height, MIN_H, MAX_H, H_ALIGN,
 			      S_ALIGN);
 
-	if (!pix->num_planes)
+	if (!pix->num_planes || pix->num_planes > 2)
 		pix->num_planes = fmt->coplanar ? 2 : 1;
 	else if (pix->num_planes > 1 && !fmt->coplanar)
 		pix->num_planes = 1;
-- 
2.20.1



