Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD61C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667DD2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015914;
	bh=tzIWuL4I+oLhLcnJ0dkLgbGro6s7v09DuAocLYhOiF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQMvDFz4LP4Kuj+PpeTCMoKkIuIoOAGDSBZDzjdL+Iu4AX3usZ/Rp4m4wFfzh/+YE
	 eJdezpDfPpFi481OL69YXFWfjnAAK5VvCWBPhCjBQaWzKFpPx296MEo2frU6kJvp32
	 OjAom/n4fUKOurV9etqeyOItRIyXOfvMGByw5NPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfLJWLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbfLJWDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:03:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D5A52053B;
        Tue, 10 Dec 2019 22:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015427;
        bh=tzIWuL4I+oLhLcnJ0dkLgbGro6s7v09DuAocLYhOiF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1G1ikLGeJEIZrQ7WdiOWSD74Tk2KDEdKlzQLFoSsOrMwePqia/9rJxAI3xh8dor/
         NMkWhoiizmOqRB4dzsWYWEnQhA66uJIP5WUlXxE20k2NxgjXBc/7BdtS9qmSQr4TT0
         WP7sA674iSxFPTo9mcAnxjRlENAhDUujXsvt+p/E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benoit Parrot <bparrot@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 038/130] media: ti-vpe: vpe: fix a v4l2-compliance failure causing a kernel panic
Date:   Tue, 10 Dec 2019 17:01:29 -0500
Message-Id: <20191210220301.13262-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
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
index a136fb14bf1a7..5adafee98e4c4 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -1663,7 +1663,7 @@ static int __vpe_try_fmt(struct vpe_ctx *ctx, struct v4l2_format *f,
 			      &pix->height, MIN_H, MAX_H, H_ALIGN,
 			      S_ALIGN);
 
-	if (!pix->num_planes)
+	if (!pix->num_planes || pix->num_planes > 2)
 		pix->num_planes = fmt->coplanar ? 2 : 1;
 	else if (pix->num_planes > 1 && !fmt->coplanar)
 		pix->num_planes = 1;
-- 
2.20.1

