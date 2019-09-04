Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D3C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C91233A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567600240;
	bh=tD3boTU6F/lowP4lob9UG30ETc5Ui2Iye/1UdKjFcIk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=C1EX2etP6XnkNkaHCOTYZDwdmircOczjiiuSTI0SPUnaw3+76GOW5rg+CohP3XtUY
	 y2fZSpqBJJ7SUqeHvNPdm6bux+YGN+myatXp2tGqSn4zTQTGDvHCAX5BcQW2yQFs9r
	 dXcBaMi2QkNtfJgSF+vyHGR0b9WHbq+3U2NPr1WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfIDMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:30:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfIDMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/BsOG3t1AtJ5lMidOZwhIOXQj5VBbo4erwS718yjdc=; b=R+3E/74urBfbdKLa0LkBouwQU
        82f/5/S15HmEO89PYuLHVCX06uO6Wz8UzeBYsQbrmSvLx4fZx7caz6juXIO0MA9kbjanRyfwYwk1t
        X60CYJj2Yx19r7Z29FAOmwm/jdiM7aUtzU5NmSCtATR9jMg38QTczNdolNhSUKms3sMyk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5UQk-0005VG-SA; Wed, 04 Sep 2019 12:30:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9E7B92742B45; Wed,  4 Sep 2019 13:30:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
Date:   Wed,  4 Sep 2019 13:30:32 +0100
Message-Id: <20190904123032.23263-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panfrost driver requests a supply using regulator_get_optional()
but both the name of the supply and the usage pattern suggest that it is
being used for the main power for the device and is not at all optional
for the device for function, there is no meaningful handling for absent
supplies.  Such regulators should use the vanilla regulator_get()
interface, it will ensure that even if a supply is not described in the
system integration one will be provided in software.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 46b0b02e4289..238fb6d54df4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -89,12 +89,9 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 {
 	int ret;
 
-	pfdev->regulator = devm_regulator_get_optional(pfdev->dev, "mali");
+	pfdev->regulator = devm_regulator_get(pfdev->dev, "mali");
 	if (IS_ERR(pfdev->regulator)) {
 		ret = PTR_ERR(pfdev->regulator);
-		pfdev->regulator = NULL;
-		if (ret == -ENODEV)
-			return 0;
 		dev_err(pfdev->dev, "failed to get regulator: %d\n", ret);
 		return ret;
 	}
@@ -110,8 +107,7 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 
 static void panfrost_regulator_fini(struct panfrost_device *pfdev)
 {
-	if (pfdev->regulator)
-		regulator_disable(pfdev->regulator);
+	regulator_disable(pfdev->regulator);
 }
 
 int panfrost_device_init(struct panfrost_device *pfdev)
-- 
2.20.1

