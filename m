Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD5FC10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92092084F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfCJQYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:24:54 -0400
Received: from shell.v3.sk ([90.176.6.54]:45106 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfCJQYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:24:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D1119102CB5;
        Sun, 10 Mar 2019 17:24:47 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BQoGn1qkQIaJ; Sun, 10 Mar 2019 17:24:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1F9F0102CBC;
        Sun, 10 Mar 2019 17:24:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lPzwv4XMoeKx; Sun, 10 Mar 2019 17:24:30 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 818D2102C8A;
        Sun, 10 Mar 2019 17:24:29 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 04/10] x86, olpc: Use a correct version when making up a battery node
Date:   Sun, 10 Mar 2019 17:24:13 +0100
Message-Id: <20190310162419.11861-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310162419.11861-1-lkundrak@v3.sk>
References: <20190310162419.11861-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature. We need to use a different compatible string for the
XO-1.5 battery.

Previously olpc_dt_fixup() used the presence od the battery node's
compatible property to decide whether the DT is up to date. Now we need
to look for a particular value in the compatible string, to decide

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v5:
- Split the "x86, olpc: Don't split string literals when fixing up the DT=
"
  and "x86, olpc: trivial code move in DT fixup" parts off from this
- Clarify some comments

Changes since v1:
- Avoid splitting string literals

 arch/x86/platform/olpc/olpc_dt.c | 64 +++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/ol=
pc_dt.c
index adf98b5623c0..1728f8992850 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -217,10 +217,28 @@ static u32 __init olpc_dt_get_board_revision(void)
 	return be32_to_cpu(rev);
 }
=20
+int olpc_dt_compatible_match(phandle node, const char *compat)
+{
+	char buf[64];
+	int plen;
+	char *p;
+	int len;
+
+	plen =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
+	if (plen <=3D 0)
+		return 0;
+
+	len =3D strlen(compat);
+	for (p =3D buf; p < buf + plen; p +=3D strlen(p) + 1) {
+		if (strcmp(p, compat) =3D=3D 0)
+			return 1;
+	}
+
+	return 0;
+}
+
 void __init olpc_dt_fixup(void)
 {
-	int r;
-	char buf[64];
 	phandle node;
 	u32 board_rev;
=20
@@ -228,22 +246,30 @@ void __init olpc_dt_fixup(void)
 	if (!node)
 		return;
=20
-	/*
-	 * If the battery node has a compatible property, we are running a new
-	 * enough firmware and don't have fixups to make.
-	 */
-	r =3D olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
-	if (r > 0)
-		return;
-
-	pr_info("PROM DT: Old firmware detected, applying fixes\n");
-
 	board_rev =3D olpc_dt_get_board_revision();
 	if (!board_rev)
 		return;
=20
 	if (board_rev >=3D olpc_board_pre(0xd0)) {
-		/* XO-1.5: add dcon device */
+		/* XO-1.5 */
+
+		if (olpc_dt_compatible_match(node, "olpc,xo1.5-battery"))
+			return;
+
+		/* Add olpc,xo1.5-battery compatible marker to battery node */
+		olpc_dt_interpret("\" /battery@0\" find-device");
+		olpc_dt_interpret("  \" olpc,xo1.5-battery\" +compatible");
+		olpc_dt_interpret("device-end");
+
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery")) {
+			/* If we have a olpc,xo1-battery compatible, then we're
+			 * running a new enough firmware that already has
+			 * the dcon node.
+			 */
+			return;
+		}
+
+		/* Add dcon device */
 		olpc_dt_interpret("\" /pci/display@1\" find-device");
 		olpc_dt_interpret("  new-device");
 		olpc_dt_interpret("    \" dcon\" device-name");
@@ -251,7 +277,17 @@ void __init olpc_dt_fixup(void)
 		olpc_dt_interpret("  finish-device");
 		olpc_dt_interpret("device-end");
 	} else {
-		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
+		/* XO-1 */
+
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery")) {
+			/* If we have a olpc,xo1-battery compatible, then we're
+			 * running a new enough firmware that already has
+			 * the dcon and RTC nodes.
+			 */
+			return;
+		}
+
+		/* Add dcon device, mark RTC as olpc,xo1-rtc */
 		olpc_dt_interpret("\" /pci/display@1,1\" find-device");
 		olpc_dt_interpret("  new-device");
 		olpc_dt_interpret("    \" dcon\" device-name");
--=20
2.20.1

