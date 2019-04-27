Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E94EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331AE2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329671;
	bh=MEUiINpsFscEIsjs2pJxEg/l9lXEFYfa7GRg9YN8qk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTpteJk/Dj07fPdNM1OOkG4uXAmgrmunxvW7HI4Rk2HFy5ILZrwXyMZfGUJZI/IZ+
	 DidZYoMCyPDPHGsS1xnXCSvDFh8yW4r+4vE6HSYOIvhcqBNksvAWNLBIe3cJ2ILTzp
	 Zd+xm2K2gWQgC5hna2uJRVUIhum0c+wl4UkNSv/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfD0Bru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbfD0Bmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0DA2146E;
        Sat, 27 Apr 2019 01:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329365;
        bh=MEUiINpsFscEIsjs2pJxEg/l9lXEFYfa7GRg9YN8qk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYaUiEKeti1SJbVZf8pNJjq5CuNP/zNSBraOr5ABIonezgmyE2xrSv6bD5YFaJggP
         eZOipyLtgULdEu4ZCtJKppbpXq8OCk6+fwjY/HyQ09WnPJugxu7YllriEwp084WopH
         xD5zkHYKZhelnPOeWpBMVEywLZaq5pnUaO2egmHw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 12/32] drm/mediatek: Fix an error code in mtk_hdmi_dt_parse_pdata()
Date:   Fri, 26 Apr 2019 21:42:03 -0400
Message-Id: <20190427014224.8274-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 2d85978341e6a32e7443d9f28639da254d53f400 ]

We don't want to overwrite "ret", it already holds the correct error
code.  The "regmap" variable might be a valid pointer as this point.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index aba27ea9cea5..a33a1918463d 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1473,7 +1473,6 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	if (IS_ERR(regmap))
 		ret = PTR_ERR(regmap);
 	if (ret) {
-		ret = PTR_ERR(regmap);
 		dev_err(dev,
 			"Failed to get system configuration registers: %d\n",
 			ret);
-- 
2.19.1

