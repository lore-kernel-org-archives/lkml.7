Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E93C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99C62133F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wDbN53zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfCEUTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:19:35 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55860 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfCEUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:19:35 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C97A9891AA;
        Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551817172;
        bh=7BaeZd54UA75pFPzRyMdWlNw1ciq4AymcW/Yk7re/Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wDbN53zh+RBYGa11sreZjALrSY4S0wtf35/DvBv8LpjVsaSMHBGU3qH25ciYWwt72
         D2cRiBLXVJGSXMf0u/19sJnGHCpoO3goX+wAImStrO0s06E2MkX9zjceKjAIqX6yk6
         7SB1LywwuRVTSJF2lxBN4I3/vWDXWpsmLA1GDvpuMc3tlLxr2cAn9xC+lpxvRLb2Gz
         OIWzJcdayHFZJmXc7B0Tw73ssIv4kFB585SeSvbRRx8OVIqP/9ixyPZJmXjYPCKPRt
         2S/PkyFOWfMrFkqTZl78BNzy8oAHSlXg1Kv5loavU2sp+p1rQyRgotcYiC3qr6P6Z0
         9oXgC8yk53cMw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c7ed9d40002>; Wed, 06 Mar 2019 09:19:32 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id D16B513EF3B;
        Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9C7F71E1D96; Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH v2 2/3] watchdog: orion: remove orion_wdt_set_timeout
Date:   Wed,  6 Mar 2019 09:19:23 +1300
Message-Id: <20190305201924.14853-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190305201924.14853-1-chris.packham@alliedtelesis.co.nz>
References: <20190305201924.14853-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog core will do the same thing if no set_timeout
is supplied so we can safely remove orion_wdt_set_timeout.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v2:
- Add Guenter's review

 drivers/watchdog/orion_wdt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 9db3b09f7568..8b259c712c52 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -349,13 +349,6 @@ static unsigned int orion_wdt_get_timeleft(struct wa=
tchdog_device *wdt_dev)
 	return readl(dev->reg + dev->data->wdt_counter_offset) / dev->clk_rate;
 }
=20
-static int orion_wdt_set_timeout(struct watchdog_device *wdt_dev,
-				 unsigned int timeout)
-{
-	wdt_dev->timeout =3D timeout;
-	return 0;
-}
-
 static const struct watchdog_info orion_wdt_info =3D {
 	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 	.identity =3D "Orion Watchdog",
@@ -366,7 +359,6 @@ static const struct watchdog_ops orion_wdt_ops =3D {
 	.start =3D orion_wdt_start,
 	.stop =3D orion_wdt_stop,
 	.ping =3D orion_wdt_ping,
-	.set_timeout =3D orion_wdt_set_timeout,
 	.get_timeleft =3D orion_wdt_get_timeleft,
 };
=20
--=20
2.21.0

