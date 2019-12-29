Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49ACC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C85620748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643451;
	bh=VTLNQnorb+Q48dR9ZWduuOkaRIp0D3kF5ikxKk+OapE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P9CxKVPMh3IA1lujlXNIt8Q5Hx7n7FcSEnk7fV/mHCpuKo1J1taUSplUUj/D9Q4Ui
	 avTzDVQokdy6A8bdkU4IJ8pPGjyOzvWUZda2cJ/fqWpTFpgh1VopKkeysqxpW6EAUJ
	 W+BdiF4HGG+7vXBqkMwaaPuxcygKB5jHYp2j090w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfL2SR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:17:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbfL2RXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:23:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C178E207FF;
        Sun, 29 Dec 2019 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640183;
        bh=VTLNQnorb+Q48dR9ZWduuOkaRIp0D3kF5ikxKk+OapE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xeLL6GqdpmAkxGmpg2vLvWYDTn4DGYHx639Lnahwy/Bo2gzbDBXpRv3PkpunS9SOP
         a0+tTh18AiMP81sbXlSMO7x07O85RXQxGnOpPmB8s3K60+tRXxsSBtVZKLAGXTLiSJ
         OVLd2GCpt+EYCQOEbbRfLl0/JvvbxEujzCLE/KIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 053/161] media: ti-vpe: vpe: Make sure YUYV is set as default format
Date:   Sun, 29 Dec 2019 18:18:21 +0100
Message-Id: <20191229162415.321591097@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

[ Upstream commit e20b248051ca0f90d84b4d9378e4780bc31f16c6 ]

v4l2-compliance fails with this message:

   fail: v4l2-test-formats.cpp(672): \
	Video Capture Multiplanar: TRY_FMT(G_FMT) != G_FMT
   fail: v4l2-test-formats.cpp(672): \
	Video Output Multiplanar: TRY_FMT(G_FMT) != G_FMT
	...
   test VIDIOC_TRY_FMT: FAIL

The default pixel format was setup as pointing to a specific offset in
the vpe_formats table assuming it was pointing to the V4L2_PIX_FMT_YUYV
entry. This became false after the addition on the NV21 format (see
above commid-id)

So instead of hard-coding an offset which might change over time we need
to use a lookup helper instead so we know the default will always be what
we intended.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Fixes: 40cc823f7005 ("media: ti-vpe: Add support for NV21 format")
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/ti-vpe/vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index 8a5c0d3e733e..a136fb14bf1a 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -2322,7 +2322,7 @@ static int vpe_open(struct file *file)
 	v4l2_ctrl_handler_setup(hdl);
 
 	s_q_data = &ctx->q_data[Q_DATA_SRC];
-	s_q_data->fmt = &vpe_formats[2];
+	s_q_data->fmt = __find_format(V4L2_PIX_FMT_YUYV);
 	s_q_data->width = 1920;
 	s_q_data->height = 1080;
 	s_q_data->nplanes = 1;
-- 
2.20.1



