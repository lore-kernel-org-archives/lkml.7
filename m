Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E2C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C10217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427856;
	bh=7YSVyEHR9cbz+EdC4WPtdFFJbGSeC6z/9Zzn4FDvP2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S6S7WFUTKFI6H4Afxfyr9zVEkHB1+vOtgk+cZQN6xlf51XAttZaatL1HaV0dYTVXv
	 aS2bMvYoCfrW83/QbsKVEmXO0dtqYW0GjYApm9dC+AuIQ9BWfewnI6VjlkKZdJFYFt
	 Hhfi+hIaRZtsjVyEuE1tGi27BfvhQn+t1Qb99uD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfEISuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfEISuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:50:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AD912177E;
        Thu,  9 May 2019 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427851;
        bh=7YSVyEHR9cbz+EdC4WPtdFFJbGSeC6z/9Zzn4FDvP2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vX/0eR5Yk9lvripiHPhe2CPazRbqBeNO2ph1nA8K/FJhTZrr3jsmD1lsZynKlmL+y
         w1xBI0EPONKxOtSPmGYJXlHWh5Dp7M2JgQ+KQBhzNSiZfISgm5mhCjwdeL99ily4yl
         jqEqOHCfq/+z1Kd9EWGVOkRpIRp5Ple3bdsEH4f0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 27/95] ASoC: cs4270: Set auto-increment bit for register writes
Date:   Thu,  9 May 2019 20:41:44 +0200
Message-Id: <20190509181311.208741542@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
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
index 33d74f163bd75..793a14d586672 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -642,6 +642,7 @@ static const struct regmap_config cs4270_regmap = {
 	.reg_defaults =		cs4270_reg_defaults,
 	.num_reg_defaults =	ARRAY_SIZE(cs4270_reg_defaults),
 	.cache_type =		REGCACHE_RBTREE,
+	.write_flag_mask =	CS4270_I2C_INCR,
 
 	.readable_reg =		cs4270_reg_is_readable,
 	.volatile_reg =		cs4270_reg_is_volatile,
-- 
2.20.1



