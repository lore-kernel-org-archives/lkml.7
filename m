Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F8DC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5189922B48
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004058;
	bh=zlLzjBEkrsdur7g63bERQIU76+VaQjQpuLBcs9wb7hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CcEiEDaPHk1x4gILeor4naz6xOgsnq2cZwYFg14vOPPIK67nC7Qqfqyjc/3X/Tw0i
	 ikvGoYVxP3VdiotC81sP5yhYTn13GozrW5xhHuDnxF9zyOAF6yoOdybalCHZdL5KIx
	 6uLxHpVBtYBaanMIP3Bg8EB3QylUO1Te63+AFbaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgABW1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbgABW1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:27:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F276B227BF;
        Thu,  2 Jan 2020 22:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004050;
        bh=zlLzjBEkrsdur7g63bERQIU76+VaQjQpuLBcs9wb7hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACJVMcIwS4+Xg0gaY9jfrrVYyVogpgf1t7pwgWS7jgePKzDw021ApnCYqcRsswHFG
         a1MHp58Lh/biwTFRn/R8gy/RWW97eE8/iiST/84Nx3EQVyddRrAZ1u0pCGjtmYK50j
         YcdtBa3IVTpxc5yRlMybRthiHRe6NuF0MmUkChtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Masney <masneyb@onstation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 008/171] drm/bridge: analogix-anx78xx: silence -EPROBE_DEFER warnings
Date:   Thu,  2 Jan 2020 23:05:39 +0100
Message-Id: <20200102220548.078950092@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Masney <masneyb@onstation.org>

[ Upstream commit 2708e876272d89bbbff811d12834adbeef85f022 ]

Silence two warning messages that occur due to -EPROBE_DEFER errors to
help cleanup the system boot log.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190815004854.19860-4-masneyb@onstation.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index a2a82366a771..eb97e88a103c 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -725,7 +725,9 @@ static int anx78xx_init_pdata(struct anx78xx *anx78xx)
 	/* 1.0V digital core power regulator  */
 	pdata->dvdd10 = devm_regulator_get(dev, "dvdd10");
 	if (IS_ERR(pdata->dvdd10)) {
-		DRM_ERROR("DVDD10 regulator not found\n");
+		if (PTR_ERR(pdata->dvdd10) != -EPROBE_DEFER)
+			DRM_ERROR("DVDD10 regulator not found\n");
+
 		return PTR_ERR(pdata->dvdd10);
 	}
 
@@ -1344,7 +1346,9 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 
 	err = anx78xx_init_pdata(anx78xx);
 	if (err) {
-		DRM_ERROR("Failed to initialize pdata: %d\n", err);
+		if (err != -EPROBE_DEFER)
+			DRM_ERROR("Failed to initialize pdata: %d\n", err);
+
 		return err;
 	}
 
-- 
2.20.1



