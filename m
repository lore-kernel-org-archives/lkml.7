Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF662C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEC820836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688248;
	bh=kFz/SwL53mt/Lfk3BxFLd98yrdH1rPesIxuQwF3XFk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tQJ4XLI+VuRPeD2Uj4OMBMbYtx4Mmr/xb5boyTGgwauJ6uR3fm0S2SCJc6x7ypmNX
	 Y8YNbLRxJztjHGVdP2szWVaUwl9laYujAhjvMUFBqQrK7ZjJsZcHHaHMSM/8Uo+YhK
	 5m8QIMtRp6KSK7iFOSBHvzBBvFIzT3DTnDcn6IEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCDIar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfCDIao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 591FF20823;
        Mon,  4 Mar 2019 08:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688243;
        bh=kFz/SwL53mt/Lfk3BxFLd98yrdH1rPesIxuQwF3XFk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioQ6KQNSPvI+HURRxl2FgUN3h96YFqWsI3XIdbA9b992tcEdV8ibXmVw+4K+pd895
         vhdmBLnoNFwjcQE20FJ3aY2s+kalr0O1AecH7luKha6ninAdVbjvCzaeaHIb/oizyC
         vVHExPpnbGVsfiSEAYqAXKxtBo9ow5+KS9DpmMzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 55/78] drm/msm: Fix A6XX support for opp-level
Date:   Mon,  4 Mar 2019 09:22:38 +0100
Message-Id: <20190304081627.956823753@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a3c5e2cd79753121f49a8662c1e0a60ddb5486ca ]

The bindings for Qualcomm opp levels changed after being Acked but
before landing.  Thus the code in the GPU driver that was relying on
the old bindings is now broken.

Let's change the code to match the new bindings by adjusting the old
string 'qcom,level' to the new string 'opp-level'.  See the patch
("dt-bindings: opp: Introduce opp-level bindings").

NOTE: we will do additional cleanup to totally remove the string from
the code and use the new dev_pm_opp_get_level() but we'll do it in a
future patch.  This will facilitate getting the important code fix in
sooner without having to deal with cross-maintainer dependencies.

This patch needs to land before the patch ("arm64: dts: sdm845: Add
gpu and gmu device nodes") since if a tree contains the device tree
patch but not this one you'll get a crash at bootup.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index bbb8126ec5c57..9acb9dfaf57e6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -896,7 +896,7 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
 	np = dev_pm_opp_get_of_node(opp);
 
 	if (np) {
-		of_property_read_u32(np, "qcom,level", &val);
+		of_property_read_u32(np, "opp-level", &val);
 		of_node_put(np);
 	}
 
-- 
2.19.1



