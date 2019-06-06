Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E073CC28EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C612089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559861681;
	bh=e+pZdpg3uSPIE9ccaCmU3TARwAieHjv2LjSK1CmQi4E=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=zIqTAoBcxkzc9BZLWAcbQW8q2YS29FCBVBioHywBJT/9IDQenGkL9Mwz/fSQp5u22
	 ENmLlWxPKpdubWKEUOGc9r82DAicUh1lacWx/Fb5QRkngO//orswf5cnUsXj4IjCap
	 04HBxwJiRhPTBjSaALml64nv0iKuxjFilAP1Sd3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfFFWyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfFFWyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:54:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F175A2089E;
        Thu,  6 Jun 2019 22:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559861679;
        bh=e+pZdpg3uSPIE9ccaCmU3TARwAieHjv2LjSK1CmQi4E=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=yMVjEVSSRtjQ9hzwL5qW2UywSczDJRmUjJLtTddGujIUCshy2h1jwdWM1PmOC2biI
         sbGj7Ww5HDTXpEI11ZhCkP7J+cdH83nuxES8c8EzPQC6EBcm9RibPxHlkkgEtVGhWd
         gc2WrocgCnGT1b/FptyiljpnVFAqLby2oQ3qNANA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5795a73002f2c787b545308585f0437eb5aa2f72.camel@baylibre.com>
References: <20190524072745.27398-1-amergnat@baylibre.com> <20190524143355.5586D2133D@mail.kernel.org> <c89ecb6f328014ce22ae5d6c634e5337dbbf3ea2.camel@baylibre.com> <20190524174454.8043420879@mail.kernel.org> <5795a73002f2c787b545308585f0437eb5aa2f72.camel@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: fix clock global name usage.
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        baylibre-upstreaming@groups.io
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 15:54:38 -0700
Message-Id: <20190606225438.F175A2089E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I'm getting back from some vacations and I'm working through the
backlog.

Quoting Jerome Brunet (2019-05-24 11:12:30)
> On Fri, 2019-05-24 at 10:44 -0700, Stephen Boyd wrote:
> > Quoting Jerome Brunet (2019-05-24 08:00:08)
> > > On Fri, 2019-05-24 at 07:33 -0700, Stephen Boyd wrote:
> > > > Do you set the index to 0 in this clk's parent_data? We purposefull=
y set
> > > > the index to -1 in clk_core_populate_parent_map() so that the fw_na=
me
> > > > can be NULL but the index can be something >=3D 0 and then we'll us=
e that
> > > > to lookup the clk from DT. We need to support that combination.
> > > >=20
> > > >         fw_name   |   index |  DT lookup?
> > > >         ----------+---------+------------
> > > >         NULL      |    >=3D 0 |     Y
> > > >         NULL      |    -1   |     N
>=20
> These two I understand
>=20
> > > >         non-NULL  |    -1   |     ?
>=20
> If fw_name is provided, you have everything you need to get the clock, wh=
y the ?

I was representing the current code and the discussion we were having.
If we apply the patch I suggested earlier then we'll make this into a
'Y'.

I thought your code fell into the first case though; NULL fw_name and
index >=3D 0, so we do the DT lookup and everything blows up because that
parent isn't the one expected.

>=20
> > > >         non-NULL  |    >=3D 0 |     Y
>=20
> If both fw_name and index are provided, how do you perform the look up ? =
using
> the index ? or the fw_name ?=20

We use the fw_name and if that isn't provided, then we use the index.
This is how the logic was written for DT parsing of clks originally, so
I'm just continuing the same logic (see of_parse_clkspec() for more
details).

>=20
> > > >=20
> > > > Maybe we should support the ? case, because right now it will fail =
to do
> > > > the DT lookup when the index is -1.

Yeah, this part. I think it's fine to do this.

