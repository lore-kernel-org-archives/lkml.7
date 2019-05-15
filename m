Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D6BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD9D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918002;
	bh=1FA4MIz3CQzJCCADgU/KVoD/cf8oj05WHxeaSFbTaBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mCPcjyMvpi4QA3agX2YoX/2npVKMV561JrjlJkjR3dPJ7crI6kqQQBfzz9oj4B3hW
	 y+1Sccm+cAr/6rXeG6x46VwLZogRJiWJQmJZ9zlVZtGhn6c3Olh9lNRwpkkD4VXyWZ
	 7NKkPlCiWMmrbb09us/WCc/0ZN81XjBHVU7aHwk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfEOLAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbfEOK77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:59:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65AE32084E;
        Wed, 15 May 2019 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557917998;
        bh=1FA4MIz3CQzJCCADgU/KVoD/cf8oj05WHxeaSFbTaBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKjHXcjFYwrd64efV+1PLrwH+P77ys95dNdTP6YXeN86wCDsC6yOLDZHpGn4FBEwR
         dCGj4+OPD3AFG8hmXekMEjeMU2JepacCtNTGWrv5U0Oyy6pj/si8h6z4pT+V5WqGdG
         xfhhBVwI5SdpU8+LJWbvJIf+u0HE2EOoT+jlH2mo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 54/86] ASoC: cs4270: Set auto-increment bit for register writes
Date:   Wed, 15 May 2019 12:55:31 +0200
Message-Id: <20190515090653.006917756@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 736c1ea8e31e2..756796c064136 100644
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
2.20.1



