Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF678C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBAB20659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520892;
	bh=HYdAbmhEThN365al8l0g9ektYP5jbJ8Nth9fQjo/xjY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QYQMkc2ZHvIqVY8DN6/08Ts2ce3eH0IHzTNn7TxHSt6mESCApYpiN84fZglcVfFJc
	 DxeriQeekqC1+WhWGgPMjv6Z/qv4GqJ0mlk3I68xNdp7pAlE5gwVY9BVJfphqBoOIr
	 Zo/7FKreQdqD5b9SfmB0lRBk8XTbVnid25arXRZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfFZDsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfFZDpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:45:12 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E77205ED;
        Wed, 26 Jun 2019 03:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520711;
        bh=HYdAbmhEThN365al8l0g9ektYP5jbJ8Nth9fQjo/xjY=;
        h=From:To:Cc:Subject:Date:From;
        b=Iw40OD++OIQ2c5uyzqCTAS0bzNUijT8iRwl3ZLXNtwz/SV0KWuuWh1XwfSJg+j+Ai
         lejYDnelWTsJqTHiVNQNPAhhzmWiHWSEi1x0BsRKh0Z7xPTdr2c9KGQUzWLIjt0xhG
         7d6Q2iqRTPeu+1LhNKNPIlzaHE7vSeHXIW8a3Oko=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matt Flax <flatmax@flatmax.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 01/21] ASoC : cs4265 : readable register too low
Date:   Tue, 25 Jun 2019 23:44:46 -0400
Message-Id: <20190626034506.24125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Flax <flatmax@flatmax.org>

[ Upstream commit f3df05c805983427319eddc2411a2105ee1757cf ]

The cs4265_readable_register function stopped short of the maximum
register.

An example bug is taken from :
https://github.com/Audio-Injector/Ultra/issues/25

Where alsactl store fails with :
Cannot read control '2,0,0,C Data Buffer,0': Input/output error

This patch fixes the bug by setting the cs4265 to have readable
registers up to the maximum hardware register CS4265_MAX_REGISTER.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs4265.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 6e8eb1f5a041..bed64723e5d9 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -60,7 +60,7 @@ static const struct reg_default cs4265_reg_defaults[] = {
 static bool cs4265_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS4265_CHIP_ID ... CS4265_SPDIF_CTL2:
+	case CS4265_CHIP_ID ... CS4265_MAX_REGISTER:
 		return true;
 	default:
 		return false;
-- 
2.20.1

