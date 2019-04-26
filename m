Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1A7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B7A206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfDZKcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:32:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51779 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:32:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4DE07805DC; Fri, 26 Apr 2019 12:32:41 +0200 (CEST)
Date:   Fri, 26 Apr 2019 12:32:49 +0200
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
Message-ID: <20190426103249.GA5001@amd>
References: <20190423102239.GA15531@amd>
 <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
 <20190424095431.GA32457@amd>
 <20190424104850.GC32457@amd>
 <20190424202119.GA26357@amd>
 <20190424204832.GA3111@amd>
 <20190424205150.GA4582@amd>
 <1556139361.161891.140.camel@acm.org>
 <20190425073343.GA19600@amd>
 <360f6936-ee21-a036-9bd4-93ecfee829e2@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <360f6936-ee21-a036-9bd4-93ecfee829e2@acm.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-04-25 06:35:58, Bart Van Assche wrote:
> On 4/25/19 12:33 AM, Pavel Machek wrote:
> > On Wed 2019-04-24 13:56:01, Bart Van Assche wrote:
> >> On Wed, 2019-04-24 at 22:51 +0200, Pavel Machek wrote:
> >>> Unfortunately, that one does not revert cleanly on top of -next.
> >>
> >> Can you try the following:
> >>
> >> git revert d16ece577bf2cee7f94bab75a0d967bcb89dd2a7 &&
> >>   git revert 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
> >>
> >> I will see whether I can come up with a better way to analyze what is
> >> going on. I had not expected that these patches would cause any suspen=
d/
> >> resume problems.
> >=20
> > Not even d16ece reverts:
> >=20
> > pavel@duo:/data/l/linux-next-32$ git show  | head -3
> > commit 76c938fcaa4b4a5d8f05fa907925d5043834964e
> > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date:   Tue Apr 23 20:24:59 2019 +1000
> > pavel@duo:/data/l/linux-next-32$ git revert
> > d16ece577bf2cee7f94bab75a0d967bcb89dd2a7
> > error: could not revert d16ece5... scsi: sd: Inline sd_probe_part2()
> > hint: after resolving the conflicts, mark the corrected paths
> > hint: with 'git add <paths>' or 'git rm <paths>'
> > hint: and commit the result with 'git commit'
>=20
> There has been a non-trivial merge between the block and scsi trees in
> linux-next. That's probably what prevents these patches to revert
> cleanly. How about performing the following tests:
> * Build, boot and test Martin's latest for-5.2 branch
> (git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git; branch
> 5.2/scsi-queue).

Ok, so that's commit a7634b6f7cbbdc6efcf772e080a6fe845d1f6161
=2E Suspend/resume is broken there.

> * If suspend/resume does not work reliably with that branch, revert the
> two patches above, rebuild, reboot and retest.

pavel@duo:/data/l/linux-next-32$ git show
commit a7634b6f7cbbdc6efcf772e080a6fe845d1f6161
Author: Colin Ian King <colin.king@canonical.com>
pavel@duo:/data/l/linux-next-32$ git revert
d16ece577bf2cee7f94bab75a0d967bcb89dd2a7
Editing file: /data/fast/l/linux-next-32/.git/COMMIT_EDITMSG
1026
?
[detached HEAD 916db0d] Revert "scsi: sd: Inline sd_probe_part2()"
 1 file changed, 58 insertions(+), 43 deletions(-)
 pavel@duo:/data/l/linux-next-32$ git revert
 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
 Editing file: /data/fast/l/linux-next-32/.git/COMMIT_EDITMSG
 1163
 ?
 [detached HEAD ac8d625] Revert "scsi: sd: Rely on the driver core for
 asynchronous probing"
  4 files changed, 47 insertions(+), 5 deletions(-)


And reverting those two indeed fixes it:

Checking version...
version is  Linux amd 5.1.0-rc1autobisect1556274387+ #261 SMP Fri Apr
26 12:27:12 CEST 2019 i686 GNU/Linux
Running test...
Result is [ TEST SUCCESS ]
Test said TEST SUCCESS

								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzC3lEACgkQMOfwapXb+vJoTQCffu48EpOKwrjNHzlGLiZ8G0rw
4xgAoIa4q0JCnAK+g4FAgxxuCYx82gQt
=bMOt
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
