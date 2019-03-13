Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA5C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3562075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504711;
	bh=tkLBUB8TwBFiqM6DVArGARpdJhCkVyck+eWaIhaPaMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GoKeZgfq4GHkmkS1mKCidXIqi/aprM3l8GdAmG1T3sj0BXVENyH8Vi2eczyBvYq6u
	 J+N25kZG5wsHt9tqhmEeOU9UEIBSZwf0JlXJHap3go7fuF/cUA38U7AkjNQ/a9Kv+e
	 Vb6MrWBFYWsZT2J8tYROkzDh/iJ0q2rDNN6Im1FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfCMTS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbfCMTSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:18:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 917662177E;
        Wed, 13 Mar 2019 19:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504703;
        bh=tkLBUB8TwBFiqM6DVArGARpdJhCkVyck+eWaIhaPaMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEaBUGHvfGofiC2hg03y3aDqibSnq6FNRmk6om5gV1+/BFEYO8ben55J6EcDwJ2pe
         BTLXh7ihtFD7fd+2Mfej/dP34WlivK+/qXAwe1iZ21C+VZ+zOj44AC1r5f6Kcddyaw
         q7ioOZx6SB7lLeci2uiXHDimeJx9GcPxfSvAWAKI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 06/15] pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins
Date:   Wed, 13 Mar 2019 15:17:52 -0400
Message-Id: <20190313191806.160547-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191806.160547-1-sashal@kernel.org>
References: <20190313191806.160547-1-sashal@kernel.org>
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
index b505b87661f8..07c4153e6f3d 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -656,7 +656,7 @@ static const char * const sd_a_groups[] = {
 
 static const char * const sdxc_a_groups[] = {
 	"sdxc_d0_0_a", "sdxc_d13_0_a", "sdxc_d47_a", "sdxc_clk_a",
-	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d0_13_1_a"
+	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d13_1_a"
 };
 
 static const char * const pcm_a_groups[] = {
-- 
2.19.1

