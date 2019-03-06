Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF00C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DD320854
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551894537;
	bh=vt77DZ7NRZimiia6SKeMbAdbmWd8wcoWdAaPHVHbXA8=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=EMC2ffGPkV/zdRLqdLjdqes+I2r4AyVw3VyFINJ/VqBCXhUwCT2lRdsRcP/jlrzo5
	 Eeh9nZ3xUG75+67cS32L9f8R200SAqvtYoxVk9PBc47tvRRNKqg1FaF754LjHHdvH6
	 0wTgSdbbaHpQJ4R9izp+OJ729PXckWjsXEamr+Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCFRsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfCFRsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:48:55 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E007E20661;
        Wed,  6 Mar 2019 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551894534;
        bh=vt77DZ7NRZimiia6SKeMbAdbmWd8wcoWdAaPHVHbXA8=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=uWfP39y8N1JraD3CT+600lPbs/9qYunduXFkS4FYwZF1dg3I8pkRnNqPPFJkaj7gH
         Y6brIRjZo2cHxY0RTfCur95uF2FZXbdqCIjSvGO265u06jnKE4Z2I7X9gNndrbDL2k
         8gHlLSrjqvNAuAOSXx0ewkhBRzli598pYdEvhs6k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c5b12b52-0aa0-417b-50cd-b7d6fd9fc992@codeaurora.org>
References: <20190226223429.193873-1-sboyd@kernel.org> <20190226223429.193873-7-sboyd@kernel.org> <c5b12b52-0aa0-417b-50cd-b7d6fd9fc992@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 6/8] clk: Allow parents to be specified without string names
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155189453289.20095.9593541968121360874@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 06 Mar 2019 09:48:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-03-02 13:25:06)
> On 2/26/2019 3:34 PM, Stephen Boyd wrote:
> > The common clk framework is lacking in ability to describe the clk
> > topology without specifying strings for every possible parent-child
> > link. There are a few drawbacks to the current approach:
> >=20
> >   1) String comparisons are used for everything, including describing
> >   topologies that are 'local' to a single clock controller.
> >=20
> >   2) clk providers (e.g. i2c clk drivers) need to create globally unique
> >   clk names to avoid collisions in the clk namespace, leading to awkward
> >   name generation code in various clk drivers.
> >=20
> >   3) DT bindings may not fully describe the clk topology and linkages
> >   between clk controllers because drivers can easily rely on globally u=
nique
> >   strings to describe connections between clks.
> >=20
> > This leads to confusing DT bindings, complicated clk name generation
> > code, and inefficient string comparisons during clk registration just so
> > that the clk framework can detect the topology of the clk tree.
> > Furthermore, some drivers call clk_get() and then __clk_get_name() to
> > extract the globally unique clk name just so they can specify the parent
> > of the clk they're registering. We have of_clk_parent_fill() but that
> > mostly only works for single clks registered from a DT node, which isn't
> > the norm. Let's simplify this all by introducing two new ways of
> > specifying clk parents.
> >=20
> > The first method is an array of pointers to clk_hw structures
> > corresponding to the parents at that index. This works for clks that are
> > registered when we have access to all the clk_hw pointers for the
> > parents.
> >=20
> > The second method is a mix of clk_hw pointers and strings of local and
> > global parent clk names. If the .name member of the map is set we'll
> > look for that clk by performing a DT based lookup of the device the clk
> > is registered with and the .name specified in the map. If that fails,
> > we'll fallback to the .fallback member and perform a global clk name
> > lookup like we've always done before.
> >=20
> > Using either one of these new methods is entirely optional. Existing
> > drivers will continue to work, and they can migrate to this new approach
> > as they see fit. Eventually, we'll want to get rid of the 'parent_names'
> > array in struct clk_init_data and use one of these new methods instead.
> >=20
>=20
> I don't know exactly what regressed from V1, but this change breaks all=20
> clock drivers as far as I can tell.  All clocks from old and new (ie=20
> 8998 mmcc rebased onto this) drivers end up as orphans.
>=20
> Is there some data I can provide to help you figure out the issue?
>=20

Can you try this patch? It fixes a pointer blunder that I'm sad about.

----8<-----
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 37aea7884166..d12afd256dc5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3297,15 +3297,17 @@ struct clk *clk_hw_create_clk(struct device *dev, s=
truct clk_hw *hw,
 	return clk;
 }
=20
-static int clk_cpy_name(const char *dst, const char *src, bool must_exist)
+static int clk_cpy_name(const char **dst_p, const char *src, bool must_exi=
st)
 {
+	const char *dst;
+
 	if (!src) {
 		if (must_exist)
 			return -EINVAL;
 		return 0;
 	}
=20
-	dst =3D kstrdup_const(src, GFP_KERNEL);
+	*dst_p =3D dst =3D kstrdup_const(src, GFP_KERNEL);
 	if (!dst)
 		return -ENOMEM;
=20
@@ -3341,14 +3343,14 @@ static int clk_core_populate_parent_map(struct clk_=
core *core)
 			WARN(!parent_names[i],
 				"%s: invalid NULL in %s's .parent_names\n",
 				__func__, core->name);
-			ret =3D clk_cpy_name(parent->name, parent_names[i],
+			ret =3D clk_cpy_name(&parent->name, parent_names[i],
 					   true);
 		} else if (parent_data) {
 			parent->hw =3D parent_data[i].hw;
-			ret =3D clk_cpy_name(parent->fw_name,
+			ret =3D clk_cpy_name(&parent->fw_name,
 					   parent_data[i].fw_name, false);
 			if (!ret)
-				ret =3D clk_cpy_name(parent->name,
+				ret =3D clk_cpy_name(&parent->name,
 						   parent_data[i].name,
 						   false);
 		} else if (parent_hws) {
