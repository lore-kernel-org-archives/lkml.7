Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDBCC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979B8215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfFSNMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:12:03 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFSNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:12:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MC2sH-1hlX0U47Th-00CQ0o; Wed, 19 Jun 2019 15:11:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] ARM: davinci: fix sleep.S build error on ARMv4
Date:   Wed, 19 Jun 2019 15:11:33 +0200
Message-Id: <20190619131148.1743339-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RCxxsPc1iW+wdf2qvwFXRCQCQwA9a8RhwBI7PbIOQcAXl1qMmye
 BxN3ySI1yqznfwmMSWbTufdMcHAb10VTw4Dl9OyAjxE3Zcn7Oy6gKbVYJWDCFpSXYGg82gp
 TymMH0ohfLvPUAE/tjuzg4oBaJsLS1Ui0hPPhGJcZJHkdNrb3sClUV+HzrDadVa7xzdWB5x
 wEQ9Anwjqu1SfsPxnoLHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WdiiRt6A5HY=:aN8ts0D3DpexapG3IApAie
 L57JWv+IozpGyPgU0RYrZEB9uoTO90JGUfs8rXhHZ5nRWDzEfR6yDsEnOKVzj29w5+7YFSDTS
 z5zu/I7mMCmjtJ9oRZh+3BEzcUb2zn+xd+gQT9QXjGnTJx3Ov2w/YiIjcIyJ7guaNwyQ0RGxX
 4HKkmeWJx6A9cYYlsRjSb4eFnfuXdfUTd48IIygZdFUv2ptUEt75SHqWZfvtlsFw7BRFpwNUz
 Cbr6SJ87uD4ywWfGUMg83MhLtTX+xIl/3xLDZFfTSU8KgfulD1AW5Q2lKZW0x8TCtS81EH0cJ
 PrYBcgB03+ZXexrJW180HBj0oOILO/6+eInRVgdoCNQFG6V8UB0w8P2y0DeQGEwV7kPixgE8o
 3CLtgybi6BjnDD/87mH4qo/ZNSt12swFj9ir9R+kM/AYxHo5aNecnZG+8l4opvrxh6dKs50Jh
 J/mm2032TO8Hn/axAAsElbeUz9kkoUVynvPE9wGwGpA5I11vHFcuJ5JmqH4xtSSlScgn7um1F
 kr+xMZB0O3gTmTmv5+JaFk3BnhkisfG6nSsxOd9nub6OrY4SHcFUXuv+ZaSX1Bxnq70G2kGNS
 X5PN1MYcyI4SqXKHFJcq62oqvXwzU6YM+LzTLRFHUX7QMZNq3BKpIed2wyeG8tixAfwMD6KvN
 AR5O5Etn+4Dh4YbYQ8CwboNa4cIDu5FqnghCw8R3GvXNNUTwcFTbAAfGh1VQVfy6MyaqAlQky
 pphwP/Sgd3BgB+vwesZMfYkG+0XP3IoRIhrv4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a multiplatform kernel that includes armv4 support,
the default target CPU does not support the blx instruction,
which leads to a build failure:

arch/arm/mach-davinci/sleep.S: Assembler messages:
arch/arm/mach-davinci/sleep.S:56: Error: selected processor does not support `blx ip' in ARM mode

Add a .arch statement in the sources to make this file build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/sleep.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index 05d03f09ff54..71262dcdbca3 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -24,6 +24,7 @@
 #define DEEPSLEEP_SLEEPENABLE_BIT	BIT(31)
 
 	.text
+	.arch	armv5te
 /*
  * Move DaVinci into deep sleep state
  *
-- 
2.20.0

