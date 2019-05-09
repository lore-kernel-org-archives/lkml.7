Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F7BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C33217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427495;
	bh=nSpBTyDk2DUiuG8wLuyLlpbmf0GF6juv+6YT6PlGsxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tKaMRRbGBIRuYp0/lJKU2yel5EkURd+jMec91r56PcKunKFxNDJGcWT77JnJD1ozU
	 D9X3tU58XnZ4wGbvJdXpn9ASPfVp8hde5Nv9bl5vJgd5PDSrWEu2n3b/wm4inJ+KH9
	 wHv16EYMGXy0hfb7/sLJa0DpdqqWUkgMnxtbuycQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfEISoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfEISow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:44:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631EB217D6;
        Thu,  9 May 2019 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427491;
        bh=nSpBTyDk2DUiuG8wLuyLlpbmf0GF6juv+6YT6PlGsxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPwYe0ohKHJO383OEcmzk+Mb0XgnV8mmkvQWso1a6sNjfM75konZSs2U1MnTKeoku
         yuOSUKUqH62LFa7BmzvPfrQ+6VCMPju+QBDsXZQpi9C2npDo/CMkMZqzFoD3LpWmMQ
         Jw0aBhB04uHzIypsSCbw3AhdeSouNemNwwwO5FDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/28] drm/mediatek: Fix an error code in mtk_hdmi_dt_parse_pdata()
Date:   Thu,  9 May 2019 20:42:01 +0200
Message-Id: <20190509181252.212056811@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181247.647767531@linuxfoundation.org>
References: <20190509181247.647767531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 863d030786e52..200f75e1d6198 100644
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
2.20.1



