Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB003C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EBB218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfC2SOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:14:14 -0400
Received: from anholt.net ([50.246.234.109]:33616 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbfC2SON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:14:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C829410A1518;
        Fri, 29 Mar 2019 11:14:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2gFnKf8qZt2K; Fri, 29 Mar 2019 11:14:11 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F146D10A05DD;
        Fri, 29 Mar 2019 11:14:10 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7F1E62FE2F72; Fri, 29 Mar 2019 11:14:10 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Stone <daniel@fooishbar.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for non-legacy drivers
In-Reply-To: <901ea65c770c80e22c69032affe3b1a22652b608.camel@bootlin.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com> <20190320154809.14823-2-paul.kocialkowski@bootlin.com> <87zhpph4c2.fsf@anholt.net> <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com> <20190328185307.GZ2665@phenom.ffwll.local> <CAPj87rMmW_7Kiy==ZxvvmHXhQLWC+F=uxed442HpMMZr=MwjRA@mail.gmail.com> <5ed7c5f361bca47d3f9771f9ed27e28e2fccb179.camel@bootlin.com> <20190329152502.GO2665@phenom.ffwll.local> <901ea65c770c80e22c69032affe3b1a22652b608.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 29 Mar 2019 11:14:09 -0700
Message-ID: <87r2appmz2.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi,
>
> Le vendredi 29 mars 2019 =C3=A0 16:25 +0100, Daniel Vetter a =C3=A9crit :
>> On Fri, Mar 29, 2019 at 04:02:23PM +0100, Paul Kocialkowski wrote:
>> > Hi,
>> >=20
>> > On Fri, 2019-03-29 at 09:09 +0000, Daniel Stone wrote:
>> > > Hi,
>> > >=20
>> > > On Thu, 28 Mar 2019 at 18:53, Daniel Vetter <daniel@ffwll.ch> wrote:
>> > > > On Thu, Mar 21, 2019 at 04:27:06PM +0100, Paul Kocialkowski wrote:
>> > > > > I don't see other options either, and using firstclose/lastopen =
feels
>> > > > > overall more readable in the driver code.
>> > > > >=20
>> > > > > I'm not sure there is such a big overhead associated with alloca=
ting
>> > > > > the binner BO (it seems that the current implementation tries to=
 alloc
>> > > > > until the specific memory constraints for the buffer are met, so
>> > > > > perhaps that can take time). But if there is, I suppose it's bes=
t to
>> > > > > have that when starting up rather than delaying the first render
>> > > > > operation.
>> > > >=20
>> > > > I'm not entirely buying the "we don't need this for fbcon only" ar=
gument -
>> > > > there's plenty of dumb kms clients too (boot splash and whatever e=
lse
>> > > > there might be). If you don't want to keep this around I think all=
ocating
>> > > > on first non-dumb bo allocation and dropping it when the last such=
 fd
>> > > > closes sounds like a much better idea. Needs a bit more state, you=
 need to
>> > > > track per drm_file whether you've already allocated a non-dumb bo,=
 and a
>> > > > drm_device refcount, but that's not much. Firstopen feels like the=
 wrong
>> > > > thing.
>> > > >=20
>> > > > Another option would be first_renderopen or something like that, e=
xcept
>> > > > you can also render on the legacy node and I'm not sure how much t=
here's a
>> > > > demand for this in other drivers. In the end you have open/close
>> > > > callbacks, you can do all the driver specific things you want to d=
o in
>> > > > there.
>> > >=20
>> > > I'd like to avoid doing it in open where possible, since that hurts
>> > > device enumeration from userspace.
>> >=20
>> > I've noticed the same issue with firstopen, where our buffer is
>> > allocated/liberated a couple of times during enumeration, before the
>> > final open that stays alive during use.
>> >=20
>> > I'm not sure what is preferable between that and allocating when the
>> > GPU is first used. Slowing down the first GPU operation with the
>> > allocation does not sound too great either and it feels like the buffer
>> > should have been allocated earlier.
>> >=20
>> > To me, it feels I think it's better to have delays due to allocation at
>> > enumeration / startup rather than later on, but I might be missing some
>> > elements to have a clear idea.
>> >=20
>> > What do you think?
>>=20
>> We'll have the delay somewhere on driver load. Better to have it only on=
ce
>> (when the driver starts using gem for real), than a bunch of time, at
>> least once while enumerating and then once more while actually
>> initializing. I think if you allocat this on first non-dumb gem_create,
>> and on first command submission (just so evil userspace can't screw up t=
he
>> hw too badly), that should be perfectly fine.
>
> I'm not totally convinced that it's okay to have a delay outside of
> init/enumeration, even if it's a smaller delay.

You'll have non-dumb buffers created during GL context creation, so
early in xserver or other KMS-and-GL-using application init anyway.
Seems like a perfectly fine plan to me.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyeYHIACgkQtdYpNtH8
nuhPIA/+K0tMT0orfpgyXvw725SRAhlrTO24BGljRqgYHPENY1sx/2UuVnsfPioN
qKFVulOOTP5H3y0J+4wNq9pgKmWc09EVgTsRbhM4d+x5SN8YFCjfeLYU3Hjje1HW
VJRgNAQKUvVFZTiac6Z8URjR1GzDmirFpsRqIL7Q3eJ2FyPpCit5ZX6vqBeOOHez
Ib5fAbiiQCRwocyqUqzutQWwxYg/K3a8A+N0RKiqxBi3DT9MUD8IXT1JgpnXb5Go
B+6KeolL9gvCd8Nyz7dyqh3Qpi0AMHOcXEZF8e/J6XGpguHYm3do7NF2ZCNugnJU
A+fFEG9hA6DluLCTGd9jqpKUB/Ub7DY7ILue6xxSAdECIC6jkv133b+DBB5cUur+
iUw5eRLeU7Vt3FZlEKFFK7EW3jH1Q4PLW40g4gzR5Hv7hqz1R+mPMCrxzsi4HhCw
eUMIE76p+x7zTIBSxIYk3C+Er10hfEClYZtWFCGdEZurYrOltDU6dWRJEPEy4LZC
Ye1rmjbj7CF8ZxrKQMcigfSezxfrE29X+Uc5Jk82SEIxTe0Ggtd3fbsLCN/j8vQV
pF05JwcnjFoAeb816UrbJNOHInEx5G1klUoKNznpg7yWPMH5RXSZxBH4yKumPkyK
G/GcXKKVoD53cINjhFpiZKRiqKOe+31T+9kRjOaGRsjqan/J8kA=
=fnRm
-----END PGP SIGNATURE-----
--=-=-=--
