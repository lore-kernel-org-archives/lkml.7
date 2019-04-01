Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429E1C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9F320870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfDALN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:13:27 -0400
Received: from sauhun.de ([88.99.104.3]:50452 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:13:27 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id 734F52C7BF4;
        Mon,  1 Apr 2019 13:13:24 +0200 (CEST)
Date:   Mon, 1 Apr 2019 13:13:24 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Message-ID: <20190401111323.ajvo4drongc6dtel@ninjato>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
 <20190401104756.GK11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7zuscjiz44miouqy"
Content-Disposition: inline
In-Reply-To: <20190401104756.GK11158@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7zuscjiz44miouqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

thanks for your answer!

On Mon, Apr 01, 2019 at 12:47:56PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 27, 2019 at 10:12:56PM +0100, Wolfram Sang wrote:
> > Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
> > added in_atomic() to the I2C core. However, the use of in_atomic()
> > outside of core kernel code is discouraged and was already[1] when this
> > code was added in early 2008. The above commit was a preparation for
> > b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit message says
> > explicitly it was added "for cases where I2C transactions have to occur
> > at times interrups are disabled". So, the intention was 'disabled
> > interrupts'. This matches the use cases for atomic I2C transfers I have
> > seen so far: very late communication (mostly to a PMIC) to powerdown or
> > reboot the system. For those cases, interrupts are disabled then. It
> > doesn't seem that in_atomic() adds value.
> >=20
> > Note that only ~10 out of ~120 bus master drivers support atomic
> > transfers, mostly by polling always when no irq is supplied. A generic
> > I2C client driver cannot assume support for atomic transfers. This is
> > currently a platform-dependent corner case.
> >=20
> > The I2C core will soon gain an extra callback into bus drivers
> > especially for atomic transfers to make them more generic. The code
> > deciding which transfer to use (atomic/non-atomic) should mimic the
> > behaviour which locking to use (trylock/lock). Because I don't want to
> > add more in_atomic() to the I2C core, this patch simply removes it.
> >=20
> > [1] https://lwn.net/Articles/274695/
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >=20
> > So, I had to dive into this in_atomic() topic and this is what I
> > concluded. I don't see any reasonable constellation where this could
> > cause a regression, but I am all open for missing something and being
> > pointed to it. This is why the patch is RFC. I'd really welcome
> > comments. Thanks!
> >=20
> >=20
> >  drivers/i2c/i2c-core-base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 38af18645133..943bebeec3ed 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -1946,7 +1946,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct=
 i2c_msg *msgs, int num)
> >  	 *    one (discarding status on the second message) or errno
> >  	 *    (discarding status on the first one).
> >  	 */
> > -	if (in_atomic() || irqs_disabled()) {
> > +	if (irqs_disabled()) {
> >  		ret =3D i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
> >  		if (!ret)
> >  			/* I2C activity is ongoing. */
>=20
> So I know absolutely nothing about i2c, except that it is supposedly
> fsck all slow.
>=20
> In that context, busy-spinning for i2c completions seems like a terrible
> idea, _esp_ in atomic contexts.
>=20
> I did a quick grep for trylock_bus() and found i2c_mux_trylock_bus()
> which uses rt_mutex_trylock and therefore the calling context must
> already exclude IRQs and NMIs and the like.
>=20
> That leaves task context with preemption/IRQs disabled. Of that, you
> retain the IRQs disabled test, which is by far the worst possible
> condition to spin-wait in.
>=20
> Why must we allow i2c usage with IRQs disabled? Just say NO?

I'd love to. But quoting my patch description:

"This matches the use cases for atomic I2C transfers I have seen so far:
very late communication (mostly to a PMIC) to powerdown or reboot the
system."

And yes, I would never recommend a HW design to use I2C for shutting
down/rebooting. But such HW is out there.

Regards,

   Wolfram


--7zuscjiz44miouqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyh8lAACgkQFA3kzBSg
KbbviA//R8NBhHBg260+abMRGJ2BGtv6OWgYalU43gKQFY7e5HYVTcJ2n0z9ZkaL
/qnqd/SXftlrBjb8zXFxnlDg820G2crGuN3YmzKAvv2wslSbgvwhWaRBZ3QaIUUO
VCDLWN2bXPUKMisuA634S2pu4MlYaAvX3qezrLfuy0l73vsoqvZqAMAmekwiK2IK
MKpKAVVFM/INy1Yl7aO2gqdai94YykIV1YaFKvelJmNDj0Vmuki6dyRu2XLVfj9+
J+qAYo6XhNOrGpjiticV6OrKW/y8hE+i/D1g2ylenRiULHE/MdlWr9R5q6xM51oe
NMsyULLDa87qirCwFBd2c6bbAYAcIFz4Yz5yQyERo/OtG7jtkL6LdbWpYtb/G/YZ
88AP3998akGXV8nGhKO8zivwqE994o6jq7OmeJpCyk+A9+HBxZF/8+7pOpfHlME2
EaCttoxLYsarqGYNaQf8O74gEHnfD5bG+wpxAuuzNXXMwFJYEgRqlVzZhtOgR185
czkYAtks1jdzMdQi5TaSCxcMgJNchDi2YMrmpIzkfHo6y5egsgqyjSgc8y1Z9TwS
jGgqFyCwr2lqbIAHV+K2enFf5IwQ+6/1MaUb+YFDQUmqGqTMhwo4JnPo1mpLbuNo
z0lYpJeI+vwVoINxkL9kQaAd+LZGP5pb2SpZ3/maZHZviwUa11A=
=QQJC
-----END PGP SIGNATURE-----

--7zuscjiz44miouqy--
