Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A01B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfDROr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:47:28 -0400
Received: from shell.v3.sk ([90.176.6.54]:47999 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389261AbfDROrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:47:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9479B1027C1;
        Thu, 18 Apr 2019 16:47:21 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O3hdU5eyObkH; Thu, 18 Apr 2019 16:47:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 029441027A7;
        Thu, 18 Apr 2019 16:47:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sgLOqBND9jEW; Thu, 18 Apr 2019 16:47:00 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 917AB1027A1;
        Thu, 18 Apr 2019 16:46:59 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v7 02/10] x86/platform/olpc: Don't split string literals when fixing up the DT
Date:   Thu, 18 Apr 2019 16:46:47 +0200
Message-Id: <20190418144655.18758-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418144655.18758-1-lkundrak@v3.sk>
References: <20190418144655.18758-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was pointed out in a review, and checkpatch.pl complains about this.
Breaking it down into multiple ofw evaluations works just as well and
reads better.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>

---
Changes since v6:
- s/perhaps even reads better/reads better/ in the commit message
- Collect ack from Thomas Gleixner
- Fix the subject prefix to "x86/platform/olpc:"

Changes since v5:
- This patch was split off from "x86, olpc: Use a correct version when
  making up a battery node"

 arch/x86/platform/olpc/olpc_dt.c | 33 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
index ac9e7bf49b66..87e1d81684c6 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -242,9 +242,9 @@ void __init olpc_dt_fixup(void)
 	pr_info("PROM DT: Old firmware detected, applying fixes\n");
=20
 	/* Add olpc,xo1-battery compatible marker to battery node */
-	olpc_dt_interpret("\" /battery@0\" find-device"
-		" \" olpc,xo1-battery\" +compatible"
-		" device-end");
+	olpc_dt_interpret("\" /battery@0\" find-device");
+	olpc_dt_interpret("  \" olpc,xo1-battery\" +compatible");
+	olpc_dt_interpret("device-end");
=20
 	board_rev =3D olpc_dt_get_board_revision();
 	if (!board_rev)
@@ -252,19 +252,24 @@ void __init olpc_dt_fixup(void)
=20
 	if (board_rev >=3D olpc_board_pre(0xd0)) {
 		/* XO-1.5: add dcon device */
-		olpc_dt_interpret("\" /pci/display@1\" find-device"
-			" new-device"
-			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
-			" finish-device device-end");
+		olpc_dt_interpret("\" /pci/display@1\" find-device");
+		olpc_dt_interpret("  new-device");
+		olpc_dt_interpret("    \" dcon\" device-name");
+		olpc_dt_interpret("    \" olpc,xo1-dcon\" +compatible");
+		olpc_dt_interpret("  finish-device");
+		olpc_dt_interpret("device-end");
 	} else {
 		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
-		olpc_dt_interpret("\" /pci/display@1,1\" find-device"
-			" new-device"
-			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
-			" finish-device device-end"
-			" \" /rtc\" find-device"
-			" \" olpc,xo1-rtc\" +compatible"
-			" device-end");
+		olpc_dt_interpret("\" /pci/display@1,1\" find-device");
+		olpc_dt_interpret("  new-device");
+		olpc_dt_interpret("    \" dcon\" device-name");
+		olpc_dt_interpret("    \" olpc,xo1-dcon\" +compatible");
+		olpc_dt_interpret("  finish-device");
+		olpc_dt_interpret("device-end");
+
+		olpc_dt_interpret("\" /rtc\" find-device");
+		olpc_dt_interpret(" \" olpc,xo1-rtc\" +compatible");
+		olpc_dt_interpret("device-end");
 	}
 }
=20
--=20
2.21.0

