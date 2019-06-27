Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00014C5B54D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2022075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561669596;
	bh=nYdmMhUFK9FMRPU5WZYEIvshwyqtXLC0Q1Sl/ireAKo=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=gygQniDDiEGLsZFqzrR6E0BRHa6Fz7/rhJ1DfYOa+nT6eNhrD2O66CngtRwcTDC4x
	 M2D3BYkedXIf84jtHIzy1XFOaSqzYn12n+iiBDk3Md62Gs5YVbmcz0JN95YoaiL3tv
	 6Bvq1fbbcN4YjPsgH9+6o6Z22ckhxN920Oq3g6vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF0VGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0VGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:06:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21EC2075E;
        Thu, 27 Jun 2019 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561669593;
        bh=nYdmMhUFK9FMRPU5WZYEIvshwyqtXLC0Q1Sl/ireAKo=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=TrwmsBZG7FdloHabc4flDFrUpF+Ho9SkvJT79k5vOTBQa5al9KNxNtsNAKd49EJG+
         ah/haztTqqiUhIKjDddKYfQ7g6844bSHhbSoP5Qgx1dwEkfumbt/FbSTsWvAREC6TT
         kSq+tc/MZtIwx3+83FJpdYR06bfEPj4qSqSARIcM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190517132352.31221-1-mike.looijmans@topic.nl>
References: <20190424090038.18353-1-mike.looijmans@topic.nl> <155623538292.15276.10999401088770081919@swboyd.mtv.corp.google.com> <20190517132352.31221-1-mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] clk: Add Si5341/Si5340 driver
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 14:06:32 -0700
Message-Id: <20190627210633.A21EC2075E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2019-05-17 06:23:52)
> Adds a driver for the Si5341 and Si5340 chips. The driver does not fully
> support all features of these chips, but allows the chip to be used
> without any support from the "clockbuilder pro" software.
>=20
> If the chip is preprogrammed, that is, you bought one with some defaults
> burned in, or you programmed the NVM in some way, the driver will just
> take over the current settings and only change them on demand. Otherwise
> the input must be a fixed XTAL in its most basic configuration (no
> predividers, no feedback, etc.).
>=20
> The driver supports dynamic changes of multisynth, output dividers and
> enabling or powering down outputs and multisynths.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Applied to clk-next + some fixes. I'm not super thrilled about the kHz
thing but we don't have a solution for it right now so might as well
come back to it later.

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 1a310835b53c..72424eb7e5f8 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -374,7 +374,7 @@ static unsigned long si5341_clk_recalc_rate(struct clk_=
hw *hw,
 	 */
 	shift =3D 0;
 	res =3D m_num;
-	while (res & 0xffff00000000) {
+	while (res & 0xffff00000000ULL) {
 		++shift;
 		res >>=3D 1;
 	}
@@ -921,7 +921,7 @@ static int si5341_write_multiple(struct clk_si5341 *dat=
a,
 	return 0;
 }
=20
-const struct si5341_reg_default si5341_preamble[] =3D {
+static const struct si5341_reg_default si5341_preamble[] =3D {
 	{ 0x0B25, 0x00 },
 	{ 0x0502, 0x01 },
 	{ 0x0505, 0x03 },
@@ -994,7 +994,7 @@ static const struct regmap_range si5341_regmap_volatile=
_range[] =3D {
 	regmap_reg_range(SI5341_SYNTH_N_UPD(4), SI5341_SYNTH_N_UPD(4)),
 };
=20
-const struct regmap_access_table si5341_regmap_volatile =3D {
+static const struct regmap_access_table si5341_regmap_volatile =3D {
 	.yes_ranges =3D si5341_regmap_volatile_range,
 	.n_yes_ranges =3D ARRAY_SIZE(si5341_regmap_volatile_range),
 };
@@ -1016,7 +1016,6 @@ static const struct regmap_config si5341_regmap_confi=
g =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 8,
 	.cache_type =3D REGCACHE_RBTREE,
-	.max_register =3D 0,
 	.ranges =3D si5341_regmap_ranges,
 	.num_ranges =3D ARRAY_SIZE(si5341_regmap_ranges),
 	.max_register =3D SI5341_REGISTER_MAX,
@@ -1328,7 +1327,7 @@ MODULE_DEVICE_TABLE(i2c, si5341_id);
 static const struct of_device_id clk_si5341_of_match[] =3D {
 	{ .compatible =3D "silabs,si5340" },
 	{ .compatible =3D "silabs,si5341" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_si5341_of_match);
=20

