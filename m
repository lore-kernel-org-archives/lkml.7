Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F144C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7479820873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572274608;
	bh=R7BCORMt4cTpOpTSUkGRHLf+t0urkhRt64HyvYMbeMc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Q10nL9duAkehuKehqhO4hkMt0PA8EgFEF0jUSFDEHmnL82VYwFpjdYWc40jL2dy92
	 DcgK/PC5Vg2ozXRt4QYXsg1CQYMmyKrthtoWO2R1pfMYR/m1VTn9+BU9QoFAiHZ9ni
	 ghaamDvKgx7VinGfB8p8fcIgdjKWu6vtWRr6Ucn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390424AbfJ1O4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:56:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39792 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfJ1O4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gMtkHpqXbGd8zJxTWU55ZYO4wyxUyNeuiQJC1jr7G1M=; b=NkdZHt8S2j1p
        MklXpynJjMwDROUGXKqyicL/iSsYOTEJSfN9mv8x3yCAWY+vD6cP/YmgeBq1UuKjSNWsTXHAldBlp
        1FlSfk/R+6WoxkC++64MsSJ7vUi1t+TigYpnjVYVh4SNKWwpB8AnHCZH3/tazb3YXJ4KBkVX7RlNK
        5VmuM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iP6Rp-0008TB-4O; Mon, 28 Oct 2019 14:56:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9B28627403E4; Mon, 28 Oct 2019 14:56:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Allow generic coupling only for always-on regulators" to the regulator tree
In-Reply-To: <20191025002240.25288-2-digetx@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145644.9B28627403E4@ypsilon.sirena.org.uk>
Date:   Mon, 28 Oct 2019 14:56:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Allow generic coupling only for always-on regulators

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From e381bfe45a891a5894465f072c5bbf3ed3e33b8a Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 25 Oct 2019 03:22:40 +0300
Subject: [PATCH] regulator: core: Allow generic coupling only for always-on
 regulators

The generic voltage balancer doesn't work correctly if one of regulator
couples turns off. Currently there are no users in kernel for that case,
although let's explicitly show that this case is unsupported for those who
will try to use that feature.

Link: https://lore.kernel.org/linux-samsung-soc/20191008170503.yd6GscYPLxjgrXqDuCO7AJc6i6egNZGJkVWHLlCxvA4@z/
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20191025002240.25288-2-digetx@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a46be221dbdc..a5b2a9b02108 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4963,6 +4963,12 @@ static int generic_coupler_attach(struct regulator_coupler *coupler,
 		return -EPERM;
 	}
 
+	if (!rdev->constraints->always_on) {
+		rdev_err(rdev,
+			 "Coupling of a non always-on regulator is unimplemented\n");
+		return -ENOTSUPP;
+	}
+
 	return 0;
 }
 
-- 
2.20.1

