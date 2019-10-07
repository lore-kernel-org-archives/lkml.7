Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16CBECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518A120835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="COxK3p8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfJGUvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:51:10 -0400
Received: from confino.investici.org ([212.103.72.250]:54771 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfJGUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:51:09 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 16:51:08 EDT
Received: from mx1.investici.org (localhost [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 9E2452126A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
        s=stigmate; t=1570480919;
        bh=AO/pFcbWATpCP7LkIzR0QiQguvCKQWG6BZ1LH+fp6Kw=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=COxK3p8K2MNb07GHQssRbiyL9/VPWZ10/005pxpUrE659GlgeW52zVGh5tCAXwPAm
         K1571Fgiua2XEEreMlj0fHmaG73UXiY+fw6pc19FIn2qsmOMmGmf1YfJCfn5lWHM+S
         QO+JQMaY6aBcDqoEJbPS+Di8i2psBeLyAG2/Jzzw=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 910BC21268
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 20:41:59 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.92.2)
        (envelope-from <invernomuto@paranoici.org>)
        id 1iHZpP-0002BJ-16
        for linux-kernel@vger.kernel.org; Mon, 07 Oct 2019 22:41:59 +0200
Date:   Mon, 7 Oct 2019 22:41:43 +0200
From:   Francesco Poli <invernomuto@paranoici.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: Question about sched_prio_to_weight values
Message-Id: <20191007224143.d21abae57a3f32ac60afd53c@paranoici.org>
In-Reply-To: <506d5ee6-246a-a03d-ea11-227ff4de1467@arm.com>
References: <20191007003205.8888ac99da2dd732b6198387@paranoici.org>
        <506d5ee6-246a-a03d-ea11-227ff4de1467@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Mon__7_Oct_2019_22_41_43_+0200___uF1Q..Wf0dWNlH"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__7_Oct_2019_22_41_43_+0200___uF1Q..Wf0dWNlH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2019 10:13:23 +0100 Valentin Schneider wrote:

[...]
> Following the blame rabbit hole I found this:
>=20
> 254753dc321e ("sched: make the multiplication table more accurate")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D254753dc321ea2b753ca9bc58ac329557a20efac
>=20
> which sounds like it would explain some small deltas if compared to a=20
> formula that is set in stone.
>=20
> Hope that helps.

It helps a lot, thank you so much for your kind reply!

I am now able to reproduce the numbers (almost), with the following
calc(1) script:

  $ cat prio_to_weight.cal=20
  #!/usr/bin/calc -f
 =20
  oldtilde =3D config("tilde", "off")
 =20
 =20
  printf('nice       mult *   inv_mult   error\n')
  printf('------------------------------------------\n')
  for (nice =3D -20; nice < 20; ++nice) {
      w =3D 1024/(1.25)^(nice);
      weight =3D round(w);
      invmul =3D round(2^32 / weight);
      error =3D weight*invmul / 2^32 - 1;
      printf('%3d:%11d *%11d%15.10f\n', nice, weight, invmul, error);
  }
 =20
  printf('\nnice       mult *   inv_mult   error\n')
  printf('------------------------------------------\n')
  for (nice =3D -20; nice < 20; ++nice) {
      w =3D 1024/(1.25)^(nice);
      for (delta =3D 0; delta < 1000; ++delta) {
          weight =3D round(w) - delta;
          invmul =3D round(2^32 / weight);
          error =3D weight*invmul / 2^32 - 1;
          if (abs(error) < 1e-8) { break; }
          weight =3D round(w) + delta;
          invmul =3D round(2^32 / weight);
          error =3D weight*invmul / 2^32 - 1;
          if (abs(error) < 1e-8) { break; }
      }
      printf('%3d:%11d *%11d%15.10f\n', nice, weight, invmul, error);
  }


After running the script:

  $ ./prio_to_weight.cal | tail -n 42 | tee prio_to_weight.out
  nice       mult *   inv_mult   error
  ------------------------------------------
  -20:      88761 *      48388  -0.0000000065
  -19:      71755 *      59856  -0.0000000037
  -18:      56483 *      76040   0.0000000056
  -17:      46273 *      92818   0.0000000042
  -16:      36291 *     118348  -0.0000000065
  -15:      29154 *     147320  -0.0000000037
  -14:      23254 *     184698  -0.0000000009
  -13:      18705 *     229616  -0.0000000037
  -12:      14949 *     287308  -0.0000000009
  -11:      11916 *     360437  -0.0000000009
  -10:       9548 *     449829  -0.0000000009
   -9:       7620 *     563644  -0.0000000037
   -8:       6100 *     704093   0.0000000009
   -7:       4904 *     875809   0.0000000093
   -6:       3906 *    1099582  -0.0000000009
   -5:       3121 *    1376151  -0.0000000058
   -4:       2501 *    1717300   0.0000000009
   -3:       1991 *    2157191  -0.0000000035
   -2:       1586 *    2708050   0.0000000009
   -1:       1277 *    3363326   0.0000000014
    0:       1024 *    4194304              0
    1:        820 *    5237765   0.0000000009
    2:        655 *    6557202   0.0000000033
    3:        526 *    8165337  -0.0000000079
    4:        423 *   10153587   0.0000000012
    5:        335 *   12820798   0.0000000079
    6:        272 *   15790321   0.0000000037
    7:        215 *   19976592  -0.0000000037
    8:        172 *   24970740  -0.0000000037
    9:        137 *   31350126  -0.0000000079
   10:        110 *   39045157  -0.0000000061
   11:         88 *   48806447   0.0000000093
   12:         70 *   61356676   0.0000000056
   13:         56 *   76695845   0.0000000056
   14:         45 *   95443718   0.0000000033
   15:         36 *  119304647  -0.0000000009
   16:         29 *  148102321   0.0000000030
   17:         23 *  186737709   0.0000000026
   18:         18 *  238609294  -0.0000000009
   19:         15 *  286331153  -0.0000000002

I get an output which is almost identical to the one copied from
the commit message (target.out):

  $ diff target.out prio_to_weight.out
  34c34
  <  11:         87 *   49367440  -0.0000000037
  ---
  >  11:         88 *   48806447   0.0000000093
  36,37c36,37
  <  13:         56 *   76695844  -0.0000000075
  <  14:         45 *   95443717  -0.0000000072
  ---
  >  13:         56 *   76695845   0.0000000056
  >  14:         45 *   95443718   0.0000000033
  39,40c39,40
  <  16:         29 *  148102320  -0.0000000037
  <  17:         23 *  186737708  -0.0000000028
  ---
  >  16:         29 *  148102321   0.0000000030
  >  17:         23 *  186737709   0.0000000026

The differences are probably due to the different precision
of the computations: I don't know the precision of those originally
carried out by Ingo Molnar (single precision? double?), but calc(1)
is an arbitrary precision calculator and, by default, performs
calculations with epsilon =3D 1e-20 !

Please note that, except for the first one, all the differing
values obtained with the calc(1) script have slightly better
errors than the ones found in kernel/sched/core.c ...


Thanks again for the clarification!
Bye.

--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Mon__7_Oct_2019_22_41_43_+0200___uF1Q..Wf0dWNlH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAl2bowcACgkQPhwn4R9p
v/6yHxAAic7shDVAvMbADIrt8jQfj0kPw5qAOntAGI+ndbsJUEMw6mBuE/PAJ9QS
zb/d+rSq4orWJ42mZBBwUqD2r0LIyPyjyfFy/6j2u8kivPVsCWX10De2EVkkMKkb
C/EbZc5STugz9HfZxyxKlLSGr+hxcgP6hcjJmyPDDm2nlKNRj0Z5AG/X5GcgOdsf
gKiY2H7BLZ7SRPAMCZJir3DeJ3z5NY+bBbBeGerKDPkaR1RkXg4TZxhCdqJPqH2Q
67GzBY6PK9lV8Gu0angftfWM8nydBzFCjluxjLggpBBb0bmzWyW9MZiaTZhyAXwM
stSthIfNv48QhKf0TSybpbHcH1QWL+qwbe/n9wo4yeC46P9j9stvHB6BPhTTcTHo
yP0Z5Z21NeX1Zp1ORc2ec8jZZBe5mMCUO5edoYvNp/scPPNuOrueZVlrXT+mVG33
EpTphyzNVdU6ZRgm7w5CanvjhEAAwGC0P8etQq3gmVQtR5tqXg2gCfFXNWKovSSi
VqYeVtdAELQrg9+3630Q7em0gmCASvAaP732tv/HVPuYMYclb447hLhZTBbIFhoU
duBUfI2iYTO9WUrsV9vDRNHnCDsT3ZIdj8S01odc0S8fil10U5b08s85QhKkUGpb
sX6mUATHeiz139iunQmOXRNM9XRBS+AGDx9dHO1HMjAB8dSxxBg=
=qmkn
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Oct_2019_22_41_43_+0200___uF1Q..Wf0dWNlH--
