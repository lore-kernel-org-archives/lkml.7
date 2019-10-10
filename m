Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B241C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E71206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="nenXF+BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfJJXC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:02:59 -0400
Received: from devianza.investici.org ([198.167.222.108]:58355 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfJJXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:02:59 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 19:02:59 EDT
Received: from mx2.investici.org (localhost [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id A028AE0629
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
        s=stigmate; t=1570747994;
        bh=LTkQOaHOhoxVL8eIcU9yAQE+5E+2PKoxTj6B885Ptcc=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=nenXF+BEME8vmNZ9S6cpJ2djNgK2JNc34EkJzZspeke/tA8wsf1BYsO7KHCyk3lrd
         ZYRUW9sRcQbEyuyaeJ51jHWt5XEblkKz0u9fY53qJFK2YchpzmmAtdPoEo4VxZ6wAP
         0jMUXnw6TnH+ttTJOBuZtXZqaUDY8OPvVUPDUkFo=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 8D13DE05FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:53:14 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.92.2)
        (envelope-from <invernomuto@paranoici.org>)
        id 1iIhJ3-0001UD-PF
        for linux-kernel@vger.kernel.org; Fri, 11 Oct 2019 00:53:13 +0200
Date:   Fri, 11 Oct 2019 00:51:03 +0200
From:   Francesco Poli <invernomuto@paranoici.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: Question about sched_prio_to_weight values
Message-Id: <20191011005103.88df00d60d3f99d66a9d558f@paranoici.org>
In-Reply-To: <21c11aca-e531-7d72-9a70-f52c12d5d408@arm.com>
References: <20191007003205.8888ac99da2dd732b6198387@paranoici.org>
        <506d5ee6-246a-a03d-ea11-227ff4de1467@arm.com>
        <20191007224143.d21abae57a3f32ac60afd53c@paranoici.org>
        <21c11aca-e531-7d72-9a70-f52c12d5d408@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Fri__11_Oct_2019_00_51_03_+0200_8jgb4MiSlRj/lIV="
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__11_Oct_2019_00_51_03_+0200_8jgb4MiSlRj/lIV=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2019 18:28:36 +0100 Valentin Schneider wrote:

> On 07/10/2019 21:41, Francesco Poli wrote:
> > The differences are probably due to the different precision
> > of the computations: I don't know the precision of those originally
> > carried out by Ingo Molnar (single precision? double?), but calc(1)
> > is an arbitrary precision calculator and, by default, performs
> > calculations with epsilon =3D 1e-20 !
> >=20
> > Please note that, except for the first one, all the differing
> > values obtained with the calc(1) script have slightly better
> > errors than the ones found in kernel/sched/core.c ...
> >=20
>=20
> As always patches are welcome, but I don't know how much there is to gain
> from a tiny error correction in those factors.

I can of course prepare a patch (a trivial adjustment of some of those
numbers), if there's interest about it, but I'll leave to you kernel
hackers to decide whether the modification may be worth doing (I am no
scheduler expert, I don't even know exactly how to test the scheduler
and assess whether a given patch is beneficial or not)...

>=20
> Out of curiosity, what led you to stare at those numbers?

While reading a chapter of a book on operating systems, I encountered
the nice-level-to-weight mapping, as defined in the CFS: I became
obsessively curious and wanted by any means to understand how those
numbers were decided. That's why I was trying to reproduce them with
some criterion which could make sense.


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Fri__11_Oct_2019_00_51_03_+0200_8jgb4MiSlRj/lIV=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAl2ftdcACgkQPhwn4R9p
v/4jaw/+Iz+mbvCjSFyqqsPUZGg40nUOD24w6AyYjqdRvp7DncXWwrFZbkqJUute
WTyBRKiukggS9PisPvfci201cODhrBHLmD7HCMtjhOFCnLWp2oKjh1jip6J8mr1e
4w455J53AIr20GUUm4hzrjgKzD9L3+2PZwwpf2oYhNZ1AJmLH7UerEryMYnfsFDl
+V+cikGmlDHZ+rGx7nl1krixry2B1U+Gb9Xhgo3TQsSDn8YTdflJoH2EH1yVwHS2
nPFMgqphm08IMpKgLufUD5m1xTUE4GVYPqxplJhqqDtHDWfsUtHG8WLonMknZjgP
z6cyYeARXl1qmymkfMFZ78ejs+nB18JxEGzVsRE4KKXVswmW/n5Rh8pLNOeEEvuJ
EM/tm0B8VSoMiyGGcng7gl85mrWrQdQHxXGoA9Hpm8RqHM9qI/iGmKdH9jSiIMtV
bRkt+NECUJFUcrf/mJpJo37ylaoqSwctAAgo7zzb3lwx+0yW3MRMrZsvGplVvvLA
97p33N2SJPTmfkOnvuR24QF+uvoKaPi9MyCkR/3Y0EVlksfQftfGjC1CQ3Aq73ra
tjpxthbbnxjtol3/Qke0YB4FNcOvPQiVkacqucrnL0fZ/MBTtT58J5tgFN2GAXiu
s0SSwi2YaAniN6UwMrlqqokS4Ws6PAxdMDHc9CXNe8CCQxfO7jY=
=W2Zj
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Oct_2019_00_51_03_+0200_8jgb4MiSlRj/lIV=--
