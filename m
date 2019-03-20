Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78114C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E30021841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103070;
	bh=5WguqMAp62uLdo+NLmrnGQLH9zm7u825E/0upOCP6eg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1kKVhB5XGaO4/BbIqXczxtLznW/EjmGbNQlPxGF2Dz3o6jdEMk+xl2YEz52B7r2aH
	 lDi7+8LLDHbYJ60TLwOAJW36YY3Yx3rCdUBBrXcey4+IBa4WGoDLJGFmrm0GRfs/wm
	 B2Su5Fwcy7aD2xFadL3V6E8J2EThBBFwJKccYQlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCTRbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:31:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43866 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SS8mIqEjR+8P1BvjrL8jO+DbHCwa1wbrhDQ+q53ja1w=; b=jEiKhiVzwd65
        dMbbyYKja9Hw7q++nh4853ykZMMq6v8zx3ru3AW03yaQafeWduw7mjieQclSm1IiBLAoogidDe8kw
        pEBCzsWfiJ87EW3YgCEp5wzpJ55nHnCxxSDYW01b+TBYaYUSj6m9O9OlQi2uykpbayjyBz9cVOQMe
        hVWmQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f23-00018y-PR; Wed, 20 Mar 2019 17:29:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 134B51126E4C; Wed, 20 Mar 2019 17:29:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: debugfs: Jump to the next readable register" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190320172939.134B51126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: debugfs: Jump to the next readable register

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From cc6a8d69ba624f0ad7a09ed095b7bd4b86476489 Mon Sep 17 00:00:00 2001
From: Lucas Tanure <tanureal@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 09:41:33 +0000
Subject: [PATCH] regmap: debugfs: Jump to the next readable register

Improve the speed of the loop jumping to the next
available register

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 648779e6df88..fc45c2bb961a 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -195,6 +195,28 @@ static inline void regmap_calc_tot_len(struct regmap *map,
 	}
 }
 
+static int regmap_next_readable_reg(struct regmap *map, int reg)
+{
+	struct regmap_debugfs_off_cache *c;
+	int ret = -EINVAL;
+
+	if (regmap_printable(map, reg + map->reg_stride)) {
+		ret = reg + map->reg_stride;
+	} else {
+		mutex_lock(&map->cache_lock);
+		list_for_each_entry(c, &map->debugfs_off_cache, list) {
+			if (reg > c->max_reg)
+				continue;
+			if (reg < c->base_reg) {
+				ret = c->base_reg;
+				break;
+			}
+		}
+		mutex_unlock(&map->cache_lock);
+	}
+	return ret;
+}
+
 static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 				   unsigned int to, char __user *user_buf,
 				   size_t count, loff_t *ppos)
@@ -218,9 +240,8 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	/* Work out which register we're starting at */
 	start_reg = regmap_debugfs_get_dump_start(map, from, *ppos, &p);
 
-	for (i = start_reg; i <= to; i += map->reg_stride) {
-		if (!regmap_printable(map, i))
-			continue;
+	for (i = start_reg; i >= 0 && i <= to;
+	     i = regmap_next_readable_reg(map, i)) {
 
 		/* If we're in the region the user is trying to read */
 		if (p >= *ppos) {
-- 
2.20.1

