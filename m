Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA5C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8B720879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558719897;
	bh=sCIfw30J0pAhw/lm4LEPayxbqHC+/EzITfD3eOsrjCY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xghGvXp6ZjcHKNAMiD4h9r8ZOfMnmIMBoWcnorIWyPCoZ24iv+gCygF9PfOFy1bOm
	 XUKrFXEm8fvQwHZEZHyKQtCXkqyrG71x8ujwRVmRk57SmzrAL4nL5UNydE8wVyU/iw
	 0UfkFihZWGLfA0mJ5G7ZsSfq6EvVFCfLJU3zrj2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbfEXRo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfEXRo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:44:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8043420879;
        Fri, 24 May 2019 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558719894;
        bh=sCIfw30J0pAhw/lm4LEPayxbqHC+/EzITfD3eOsrjCY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BRC7nsmcKnJM8nbaZSMpC2u30M7sxPX/5eLN6EwUk/s9Qrls920l1sAzkLCY4JQhG
         r1pJJqFUZ4yCf1I+mw91Itqqonih6onfNVqOLdc8tC7HQtbmyIu6LdYYFqSQ1yh90u
         GeNX33jIiAbkWf55vdh0GHY6dxvqBTDr8YXv86MU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c89ecb6f328014ce22ae5d6c634e5337dbbf3ea2.camel@baylibre.com>
References: <20190524072745.27398-1-amergnat@baylibre.com> <20190524143355.5586D2133D@mail.kernel.org> <c89ecb6f328014ce22ae5d6c634e5337dbbf3ea2.camel@baylibre.com>
Subject: Re: [PATCH] clk: fix clock global name usage.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        baylibre-upstreaming@groups.io
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, mturquette@baylibre.com
User-Agent: alot/0.8.1
Date:   Fri, 24 May 2019 10:44:53 -0700
Message-Id: <20190524174454.8043420879@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-05-24 08:00:08)
> On Fri, 2019-05-24 at 07:33 -0700, Stephen Boyd wrote:
> > Do you set the index to 0 in this clk's parent_data? We purposefully set
> > the index to -1 in clk_core_populate_parent_map() so that the fw_name
> > can be NULL but the index can be something >=3D 0 and then we'll use th=
at
> > to lookup the clk from DT. We need to support that combination.
> >=20
> >         fw_name   |   index |  DT lookup?
> >         ----------+---------+------------
> >         NULL      |    >=3D 0 |     Y
> >         NULL      |    -1   |     N
> >         non-NULL  |    -1   |     ?
> >         non-NULL  |    >=3D 0 |     Y
> >=20
> > Maybe we should support the ? case, because right now it will fail to do
> > the DT lookup when the index is -1.
>=20
> Hi Stephen,
>=20
> We are trying to migrate all meson clocks to the new parent structure.
> There is a little quirk which forces us to continue to use legacy names
> for a couple of clocks.
>=20
> We heavily use static data which init everything to 0.
> Here is an example:
>=20
> static struct clk_regmap g12a_aoclk_cts_rtc_oscin =3D {
> [...]
>         .hw.init =3D &(struct clk_init_data){
>                 .name =3D "g12a_ao_cts_rtc_oscin",
>                 .ops =3D &clk_regmap_mux_ops,
> -               .parent_names =3D (const char *[]){ "g12a_ao_32k_by_oscin=
",
> -                                                 IN_PREFIX "ext_32k-0" },
> +               .parent_data =3D (const struct clk_parent_data []) {
> +                       { .name =3D "g12a_ao_32k_by_oscin" },
> +                       { .fw_name =3D "ext-32k-0", },
> +               },
>                 .num_parents =3D 2,
>                 .flags =3D CLK_SET_RATE_PARENT,
>         },
> };
>=20
> With this, instead of taking name =3D "g12a_ao_32k_by_oscin" for entry #0
> it takes DT names at index 0 which is not what we intended.
>=20
> If I understand correctly we should put
> +                       { .name =3D "g12a_ao_32k_by_oscin", index =3D -1,=
 },
>=20
> And would be alright ?

I don't understand why this wouldn't have a .fw_name or an .index >=3D 0,
or both. Is there some reason why that isn't happening?

>=20
> While I understand it, it is not very obvious or nice to look at.
> Plus it is a bit weird that this -1 is required for .name and not .hw.

Sure. It can be better documented. Sorry it's not super obvious. I added
this later in the series. We could have:

	#define CLK_SKIP_FW_LOOKUP .index =3D -1

and then this would read as:

        { .name =3D "g12a_ao_32k_by_oscin", CLK_SKIP_FW_LOOKUP },

>=20
> Do you think we could come up with a priority order which makes the first
> example work ?

Maybe? I'm open to suggestions.

>=20
> Something like:
>=20
> if (hw) {
>         /* use pointer */
> } else if (name) {
>         /* use legacy global names */

I don't imagine we can get rid of legacy name for a long time, so this
can't be in this order. Otherwise we'll try to lookup the legacy name
before trying the DT lookup and suffer performance hits doing a big
global search while also skipping the DT lookup that we want drivers to
use if they're more modern.

> } else if (fw_name) {
>         /* use DT names */
> } else if (index >=3D 0)=20
>         /* use DT index */
> } else {
>         return -EINVAL;
> }
>=20
> The last 2 clause could be removed if we make index an unsigned.
>=20

So just assign -1 to .index? I still think my patch may be needed if
somehow the index is assigned to something less than 0 and the .fw_name
is specified. I guess that's possible if the struct is on the stack, so
we'll probably have to allow this combination.

