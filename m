Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C6AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0E02339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567600302;
	bh=ry4+uEL6y1/PFOnObiPaS/O/MziqdOob7j7LL7DIx34=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N8Cwk43Fmh4OPcpsIiMj+PVfKhTtmjh6RxENix6mrcQ27aQO12Eb88lhjw6JcKf2p
	 oLycjPyiQREfbpV5vEGr2MivDmtvgVjCBEH4zXdXpblBX4rvx2189ETk4O/vJsBlS3
	 Qky9jRkavI5Tzi5N/jIV6Uq4te2hs+7rNufk7BeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfIDMbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:31:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfIDMbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GJQS4gJTNCVjRGvUWvcmKFiWyiK9BNAlq0ggTUPKG2o=; b=ouXJU2+HFB3fD9w9XNx7iYXQr
        uN9s5R5ySnQlfrHgHJtW/lRO1ROvRY5xiDQmCHnlKS3j4a9r8TsviII2WkgFg4GFMVnNSATisBxuw
        pXvCkBVR7AmBNyWHxdmMp3pW11wKlBXQXUplxXLcPjvA9NWQa2HkTjp9Vh9IXJ4WnG7D4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5URk-0005Vd-QN; Wed, 04 Sep 2019 12:31:36 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3017C2742B45; Wed,  4 Sep 2019 13:31:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] drm/lima: Fix regulator_get_optional() misuse
Date:   Wed,  4 Sep 2019 13:31:29 +0100
Message-Id: <20190904123129.23351-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lima driver requests a supply using regulator_get_optional() but
both the name of the supply and the usage pattern suggest that it is
being used for the main power for the device and is not at all optional
for the device for function, there is no meaningful handling for absent
supplies.  Such regulators should use the vanilla regulator_get()
interface, it will ensure that even if a supply is not described in the
system integration one will be provided in software.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpu/drm/lima/lima_device.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index d86b8d81a483..d718ac70df1e 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -142,12 +142,9 @@ static int lima_regulator_init(struct lima_device *dev)
 {
 	int ret;
 
-	dev->regulator = devm_regulator_get_optional(dev->dev, "mali");
+	dev->regulator = devm_regulator_get(dev->dev, "mali");
 	if (IS_ERR(dev->regulator)) {
 		ret = PTR_ERR(dev->regulator);
-		dev->regulator = NULL;
-		if (ret == -ENODEV)
-			return 0;
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev->dev, "failed to get regulator: %d\n", ret);
 		return ret;
@@ -164,8 +161,7 @@ static int lima_regulator_init(struct lima_device *dev)
 
 static void lima_regulator_fini(struct lima_device *dev)
 {
-	if (dev->regulator)
-		regulator_disable(dev->regulator);
+	regulator_disable(dev->regulator);
 }
 
 static int lima_init_ip(struct lima_device *dev, int index)
-- 
2.20.1

