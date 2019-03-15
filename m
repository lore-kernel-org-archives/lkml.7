Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B809C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C95218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552670223;
	bh=V3/XgsQWVmPCXl4GDlQD79hp94lmq10+5QAqPCddwss=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=Xp9J19x+UO++Bq842zBjM/R5qDHbYmMNk0hAgZu2Ayfu+cjYVKY0i3zep47lX+6zN
	 nhhaG2a4wzxGZIO8pMQDHTfe420gzLXy/ZEELTibBA5uTeVMVrliQ329WAGjWbGB+o
	 CgT8uJZI0uSKQ2+LU9ZBI4DC2Vh18NeyO5q2hEz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfCORRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfCORRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:17:01 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA8721019;
        Fri, 15 Mar 2019 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552670220;
        bh=V3/XgsQWVmPCXl4GDlQD79hp94lmq10+5QAqPCddwss=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=DGyXZRh4ufdls23OelKLRSrvihXBHg7ql0YkMRNtlzVz/aSCH1IKWvAVeFJEtn50M
         VtJoAUMEx11YABdxMbMp3h6+Dr9/SzKdVS85BR0CDCxDTrkg9XqJUgTF8Z7zFTvHjt
         3cwQh6PAh0yn6R6GHf5FAC3BhNVPQkSCFDKQPLfs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3e6aa4c392ccdd3bac76b556645139536e61e5e6.camel@baylibre.com>
References: <20190226223429.193873-1-sboyd@kernel.org> <20190226223429.193873-7-sboyd@kernel.org> <3e6aa4c392ccdd3bac76b556645139536e61e5e6.camel@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 6/8] clk: Allow parents to be specified without string names
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155267021941.20095.16439182841724325601@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 15 Mar 2019 10:16:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-03-15 03:01:53)
> On Tue, 2019-02-26 at 14:34 -0800, Stephen Boyd wrote:
> > ---
> >  drivers/clk/clk.c            | 260 ++++++++++++++++++++++++++---------
> >  include/linux/clk-provider.h |  19 +++
> >  2 files changed, 217 insertions(+), 62 deletions(-)
>=20
> Sorry for the delay.
>=20
> With the fix you sent to Jeffrey
> Tested by porting the aoclk controller of Amlogic g12a SoC.
> This allowed to test
>  * hws only table
>  * parent_data with a mix of hw pointers and fw_name (with different input
> controllers and also an input that is optional and never provided)
>=20
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
>=20
> With the small comment below
>=20
> Reviewed-by Jerome Brunet <jbrunet@baylibre.com>
>=20

Awesome. Thanks! I need to Cc Rob H to hopefully get an ack on the
concept of relying on DT so I'll resend this series again next week. It
would also be nice if I can throw in a couple more patches to let
drivers specify a DT node when registering a clk if they don't have a
struct device on hand and let drivers lookup with clk_lookups somehow.

>=20
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 937b8d092d17..3d01e8c56400 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -39,6 +39,13 @@ static LIST_HEAD(clk_notifier_list);
> > =20
>=20
> [...]
>=20
> > =20
> > +static int clk_cpy_name(const char *dst, const char *src, bool must_ex=
ist)
> > +{
> > +     if (!src) {
> > +             if (must_exist)
> > +                     return -EINVAL;
> > +             return 0;
> > +     }
> > +
> > +     dst =3D kstrdup_const(src, GFP_KERNEL);
> > +     if (!dst)
> > +             return -ENOMEM;
> > +
> > +     return 0;
> > +}
> > +
> > +static int clk_core_populate_parent_map(struct clk_core *core)
> > +{
> > +     const struct clk_init_data *init =3D core->hw->init;
> > +     u8 num_parents =3D init->num_parents;
> > +     const char * const *parent_names =3D init->parent_names;
> > +     const struct clk_hw **parent_hws =3D init->parent_hws;
> > +     const struct clk_parent_data *parent_data =3D init->parent_data;
> > +     int i, ret =3D 0;
> > +     struct clk_parent_map *parents, *parent;
> > +
> > +     if (!num_parents)
> > +             return 0;
> > +
> > +     /*
> > +      * Avoid unnecessary string look-ups of clk_core's possible paren=
ts by
> > +      * having a cache of names/clk_hw pointers to clk_core pointers.
> > +      */
> > +     parents =3D kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
> > +     core->parents =3D parents;
> > +     if (!parents)
> > +             return -ENOMEM;
> > +
> > +     /* Copy everything over because it might be __initdata */
> > +     for (i =3D 0, parent =3D parents; i < num_parents; i++, parent++)=
 {
> > +             if (parent_names) {
> > +                     /* throw a WARN if any entries are NULL */
> > +                     WARN(!parent_names[i],
> > +                             "%s: invalid NULL in %s's .parent_names\n=
",
> > +                             __func__, core->name);
> > +                     ret =3D clk_cpy_name(parent->name, parent_names[i=
],
> > +                                        true);
> > +             } else if (parent_data) {
>=20
> While testing, I mistakenly left both parent_names and parent_data. I was
> surprised that parent_data did not take precedence of parent_names.
>=20
> Maybe it should ? (... but I understand we are not supposed to provide bo=
th)

I don't think we can. We have a problem where drivers don't initialize
the init structure properly, opting to just throw it on the stack and
leave junk in there that they overwrite. We'd have to go through all the
init structures and initialize them. I suppose we could make a macro for
that:

	DECLARE_CLK_INIT_DATA(init);

or something like that that does this. We could bury a magic number in
there under some debug option too so that we can make sure drivers are
doing this properly. Otherwise we're left to doing these weird tricks
like I've done here.

Regardless. I'll have to add a comment to this fact in the code. Thanks.

>=20
> > +                     parent->hw =3D parent_data[i].hw;
> > +                     ret =3D clk_cpy_name(parent->fw_name,
> > +                                        parent_data[i].fw_name, false);
> > +                     if (!ret)
> > +                             ret =3D clk_cpy_name(parent->name,
> > +                                                parent_data[i].name,
> > +                                                false);
> > +             } else if (parent_hws) {
> > +                     parent->hw =3D parent_hws[i];
> > +             } else {
>=20
> Maybe there should also some kinda of check to verify if more than one op=
tion
> (among hws, parent_data and parent_names) was provided and throw a warn ?
>=20
> Could be useful with drivers move away from parent_names ?

Same thing. It would be nice but we're sort of unable to do so unless we
do what I suggest above. Should we do it?

