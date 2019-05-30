Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD78C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75448244A4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186896;
	bh=ZQFyU4cqT2U+b9/BORK7QRaVKcpBPZgIQWZKPkKE71M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jH+IFPYP9/pOs9gilsFdP4XYSTW0XqushA0PSAwpincwFlc0Oa5Vr/scgU5tMzSB4
	 EkClKcJAPsua3L3allY+Y8VDc/2O7FzWZOUhr88UYzAHHcjZlnwNtGT3MpqMBVyUaS
	 kH/+X/hJAOTsq8Yfv8/VmoNFObQ5MJ2OpxkMG7qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbfE3D2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731346AbfE3DTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:19:53 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2AB248E3;
        Thu, 30 May 2019 03:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186392;
        bh=ZQFyU4cqT2U+b9/BORK7QRaVKcpBPZgIQWZKPkKE71M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcoqZ7O9XxK8sSCszF0yyXmx81SmG9w986oSTSwr7CiJ30SurQQLonJ2lrABnlioD
         qLn+nzah+oUkEr6dHee7TEia7cV/2Wk9gC54SAp1AmK09ix9wAZvEgcOWWyOG/BS9q
         qu+qZrw5aVw8DJ30tujXPxSHVlekN1nPEldLUDvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 164/193] media: video-mux: fix null pointer dereferences
Date:   Wed, 29 May 2019 20:06:58 -0700
Message-Id: <20190530030510.795775492@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aeb0d0f581e2079868e64a2e5ee346d340376eae ]

devm_kcalloc may fail and return a null pointer. The fix returns
-ENOMEM upon failures to avoid null pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/video-mux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index ee89ad76bee23..eedc0b99a891e 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -242,9 +242,14 @@ static int video_mux_probe(struct platform_device *pdev)
 	vmux->active = -1;
 	vmux->pads = devm_kcalloc(dev, num_pads, sizeof(*vmux->pads),
 				  GFP_KERNEL);
+	if (!vmux->pads)
+		return -ENOMEM;
+
 	vmux->format_mbus = devm_kcalloc(dev, num_pads,
 					 sizeof(*vmux->format_mbus),
 					 GFP_KERNEL);
+	if (!vmux->format_mbus)
+		return -ENOMEM;
 
 	for (i = 0; i < num_pads - 1; i++)
 		vmux->pads[i].flags = MEDIA_PAD_FL_SINK;
-- 
2.20.1



