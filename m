Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D7C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14072216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329464;
	bh=a1CvUUpJChtt3IA25gGJ1WIEthDvwfe9mksI6A3cWWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j/2Fq9k1+sy98bg1nFihKmQl3p4VBNfF+3xJopaBBbJYSLT6dnr+IBcU3Aap5ZK6m
	 HWW9kimJ7+ZLVmbL5r+4Q4bPAJcBTIT22Zot2jGY6GFcRmmMq1zEWVyluBtb0VVHvF
	 iKJwuxm07AvwhCRo7GGpfhemxMdef9qaSEySxH44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfD0BoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfD0BoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:44:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5B5216C4;
        Sat, 27 Apr 2019 01:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329456;
        bh=a1CvUUpJChtt3IA25gGJ1WIEthDvwfe9mksI6A3cWWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtR/nHtKU9zJcS++pVgk62K+DnB1BuMs1Ambx/Zob9siHFc548SyQvrCm6ls1f3BW
         0oZD1d83UnykoS5BTYw3llEACwvKgIkNNCHThKmpf5D7S+YJHfgGIkYc0RdPawDu9w
         wU4+8iJjznruTRvsDIE1lkzl0Of2l6RWWUuxkkic=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 3/8] ASoC: cs4270: Set auto-increment bit for register writes
Date:   Fri, 26 Apr 2019 21:44:06 -0400
Message-Id: <20190427014412.9091-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014412.9091-1-sashal@kernel.org>
References: <20190427014412.9091-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit f0f2338a9cfaf71db895fa989ea7234e8a9b471d ]

The CS4270 does not by default increment the register address on
consecutive writes. During normal operation it doesn't matter as all
register accesses are done individually. At resume time after suspend,
however, the regcache code gathers the biggest possible block of
registers to sync and sends them one on one go.

To fix this, set the INCR bit in all cases.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs4270.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 736c1ea8e31e..756796c06413 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -641,6 +641,7 @@ static const struct regmap_config cs4270_regmap = {
 	.reg_defaults =		cs4270_reg_defaults,
 	.num_reg_defaults =	ARRAY_SIZE(cs4270_reg_defaults),
 	.cache_type =		REGCACHE_RBTREE,
+	.write_flag_mask =	CS4270_I2C_INCR,
 
 	.readable_reg =		cs4270_reg_is_readable,
 	.volatile_reg =		cs4270_reg_is_volatile,
-- 
2.19.1

