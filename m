Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC547C17448
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BC22067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611882;
	bh=sZyurtuWXFYsgOUj80/7yxV09L1SNtY4gxeDxJst5wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kJ6W7Yyhze8VhKfhpahDUNt1bkRlYZ6CGri4qyVZ0dxEkUVD6FSPa0gHXdAliX0lu
	 MyS0qv5C7jwl0J3uAEPxAG2B6erDy/WeIkty+1vNG/IPccBuuE8K3EPyirl/LCHGrx
	 avJTXffxRPg6as0pqmrzOH6eUPxQRbEc615/3oN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfKMBwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbfKMBv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EAA204EC;
        Wed, 13 Nov 2019 01:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609916;
        bh=sZyurtuWXFYsgOUj80/7yxV09L1SNtY4gxeDxJst5wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwtpX5b7Vl5k7e8EowXbw2IZYcjXEe94QEEmRyiP2ElI89mQS/9oxNCKMj2znRHqT
         gLStmrmppsGFp6xfIDdh0qwOkDC8ZC/Pzd+kLKspmpOwpbdEbqsEZM9I/FnfH0vF8e
         LDzSUcAK9JuIgRlxZGxSpRv2d+QdLudFBZEJghDA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 065/209] clocksource/drivers/sh_cmt: Fix clocksource width for 32-bit machines
Date:   Tue, 12 Nov 2019 20:48:01 -0500
Message-Id: <20191113015025.9685-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit 37e7742c55ba856eaec7e35673ee370f36eb17f3 ]

The driver seems to abuse *unsigned long* not only for the (32-bit)
register values but also for the 'sh_cmt_channel::total_cycles' which
needs to always be 64-bit -- as a result, the clocksource's mask is
needlessly clamped down to 32-bits on the 32-bit machines...

Fixes: 19bdc9d061bc ("clocksource: sh_cmt clocksource support")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/sh_cmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 49302086f36fd..cec90a4c79b34 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -108,7 +108,7 @@ struct sh_cmt_channel {
 	raw_spinlock_t lock;
 	struct clock_event_device ced;
 	struct clocksource cs;
-	unsigned long total_cycles;
+	u64 total_cycles;
 	bool cs_enabled;
 };
 
@@ -613,8 +613,8 @@ static u64 sh_cmt_clocksource_read(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
 	unsigned long flags;
-	unsigned long value;
 	u32 has_wrapped;
+	u64 value;
 	u32 raw;
 
 	raw_spin_lock_irqsave(&ch->lock, flags);
@@ -688,7 +688,7 @@ static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
 	cs->disable = sh_cmt_clocksource_disable;
 	cs->suspend = sh_cmt_clocksource_suspend;
 	cs->resume = sh_cmt_clocksource_resume;
-	cs->mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+	cs->mask = CLOCKSOURCE_MASK(sizeof(u64) * 8);
 	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used as clock source\n",
-- 
2.20.1

