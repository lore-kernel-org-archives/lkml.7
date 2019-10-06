Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6D3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2378320862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 22:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="RjfnXkwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfJFWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 18:41:23 -0400
Received: from latitanza.investici.org ([82.94.249.234]:52121 "EHLO
        latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJFWlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 18:41:23 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Oct 2019 18:41:21 EDT
Received: from mx3.investici.org (localhost [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 08CB4120249
        for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2019 22:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
        s=stigmate; t=1570401133;
        bh=XWRTVuOQgQhRGvwSz9ecvELf4dYZZb9UNRmCJdzibcA=;
        h=Date:From:To:Subject:From;
        b=RjfnXkwLPwOdZiwUAFDugd0QUJxyFaiV62yk5tXariEZBwGEyPiArYNf7Uvq+uDkY
         1gw7Go2XSfz2znqGXq03sZUoUzArHLUi2p4YSq5T09j8RHEpp5rtl79laXLOwrPHtZ
         HjysPDL0OeSgNd42A3OCqKb79GAxcPQvw7jCPIZE=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id E1305120156
        for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2019 22:32:12 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.92.2)
        (envelope-from <invernomuto@paranoici.org>)
        id 1iHF4W-0001nf-0e
        for linux-kernel@vger.kernel.org; Mon, 07 Oct 2019 00:32:12 +0200
Date:   Mon, 7 Oct 2019 00:32:05 +0200
From:   Francesco Poli <invernomuto@paranoici.org>
To:     linux-kernel@vger.kernel.org
Subject: Question about sched_prio_to_weight values
Message-Id: <20191007003205.8888ac99da2dd732b6198387@paranoici.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Mon__7_Oct_2019_00_32_05_+0200_zDIrpdzOEkZ987T4"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__7_Oct_2019_00_32_05_+0200_zDIrpdzOEkZ987T4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
I am trying to understand something about the internals of the
completely fair scheduler (CFS) used in the Linux kernel.

I have a question about the mapping between nice levels and weights,
I hope someone can shed some light on those numbers.
Please note that I am not subscribed to the LKML: could you please Cc
me on replies? Thanks for your understanding.


As far as I can see, the mapping is hard-coded in the
sched_prio_to_weight array, which is defined in kernel/sched/core.c
The [latest code] defines the following values:

  const int sched_prio_to_weight[40] =3D {
   /* -20 */     88761,     71755,     56483,     46273,     36291,
   /* -15 */     29154,     23254,     18705,     14949,     11916,
   /* -10 */      9548,      7620,      6100,      4904,      3906,
   /*  -5 */      3121,      2501,      1991,      1586,      1277,
   /*   0 */      1024,       820,       655,       526,       423,
   /*   5 */       335,       272,       215,       172,       137,
   /*  10 */       110,        87,        70,        56,        45,
   /*  15 */        36,        29,        23,        18,        15,
  };

but I found the same values in much more ancient versions
(the values probably date back to the first patch that introduced
the CFS in the kernel).

[latest code]: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/tree/kernel/sched/core.c?h=3Dv5.4-rc1>

Now, the comments in the code suggest that each value is obtained by
dividing the previous one by 1.25: I found [some] [documentation] that
seems to confirm that the "weight is roughly equivalent to
1024/(1.25)^(nice)"

[some]: <https://blog.shichao.io/2015/07/22/relationships_among_nice_priori=
ty_and_weight_in_linux_kernel.html>
[documentation]: <www.iaiai.org/journals/index.php/IEE/article/download/9/1=
9>

I tried to see whether I could re-obtain those numbers by rounding (to
integers) the values computed with that formula, but the result does not
look quite right.
By using calc(1), I get:

  ; for (nice =3D -20; nice < 20; ++nice) {=20
  ;;     w =3D 1024/(1.25)^(nice);
  ;;     printf('%3d %7d (%.2f)\n', nice, round(w), w);
  ;; }
  -20   88818 (~88817.84)
  -19   71054 (~71054.27)
  -18   56843 (~56843.42)
  -17   45475 (~45474.74)
  -16   36380 (~36379.79)
  -15   29104 (~29103.83)
  -14   23283 (~23283.06)
  -13   18626 (~18626.45)
  -12   14901 (~14901.16)
  -11   11921 (~11920.93)
  -10    9537 (~9536.74)
   -9    7629 (~7629.39)
   -8    6104 (~6103.52)
   -7    4883 (~4882.81)
   -6    3906 (3906.25)
   -5    3125 (3125)
   -4    2500 (2500)
   -3    2000 (2000)
   -2    1600 (1600)
   -1    1280 (1280)
    0    1024 (1024)
    1     819 (819.2)
    2     655 (655.36)
    3     524 (~524.29)
    4     419 (~419.43)
    5     336 (~335.54)
    6     268 (~268.44)
    7     215 (~214.75)
    8     172 (~171.80)
    9     137 (~137.44)
   10     110 (~109.95)
   11      88 (~87.96)
   12      70 (~70.37)
   13      56 (~56.29)
   14      45 (~45.04)
   15      36 (~36.03)
   16      29 (~28.82)
   17      23 (~23.06)
   18      18 (~18.45)
   19      15 (~14.76)

where some numbers correspond, while others differ from those found
in kernel/sched/core.c ...

I tried to tweak the 1.25 factor: 1.2499599 makes me get
weight =3D=3D 88761 for nice =3D=3D -20, but other numbers still differ.
A non-linear curve fitting with grace(1) leads to a factor of 1.25018,
which still produces values that fail to completely match those found
in kernel/sched/core.c ...

I searched the web and the mailing list archives, but I failed to find
an answer to this question. Could someone please explain me how those
numbers were picked?

Thanks for your time!


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Mon__7_Oct_2019_00_32_05_+0200_zDIrpdzOEkZ987T4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAl2aa2UACgkQPhwn4R9p
v/4qIA//e29ELud66GOxrxzMlgufK42tTQaIH+WupbfErX6iU9urE/TzeDnw+nwz
yLVR91+l7T8PEAHwdZ+kVU9+GzK6IZLL8VNsAI6TakO2V3Mg+qYssgWM/UAi1zZl
PJXoGhLI1x+p2iNRrZnnqYOoLZn9uWSYprLw1aabn0nchrr+H3KsBlkX0+mW/sac
2SuJu1OX0Ncg6teR/PZ9sgJAGoDrIvZsQOQ4iH8gokmVR1NImP1XR92cuuib2TmU
vqLyqc1H+JGZN2oILPHbSfEaYCu826jx9tZAjMY2pXYje4ml1Y5CQBPuASjso/E8
dI+dRBMREO+7fiiFK3hgmk8QkNPWWeg5AjyJDsro0GeEoe3a7iVXHWi2OAZwYKzb
tVQtDQjsWGZ7uT3RHiE4CLIT6jp6IAjyKJcSdnO2mpFOyzOindeIv4EnZwtFWusu
0lYvSkgL3cQxfX15MeL7vfx26dvZqvCKN/ttUEbpeuC9lyrn8Aq6e8ZjpMwJtSrs
ernSC6/xucibaPtOQSAFejYfTs92RPFiGtZWVAph4vIqlR/WD22jCQ+icz9dvuc3
fqnwFLJBdxOL9+ZhLWbnns0wbMt97V+HMLZ7aQe1QNoq0oOmYHZJDyy6v/e5WM0t
1ObidXJUoIGQPOKYxyI4KzYRsAdYIBiZRl+cGKvFY4s5q+qnrTE=
=OjWA
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Oct_2019_00_32_05_+0200_zDIrpdzOEkZ987T4--
