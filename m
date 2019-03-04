Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C13C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A843E208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688593;
	bh=HptPSwDUNWSjIPkdnFjlSzqHwtQ3/yXZmPuLzSEpXrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cmMxXeAYmCIPMsCaqtkmYJENEj6JUulmwgl4808V79sbdlAU0kJhcBKFEEURFeDP
	 JI5JIUTUBIjtD/acJ1QFnAHgRkYIEIB7a0GMVM0xF5j8ca/WaITWXsE17xHvi4qFRH
	 eF+pHQIM4Qg59km+ThTixdrtvaA5BvyffMOmfpOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfCDIgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfCDIg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE6B208E4;
        Mon,  4 Mar 2019 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688588;
        bh=HptPSwDUNWSjIPkdnFjlSzqHwtQ3/yXZmPuLzSEpXrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g//PSXai80BUx+u1TlBgXnSoWc5UTDJDhQLPNK/6loROrXMbfqHylvnuimhUnz+DV
         54Ef+UJgggJW0cjdWF/x5YqBTvPkhFh1raYCY6h7IghSkVnp2koks0Zo4+MW0PjEev
         3gYsYgkubetX9UDyCSgh1J5AMCaoAQCf0YG09d3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 56/88] drm/msm: Fix A6XX support for opp-level
Date:   Mon,  4 Mar 2019 09:22:39 +0100
Message-Id: <20190304081632.752040361@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index d4e98e5876bc4..00b2e6e94689f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -939,7 +939,7 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
 	np = dev_pm_opp_get_of_node(opp);
 
 	if (np) {
-		of_property_read_u32(np, "qcom,level", &val);
+		of_property_read_u32(np, "opp-level", &val);
 		of_node_put(np);
 	}
 
-- 
2.19.1



