Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ACFC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6448E208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329540;
	bh=wjkpr/14v1CkGVKBhiwrjp4lLr83I2wIJtZFg1HOnmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2cYNLjcGKQljU/2dSO1LaRV1ipjMThTz6M0oRDM+M8VExiWGz/IZkslZ20t10BB6M
	 UF/grOCfugHKs+3CrGDYek6KUcsZ2kTg3tjU6j76xoei+jayTIu23P4Ah2RwEo1oKJ
	 iyppyzNKPT1SEKn324xMHzszvDgvUKP3iXKT8Ov0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfD0Bnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfD0Bnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45447216B7;
        Sat, 27 Apr 2019 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329428;
        bh=wjkpr/14v1CkGVKBhiwrjp4lLr83I2wIJtZFg1HOnmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LV6F/KdyAhIvvyoDctcJuwa9pBndEfoMR6aR+z5pYNWIBWUG8RH4Vu81vt9qFu3VK
         0/3ZWS+mGYvX9eCLSUlfMx1DiM9nnE9zvDvlbO90mXmeOzaX5939d5SA6U6vdrmIHv
         wW5sbbtzm5WfJ3Au4P3LMOobD74rQ2AyXr2IZxfo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 12/16] drm/mediatek: fix possible object reference leak
Date:   Fri, 26 Apr 2019 21:43:20 -0400
Message-Id: <20190427014325.8704-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014325.8704-1-sashal@kernel.org>
References: <20190427014325.8704-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 2ae2c3316fb77dcf64275d011596b60104c45426 ]

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
drivers/gpu/drm/mediatek/mtk_hdmi.c:1521:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1509, but without a corresponding object release within this function.
drivers/gpu/drm/mediatek/mtk_hdmi.c:1524:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1509, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 200f75e1d619..e7a6651ceeab 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1528,6 +1528,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	of_node_put(remote);
 
 	hdmi->ddc_adpt = of_find_i2c_adapter_by_node(i2c_np);
+	of_node_put(i2c_np);
 	if (!hdmi->ddc_adpt) {
 		dev_err(dev, "Failed to get ddc i2c adapter by node\n");
 		return -EINVAL;
-- 
2.19.1

