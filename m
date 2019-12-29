Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F1020718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641461;
	bh=KYV3TvSzgFQ9+R61pPWa/09LsyaccchKA+de+OED69k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgRz9x/5YzjHOq//B6rlLO9zpxzf4c9ABY8RkUwmflUiSU+aKP9zUIZLDLY1r51xA
	 oVBZZAFTEVlmlEpdAzxGBNlL1Xrl/OrRD3i8Kr7YisqoM/ogvFoCilLvpsC2dukn9+
	 +C1U5NF7KjQOCrc6RGRnfe2LEPY+EDxtH032oZcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfL2RoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730656AbfL2RoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:44:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E10E206A4;
        Sun, 29 Dec 2019 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641457;
        bh=KYV3TvSzgFQ9+R61pPWa/09LsyaccchKA+de+OED69k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdkCOaIBS6yUEtWVKZ8FMO7DQrGrqwo0NLNUYP8UZXUBpDqqQxByg4PKsb51Nf47A
         Xhfjnmpdk68BJ2ZSVrBLzvBotZa7fKJp1Wnc4J66+9D1s2h3HzryvDpBGClqYGW5li
         dHhFs0HkCUTh5OXr+kZ/sYBp1rhBFObIsOs8wH6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 074/434] media: am437x-vpfe: Setting STD to current value is not an error
Date:   Sun, 29 Dec 2019 18:22:07 +0100
Message-Id: <20191229172706.563012528@linuxfoundation.org>
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

[ Upstream commit 13aa21cfe92ce9ebb51824029d89f19c33f81419 ]

VIDIOC_S_STD should not return an error if the value is identical
to the current one.
This error was highlighted by the v4l2-compliance test.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Acked-by: Lad Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/am437x/am437x-vpfe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
index 2b42ba1f5949..e13dbf27a9c2 100644
--- a/drivers/media/platform/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/am437x/am437x-vpfe.c
@@ -1830,6 +1830,10 @@ static int vpfe_s_std(struct file *file, void *priv, v4l2_std_id std_id)
 	if (!(sdinfo->inputs[0].capabilities & V4L2_IN_CAP_STD))
 		return -ENODATA;
 
+	/* if trying to set the same std then nothing to do */
+	if (vpfe_standards[vpfe->std_index].std_id == std_id)
+		return 0;
+
 	/* If streaming is started, return error */
 	if (vb2_is_busy(&vpfe->buffer_queue)) {
 		vpfe_err(vpfe, "%s device busy\n", __func__);
-- 
2.20.1



