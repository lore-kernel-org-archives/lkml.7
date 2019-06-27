Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B2C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190412184B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595642;
	bh=we131unhgMQ7C3zOh8M9oe4r3AEFYopGa1hNQUNp3kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pC7ofeRS6Zk8b7uAsf2cRk2iw8bnxWX5+ewLpzo1y+fx1c5CRcvoQXxssAqEyAZSa
	 Y+jkdAVXAA34n8PZCCNJKtbp/EjjPJuVXm9CaLIXNXasEx8xKLj2sDWeZ0FdIdcPhZ
	 e6xQzFpSgPJuMPS26/lBT3EYz7dxHiboa0mQ1Dj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfF0AeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfF0Ad5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:33:57 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A883620815;
        Thu, 27 Jun 2019 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595635;
        bh=we131unhgMQ7C3zOh8M9oe4r3AEFYopGa1hNQUNp3kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oy441cvjLsUXPsV/jrbVyQBGMjzIsg0Joq0BJVsx84+2dTmXacuA4lp/HoMkHRE8D
         mWWAN0q0yo+nKp3RVdWg8q2yW0JT/AOQXOBBv22KhkxG75Q/NBc6JgbL0fGuFibG+F
         P1vJUMVpVcBKwCdQd5+aX25bhHxqV/JGv5byTbd8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Harsha Manjula Mallikarjun 
        <Harsha.ManjulaMallikarjun@in.bosch.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 62/95] gpu: ipu-v3: image-convert: Fix input bytesperline for packed formats
Date:   Wed, 26 Jun 2019 20:29:47 -0400
Message-Id: <20190627003021.19867-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Longerbeam <slongerbeam@gmail.com>

[ Upstream commit bca4d70cf1b8f6478a711c448a3a1e47b794b162 ]

The input bytesperline calculation for packed pixel formats was
incorrect. The min/max clamping values must be multiplied by the
packed bits-per-pixel. This was causing corrupted converted images
when the input format was RGB4 (probably also other input packed
formats).

Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline
adjustment")

Reported-by: Harsha Manjula Mallikarjun <Harsha.ManjulaMallikarjun@in.bosch.com>
Suggested-by: Harsha Manjula Mallikarjun <Harsha.ManjulaMallikarjun@in.bosch.com>
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 0d971985f8c9..19d3b85e0e98 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1942,7 +1942,9 @@ void ipu_image_convert_adjust(struct ipu_image *in, struct ipu_image *out,
 		clamp_align(in->pix.width, 2 << w_align_in, MAX_W,
 			    w_align_in) :
 		clamp_align((in->pix.width * infmt->bpp) >> 3,
-			    2 << w_align_in, MAX_W, w_align_in);
+			    ((2 << w_align_in) * infmt->bpp) >> 3,
+			    (MAX_W * infmt->bpp) >> 3,
+			    w_align_in);
 	in->pix.sizeimage = infmt->planar ?
 		(in->pix.height * in->pix.bytesperline * infmt->bpp) >> 3 :
 		in->pix.height * in->pix.bytesperline;
-- 
2.20.1

