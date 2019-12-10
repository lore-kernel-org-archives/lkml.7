Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3161CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027A020828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014281;
	bh=lbtJZOvXmjk47Zc5OtErUJv/UdxnjO9bpPO32xW3jB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=az92nwaGbH+VUX1LBPkH8GlymqSuixuU2sHb6xqE7fccvCihslfyowkomO2hqvcmn
	 Fr9kziEwRAvvFCI4UY1zo4JOl4ILHF6jDjggj+uFaWDXVdzs4BEFbZaA1t/61l0Kau
	 KIDWdOwsKBCoX8geGXIQwJmhWuFP+0faNcw29zx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfLJVoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbfLJVdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3C622464;
        Tue, 10 Dec 2019 21:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013595;
        bh=lbtJZOvXmjk47Zc5OtErUJv/UdxnjO9bpPO32xW3jB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwO9+4otcC6XfgdJ75LVzUhJ11KNv3Ia33YJNZGB9QmcILuHtorOX4k5Ooc09laeC
         LShDpJfxDE+1vYCqYzX3M7crkvpE3PEzcCv0Qg1MVatHHIL9U1et3mLeCQD9cUWB83
         yNWoTt15IrXYdl0bEUd0AJSAjG3DYUXxNFLVJF0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benoit Parrot <bparrot@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 045/177] media: ti-vpe: vpe: fix a v4l2-compliance failure causing a kernel panic
Date:   Tue, 10 Dec 2019 16:30:09 -0500
Message-Id: <20191210213221.11921-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index ca9095b803097..54f0d9d3cc491 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -1646,7 +1646,7 @@ static int __vpe_try_fmt(struct vpe_ctx *ctx, struct v4l2_format *f,
 			      &pix->height, MIN_H, MAX_H, H_ALIGN,
 			      S_ALIGN);
 
-	if (!pix->num_planes)
+	if (!pix->num_planes || pix->num_planes > 2)
 		pix->num_planes = fmt->coplanar ? 2 : 1;
 	else if (pix->num_planes > 1 && !fmt->coplanar)
 		pix->num_planes = 1;
-- 
2.20.1

