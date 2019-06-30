Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F65C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE13221473
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDbK7S2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfF3VFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:05:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34419 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfF3VEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so7349209lfa.1;
        Sun, 30 Jun 2019 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OvHoOucTtPtgMGupRgibL0AaI8RRb9BuEbjOandQO8=;
        b=rDbK7S2YYJoIEfU4SJ2J9FsgAI8xbqlA+BBhF2cQh6Os6c655QCvniW9MjevmrsOsJ
         Ly44kRYJe2BK7NoQMKQ3NfMOAELjM/7oNQXu0lCpOuP6F3GRyMdNMOikoCD+HMJdmSWv
         /J4czIA33pLhjnpLRf489Pp9asxOpaP4xhqKZnxN/yUW0B4m4WjyfOwxfaCUkoUyoUM9
         MWf2x4S8braSBcw9bgqCNGDo0aGViQY6BCbBT1CYrgKmwZR6oQcF6qcvAgoA3plPu4wO
         KIltgT2SU9qbD8yxPpFEmCyQm/akEcpeFZ5na4+yfR60Tfgrs17jvtVOme5XsDLs/2bq
         Gvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OvHoOucTtPtgMGupRgibL0AaI8RRb9BuEbjOandQO8=;
        b=f+k0RuE0OezGXH4xa1gJUQWsTGOLSnkeQpW2qGUuO6olWGNw9EHKqamEV0SakZK+Ln
         LXM44EAazwlmb/skkNIeEgJcY9rigXif+QIMj8J4c5++FeUb/KpT3sQBml8yHPkmc/3G
         nusp0Qrdjam9kVZkfSTCyTYhfA9vCgdHgZ64QnxgK2NuqMQhGi6hBhMdU+RbWhRmBtbX
         KpEv9Npsshc8jB+T48T/RZVv/bZCZqN5kP23Iecs5fPsf2FO69lEbZUOU1qLfXzidjoO
         uyiIl/1K8SBv8Z/l2cahKmwV0oyOxLqIAgx1yQ2YN0k/XQ0Ao666K1Kx9AkjCrVsuz2e
         /IRg==
X-Gm-Message-State: APjAAAVWg3MSP2MvNcLoeg/H6DLiSMvpZNMwIrPy2jOtXyqaZXmGWJlF
        KxMwBz4SZNdYyX20kXI7g54=
X-Google-Smtp-Source: APXvYqxyrLZ85JeyLJ5xc4A+k1GrDjiaxpGZBeKSBLBqtOP1hfBGErFVObmrbGRtIThiRRGTFHJ1cw==
X-Received: by 2002:ac2:44a4:: with SMTP id c4mr5814412lfm.116.1561928691435;
        Sun, 30 Jun 2019 14:04:51 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/15] ARM: tegra30: cpuidle: Don't enter LP2 on CPU0 when EMC runs off PLLP
Date:   Mon,  1 Jul 2019 00:00:18 +0300
Message-Id: <20190630210019.26914-15-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190630210019.26914-1-digetx@gmail.com>
References: <20190630210019.26914-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Machine hangs after entering LP2 if EMC clock is running off the PLLP.
Either hardware is touching PLLP during LP2, making it unstable, or there
is a software bug somewhere around PLLP programming. Real reason is
unknown, hence let's simply avoid LP2 for CPU0 for now to workaround the
problem. Note that LP2 works fine when EMC is running off any other parent
clock, LP1 is totally unaffected. Also note that there is no hang on LP2
if memory timing is set up for a higher rate (600MHz) when on PLLP, which
makes this extra suspicious.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra30.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index c6128526877d..0f8da69ba5be 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -60,10 +60,15 @@ static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
 					   int index)
 {
-	/* All CPUs entering LP2 is not working.
+	/*
+	 * All CPUs entering LP2 is not working.
 	 * Don't let CPU0 enter LP2 when any secondary CPU is online.
+	 *
+	 * Machine hangs after entering LP2 if EMC is running off PLLP,
+	 * reason is unknown.
 	 */
-	if (num_online_cpus() > 1 || !tegra_cpu_rail_off_ready()) {
+	if (num_online_cpus() > 1 || !tegra_cpu_rail_off_ready() ||
+	    tegra20_clk_emc_on_pllp()) {
 		cpu_do_idle();
 		return false;
 	}
-- 
2.22.0

