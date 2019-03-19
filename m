Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C482C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFA620854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCSGOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:14:55 -0400
Received: from smtp.bonedaddy.net ([45.33.94.42]:42126 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCSGOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:14:55 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Mar 2019 02:14:54 EDT
Received: from chianamo (unknown [114.111.153.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id 7BAF1180043;
        Tue, 19 Mar 2019 02:06:33 -0400 (EDT)
Message-ID: <c8b7ecb8508895bf4adb62a748e2ea2c71854597.camel@bonedaddy.net>
Subject: PROBLEM: Linux kernel.core_pattern with pipes does argument
 splitting after template expansion
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jakub Wilk <jwilk@jwilk.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-/kAUG1cFZlcQ+Edi9z5s"
Date:   Tue, 19 Mar 2019 14:06:27 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.30.5-1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/kAUG1cFZlcQ+Edi9z5s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Linux kernel.core_pattern support for core dump handlers using the
pipe syntax does argument splitting after template expansion.

At minimum this bug could cause truncated values for the executable
name. This also means that the argument parsing for core dump handlers
is slightly more complicated because they have to deal with the fact
that an attacker that can control the executable name via %E and %e
could pass additional arguments, including command-line options, to the
handler. Usually this is easy to deal with by merging the remaining
arguments after an options termination indicator but it is very
unlikely that core dump handler implementers are aware of the issue.

Theoretically hostnames with %h could also be split up but in practice
they do not appear to be allowed to contain spaces.

Steps to reproduce:

   $ cat foo=20
   #!/bin/sh
   printf "%s~" "$@" >> /var/log/core
   echo >> /var/log/core

   $ chmod a+rx foo

   $ sudo sysctl kernel.core_pattern=3D"|`pwd`/foo %E"
   kernel.core_pattern =3D |/home/pabs/foo %E

   $ cp /bin/sleep 'sleep with spaces'

   $ ./sleep\ with\ spaces 55555 &
   [1] 16041

   $ kill -SEGV %1
   [1]+  Segmentation fault      (core dumped) ./sleep\ with\ spaces 55555

Incorrect results:

   $ cat /var/log/core
   !home!pabs!sleep~with~spaces~

Correct results:

   $ cat /var/log/core
   !home!pabs!sleep with spaces~

This was originally reported by Jakub Wilk <jwilk@jwilk.net>:
<20190312145043.jxjoj66kqssptolr@jwilk.net>
https://bugs.debian.org/924398

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-/kAUG1cFZlcQ+Edi9z5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAlyQht8ACgkQMRa6Xp/6
aaNflhAAqeV4lwN8MJQOpFEUQPbk/Nwy0gw/oO9oCTOg//oVcn4WA0xm4KHkc2cK
8YNdsr0AziSH+/6legrCS8X3yL9BFLza6V7T296oLXTdlhDhEI4qqSKKiF6fWTT3
p0YLgIvBe+4mOMXRZx2821oUhTdAZQ8Pn2gN76HqCFfy/0Ym28j+FlcRhfdGRm4E
dh3mbwqUcig4Klv9BXnlHh7qLGo4ZnezFLLO/yJsyPjxJKxNpgaYenF1OwdP3S6s
rSjXOBPRN8mriqVE9X4kw5eLGOkUHVV78xhtVzqTPNVCTfgMgjkXpNPIe5v+qL/2
ymJAeJDT7ghwG+v0Nc6aWZuXvn0tBvmx45hKZcSWNdOJtWcqgi3EloRvrY/OJxEw
A/P2wvfb2WgSPIQ3i4snoqAcbn9+wdPzCt4RrkBbCFnSWs4/sB5MnNR6DuG+T5/V
r1hUqdRJAzco8oZ1n9MW+rkWYJdhZV8pDcCKv+OGPmw3O3W9S4eOAjrNzGciBTej
epkkLOwewot/PrNqj9Rsqgf6yz0plkXRsKC4hIXE6DyntiIU6wtn435YKYEi8QxR
ma7PFV4ylVjYWaTp1Pjbv+c7ToG2QN841rHvtfEOM8xhniSX4b9oOLi++f5ky1g8
qjam1ie9H0NrcCg615arLD8hnB7qT+xWg5SGem3dzeut1aC9JJk=
=66OZ
-----END PGP SIGNATURE-----

--=-/kAUG1cFZlcQ+Edi9z5s--

