Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A4C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66311206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556226899;
	bh=/JGqUINK2o2pYurrs2MHU7TCgmj9EkCb7ch+7z0mFqM=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=NqT7figUaQmst2GDcVLldyUuSlJBg0OOBLQ7dvdEYHeHZRcpOSkxzx4YgXYqWstpm
	 NxPc1ZiF66H/2kQHEpItItCTrq7bsS84YkRzvZIhn2WjeATQ7H+0kr/NXn0o8oe7yo
	 3WIKvEV/7eN/wtR3LngTHqC44JxQwAO2SHjsPbzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfDYVO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfDYVO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:14:57 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8FA0206BA;
        Thu, 25 Apr 2019 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556226895;
        bh=/JGqUINK2o2pYurrs2MHU7TCgmj9EkCb7ch+7z0mFqM=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=PgCUlVrM7kPNW/Lk4gDr36xYD/nzfdZ+Vjjh2QzuWHl6wzCCStmCXY1DRHUVG3GYz
         obL3Ujlz0uH+a+THQ1M/QgOOtW5tBwU/lkoHAXj8pjwuewFYGLUYvShHtJEzIe+7bb
         oA0+jovG5omzM2gLL0syGacsUKtr54z3qZ7mNFHY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <155622589096.15276.8583738150370510787@swboyd.mtv.corp.google.com>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-8-alexandre.belloni@bootlin.com> <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com> <20190425203139.GO14604@piout.net> <155622589096.15276.8583738150370510787@swboyd.mtv.corp.google.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 7/7] clk: at91: add sam9x60 pmc driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155622689471.15276.16322042541342557062@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 14:14:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-25 13:58:10)
> Quoting Alexandre Belloni (2019-04-25 13:31:39)
> > On 25/04/2019 12:38:55-0700, Stephen Boyd wrote:
> > >=20
> > > const?
> > >=20
> >=20
> > Right, can you fix that up or should I send a new version?
> >=20
>=20
> I can fix it.

It's more complicated. I'll pile this patch on top. Maybe other
static data in drivers/clk/at91 can be const, but this at least covers
the struct clk_range ones.

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index b1af5a395423..0aabe49aed09 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -41,7 +41,7 @@ static u8 sam9260_plla_out[] =3D { 0, 2 };
=20
 static u16 sam9260_plla_icpll[] =3D { 1, 1 };
