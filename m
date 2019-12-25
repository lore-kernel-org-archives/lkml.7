Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88922C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 16:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF0620722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 16:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk0h3zyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfLYQef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 11:34:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34577 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 11:34:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so11800011pgf.1;
        Wed, 25 Dec 2019 08:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bM15yY7unBCboNQn0vtKKuJc6P9Ay93lXeItl76c2q0=;
        b=Tk0h3zyt8O/p5F3+j0HKXDtRinFFYF5/mfOJnqQZnXmb9S9njd2ELDf2DFSTtYlbNd
         KdUQ+53mbOMHpoMjTcZ0sfqdrFBRdPsdffgeHETwv22HBVGyPl+idbpSNyqEeerkUsVw
         iHnA7UhCfW9BjY8pla7q20R+csHYg9uGOa6/gXZ9xbXUdvGK4Q74e1n99RWrDYR5PsqX
         H1AMrIdtaVbAiX/tt+gYmbIiqTVBUM4GlmUZ9kE8Om/ygBug/yYTbbTNNka7efKF35DC
         62jCBnXXyEzPntXjRepOd3nAXLeKTHYw2ZN2vp5gZASUQwCc4o5ETSL++Tg//GvGuH0s
         vhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=bM15yY7unBCboNQn0vtKKuJc6P9Ay93lXeItl76c2q0=;
        b=CsJ0GV2oJOJj1L6MytcxGsn/RqzYywl18O18oS7niDmQ+sfazbUsVq5ETYDj/+SI2T
         WpGqvIHSBEHPiufrby5INqBoGmAlU307uquLudAhKPWus8U9z9A1Bg0n1b0xEfjy4736
         WzN+UEY7UrmwFCTGMe9I+2oyI2xpND1okblZfvPFriErkQNjnAjZZQ/hteeeEaAn4HAj
         EonsPLIABuG+HrOfnO8KdbLqzEjij+/46P50/iktqtR8WopdD7vsS/vbjSUTIJikPS3g
         OLE1dZHQRcqsOVU8A70Q8UFJXpqiH2DmDKE9H72eYiNaFEpI+DW8FKqAcYErtyufKeVd
         HV7g==
X-Gm-Message-State: APjAAAWN/vjibRtGSq2jbH1ofo85qY588m+tcHt/2acS45KCiFdbOyoc
        ypW5nzYQKBpwrwxm1DdzN04=
X-Google-Smtp-Source: APXvYqw1qvcsid6VJtiBetDQXvsJ7ayB2ot+OMcWo7b6tScrQecVUQtRND3OzAHpSX4y8Ag4Vad3mQ==
X-Received: by 2002:a63:eb02:: with SMTP id t2mr44014216pgh.289.1577291674429;
        Wed, 25 Dec 2019 08:34:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r66sm33694347pfc.74.2019.12.25.08.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Dec 2019 08:34:33 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] clk: Don't try to enable critical clocks if prepare failed
Date:   Wed, 25 Dec 2019 08:34:29 -0800
Message-Id: <20191225163429.29694-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following traceback is seen if a critical clock fails to prepare.

bcm2835-clk 3f101000.cprman: plld: couldn't lock PLL
------------[ cut here ]------------
Enabling unprepared plld_per
WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:1014 clk_core_enable+0xcc/0x2c0
...
Call trace:
 clk_core_enable+0xcc/0x2c0
 __clk_register+0x5c4/0x788
 devm_clk_hw_register+0x4c/0xb0
 bcm2835_register_pll_divider+0xc0/0x150
 bcm2835_clk_probe+0x134/0x1e8
 platform_drv_probe+0x50/0xa0
 really_probe+0xd4/0x308
 driver_probe_device+0x54/0xe8
 device_driver_attach+0x6c/0x78
 __driver_attach+0x54/0xd8
...

Check return values from clk_core_prepare() and clk_core_enable() and
bail out if any of those functions returns an error.

Cc: Jerome Brunet <jbrunet@baylibre.com>
Fixes: 99652a469df1 ("clk: migrate the count of orphaned clocks at init")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/clk/clk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 6a11239ccde3..772258de2d1f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3426,11 +3426,17 @@ static int __clk_core_init(struct clk_core *core)
 	if (core->flags & CLK_IS_CRITICAL) {
 		unsigned long flags;
 
-		clk_core_prepare(core);
+		ret = clk_core_prepare(core);
+		if (ret)
+			goto out;
 
 		flags = clk_enable_lock();
-		clk_core_enable(core);
+		ret = clk_core_enable(core);
 		clk_enable_unlock(flags);
+		if (ret) {
+			clk_core_unprepare(core);
+			goto out;
+		}
 	}
 
 	clk_core_reparent_orphans_nolock();
-- 
2.17.1

