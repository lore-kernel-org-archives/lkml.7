Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7EBC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B20C21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbfJALnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:43:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53402 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbfJALnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:43:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DD30F804C4; Tue,  1 Oct 2019 13:43:15 +0200 (CEST)
Date:   Tue, 1 Oct 2019 13:43:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com
Subject: Re: DDC on Thinkpad x220
Message-ID: <20191001114329.GA4381@amd>
References: <20190930184707.GA5703@amd>
 <87eezwdctl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <87eezwdctl.fsf@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-10-01 12:39:34, Jani Nikula wrote:
> On Mon, 30 Sep 2019, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > Thinkpad X220 should be new enough machine to talk DDC to the
> > monitors, right? And my monitor has DDC enable/disable in the menu, so
> > it should support it, too...
> >
> > But I don't have /dev/i2c* and did not figure out how to talk to the
> > monitor. Is the support there in the kernel? What do I need to enable
> > it?
>=20
> # modprobe i2c-dev

Thanks!

I enabled I2C_CHARDEV, and installed ddccontrol:

c   ddccontrol                      - program to control monitor

I can read parameters of Dell monitor on VGA:

sudo ddccontrol dev:/dev/i2c-1 -c -d
/usr/share/ddccontrol-db/monitor/DELA013.xml
Control 0x10: +/79/100   [???] -- brightness
Control 0x12: +/63/100   [???] -- contrast

Unfortunately the Fujitsu monitor does not seem to
communicate. Fujitsu is my main monitor :-(.

pavel@duo:~$ sudo ddccontrol dev:/dev/i2c-4 -c -d
ddccontrol version 0.4.2
Copyright 2004-2005 Oleg I. Vdovikin (oleg@cs.msu.su)
Copyright 2004-2006 Nicolas Boichat (nicolas@boichat.ch)
This program comes with ABSOLUTELY NO WARRANTY.
You may redistribute copies of this program under the terms of the GNU
General Public License.

Reading EDID and initializing DDC/CI at bus dev:/dev/i2c-4...
ioctl(): No such device or address
ioctl returned -1
ioctl(): No such device or address
ioctl returned -1
ioctl(): No such device or address
ioctl returned -1
I/O warning : failed to load external entity
"/usr/share/ddccontrol-db/monitor/FUS080A.xml"
Document not parsed successfully.
ioctl(): No such device or address
ioctl returned -1

DDC/CI at dev:/dev/i2c-4 is unusable (-1).
If your graphics card need it, please check all the required kernel
modules are loaded (i2c-dev, and your framebuffer driver).

Any further hints?

Thanks and best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2TO+EACgkQMOfwapXb+vIh4QCdFDvDzV3QA1YJOk5R9U6nxemF
HEsAnjEXcNYjfaMOB2RxofefvCvrZxEe
=yDeJ
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