> > >=20
> > > We are trying to migrate all meson clocks to the new parent structure.
> > > There is a little quirk which forces us to continue to use legacy nam=
es
> > > for a couple of clocks.
> > >=20
> > > We heavily use static data which init everything to 0.
> > > Here is an example:
> > >=20
> > > static struct clk_regmap g12a_aoclk_cts_rtc_oscin =3D {
> > > [...]
> > >         .hw.init =3D &(struct clk_init_data){
> > >                 .name =3D "g12a_ao_cts_rtc_oscin",
> > >                 .ops =3D &clk_regmap_mux_ops,
> > > -               .parent_names =3D (const char *[]){ "g12a_ao_32k_by_o=
scin",
> > > -                                                 IN_PREFIX "ext_32k-=
0" },
> > > +               .parent_data =3D (const struct clk_parent_data []) {
> > > +                       { .name =3D "g12a_ao_32k_by_oscin" },
> > > +                       { .fw_name =3D "ext-32k-0", },
> > > +               },
> > >                 .num_parents =3D 2,
> > >                 .flags =3D CLK_SET_RATE_PARENT,
> > >         },
> > > };
> > >=20
> > > With this, instead of taking name =3D "g12a_ao_32k_by_oscin" for entr=
y #0
> > > it takes DT names at index 0 which is not what we intended.
> > >=20
> > > If I understand correctly we should put
> > > +                       { .name =3D "g12a_ao_32k_by_oscin", index =3D=
 -1, },
> > >=20
> > > And would be alright ?
> >=20
> > I don't understand why this wouldn't have a .fw_name or an .index >=3D =
0,
> > or both. Is there some reason why that isn't happening?
>=20
> And now its me not following :)
>=20
> In the case I presenting, I only defined the (legacy) name because that w=
e want
> to use. In another thread, I'll explain the particular problem that make =
us use
> this legacy name, I just to dont want to over complicate this topic now.

Ok. So you have a mixture of some parents with only the legacy name and
then other clks with some parents in the new style? As long as we
understand each other I think we'll figure it out.

>=20
> >=20
> > > While I understand it, it is not very obvious or nice to look at.
> > > Plus it is a bit weird that this -1 is required for .name and not .hw.
> >=20
> > Sure. It can be better documented. Sorry it's not super obvious. I added
> > this later in the series. We could have:
> >=20
> >       #define CLK_SKIP_FW_LOOKUP .index =3D -1
> >=20
> > and then this would read as:
> >=20
> >         { .name =3D "g12a_ao_32k_by_oscin", CLK_SKIP_FW_LOOKUP },
>=20
> Sure but it is still a bit ugly and un-intuitive. If I only defined the l=
egacy
> name, it's pretty obvious that what I want to use ... I should not have to
> insist :)

Agreed, but you've implicitly defined the .fw_name to NULL and the
.index to 0, so you're insisting that an index of 0 should be used,
albeit implicitly so.

>=20
> And again the fact that (legacy) .name is silently discarded if index is =
not
> defined, but .hw or .fw_name are taken into account no matter what is not
> consistent

Hmmm I made the assumption that if you were going to use the new
structure that you would be using "clock-names" (.fw_name) or an index
for everything and then falling back to .name for legacy migration
reasons. I didn't really consider that a mix of .name and .fw_name
would be used for different parent indices.

