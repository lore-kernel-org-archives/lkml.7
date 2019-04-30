Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82633C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5079A205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfD3MNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:13:17 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:55054 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfD3MNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:13:07 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 6cCz200093XaVaC01cCzqa; Tue, 30 Apr 2019 14:13:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hLRd5-00086a-QJ; Tue, 30 Apr 2019 14:12:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hLRd5-0000zF-NS; Tue, 30 Apr 2019 14:12:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Brandt <chris.brandt@renesas.com>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/5] soc: renesas: Enable RZ/A1 IRQC on RZ/A1H and RZ/A2M
Date:   Tue, 30 Apr 2019 14:12:52 +0200
Message-Id: <20190430121254.3737-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430121254.3737-1-geert+renesas@glider.be>
References: <20190430121254.3737-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-enable support for the RZ/A1 Interrupt Controller when configuring
a kernel which supports RZ/A1H or RZ/A2M SoCs.
Keep selects sorted while at it.

This is similar to how interrupt controllers for other Renesas SoCs are
enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Reviewed-by,
  - Add RZ/A2M,
  - Sort RZ/A1H selects.
---
 drivers/soc/renesas/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 68bfca6f20ddf8a7..2bbf49e5d441808b 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -57,14 +57,16 @@ config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 	select PM
 	select PM_GENERIC_DOMAINS
-	select SYS_SUPPORTS_SH_MTU2
 	select RENESAS_OSTM
+	select RENESAS_RZA1_IRQC
+	select SYS_SUPPORTS_SH_MTU2
 
 config ARCH_R7S9210
 	bool "RZ/A2 (R7S9210)"
 	select PM
 	select PM_GENERIC_DOMAINS
 	select RENESAS_OSTM
+	select RENESAS_RZA1_IRQC
 
 config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
-- 
2.17.1

