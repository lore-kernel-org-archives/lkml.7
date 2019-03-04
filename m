Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E75C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1913620830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551657998;
	bh=AphbqnMLTdVz7EvYe4BH/Ut1IPA89ZgaqffLOYkoFPg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BpDtlFC3OOvqbX6Pb3NHlsIll0nFfy0clcgk1lt814RuVtdV8XYrS7fkZHUgheXnD
	 cDijQYbt7JVVtxY8gKdlwM3pOXR13IdI7QlWg/Qls+OIbBBNgfhfUJmInLLTH042Xv
	 EBX96RUWveRhIyW+VfaXzC4/F+WYitlZDWAloT1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCDAGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCDAGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7k9wM79Fabb7fqwJfEYF6QJtYUVUnLJ6pepKFDL+pW4=; b=TYByjNfp4ddf
        UVECaehG4/tkv3gpz4AT9/6kW1gGYqei0QhA9ttmYPVrByo6prVQGSZqj7hfk7dYCcnh1qoWqUNEX
        coSvvQ4NZLwydf42uQPvkMvvYpUZp11zwT5tscwOeWLjR73K5XxepNv13JO/poiTrqwf2DCwK1X5Z
        guqL8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7n-0007PY-RY; Mon, 04 Mar 2019 00:06:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 10931440082; Mon,  4 Mar 2019 00:06:31 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: palmas: Constify palmas_smps_ramp_delay array" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000631.10931440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: palmas: Constify palmas_smps_ramp_delay array

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From ad542a527c9a4d9088da3a0977c7508266229f07 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 1 Mar 2019 22:20:16 +0800
Subject: [PATCH] regulator: palmas: Constify palmas_smps_ramp_delay array

The palmas_smps_ramp_delay array should never modify, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/palmas-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index c2cc392a27d4..7fb9e8dd834e 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -382,7 +382,7 @@ static struct palmas_sleep_requestor_info tps65917_sleep_req_info[] = {
 	EXTERNAL_REQUESTOR_TPS65917(LDO5, 2, 4),
 };
 
-static unsigned int palmas_smps_ramp_delay[4] = {0, 10000, 5000, 2500};
+static const unsigned int palmas_smps_ramp_delay[4] = {0, 10000, 5000, 2500};
 
 #define SMPS_CTRL_MODE_OFF		0x00
 #define SMPS_CTRL_MODE_ON		0x01
-- 
2.20.1

