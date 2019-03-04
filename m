Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB72070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="jAw72C7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfCDWwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:52:17 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53687 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCDWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:52:15 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EC70D891A9;
        Tue,  5 Mar 2019 11:52:13 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551739933;
        bh=OdfdthRlN2O3MGSbzK0x0yWQkuVhLUtpzxkEbn1J86A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jAw72C7dDUpNMesZGbH/otw45+m6eAEaA1c9K1xOSVdCHCeA7kVE1ufX6IZWbD8l4
         jaPcCFgZvZu5raw1H4HwKSqd2SPhrtipGz24GNOZ4gluYEu74Pm8GI+sNME2MnEQBI
         x/kQRMnOfTp4gtvAa/5YtStdI+rHz1sCgwNcYNgMoiJHmqIx0xTH5QjtxVuNr4WFPu
         N9HACsZytJK7SFjtHC30IWaCw4kdSJAh8fRpKeb7UqlVp5QaqdQ6uiKU73z1dSIroh
         HfbvrpreYG2jBK55znX/QTQ7JC5B29BYETLUyiktmwnuWbaQGWkp7L8RHF+r20KSXR
         +ZeCXNVyMT0og==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c7dac190000>; Tue, 05 Mar 2019 11:52:12 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 0653813EF73;
        Tue,  5 Mar 2019 11:52:11 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id BDDB91E1D96; Tue,  5 Mar 2019 11:52:10 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        jason@lakedaemon.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 1/2] watchdog: orion_wdt: remove orion_wdt_set_timeout
Date:   Tue,  5 Mar 2019 11:51:51 +1300
Message-Id: <20190304225152.26831-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
References: <20190227230707.GA28635@roeck-us.net>
 <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
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
---
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

