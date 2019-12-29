Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96669222C3
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641836;
	bh=wxWokD7qX8ObbSGfUeBzRBPGheUjceHaKaspRyyulB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=12TL+DOeFb3jh23qxvIhNwyYaj1PCdTxJ3kAy49Mrn6jGPcO31r0q1zm6kp53IV63
	 yUs/kajiZB8D5jfZ3ny4gDAIqa8hXG/NpmZQH6XGcX0i8u0up/rcI32OKatPayu/dv
	 js9ky8lmOp4odL6gBGLnxhXEVSaakNAaGy4BrjwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfL2Ruf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:50:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731446AbfL2Rud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:50:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C802253D;
        Sun, 29 Dec 2019 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641833;
        bh=wxWokD7qX8ObbSGfUeBzRBPGheUjceHaKaspRyyulB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxKfEQsvIM+qnS+4WNjwE3+1uI65WF7DPIxmnEoSK3e781BjBoe8TqcvtgJdzuS5+
         CIl44hok7zoh2wJXYJxVz35VFXyk5jiY/JlG/qRuTQmJtoghvZsvAbliaRbeqFdLZm
         UUL7465XAaeZBOVaqXzadSY2FvvNmR2z0MFBldJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 228/434] media: rcar_drif: fix a memory disclosure
Date:   Sun, 29 Dec 2019 18:24:41 +0100
Message-Id: <20191229172717.010498022@linuxfoundation.org>
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

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit d39083234c60519724c6ed59509a2129fd2aed41 ]

"f->fmt.sdr.reserved" is uninitialized. As other peer drivers
like msi2500 and airspy do, the fix initializes it to avoid
memory disclosures.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_drif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/rcar_drif.c
index 608e5217ccd5..0f267a237b42 100644
--- a/drivers/media/platform/rcar_drif.c
+++ b/drivers/media/platform/rcar_drif.c
@@ -912,6 +912,7 @@ static int rcar_drif_g_fmt_sdr_cap(struct file *file, void *priv,
 {
 	struct rcar_drif_sdr *sdr = video_drvdata(file);
 
+	memset(f->fmt.sdr.reserved, 0, sizeof(f->fmt.sdr.reserved));
 	f->fmt.sdr.pixelformat = sdr->fmt->pixelformat;
 	f->fmt.sdr.buffersize = sdr->fmt->buffersize;
 
-- 
2.20.1



