Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFE3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A529920842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCENZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:25:38 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfCENZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:25:37 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhlXE-1hW4yn3bfc-00dmB9; Tue, 05 Mar 2019 14:25:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tomer Maimon <tmaimon77@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/npcm: select TIMER_OF
Date:   Tue,  5 Mar 2019 14:24:48 +0100
Message-Id: <20190305132529.3835223-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hsyeLehgGd1Ixzf/2QZehNZOontyNXqAMz7RYGCSvQxiWa+3reM
 1KmQf7zzWw6D1yUcKFTtON6NSvXjmWAtRN4UM2VfuCD4DenKcHHBmTS5NUUtkDXv89iRLx8
 1cI5nueCWMQqi1ZCx1jmi1xXJ+wzjuT1tMzYlzCUlCYiG6lCahhycwFuQ5R5eXpxv2Q4Ckp
 xEqYGdhunxSqts2Wk7KWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6U7yAjspN6o=:pyvEeCSNRs2z7rko5E5Pw8
 jvgCAdR8w9qDWaZuzOlL3WZ5CPiLosApnZKFu9RvQEWSDIcv7AUwnLEhEmAJRhjnB7gxSWNTs
 86wSu8o0zXkgyPQ+SyJGPZ64uyHTAPPwqzh1I/iCnKKH54HZcxPcSq470ThTvSN5kjcAsJLAB
 BJMWrRRq2mJM5cL3Ve0iJLcKgRlEcyIsvyd8zS5tZcGTaItKzaxBIC3bFjnTtijC10soLjFDe
 9+nVaOzPhRmGHvsgDoTuG09n00PIJln4tWHJq+pGHOANQkQT4xv+gX/bNIuA0JpD6X0SkGxSi
 7BFqBBRvAC6lJxpqsOGFP+iTNwCJZjStF9jVApjP7xkUDqUrqK43lPzdGhRn3N8Q9iJHzL+c9
 gMV5f8g7fHcxsifTANS/el2Jq5bG9gAmDCrLupKfDTZd2EkMlTKnagX7YmI9mK8vjCk0R11dl
 Yr/03kOjV+kOKTD7QIPh3p1HjSizmK/PGP8K8MGzzJbwZwAawnx/5hs4ERk/Yo1J+sFZPgIop
 UT6qLGM1KACDboLhkmPMrAZZsf/qO9qaemdkrwBweUV5VWAqUTsA3ebAfBIFwrvHQAxGifC2m
 YeIqQSF1E8sXCtybHZcVZZCix57QvJ6fZbRy3tDy+9OOo/bLQm3LPoPBxBx7zgd+JOCoH6gOz
 i7Ld6nz7b3r7jdcC32aZkRG4ePlnBxn5nhIChXI/mnHdEfyAQ8ULWYEw7I/ED+BIJVDyQihfC
 /brHxl8SA9cBFtS8/2o+RnbfUP95Kr3aSyxOcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this is disabled, we get a link failure:

drivers/clocksource/timer-npcm7xx.o: In function `npcm7xx_timer_init':
timer-npcm7xx.c:(.init.text+0xf): undefined reference to `timer_of_init'

Fixes: 1c00289ecd12 ("clocksource/drivers/npcm: Add NPCM7xx timer driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..4b3d143f0f8a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -145,6 +145,7 @@ config VT8500_TIMER
 config NPCM7XX_TIMER
 	bool "NPCM7xx timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx architecture,
-- 
2.20.0

