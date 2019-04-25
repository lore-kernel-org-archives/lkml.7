Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5495BC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2345A217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfDYHdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:33:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59166 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfDYHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:33:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7B9728058A; Thu, 25 Apr 2019 09:33:35 +0200 (CEST)
Date:   Thu, 25 Apr 2019 09:33:43 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Pavel Machek <pavel@denx.de>, Jens Axboe <axboe@kernel.dk>,
        jejb@linux.ibm.com, martin.petersen@oracle.com, lduncan@suse.com,
        hare@suse.com, mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
Subject: Re: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems on
 Thinkpad X60
Message-ID: <20190425073343.GA19600@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
 <20190424095431.GA32457@amd>
 <20190424104850.GC32457@amd>
 <20190424202119.GA26357@amd>
 <20190424204832.GA3111@amd>
 <20190424205150.GA4582@amd>
 <1556139361.161891.140.camel@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1556139361.161891.140.camel@acm.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-24 13:56:01, Bart Van Assche wrote:
> On Wed, 2019-04-24 at 22:51 +0200, Pavel Machek wrote:
> > Unfortunately, that one does not revert cleanly on top of -next.
>=20
> Can you try the following:
>=20
> git revert d16ece577bf2cee7f94bab75a0d967bcb89dd2a7 &&
>   git revert 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
>=20
> I will see whether I can come up with a better way to analyze what is
> going on. I had not expected that these patches would cause any suspend/
> resume problems.

Not even d16ece reverts:

pavel@duo:/data/l/linux-next-32$ git show  | head -3
commit 76c938fcaa4b4a5d8f05fa907925d5043834964e
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Apr 23 20:24:59 2019 +1000
pavel@duo:/data/l/linux-next-32$ git revert
d16ece577bf2cee7f94bab75a0d967bcb89dd2a7
error: could not revert d16ece5... scsi: sd: Inline sd_probe_part2()
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzBYtcACgkQMOfwapXb+vLSPACggAjbyoCyqU8ktZSlP27yCCjh
Y5sAnRe/NkQIgD/Wl4euXqOxeO2JdhOO
=JJcZ
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
