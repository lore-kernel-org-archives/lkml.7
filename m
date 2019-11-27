Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B47C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C48B215F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890110;
	bh=oMoPkCwY6kDzGS2Li0xLQGa17DHyFG0V1ZNnzIwiQfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xUgUkF2RyJPIyGYDm5fu7nSSa68vBah6+4bcbVYbTTZzgtxcYnIG5ICkfgnRL7PLY
	 6H5c5YwY8kx7Wx72bdq0+5ChA0kob4rgrnEkxW8qVafOl2ehZn0+lJgLZHKR5hPHzK
	 IV7xZRsLdc5tksem1feNnvWTQAr4nRWitPamefQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfK0U6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbfK0U6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:58:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4722821556;
        Wed, 27 Nov 2019 20:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888300;
        bh=oMoPkCwY6kDzGS2Li0xLQGa17DHyFG0V1ZNnzIwiQfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjn2RyHOQDy5V+W6F5sht/C2jGAwpHMJIjzZmhTr/VS+CCJRhiFbn/aRMCKiTWocB
         ITLZBWJNf/UYzWBaHzhJazw8hxxt9ntaQ+PlL52ko4WRczVHZ80GVP+6JQlZtbDosZ
         e3TG95iPWOur0MxjqfKHgwXqRPLGCkUAepwrSfAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/306] clk: at91: audio-pll: fix audio pmc type
Date:   Wed, 27 Nov 2019 21:28:50 +0100
Message-Id: <20191127203120.757725986@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 7fa75007b7d7421aea59ff2b12ab1bd65a5abfa6 ]

The allocation for the audio pmc is using the size of struct clk_audio_pad
instead of struct clk_audio_pmc. This works fine because the former is
larger than the latter but it is safer to be correct.

Fixes: ("0865805d82d4 clk: at91: add audio pll clock drivers")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/at91/clk-audio-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
index da7bafcfbe706..b3eaf654fac98 100644
--- a/drivers/clk/at91/clk-audio-pll.c
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -509,7 +509,7 @@ static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
 
 static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
 {
-	struct clk_audio_pad *apmc_ck;
+	struct clk_audio_pmc *apmc_ck;
 	struct clk_init_data init = {};
 
 	apmc_ck = kzalloc(sizeof(*apmc_ck), GFP_KERNEL);
-- 
2.20.1



