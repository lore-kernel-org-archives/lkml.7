Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A6C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40912087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556655767;
	bh=Kv35gbOtGUQkDfxOeQBvLR2bGLEYXN6clOrVIU0lC1s=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=IIfFna5CDL7knM3bDjbJY96uEXgAdboI1VhOPpS9uvvCv+Dd34wZHOouNyTXGo1aW
	 V370BaJCoKy8lG9BrmvV0gNJDF8p9DmHHIwQW0btZu2MMqESSRhjZ4qdtxXOY+EPPy
	 mGFiZ1fYmMjTG2hJ65icp4EmpJtJML3C1it2oznU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfD3UWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3UWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:22:46 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76632087B;
        Tue, 30 Apr 2019 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556655764;
        bh=Kv35gbOtGUQkDfxOeQBvLR2bGLEYXN6clOrVIU0lC1s=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=fePt9ZRbemBNqPP3fkd7BgqIGS4kI8msSLWCybbFG40jToYR6zcCV3e1wmg5VSqXs
         V86nT4D1vCZhFWqangwzpie4ZpOuQGkFeMoLPnKBZ5sHe8+2IWooEtkcrf9nKpuf6U
         KN3PCrCVMr5mu/EEXkgsl02RTv8UWjAFr39PD8yM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <alpine.DEB.2.21.9999.1904291506060.7063@viisi.sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com> <155656941055.168659.18136739282359756367@swboyd.mtv.corp.google.com> <alpine.DEB.2.21.9999.1904291506060.7063@viisi.sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/3] clk: analogbits: add Wide-Range PLL library
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Megan Wachs <megan@sifive.com>
Message-ID: <155665576397.168659.15988829291472885637@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 30 Apr 2019 13:22:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-29 18:14:14)
> On Mon, 29 Apr 2019, Stephen Boyd wrote:
> >=20
> > Nitpick: This might be easier to read with a switch statement:
> >=20
> >       switch (post_divr_freq) {
> >       case 0 ... 11000000:
> >               return 1;
> >       case 11000001 ... 18000000:
> >               return 2;
> >       case 18000001 ... 30000000:
> >               return 3;
> >       case 30000001 ... 50000000:
> >               return 4;
> >       case 50000000 ... 80000000:
> >               return 5;
> >       case 80000001 ... 130000000:
> >               return 6;
> >       }
> >=20
> >       return 7;
>=20
> To be equivalent to the original code, we'd need to write:
>=20
>        switch (post_divr_freq) {
>        case 0 ... 10999999:
>                return 1;
>        case 11000000 ... 17999999:
>                return 2;
> (etc.)
>=20
> In any case, it's been changed to use the gcc case range operator.

Ah right, thanks!

> > > +{
> > > +       return (c->flags & WRPLL_FLAGS_INT_FEEDBACK_MASK) ? 2 : 1;
> > > +}
> > > +
> > > +/**
> > > + * __wrpll_calc_divq() - determine DIVQ based on target PLL output c=
lock rate
> > > + * @target_rate: target PLL output clock rate
> > > + * @vco_rate: pointer to a u64 to store the computed VCO rate into
> > > + *
> > > + * Determine a reasonable value for the PLL Q post-divider, based on=
 the
> > > + * target output rate @target_rate for the PLL.  Along with returnin=
g the
> > > + * computed Q divider value as the return value, this function store=
s the
> > > + * desired target VCO rate into the variable pointed to by @vco_rate.
> > > + *
> > > + * Context: Any context.  Caller must protect the memory pointed to =
by
> > > + *          @vco_rate from simultaneous access or modification.
> > > + *
> > > + * Return: a positive integer DIVQ value to be programmed into the h=
ardware
> > > + *         upon success, or 0 upon error (since 0 is an invalid DIVQ=
 value)
> >=20
> > Why are we doing that? Can't we return a normal error code and test for
> > it being negative and then consider the number if its greater than 0 to
> > be valid?
>=20
> One motivation here is that this function returns a divisor value.  So a =

> zero represents a divide by zero, which is intrinsically an error for a=20
> function that returns a divisor.  The other motivation is that the curren=
t=20
> return value directly maps to what the hardware expects to see.
> =20
> Let me know if you want me to change this anyway.

Ok, sounds fine.

>  =20
> > > + */
> > > +static u8 __wrpll_calc_divq(u32 target_rate, u64 *vco_rate)
> >=20
> > Why does target_rate need to be u32?=20
>=20
> I don't think there's any specific requirement for it to be a u32.

Ok.

>=20
> > Can it be unsigned long?
>=20
> There are two basic principles motivating this:
>=20
> 1. Use the shortest type that fits what will be contained in the variable.
>    This increases the chance that static analysis will catch any=20
>    inadvertent overflows (for example, via gcc -Woverflow).
>=20
> 2. Use fixed-width types for hardware-constrained values that are=20
>    unrelated to the CPU's native word length.  This is a general design=20
>    practice, both to avoid confusion as to whether the variable's range=20
>    does in fact depend on the compiler's implementation, and to avoid API=
=20
>    problems if the width does change.  Although this last case doesn't=20
>    apply here, the general application of this practice avoids problems=20
>    like the longstanding API problem we've had with clk_set_rate(), which=
=20
>    can't take a 64 bit clock rate argument if the kernel is built with a =

>    compiler that uses 32 bit longs.
>=20

Sure, makes sense.

>=20
> > > +
> > > +       if (parent_rate > MAX_INPUT_FREQ || parent_rate < MIN_POST_DI=
VR_FREQ)
> > > +               return -1;
> > > +
> > > +       c->parent_rate =3D parent_rate;
> > > +       max_r_for_parent =3D div_u64(parent_rate, MIN_POST_DIVR_FREQ);
> > > +       c->max_r =3D min_t(u8, MAX_DIVR_DIVISOR, max_r_for_parent);
> >=20
> > Then this min_t can be min() which is simpler to reason about.
>=20
> To me they have the same meaning - min_t doesn't seem too obscure:
>=20
> $ fgrep -Ir min_t\( linux/ | wc -l
> 3320
> $=20
>=20
> and using it means we don't have to use a type that's needlessly large fo=
r=20
> the range of values that the variable will contain.  However, if getting =

> rid of min_t() is more important to you than that principle, it can=20
> of course be changed.  Do you feel strongly about it?

It's not about obscurity. min_t() is an indicator that we have to coerce
type for comparison with casting. It's nice to avoid casts if possible
and use native types for the comparison.  assignment. It's good that you
aren't using min() with a cast though, so this look fine to me and I'm
not going to stay worried about this.

> > > + * mutually exclusive.  If both bits are set, or both are zero, the =
struct
> > > + * analogbits_wrpll_cfg record is uninitialized or corrupt.
> > > + */
> > > +#define WRPLL_FLAGS_BYPASS_SHIFT               0
> > > +#define WRPLL_FLAGS_BYPASS_MASK                BIT(WRPLL_FLAGS_BYPAS=
S_SHIFT)
> > > +#define WRPLL_FLAGS_RESET_SHIFT                1
> > > +#define WRPLL_FLAGS_RESET_MASK         BIT(WRPLL_FLAGS_RESET_SHIFT)
> > > +#define WRPLL_FLAGS_INT_FEEDBACK_SHIFT 2
> > > +#define WRPLL_FLAGS_INT_FEEDBACK_MASK  BIT(WRPLL_FLAGS_INT_FEEDBACK_=
SHIFT)
> > > +#define WRPLL_FLAGS_EXT_FEEDBACK_SHIFT 3
> > > +#define WRPLL_FLAGS_EXT_FEEDBACK_MASK  BIT(WRPLL_FLAGS_EXT_FEEDBACK_=
SHIFT)
> >=20
> > Maybe you can use FIELD_GET/FIELD_SET?
>=20
> To me BIT() is clearer and more concise.  However, please let me know if =