=20
-static struct clk_range sam9260_plla_outputs[] =3D {
+static const struct clk_range sam9260_plla_outputs[] =3D {
 	{ .min =3D 80000000, .max =3D 160000000 },
 	{ .min =3D 150000000, .max =3D 240000000 },
 };
@@ -58,7 +58,7 @@ static u8 sam9260_pllb_out[] =3D { 1 };
=20
 static u16 sam9260_pllb_icpll[] =3D { 1 };
=20
-static struct clk_range sam9260_pllb_outputs[] =3D {
+static const struct clk_range sam9260_pllb_outputs[] =3D {
 	{ .min =3D 70000000, .max =3D 130000000 },
 };
=20
@@ -128,7 +128,7 @@ static u8 sam9g20_plla_out[] =3D { 0, 1, 2, 3, 0, 1, 2,=
 3 };
=20
 static u16 sam9g20_plla_icpll[] =3D { 0, 0, 0, 0, 1, 1, 1, 1 };
=20
-static struct clk_range sam9g20_plla_outputs[] =3D {
+static const struct clk_range sam9g20_plla_outputs[] =3D {
 	{ .min =3D 745000000, .max =3D 800000000 },
 	{ .min =3D 695000000, .max =3D 750000000 },
 	{ .min =3D 645000000, .max =3D 700000000 },
@@ -151,7 +151,7 @@ static u8 sam9g20_pllb_out[] =3D { 0 };
=20
 static u16 sam9g20_pllb_icpll[] =3D { 0 };
=20
-static struct clk_range sam9g20_pllb_outputs[] =3D {
+static const struct clk_range sam9g20_pllb_outputs[] =3D {
 	{ .min =3D 30000000, .max =3D 100000000 },
 };
=20
@@ -182,7 +182,7 @@ static const struct clk_master_characteristics sam9261_=
mck_characteristics =3D {
 	.divisors =3D { 1, 2, 4, 0 },
 };
=20
-static struct clk_range sam9261_plla_outputs[] =3D {
+static const struct clk_range sam9261_plla_outputs[] =3D {
 	{ .min =3D 80000000, .max =3D 200000000 },
 	{ .min =3D 190000000, .max =3D 240000000 },
 };
@@ -199,7 +199,7 @@ static u8 sam9261_pllb_out[] =3D { 1 };
=20
 static u16 sam9261_pllb_icpll[] =3D { 1 };
=20
-static struct clk_range sam9261_pllb_outputs[] =3D {
+static const struct clk_range sam9261_pllb_outputs[] =3D {
 	{ .min =3D 70000000, .max =3D 130000000 },
 };
=20
@@ -262,7 +262,7 @@ static const struct clk_master_characteristics sam9263_=
mck_characteristics =3D {
 	.divisors =3D { 1, 2, 4, 0 },
 };
=20
-static struct clk_range sam9263_pll_outputs[] =3D {
+static const struct clk_range sam9263_pll_outputs[] =3D {
 	{ .min =3D 80000000, .max =3D 200000000 },
 	{ .min =3D 190000000, .max =3D 240000000 },
 };
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 5aeef68b4bdd..0ac34cdaa106 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -14,7 +14,7 @@ static const struct clk_master_characteristics sam9rl_mck=
_characteristics =3D {
=20
 static u8 sam9rl_plla_out[] =3D { 0, 2 };
=20
-static struct clk_range sam9rl_plla_outputs[] =3D {
+static const struct clk_range sam9rl_plla_outputs[] =3D {
 	{ .min =3D 80000000, .max =3D 200000000 },
 	{ .min =3D 190000000, .max =3D 240000000 },
 };
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index f5cfcbd85f10..0855f3a80cc7 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -17,7 +17,7 @@ static u8 plla_out[] =3D { 0, 1, 2, 3, 0, 1, 2, 3 };
=20
 static u16 plla_icpll[] =3D { 0, 0, 0, 0, 1, 1, 1, 1 };
=20
-static struct clk_range plla_outputs[] =3D {
+static const struct clk_range plla_outputs[] =3D {
 	{ .min =3D 745000000, .max =3D 800000000 },
 	{ .min =3D 695000000, .max =3D 750000000 },
 	{ .min =3D 645000000, .max =3D 700000000 },
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index fb9e9c4cdc8d..775b77a433f5 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -66,7 +66,7 @@ extern const struct clk_pll_layout sama5d3_pll_layout;
 struct clk_pll_characteristics {
 	struct clk_range input;
 	int num_output;
-	struct clk_range *output;
+	const struct clk_range *output;
 	u16 *icpll;
 	u8 *out;
 	u8 upll : 1;
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 864ac060aed6..6340b1fc1828 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -21,7 +21,7 @@ static const struct clk_master_layout sam9x60_master_layo=
ut =3D {
 	.offset =3D 0x28,
 };
=20
-static struct clk_range plla_outputs[] =3D {
+static const struct clk_range plla_outputs[] =3D {
 	{ .min =3D 300000000, .max =3D 600000000 },
 };
=20
@@ -31,7 +31,7 @@ static const struct clk_pll_characteristics plla_characte=
ristics =3D {
 	.output =3D plla_outputs,
 };
=20
-static struct clk_range upll_outputs[] =3D {
+static const struct clk_range upll_outputs[] =3D {
 	{ .min =3D 300000000, .max =3D 500000000 },
 };
=20
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 096156850e08..f3d3f6c8e261 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -16,7 +16,7 @@ static u8 plla_out[] =3D { 0 };
=20
 static u16 plla_icpll[] =3D { 0 };
=20
-static struct clk_range plla_outputs[] =3D {
+static const struct clk_range plla_outputs[] =3D {
 	{ .min =3D 600000000, .max =3D 1200000000 },
 };
=20
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 840edca77821..25b156d4e645 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -16,7 +16,7 @@ static u8 plla_out[] =3D { 0 };
=20
 static u16 plla_icpll[] =3D { 0 };
=20
-static struct clk_range plla_outputs[] =3D {
+static const struct clk_range plla_outputs[] =3D {
 	{ .min =3D 600000000, .max =3D 1200000000 },
 };
=20
