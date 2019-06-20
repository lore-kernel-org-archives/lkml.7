Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789B9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9EF2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053612;
	bh=r0ROucvzqJZRMYt99toU/ADmffzvdCx3F3KC4JB0Aq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UPP8cz11Zt9C3pWlBaHsuLMnnlMqHeEdvSLv7M8rLhVkd25FzAXyG3Tnv3uJ0e+A7
	 bdEg32kkrm1xldsaFosqCrTkQ80bvpgmWMnBr0Agk7RlH8NLSkl8mBo4qt0+Bz8yGz
	 +XDoHuaUoDWNQvNGAFHWMIpKyvad08uZp4isQgPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfFTSAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfFTSAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:00:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C71121530;
        Thu, 20 Jun 2019 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053607;
        bh=r0ROucvzqJZRMYt99toU/ADmffzvdCx3F3KC4JB0Aq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYr9XtcwrG67D8lVy9aDJGEnNrQYEgumzKLJg5gUJM85xVwE1XhUdOiVZuH2NlpG0
         Hw8yZ66pjJ7dTucQ29Gmq3VqZYZ7jsOEXGhsyD+v3Xv/HEZtjiEAfmghnF1eez6955
         SprE08ay0m4su8qMahfKK7MxSXYDopxmrZTHianQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 49/84] ASoC: cs42xx8: Add regcache mask dirty
Date:   Thu, 20 Jun 2019 19:56:46 +0200
Message-Id: <20190620174346.228445027@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: S.j. Wang <shengjiu.wang@nxp.com>

commit ad6eecbfc01c987e0253371f274c3872042e4350 upstream.

Add regcache_mark_dirty before regcache_sync for power
of codec may be lost at suspend, then all the register
need to be reconfigured.

Fixes: 0c516b4ff85c ("ASoC: cs42xx8: Add codec driver
support for CS42448/CS42888")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/cs42xx8.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -561,6 +561,7 @@ static int cs42xx8_runtime_resume(struct
 	msleep(5);
 
 	regcache_cache_only(cs42xx8->regmap, false);
+	regcache_mark_dirty(cs42xx8->regmap);
 
 	ret = regcache_sync(cs42xx8->regmap);
 	if (ret) {


