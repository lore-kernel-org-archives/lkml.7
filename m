Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF7EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1712F20862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfJCTjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:39:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731412AbfJCTjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:39:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C164AFA9;
        Thu,  3 Oct 2019 19:39:40 +0000 (UTC)
Message-ID: <2af0a5ad604064d8fcf9febce72f0c23f1a1a1db.camel@suse.de>
Subject: Re: [PATCH] ARM: dt: check MPIDR on MP devices built without SMP
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        "kernelci.org bot" <bot@kernelci.org>, wahrenst@gmx.net
Date:   Thu, 03 Oct 2019 21:39:38 +0200
In-Reply-To: <17976e82-04da-d22d-5779-f50db63f98a2@gmail.com>
References: <20191002114508.1089-1-nsaenzjulienne@suse.de>
         <17976e82-04da-d22d-5779-f50db63f98a2@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wn5QOuBuM4PXmz8oEO2H"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wn5QOuBuM4PXmz8oEO2H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 11:08 -0700, Florian Fainelli wrote:
> On 10/2/19 4:45 AM, Nicolas Saenz Julienne wrote:
> > Currently, in arm_dt_init_cpu_maps(), the hwid of the boot CPU is read
> > from MPIDR on SMP devices and set to 0 for non SMP. This value is then
> > matched with the DT cpu nodes' reg property in order to find the boot
> > CPU in DT.
>=20
> The code you change is about the "mpidr" variable, yet in your commit
> message you refer to "hwid", that is a tad confusing for the reader.

Sorry, it's indeed pretty confusing. I'll send a new version with a fixed
description if there is no major push back.

> > On MP devices build without SMP the cpu DT node contains the expected
> > MPIDR yet the hwid is set to 0. With this the function fails to match
> > the cpus and uses the default CPU logical map. Making it impossible to
> > get the CPU's DT node further down the line. This causes issues with
> > cpufreq-dt, as it triggers warnings when not finding a suitable DT node
> > on CPU0.
> >=20
> > Change the way we choose whether to get MPIDR or not. Instead of
> > depending on SMP check the number of CPUs defined in DT. Anything > 1
> > means MPIDR will be available.
>=20
> Except if someone accidentally wrote their Device Tree such as to have >
> 1 CPU nodes, yet the CPU is not MP capable and reading the MPIDR
> register does return the expected value, but that is wrong anyway.

An UP device will most likely not have a MPIDR. That said I'm not sure this=
 is
always true. As per ARM1176JZ's TRM[1], the RPi1 CPU, if one was to get the
MPIDR it would raise an undefined exception.

The way I see it's an acceptable outcome as the DT is clearly wrong.

Regarda,
Nicolas

[1] See 3.1.10 Use of the system control coprocessor in
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0333h/DDI0333H_arm1176j=
zs_r0p7_trm.pdf:

	"Attempting to read from a nonreadable register, or to write to a
	nonwriteable register causes Undefined exceptions."


--=-wn5QOuBuM4PXmz8oEO2H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2WTnoACgkQlfZmHno8
x/4bvAgAtyk/Bgiw8yUW6YI6IH0WAjg+Xb0H7sklA8m+ex4biH6o0mDe3SCvFsVn
uN0bSzNeoJxGsAdv5SM9bRMv0nlQSmwEWNTEgsiXKihrhrLOY/makXv9youT7egg
nwaEQ+3W7T9xPjKXyYj/2GjdLVIrmno0eRdSJMht6vFBTZcrWDJQLbu5UwWwDfYP
oYSQjPnMYwB5h1jlS7OYvggAoatV+6eMK7fseHVPf1GGWtk4TKus2JSudUlzMDN4
xsa3PiRyZCudDgmEO7ZIwbRRj0sZPoePrTrVVRFuSbY2HnMCnZgN4LLs5egCt0lJ
YD/FPhJPvHjSGKhBg7veHxguuSRpfQ==
=sLCN
-----END PGP SIGNATURE-----

--=-wn5QOuBuM4PXmz8oEO2H--

