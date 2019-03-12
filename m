Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E2BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2492147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfCLJEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:04:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53514 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfCLJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:04:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1861380449; Tue, 12 Mar 2019 10:04:24 +0100 (CET)
Date:   Tue, 12 Mar 2019 10:04:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        sunzhaosheng@hisilicon.com, jean.xupeng@hisilicon.com,
        yuwei3@hisilicon.com, gengyanping@hisilicon.com,
        peter.panshilin@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PM / wakeup: Remove timer from wakeup_source_remove()
Message-ID: <20190312090430.GA28905@amd>
References: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
 <3100371.t8xxUOTPUa@aspire.rjw.lan>
 <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-03-12 08:58:02, Viresh Kumar wrote:
> On 11-03-19, 13:05, Rafael J. Wysocki wrote:
> > On Friday, March 8, 2019 10:53:11 AM CET Viresh Kumar wrote:
> > > wakeup_source_remove() is the counterpart of wakeup_source_add() help=
er
> > > and must undo the initializations done by wakeup_source_add(). Curren=
tly
> > > the timer is initialized by wakeup_source_add() but removed from
> > > wakeup_source_drop(), which doesn't look logically correct. Also it
> > > should be okay to call wakeup_source_add() right after calling
> > > wakeup_source_remove(), and in that case we may end up calling
> > > timer_setup() for a potentially scheduled timer which is surely
> > > incorrect.
> > >=20
> > > Move the timer removal part to wakeup_source_remove() instead.

> >=20
> > I've merged it with the [2/2], rewritten the subject and changelog and
> > queued the result as commit d856f39ac1cc ("PM / wakeup: Rework wakeup
> > source timer cancellation").
>=20
> Okay, thanks. We (Android guys) want this to be backported into 4.4+
> kernels via the stable tree. Can we mark this for stable in the commit
> itself ? Else I would be required to send this separately for all the
> kernels. I should have marked it for stable initially though, sorry
> about forgetting then.

Greg is normally pretty agressive about backporting everything
remotely looking like a fix...

But better changelog would help. How is the bug actually affecting
users?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyHdh4ACgkQMOfwapXb+vJ2DQCfeIWIJeroQm4LfPM3u2gQrOpD
mYMAoIWzIxYGUBarjk7KX845DqhcO8Gw
=Yb7p
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
