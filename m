Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07977C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B020873
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329685;
	bh=bs1jjb41LIAyMyX/KF+eOa0V8Fa85LrWfcCk8kGaSSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QUiBpKQjRnWaD7+CXloGq5kbMcw7sK9iEO5ueBs8vyoZb8w/x55tnVBvLptgfe5Gi
	 vT9WCPSnZYyZ631vSSy3W7F3pRmkigye9GQxVrs+FF3oG/8Q0+CxtvLz+U39v7Y+sS
	 7mwps0VH62ly+6WEwO7YgA/knYEpoeCDpfVWGAxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfD0Bmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfD0Bmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB42220679;
        Sat, 27 Apr 2019 01:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329358;
        bh=bs1jjb41LIAyMyX/KF+eOa0V8Fa85LrWfcCk8kGaSSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0F2lFwPB0KIHcY1BYSm50D+TCCN3oiZ+99Q7jG9uJBv8Ri+irz9QG/S5loLXJDPm
         607v85uP/y9uAu8eMdJPDEQOK0CNjFFoyjzrElMBvUyIC+YNbK7h8RQ4HETaGXrNHC
         9m/W2he0pnwy6PvSR94OJapJ2vPl7lSBVKWLPzRI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 08/32] ASoC: cs4270: Set auto-increment bit for register writes
Date:   Fri, 26 Apr 2019 21:41:59 -0400
Message-Id: <20190427014224.8274-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
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
index 84f86745c30e..828bc615a190 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -643,6 +643,7 @@ static const struct regmap_config cs4270_regmap = {
 	.reg_defaults =		cs4270_reg_defaults,
 	.num_reg_defaults =	ARRAY_SIZE(cs4270_reg_defaults),
 	.cache_type =		REGCACHE_RBTREE,
+	.write_flag_mask =	CS4270_I2C_INCR,
 
 	.readable_reg =		cs4270_reg_is_readable,
 	.volatile_reg =		cs4270_reg_is_volatile,
-- 
2.19.1