>=20
> >=20
> > > Do you think we could come up with a priority order which makes the f=
irst
> > > example work ?
> >=20
> > Maybe? I'm open to suggestions.
> >=20
> > > Something like:
> > >=20
> > > if (hw) {
> > >         /* use pointer */
> > > } else if (name) {
> > >         /* use legacy global names */
> >=20
> > I don't imagine we can get rid of legacy name for a long time, so this
> > can't be in this order. Otherwise we'll try to lookup the legacy name
> > before trying the DT lookup and suffer performance hits doing a big
> > global search while also skipping the DT lookup that we want drivers to
> > use if they're more modern.
>=20
> You'll try to look up the legacy name only if it is defined, in which cas=
e you
> know you this is what you want to use, so I don't see the penalty.  Unles=
s ...

We'll only try the legacy name if all else fails. We're hoping that
.fw_name or .hw is used instead because those are faster than string
comparisons on the entire tree.

>=20
> Are trying to support case where multiple fields among hw, name, fw_name,=
 index
> would be defined simultaneously ??

Yes.

>=20
> IMO, it would be weird and very confusing.

Let's expand the table.

    .fw_name   |  .index |  .name      | DT lookup? | fallback to legacy?=20
   +-----------+---------+-------------+----+----------------------------
 1 | NULL      |    >=3D 0 |  NULL       |    Y       |         N
 2 | NULL      |    -1   |  NULL       |    N       |         N
 3 | non-NULL  |    -1   |  NULL       |    Y       |         N
 4 | non-NULL  |    >=3D 0 |  NULL       |    Y       |         N
 5 | NULL      |    >=3D 0 |  non-NULL   |    Y       |         Y
 6 | NULL      |    -1   |  non-NULL   |    N       |         Y
 7 | non-NULL  |    -1   |  non-NULL   |    Y       |         Y
 8 | non-NULL  |    >=3D 0 |  non-NULL   |    Y       |         Y

And then if .hw is set we just don't even try to use the above table.

You want case #5 to skip the DT lookup because .fw_name is NULL, but the
index is 0. I stared at this for a few minutes and I think you're
arguing that we should only do the DT lookup when index is 0 if we can't
fallback to a legacy lookup.

Initially that sounds OK, but then we'll get stuck with legacy lookups
forever if someone doesn't put a matching .fw_name into the
'clock-names' property. We don't want that to happen. We want to get off
legacy and into the new world where either .fw_name or .index is used to
specify a parent.

From my perspective you're suffering from static initializers setting
everything to 0 and that making the index 0 and "valid" for a DT lookup
hitting up against not wanting to set anything in the structure
unnecessarily. While at the same time, it's great that .fw_name is set
to NULL by the static initializer, so it's a case of wanting the same
thing to do different things.

If we would have made it so the DT index started at 1 then this wouldn't
be a problem, but that's not possible. Or if we would have made a new
clk flag that said CLK_USE_INDEX_FOR_DT then it could have gotten over
this problem but that's basically the same as making the inverse set of
drivers use -1 for the index to indicate they don't want a DT lookup.

I still believe the large majority of clk drivers will either use .hw or
.fw_name to find parents, while falling back to the .name for legacy
reasons. The .index field won't see much use, but we'll support it for
the firmwares out there that don't use "clock-names". Similarly, we'll
have only a handful of drivers that only want to specify .name and
nothing else, and those few drivers can use .index =3D -1 to overcome
this.

> > > } else if (fw_name) {
> > >         /* use DT names */
> > > } else if (index >=3D 0)=20
> > >         /* use DT index */
> > > } else {
> > >         return -EINVAL;
> > > }
> > >=20
> > > The last 2 clause could be removed if we make index an unsigned.
> > >=20
> >=20
> > So just assign -1 to .index? I still think my patch may be needed if
> > somehow the index is assigned to something less than 0 and the .fw_name
> > is specified. I guess that's possible if the struct is on the stack, so
> > we'll probably have to allow this combination.
>=20
> Maybe it just solve the problem, I don't fully understand its implication=
. I
> might need to try it, and see
>=20
> >=20
>=20
> digressing a bit ...
>=20
> I don't remember seeing the index field in the initial review of your ser=
ies ?
> what made you add this ?
>=20
> Isn't it simpler to mandate the use of the clock-names property ? Referri=
ng to
> the clock property by index is really weak and should discouraged IMO.
>=20
>=20

We need to support DTBs that don't specify "clock-names". The
"clock-names" property isn't mandatory, just strongly recommended, and
we have various bits of code like the fixed factor clk that don't expect
to see a name, just use some index like 0 to get the parent clk. I don't
want to go retroactively force a bunch of DT to get "clock-names"
properties in them so that they can work with the new style of parents.
And I don't want them to be stuck calling of_clk_parent_fill() or
of_clk_get() to parse that index and grab the clk name out during
registration.

