Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F87C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDFD20861
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="WPR/5ZoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfFORQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 13:16:48 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:54290 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfFORQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 13:16:48 -0400
X-Greylist: delayed 2592 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Jun 2019 13:16:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eOiWl8p2TWN6Uxy14AMrR2XP1Yr3a8JbfAQfRrrCR5U=; b=WPR/5ZoQSEu+cvcRoNTd3f9IR0
        FMs7Tx0pZZ6ekv4taD6McaZO2x1aq/h5dQHJ2b6tnyLHObewXebdzvYjSY66u9U/5fxKCtbuug1Kb
        T3LEvIXb5DzPBf/3Jx/leBnkcGVUEyWflWP8biPABHeXgtW0ndX50jqveC1BHwk9ZMLM=;
Received: from p200300ccff3e33001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff3e:3300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hcBcP-0005bp-QY; Sat, 15 Jun 2019 18:33:29 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1hcBcP-0007Tk-EP; Sat, 15 Jun 2019 18:33:29 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com,
        vireshk@kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Date:   Sat, 15 Jun 2019 18:33:14 +0200
Message-Id: <20190615163314.28173-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_opp_supported_by_regulators() wrongly ignored errors from
regulator_is_supported_voltage(), so it considered errors as
success. Since
commit 498209445124 ("regulator: core: simplify return value on suported_voltage")
regulator_is_supported_voltage() returns a real boolean, so
errors make _opp_supported_by_regulators() return false.

The VDD1/VDD2 regulators on twl4030 are neither defined with
voltage lists nor with the continuous flag set, so
regulator_is_supported_voltage() returns false and an error
before above mentioned commit (which was considered success)
The result is that after the above mentioned commit cpufreq
does not work properly e.g. dm3730.

[    2.490997] core: _opp_supported_by_regulators: OPP minuV: 1012500 maxuV: 1012500, not supported by regulator
[    2.501617] cpu cpu0: _opp_add: OPP not supported by regulators (300000000)
[    2.509246] core: _opp_supported_by_regulators: OPP minuV: 1200000 maxuV: 1200000, not supported by regulator
[    2.519775] cpu cpu0: _opp_add: OPP not supported by regulators (600000000)
[    2.527313] core: _opp_supported_by_regulators: OPP minuV: 1325000 maxuV: 1325000, not supported by regulator
[    2.537750] cpu cpu0: _opp_add: OPP not supported by regulators (800000000)

The patch fixes declaration of VDD1/2 regulators.

Fixes: 498209445124 ("regulator: core: simplify return value on suported_voltage")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/regulator/twl-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 6fa15b2d6fb3..f7bfdf53701d 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -478,6 +478,7 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		.enable_time = turnon_delay, \
+		.continuous_voltage_range = true, \
 		.of_map_mode = twl4030reg_map_mode, \
 		}, \
 	}
-- 
2.20.1

