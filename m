Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E4C20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688341;
	bh=7UQ9sUODuMkxvbYQ+K7NzkwWwRaWXN+DQXpgRL/EqLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqqckZXgUSQkxfDzPRjH8g/sz7pcFyFuW7AWj+TRnJJADiljgxzMQq7Dgo3qMBhXD
	 tX/9hJGDD33F4MuctoqleE1ibPwMUnCVNv9jQ//KTU5vgfiZvqboa2LsCGmLoMJwxd
	 f/8dtixDWye4zcMhoQvv4GaRS84JHck1PGnG4KJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfCDIcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfCDIcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E89A20836;
        Mon,  4 Mar 2019 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688337;
        bh=7UQ9sUODuMkxvbYQ+K7NzkwWwRaWXN+DQXpgRL/EqLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxxqFSk+s8c6XvthmlT80mAYkZYEEp9MyxsHhcaa/xuVLyJo45mUfivhHOIhI3/4u
         5WlETIsIxjGvEo0kl9HwHXLdDucp4NeZdu3Y+E6LdtAayVOYWnk1yoYoPriPIVu7fN
         +GWCNgjWNKI6ZDDXOXFvUyMTf/VCNibCefkdJ3E0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 06/88] ASoC: rt5682: Fix recording no sound issue
Date:   Mon,  4 Mar 2019 09:21:49 +0100
Message-Id: <20190304081630.831329234@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 22c7d5e7bad1fb2d8b9c611acb55a389f5d848d8 ]

The ADC mixer setting needs to restore to default value
after calibration.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 34cfaf8f6f345..89c43b26c3790 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2512,6 +2512,7 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x2000);
 	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x2005);
+	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0xc0c4);
 
 	mutex_unlock(&rt5682->calibrate_mutex);
 
-- 
2.19.1



