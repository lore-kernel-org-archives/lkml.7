Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E32BC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B4420659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520844;
	bh=HYdAbmhEThN365al8l0g9ektYP5jbJ8Nth9fQjo/xjY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jNZhZjVmU5CY/+PQif6jO7nNT7jiMOcsBWPW7/fL+vjnvMaVnc14TDC2Z+hiuYCzC
	 Ao44xsQSprYojKSKWfwhKB9bYjh/HH8QsXibgGeu6OUlnYgXOKD54cXXoLitBDVrGT
	 v4go4lL2I8J6wRm9jMIE2tQwdOGk53+atiXYgVAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfFZDqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbfFZDqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:46:05 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-82.mobile.att.net [107.77.172.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCF520B7C;
        Wed, 26 Jun 2019 03:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520765;
        bh=HYdAbmhEThN365al8l0g9ektYP5jbJ8Nth9fQjo/xjY=;
        h=From:To:Cc:Subject:Date:From;
        b=tw1S8LN0SgLpHD9u3vM74c59O9asySfDwmMKPeU4yxGw06ZquEbZXRsx01dU7NgZx
         TOX9zQCFh6RcWs7Co+pXvkOth3G7+yacFeWOM7gpm2PjbTZCNdD7GhRUN5wTMtG2UA
         Z0tUpgDV9l4f3r4rAYgmb3SRrUo5PWpLWcDXkUhg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matt Flax <flatmax@flatmax.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 01/11] ASoC : cs4265 : readable register too low
Date:   Tue, 25 Jun 2019 23:45:51 -0400
Message-Id: <20190626034602.24367-1-sashal@kernel.org>
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

