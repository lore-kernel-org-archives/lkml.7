Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2906C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE512075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505576;
	bh=oy3dvynanRjImHK2flmvaHnoYG6sbJAJOPDGEKGTCBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g37y05gu/P+g/vV0qSF2yzibaCTmovw6WUFoAcioyMuY8cnTQU3YO7i7Tk+wJzxgM
	 EpZhnTWDuvMj7yAftewyTKrbsKdxntChHJ+NgdV6ng3R2XF0yrZFcf/YKrwL44Gkmg
	 O8SNQQDCAKJzSzmjMu2JkZWZ/9VJaIK2THPnl398=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCMTLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfCMTK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACF221855;
        Wed, 13 Mar 2019 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504258;
        bh=oy3dvynanRjImHK2flmvaHnoYG6sbJAJOPDGEKGTCBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5v8dJjdLevXNmBgS+EklZJDlKRPGjojiEmkC8k5YFslr0CDDkYqZ7yNGC6sA51pR
         FtcDPJlslENW4QhZxLo4X5AmjenRRocmZjOTZPMsBHPQG2/N9wylzw7CCHVbil7+eW
         qhdcxL6eAdNBWuOtlFbDxXQlNBn5imEMHDspw+xc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 17/60] pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins
Date:   Wed, 13 Mar 2019 15:09:38 -0400
Message-Id: <20190313191021.158171-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit c17abcfa93bf0be5e48bb011607d237ac2bfc839 ]

Fix the mismatch between the "sdxc_d13_1_a" pin group definition from
meson8b_cbus_groups and the entry in sdxc_a_groups ("sdxc_d0_13_1_a").
This makes it possible to use "sdxc_d13_1_a" in device-tree files to
route the MMC data 1..3 pins to GPIOX_1..3.

Fixes: 0fefcb6876d0d6 ("pinctrl: Add support for Meson8b")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 91cffc051055..ead4beb5f55f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -665,7 +665,7 @@ static const char * const sd_a_groups[] = {
 
 static const char * const sdxc_a_groups[] = {
 	"sdxc_d0_0_a", "sdxc_d13_0_a", "sdxc_d47_a", "sdxc_clk_a",
-	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d0_13_1_a"
+	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d13_1_a"
 };
 
 static const char * const pcm_a_groups[] = {
-- 
2.19.1