> the use of the FIELD_*() macros is important to you, and I will change it.

I'm not strong on it so up to you.

> > > + */
> > > +struct analogbits_wrpll_cfg {
> > > +       u8 divr;
> > > +       u8 divq;
> > > +       u8 range;
> > > +       u8 flags;
> > > +       u16 divf;
> > > +/* private: */
> > > +       u32 output_rate_cache[DIVQ_VALUES];
> > > +       unsigned long parent_rate;
> > > +       u8 max_r;
> > > +       u8 init_r;
> > > +};
> > > +
> > > +int analogbits_wrpll_configure_for_rate(struct analogbits_wrpll_cfg =
*c,
> > > +                                       u32 target_rate,
> > > +                                       unsigned long parent_rate);
> > > +
> > > +unsigned int analogbits_wrpll_calc_max_lock_us(struct analogbits_wrp=
ll_cfg *c);
> > > +
> > > +unsigned long analogbits_wrpll_calc_output_rate(struct analogbits_wr=
pll_cfg *c,
> > > +                                               unsigned long parent_=
rate);
> >=20
> > I wonder if it may be better to remove analogbits_ from all these
> > exported functions. I suspect that it wouldn't conflict if it was
> > prefixed with wrpll_ and it's shorter this way. Up to you.
>=20
> I don't have a strong preference either way.  I've changed it to remove=20
> the analogbits prefix as you request.
>=20

Alright sounds good!

