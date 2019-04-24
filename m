Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D591C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537EB2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfDXUsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:48:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33250 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbfDXUsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:48:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 65B4480692; Wed, 24 Apr 2019 22:48:24 +0200 (CEST)
Date:   Wed, 24 Apr 2019 22:48:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jens Axboe <axboe@kernel.dk>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lduncan@suse.com, hare@suse.com,
        mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        bvanassche@acm.org
Cc:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
Subject: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems on
 Thinkpad X60
Message-ID: <20190424204832.GA3111@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
 <20190424095431.GA32457@amd>
 <20190424104850.GC32457@amd>
 <20190424202119.GA26357@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20190424202119.GA26357@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Not block, but it seems scsi subsystem is:

commit 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Wed Mar 20 13:09:19 2019 -0700

    scsi: sd: Rely on the driver core for asynchronous probing

    As explained during the 2018 LSF/MM session about increasing SCSI
    disk
        probing concurrency, the problems with the current probing
    approach are as

Seems to be responsible. Full log attached.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=delme

# bad: [76c938fcaa4b4a5d8f05fa907925d5043834964e] Add linux-next specific files for 20190423
# good: [7142eaa58b49d9de492ccc16d48df7c488a5fbb6] Merge tag 'mips_fixes_5.1_3' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect start 'next-20190423' '7142eaa58b49d9de492ccc16d48df7c488a5fbb6'
# good: [ed04f675fa2c22316d7b57bea1258a18a47537ea] Merge remote-tracking branch 'crypto/master'
git bisect good ed04f675fa2c22316d7b57bea1258a18a47537ea
# good: [4a99e5b3463f5c936540958914bff57ec50ac1e0] Merge remote-tracking branch 'spi/for-next'
git bisect good 4a99e5b3463f5c936540958914bff57ec50ac1e0
# good: [61cabbda2a7e966b689a6791050ad675e6dff274] Merge remote-tracking branch 'staging/staging-next'
git bisect good 61cabbda2a7e966b689a6791050ad675e6dff274
# bad: [c8f0c2453f64529035e25fbfb9de9d24e98baff7] Merge remote-tracking branch 'coresight/next'
git bisect bad c8f0c2453f64529035e25fbfb9de9d24e98baff7
# bad: [6fb251c6f174d3cc571391baa9f6e57fff505446] Merge branch 'misc' into for-next
git bisect bad 6fb251c6f174d3cc571391baa9f6e57fff505446
# bad: [78a8ab3cc0f95a66c8fb2429030289103de173e7] scsi: qedf: fixup bit operations
git bisect bad 78a8ab3cc0f95a66c8fb2429030289103de173e7
# good: [c0327e67ecd86e88f5bc5fd54bfdf9b422a1c93f] scsi: core: remove the scsi_ioctl_reset export
git bisect good c0327e67ecd86e88f5bc5fd54bfdf9b422a1c93f
# good: [cbb24e26735f6142ba994b4d44fc2dcd54c3fe1f] scsi: ufs-mediatek: Make some symbols static
git bisect good cbb24e26735f6142ba994b4d44fc2dcd54c3fe1f
# bad: [21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3] scsi: sd: Rely on the driver core for asynchronous probing
git bisect bad 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
# good: [e7f7b6f38a44697428f5a2e7c606de028df2b0e3] scsi: lpfc: change snprintf to scnprintf for possible overflow
git bisect good e7f7b6f38a44697428f5a2e7c606de028df2b0e3
# good: [3e14592da654d53d87987aa09753d5a26e45446f] scsi: gdth: Only call dma_free_coherent when buf is not NULL in ioc_general
git bisect good 3e14592da654d53d87987aa09753d5a26e45446f
# good: [8378573353728a02602d6f956a3df48db0505c65] scsi: libcxgbi: remove uninitialized variable len
git bisect good 8378573353728a02602d6f956a3df48db0505c65
# good: [ea9006dfda65b7dc369aaa2359b3dedfc1bb08b6] scsi: mpt3sas: fix indentation issue
git bisect good ea9006dfda65b7dc369aaa2359b3dedfc1bb08b6
# first bad commit: [21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3] scsi: sd: Rely on the driver core for asynchronous probing

--Qxx1br4bt0+wmkIi--

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAy6AACgkQMOfwapXb+vIRIwCglgb39piVMku5Vq/sKRL2Qt6k
s7AAn2Utp1UzwRboUpz63y6yQXF2hodv
=RW0l
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
