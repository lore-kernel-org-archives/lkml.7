Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83761C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5806E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfC2Mcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:32:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41423 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfC2Mcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:32:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E499C8073A; Fri, 29 Mar 2019 13:32:37 +0100 (CET)
Date:   Fri, 29 Mar 2019 13:32:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Chen, Hu" <hu1.chen@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI / PM: Propagate KEY_POWER to user space when
 resume
Message-ID: <20190329123244.GA20104@amd>
References: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
 <20190328103448.20335-1-hu1.chen@intel.com>
 <20190329102519.GA11784@atrey.karlin.mff.cuni.cz>
 <23bc59ef-fc25-440b-ab1c-c5db6b5cf6d2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <23bc59ef-fc25-440b-ab1c-c5db6b5cf6d2@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-03-29 12:38:39, Hans de Goede wrote:
> Hi,
>=20
> On 3/29/19 11:25 AM, Pavel Machek wrote:
> >>I run Android on x86 PC (it's a NUC). Everytime I press the power button
> >>to wake the system, it suspends right away. After some debug, I find
> >>that Android wants to see KEY_POWER at resume. Otherwise, its
> >>opportunistic suspend will kick in shortly.
> >>
> >>However, other OS such as Ubuntu doesn't like KEY_POWER at resume. So
> >>add a knob "/sys/module/button/parameters/key_power_at_resume" for users
> >>to select.
> >>
> >>Signed-off-by: Chen, Hu <hu1.chen@intel.com>
> >
> >NAK.
> >
> >Fix android, lets not break kernel.
>=20
> It is not that simple, as I explained in my other reply to this
> patch, we alreayd have inconsistent behavior here inside the kernel.
>=20
> When KEY_POWER is handled by the gpio-keys driver it does explicitly
> send a KET_POWER press event when the system is woken up through the
> power-button.

Which may be okay.

> Arguably that is more consistent, e.g. some systems can also be woken
> up through a home-button press and in that case we do want the KEY_HOMEPA=
GE
> to be propagated to userspace after the wakeup so that we not only wake
> but also switch to the homescreen (whatever that might be).

Which may also be okay.

> Note I'm not saying that I'm happy with any of this, but simply NACK-ing
> this patch is IMHO not the answer.

Well, to add a knob
"/sys/module/button/parameters/key_power_at_resume" is really not
acceptable. Android does not know that it needs to set it, so it will
not set it, and the problem remains. Plus, we get a great mess in
future.

But yes, we might want userland to know why the system woke up. And it
would be good if everything also worked with wake-on-lan. Hmm.

It is also possible that PC's ACPI power button should generate
something else than KEY_POWER. Power button on my USB keyboard
generates that, and that is really quite different button the one on
the box.

I'm not saying I know what the solution is. But we should have one
solution, not a knob to select between different solutions.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyeEGwACgkQMOfwapXb+vIeZgCfUC8q4+n31T3i6R7APn52ZVnW
ei0An22NKrpngC6KAJZhnySIy5Ngkkud
=NPzD
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
