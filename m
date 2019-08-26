Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E71C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B7E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfHZWwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:52:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41520 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfHZWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2NqY-0006qf-Ne; Tue, 27 Aug 2019 00:52:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 126171C0DDE;
        Tue, 27 Aug 2019 00:52:20 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:20 -0000
From:   tip-bot2 for Magnus Damm <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_cmt: Document "cmt-48" as
 deprecated
Cc:     Magnus Damm <damm+renesas@opensource.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685994001.1342.8063596857526317450.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     19d608458f4f3bb3a1f89bd7e4814c3fd30dbec7
Gitweb:        https://git.kernel.org/tip/19d608458f4f3bb3a1f89bd7e4814c3fd30dbec7
Author:        Magnus Damm <damm+renesas@opensource.se>
AuthorDate:    Tue, 20 Aug 2019 21:36:07 +09:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

clocksource/drivers/sh_cmt: Document "cmt-48" as deprecated

Update the CMT driver to mark "renesas,cmt-48" as deprecated.

Instead of documenting a theoretical hardware device based on current software
support level, define DT bindings top-down based on available data sheet
information and make use of part numbers in the DT compat string.

In case of the only in-tree users r8a7740 and sh73a0 the compat strings
"renesas,r8a7740-cmt1" and "renesas,sh73a0-cmt1" may be used instead.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index abf5e78..ef773db 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -918,7 +918,11 @@ static const struct platform_device_id sh_cmt_id_table[] = {
 MODULE_DEVICE_TABLE(platform, sh_cmt_id_table);
 
 static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
-	{ .compatible = "renesas,cmt-48", .data = &sh_cmt_info[SH_CMT_48BIT] },
+	{
+		/* deprecated, preserved for backward compatibility */
+		.compatible = "renesas,cmt-48",
+		.data = &sh_cmt_info[SH_CMT_48BIT]
+	},
 	{
 		/* deprecated, preserved for backward compatibility */
 		.compatible = "renesas,cmt-48-gen2",
