Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB9C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052DB20652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100165;
	bh=dtCy8NxLywADGR3g1b1WIkbIHMEPVPieh+HB0Gs1iyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iy/cdjQCuB23SFMQnCQjcHUadxDqYS3w4bBTyvNOxTowt+grMZZnRCm6lU9KtgpR6
	 +ZPInhYW79BpuMVUxVy5jIW3uw3Xe/LMJa1teKt3fJxN4pfXXDF/BCyW3ZDAIwLKgd
	 g42+DuN6DMcSB53c9nVHdK2qfVst3CRl1zczZILs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbfFIRJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388549AbfFIREF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:04:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C14206C3;
        Sun,  9 Jun 2019 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099845;
        bh=dtCy8NxLywADGR3g1b1WIkbIHMEPVPieh+HB0Gs1iyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujUO1S49uyOhw49FcuIM11aU7ZDgKS57zUlaQl3YSDBPuAvDyS1Kwx3xiR4eBHQqJ
         65RV4PN/86/CRNsOY/3OWLthGyMiUDqy3+JBOGoHx9jPubqft49jeRUvH1GyzZopVA
         weIc/xuSTHFqzLrgqShh1ItPzuSThZs22W0+fTK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 142/241] extcon: arizona: Disable mic detect if running when driver is removed
Date:   Sun,  9 Jun 2019 18:41:24 +0200
Message-Id: <20190609164151.883673434@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 00053de52231117ddc154042549f2256183ffb86 ]

Microphone detection provides the button detection features on the
Arizona CODECs as such it will be running if the jack is currently
inserted. If the driver is unbound whilst the jack is still inserted
this will cause warnings from the regulator framework as the MICVDD
regulator is put but was never disabled.

Correct this by disabling microphone detection on driver removal and if
the microphone detection was running disable the regulator and put the
runtime reference that was currently held.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-arizona.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index e4890dd4fefd6..38fb212e58ee8 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1616,6 +1616,16 @@ static int arizona_extcon_remove(struct platform_device *pdev)
 	struct arizona_extcon_info *info = platform_get_drvdata(pdev);
 	struct arizona *arizona = info->arizona;
 	int jack_irq_rise, jack_irq_fall;
+	bool change;
+
+	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
+				 ARIZONA_MICD_ENA, 0,
+				 &change);
+
+	if (change) {
+		regulator_disable(info->micvdd);
+		pm_runtime_put(info->dev);
+	}
 
 	gpiod_put(info->micd_pol_gpio);
 
-- 
2.20.1



