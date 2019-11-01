Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33DCCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ECB21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="q1GNBpiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfKAQmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:42:04 -0400
Received: from vps.xff.cz ([195.181.215.36]:60608 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfKAQmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572626522; bh=Gmx9bz5c58Bmxt6o/l+l4TxxiIaJ3KV5uLxeuq7aJF4=;
        h=From:To:Cc:Subject:Date:From;
        b=q1GNBpiQn9Hc6z2CYpSi/KhF7+Zu43LFYFVzBX3EmFZCU0KFXbokbxCCPg1g7n+FU
         Ztbh4zB5zrTH1o5e8YV6cvZkk+eeb0mP2ta6GWqUrAWICBj5DIOyo14eLesIO0F8UZ
         YRUOINktiejT4Q2xpVswf4M6RJynZKasnXXDtpGU=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org (open list:ALLWINNER CPUFREQ DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] cpufreq: sun50i: Fix CPU speed bin detection
Date:   Fri,  1 Nov 2019 17:41:51 +0100
Message-Id: <20191101164152.445067-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have observed failures to boot on Orange Pi 3, because this driver
determined that my SoC is from the normal bin, but my SoC only works
reliably with the OPP values for the slowest bin.

By querying H6 owners, it was found that e-fuse values found in the wild
are in the range of 1-3, value of 7 was not reported, yet. From this and
from unused defines in BSP code, it can be assumed that meaning of efuse
values on H6 actually is:

- 1 = slowest bin
- 2 = normal bin
- 3 = fastest bin

Vendor code actually treats 0 and 2 as invalid efuse values, but later
treats all invalid values as a normal bin. This looks like a mistake in
bin detection code, that was plastered over by a hack in cpufreq code,
so let's not repeat it here. It probably only works because there are no
SoCs in the wild with efuse value of 0, and fast bin SoCs are made to
use normal bin OPP tables, which is also safe.

Let's play it safe and interpret 0 as the slowest bin, but fix detection
of other bins to match this research. More research will be done before
actual OPP tables are merged.

Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
Signed-off-by: Ondrej Jirman <megous@megous.com>
---

 See also https://lkml.org/lkml/2019/11/1/496

 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index eca32e443716..9907a165135b 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -25,7 +25,7 @@
 static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
 
 /**
- * sun50i_cpufreq_get_efuse() - Parse and return efuse value present on SoC
+ * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
  * @versions: Set to the value parsed from efuse
  *
  * Returns 0 if success.
@@ -69,21 +69,16 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 		return PTR_ERR(speedbin);
 
 	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
-	switch (efuse_value) {
-	case 0b0001:
-		*versions = 1;
-		break;
-	case 0b0011:
-		*versions = 2;
-		break;
-	default:
-		/*
-		 * For other situations, we treat it as bin0.
-		 * This vf table can be run for any good cpu.
-		 */
+
+	/*
+	 * We treat unexpected efuse values as if the SoC was from
+	 * the slowest bin. Expected efuse values are 1-3, slowest
+	 * to fastest.
+	 */
+	if (efuse_value >= 1 && efuse_value <= 3)
+		*versions = efuse_value - 1;
+	else
 		*versions = 0;
-		break;
-	}
 
 	kfree(speedbin);
 	return 0;
-- 
2.23.0

