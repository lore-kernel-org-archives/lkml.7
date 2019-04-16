Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F696C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA52206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfDPL4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:56:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59859 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfDPL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:56:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3C900803A9; Tue, 16 Apr 2019 13:56:36 +0200 (CEST)
Date:   Tue, 16 Apr 2019 13:56:44 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.14 05/69] x86/power: Make restore_processor_context()
 sane
Message-ID: <20190416115644.GA7009@amd>
References: <20190415183726.036654568@linuxfoundation.org>
 <20190415183727.581656002@linuxfoundation.org>
 <20190415200452.GA25908@amd>
 <CALCETrW9E8Y1vxn377jU_P2cQBw0oR2VDJGUkUKKH3RJEByiPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <CALCETrW9E8Y1vxn377jU_P2cQBw0oR2VDJGUkUKKH3RJEByiPQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-15 13:18:56, Andy Lutomirski wrote:
> On Mon, Apr 15, 2019 at 1:04 PM Pavel Machek <pavel@denx.de> wrote:
> >
> > On Mon 2019-04-15 20:58:23, Greg Kroah-Hartman wrote:
> > > [ Upstream commit 7ee18d677989e99635027cee04c878950e0752b9 ]
> > >
> > > My previous attempt to fix a couple of bugs in __restore_processor_co=
ntext():
> > >
> > >   5b06bbcfc2c6 ("x86/power: Fix some ordering bugs in __restore_proce=
ssor_context()")
> > >
> > > ... introduced yet another bug, breaking suspend-resume.
> > >
> > > Rather than trying to come up with a minimal fix, let's try to clean =
it up
> > > for real.  This patch fixes quite a few things:
> >
> > 5b06bbcfc2c6 fixed theoretical bug; rather than porting it to stable
> > than fixing it up, it would be better not to port it to stable in the
> > first place or simply revert it there.
>=20
> Are you sure about that?  The bug was reported by real users who had
> their systems really crash:
>=20
> https://lore.kernel.org/lkml/?q=3D0fede9f9-88b0-a6e7-1027-dfb2019b8ef2%40=
linux.intel.com
>=20
> https://lore.kernel.org/lkml/CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-6=
94yeq1w@mail.gmail.com/
>=20
> And we had a report that the bug got backported:
>=20
> https://lore.kernel.org/stable/20190407160005.djiw4reapwvbxmgo@debian/
>=20
> And if we're going to backport some of the fix, we should definitely
> backport the whole set to avoid having the -stable kernels be in a
> state that was never in any released kernel.

I agree it should be all or nothing. And I may have been slightly
confused.

Anyway: 5b06bbcfc2c6 is fix for ca37e57bbe0cf, and that one is for
"mostly harmless warning" (quoting changelog). ca37e57bbe0cf is not
present in 4.4.178, I believe best solution is not to add that one in
the first place, so we don't have to fix it up.
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly1wvwACgkQMOfwapXb+vLxKQCfVrQmHdUqA4Xg4gNYlrIS2QA7
b4kAn1AGQybkO71SHNy/GRh69qnh3Qjt
=gjmZ
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
