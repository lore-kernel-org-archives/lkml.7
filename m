Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA09CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B257F20848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfKDRsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:48:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37999 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfKDRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:48:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRgSm-0002TJ-D2; Mon, 04 Nov 2019 18:48:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B6CF71C0017;
        Mon,  4 Nov 2019 18:48:23 +0100 (CET)
Date:   Mon, 04 Nov 2019 17:48:23 -0000
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/sh_mtu2: Do not loop using
 platform_get_irq_by_name()
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016143003.28561-1-geert+renesas@glider.be>
References: <20191016143003.28561-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <157288970341.29376.4277271047838734036.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     7693de9f7aa4e2993fbd7094863304be6a4bbe16
Gitweb:        https://git.kernel.org/tip/7693de9f7aa4e2993fbd7094863304be6a4bbe16
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 16 Oct 2019 16:30:03 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Oct 2019 07:55:16 +02:00

clocksource/drivers/sh_mtu2: Do not loop using platform_get_irq_by_name()

As platform_get_irq_by_name() now prints an error when the interrupt
does not exist, looping over possibly non-existing interrupts causes the
printing of scary messages like:

    sh_mtu2 fcff0000.timer: IRQ tgi1a not found
    sh_mtu2 fcff0000.timer: IRQ tgi2a not found

Fix this by using the platform_irq_count() helper, to avoid touching
non-existent interrupts.  Limit the returned number of interrupts to the
maximum number of channels currently supported by the driver in a
future-proof way, i.e. using ARRAY_SIZE() instead of a hardcoded number.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016143003.28561-1-geert+renesas@glider.be
---
 drivers/clocksource/sh_mtu2.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 354b27d..62812f8 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -328,12 +328,13 @@ static int sh_mtu2_register(struct sh_mtu2_channel *ch, const char *name)
 	return 0;
 }
 
+static const unsigned int sh_mtu2_channel_offsets[] = {
+	0x300, 0x380, 0x000,
+};
+
 static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch, unsigned int index,
 				 struct sh_mtu2_device *mtu)
 {
-	static const unsigned int channel_offsets[] = {
-		0x300, 0x380, 0x000,
-	};
 	char name[6];
 	int irq;
 	int ret;
@@ -356,7 +357,7 @@ static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch, unsigned int index,
 		return ret;
 	}
 
-	ch->base = mtu->mapbase + channel_offsets[index];
+	ch->base = mtu->mapbase + sh_mtu2_channel_offsets[index];
 	ch->index = index;
 
 	return sh_mtu2_register(ch, dev_name(&mtu->pdev->dev));
@@ -408,7 +409,12 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	}
 
 	/* Allocate and setup the channels. */
-	mtu->num_channels = 3;
+	ret = platform_irq_count(pdev);
+	if (ret < 0)
+		goto err_unmap;
+
+	mtu->num_channels = min_t(unsigned int, ret,
+				  ARRAY_SIZE(sh_mtu2_channel_offsets));
 
 	mtu->channels = kcalloc(mtu->num_channels, sizeof(*mtu->channels),
 				GFP_KERNEL);
