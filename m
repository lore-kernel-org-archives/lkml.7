Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CBDC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21F821670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567600987;
	bh=JqRFubywZiN5OK3vqyin+E40kP1IiGoLOlhUy/dPWtc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=H2A+i7uMHP+uMJmFkUdWegbeU6ufLy6oxGf+fVt68xs72XR/3vLMBPeNt0Dx2vEfD
	 ixJMS0yWCGguKkUYRXXpLsHWZRK15CRJ/okZYpo2jakHrVS7AfKan9pGh9euSKgvjX
	 diUfZeP14Y0j6OEKWyOihz1u74kFhvfosOv2VF2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfIDMnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:43:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35990 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfIDMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kT6JiKSS9HwgRZeLeoXhpFd1kRtgRGK+0O09M9Xb7A4=; b=bLOgq8Hq7J4RrL6Ex2KHUEO52
        5CfCv2ZZeEOLWUyigJX9wVVFaEGiYFO6UlzH0P12zjIv9WTtjVe/mbHtpTEq+iTOPO6RLvzVQKYLn
        K3TkC3br3bLefWytp4Ztv6RY/+Gm6Y3MAnVsoszwYI0wvjhuWAeFbDHAMstUXIviLB0yE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5Ucq-0005XK-FK; Wed, 04 Sep 2019 12:43:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 925622742B45; Wed,  4 Sep 2019 13:43:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] regulator: Defer init completion for a while after late_initcall
Date:   Wed,  4 Sep 2019 13:42:50 +0100
Message-Id: <20190904124250.25844-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has no way of knowing when we have finished instantiating
drivers, between deferred probe and systems that build key drivers as
modules we might be doing this long after userspace has booted. This has
always been a bit of an issue with regulator_init_complete since it can
power off hardware that's not had it's driver loaded which can result in
user visible effects, the main case is powering off displays. Practically
speaking it's not been an issue in real systems since most systems that
use the regulator API are embedded and build in key drivers anyway but
with Arm laptops coming on the market it's becoming more of an issue so
let's do something about it.

In the absence of any better idea just defer the powering off for 30s
after late_initcall(), this is obviously a hack but it should mask the
issue for now and it's no more arbitrary than late_initcall() itself.
Ideally we'd have some heuristics to detect if we're on an affected
system and tune or skip the delay appropriately, and there may be some
need for a command line option to be added.

Signed-off-by: Mark Brown <broonie@kernel.org>
Tested-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/core.c | 42 +++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4a27a46ec6e7..340db986b67f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5644,7 +5644,7 @@ static int __init regulator_init(void)
 /* init early to allow our consumers to complete system booting */
 core_initcall(regulator_init);
 
-static int __init regulator_late_cleanup(struct device *dev, void *data)
+static int regulator_late_cleanup(struct device *dev, void *data)
 {
 	struct regulator_dev *rdev = dev_to_rdev(dev);
 	const struct regulator_ops *ops = rdev->desc->ops;
@@ -5693,17 +5693,8 @@ static int __init regulator_late_cleanup(struct device *dev, void *data)
 	return 0;
 }
 
-static int __init regulator_init_complete(void)
+static void regulator_init_complete_work_function(struct work_struct *work)
 {
-	/*
-	 * Since DT doesn't provide an idiomatic mechanism for
-	 * enabling full constraints and since it's much more natural
-	 * with DT to provide them just assume that a DT enabled
-	 * system has full constraints.
-	 */
-	if (of_have_populated_dt())
-		has_full_constraints = true;
-
 	/*
 	 * Regulators may had failed to resolve their input supplies
 	 * when were registered, either because the input supply was
@@ -5721,6 +5712,35 @@ static int __init regulator_init_complete(void)
 	 */
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_late_cleanup);
+}
+
+static DECLARE_DELAYED_WORK(regulator_init_complete_work,
+			    regulator_init_complete_work_function);
+
+static int __init regulator_init_complete(void)
+{
+	/*
+	 * Since DT doesn't provide an idiomatic mechanism for
+	 * enabling full constraints and since it's much more natural
+	 * with DT to provide them just assume that a DT enabled
+	 * system has full constraints.
+	 */
+	if (of_have_populated_dt())
+		has_full_constraints = true;
+
+	/*
+	 * We punt completion for an arbitrary amount of time since
+	 * systems like distros will load many drivers from userspace
+	 * so consumers might not always be ready yet, this is
+	 * particularly an issue with laptops where this might bounce
+	 * the display off then on.  Ideally we'd get a notification
+	 * from userspace when this happens but we don't so just wait
+	 * a bit and hope we waited long enough.  It'd be better if
+	 * we'd only do this on systems that need it, and a kernel
+	 * command line option might be useful.
+	 */
+	schedule_delayed_work(&regulator_init_complete_work,
+			      msecs_to_jiffies(30000));
 
 	return 0;
 }
-- 
2.20.1

