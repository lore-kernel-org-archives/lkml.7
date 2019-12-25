Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F4C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E4C20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 14:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOv5H1xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLYOCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 09:02:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39563 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLYOCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 09:02:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so21829328wrt.6;
        Wed, 25 Dec 2019 06:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZI2x2dJCLjoWui2T/69ue53B20MGYAtOy9JniYTxQdM=;
        b=dOv5H1xMapGr93AONepk1LXA8TRxkvZvF95PvyVLEJzz9P9zv4SIar1Ob5R+oJpqgK
         NxZ/Mb4Vrl8uMu2Qr3oXHRhE9joImNg4EcXbOjprdP+0C/NnI5QX+PdiyztJkrHj4X5P
         GjSo/KBetTntqQaAiiK0W5oG54ZLlbBuF/D6Z6mZlZE2bg1HYtRTqG52TaOQGsMxqfG0
         QX9q0lNc6MEyf/U5FVBy2bG0KhKVG+3bxaoFz0WOQSMG6K/Ge4jyTxlgqSZARSVXurbz
         FfKLT7cqotQd3mmcnHEPe9NVoi/C1ns7aLiPhH4S+JxITioTWHIl9eD4AZz5tlcEO1C2
         zHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZI2x2dJCLjoWui2T/69ue53B20MGYAtOy9JniYTxQdM=;
        b=Zkjf9V8DCbZira857wr02qo9M/JQvuvkZ3bakqy3NjwviWom/rJ1WWB0mJ01UMYqKG
         FsPdZ4GBXK7ZptX9h4li10AYtGQvHeylAiOBZ37wAmHAJEBbX/kgRFUCs0WaZTq0HNvs
         7R2qGWQg03oqPAiCq3YZ7mwe3zOtLnvxdKjdwV1cKSayNP4jVI2Uz7Tp740QVpYQ4t8U
         NjgfUhc8AoXkj71NwstpoeuT1d6x1Innd7rfe7VXZ0m+cRXulX8c2hBKZyyOsH/fIVxY
         Svbp6HL/FefFdZu2G1sZAe7CO3UTyOZhpOUwS/pG2UkNkcdfMP+sOfxrkbYVPUyqSYlb
         O8Sg==
X-Gm-Message-State: APjAAAUgaWymP/FbYVQ0RoKkU03OB5/f32rW/3I5/iYuQsqUgRSJ9ggx
        1fJLy39Sx7HOnvFRWo6UpKU=
X-Google-Smtp-Source: APXvYqyWYUM/Rg8NsMw+WEAqQXgvZD/9PtjI+YxABMsYeV+JiA6dx+lP611KNuMU8ogRKvvJIdPdIQ==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr40797828wrm.293.1577282520112;
        Wed, 25 Dec 2019 06:02:00 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u1sm5574345wmc.5.2019.12.25.06.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Dec 2019 06:01:59 -0800 (PST)
Date:   Wed, 25 Dec 2019 15:01:58 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Broken sata_nv since 4.19
Message-ID: <20191225140158.eeh2immcbi3ou633@pali>
References: <20191224173529.zudlfsjvdqrbayqx@pali>
 <20191225110531.devfxvumnxwgtsif@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jahbjbeqaywbbylu"
Content-Disposition: inline
In-Reply-To: <20191225110531.devfxvumnxwgtsif@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jahbjbeqaywbbylu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens, can you please try to look at this problem?

On Wednesday 25 December 2019 12:05:31 Pali Roh=C3=A1r wrote:
> On Tuesday 24 December 2019 18:35:29 Pali Roh=C3=A1r wrote:
> > Hello!
> >=20
> > I upgraded machine with NVIDIA SATA controller (nforce4 chipse) from
> > Debian Stretch to Debian Buster and SATA disks started to have problems.
> > I booted back to Debian Stretch kernel version (having userspace
> > untouched in Buster) and everything was like before, so problem is 100%
> > kernel related. Problematic is APM support (it does not work at all),
> > HPA support (kernel show warnings at boot time) and whole booting is
> > delayed by 10 seconds. Also broken is disk speed test.
> >=20
> > SATA controller is using sata_nv.ko kernel driver and in lspci is
> > identified as:
> >=20
> >   00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Con=
troller [10de:0054] (rev f3)
> >   00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Con=
troller [10de:0055] (rev f3)
> >=20
> > Debian Stretch has kernel version (which is working fine):
> >=20
> >   4.9.0-11-amd64 #1 SMP Debian 4.9.189-3+deb9u2 (2019-11-11) x86_64
> >=20
> > Debian Buster has kernel version (which is problematic):
> >=20
> >   4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) x86_64
> >=20
> > So kernel regression happened somewhere between 4.9 and 4.19 versions.
> >=20
> > APM on Stretch:
> >=20
> >   $ sudo hdparm -B /dev/sda
> >=20
> >   /dev/sda:
> >    APM_level      =3D not supported
> >=20
> >   $ sudo hdparm -B /dev/sdb
> >=20
> >   /dev/sdb:
> >    APM_level      =3D off
> >=20
> > APM on Buster:
> >=20
> >   $ sudo hdparm -B /dev/sda
> >=20
> >   /dev/sda:
> >   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 5=
5 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >    APM_level      =3D not supported
> >=20
> >=20
> >   $ sudo hdparm -B /dev/sdb
> >=20
> >   /dev/sdb:
> >   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 5=
5 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >    APM_level      =3D not supported
> >=20
> > /dev/sda does not support APM, but /dev/sdb supports. I do not
> > understand what above SG_IO error means, but because it works fine on
> > older kernel version, it is not hardware problem.
> >=20
> > Disk speed test on Stretch:
> >=20
> >   $ sudo hdparm -Tt /dev/sda
> >=20
> >   /dev/sda:
> >    Timing cached reads:   118 MB in  2.00 seconds =3D  58.91 MB/sec
> >    Timing buffered disk reads: 116 MB in  3.09 seconds =3D  37.54 MB/sec
> >=20
> >   $ sudo hdparm -Tt /dev/sdb
> >=20
> >   /dev/sdb:
> >    Timing cached reads:   1242 MB in  2.00 seconds =3D 620.93 MB/sec
> >    Timing buffered disk reads: 388 MB in  3.00 seconds =3D 129.31 MB/sec
> >=20
> > Disk speed test on Buster:
> >=20
> >   $ sudo hdparm -Tt /dev/sda
> >=20
> >   /dev/sda:
> >   read() hit EOF - device too small
> >   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 5=
5 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >    Timing buffered disk reads: read() hit EOF - device too small
> >=20
> >   $ sudo hdparm -Tt /dev/sdb
> >=20
> >   /dev/sdb:
> >   read() hit EOF - device too small
> >   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 5=
5 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >    Timing buffered disk reads: read() hit EOF - device too small
> >=20
> > As can be seen disk speed test is completely broken on new kernel
> > version and hdparm returns same error as for APM.
> >=20
> > dmesg output on Stretch:
> >=20
> > [    1.716970] sata_nv 0000:00:07.0: version 3.5
> > [    1.717309] sata_nv 0000:00:07.0: Using ADMA mode
> > [    1.717358] sata_nv 0000:00:07.0: Using MSI
> > [    1.717810] scsi host0: sata_nv
> > [    1.717954] scsi host1: sata_nv
> > [    1.718016] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd000=
 irq 20
> > [    1.718024] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd008=
 irq 20
> > [    1.718308] sata_nv 0000:00:08.0: Using ADMA mode
> > [    1.718345] sata_nv 0000:00:08.0: Using MSI
> > [    1.718757] scsi host2: sata_nv
> > [    1.718886] scsi host3: sata_nv
> > [    2.192111] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [    2.194691] ata1.00: HPA detected: current 976771055, native 9767731=
68
> > [    2.194701] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max UDM=
A/133
> > [    2.194709] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 3=
1/32)
> > [    2.199241] ata1.00: configured for UDMA/133
> > [    2.199501] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFF=
FFFFFF, hw segs 61
> > [    2.708030] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [    2.710442] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> > [    2.710455] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth =
31/32)
> > [    2.715066] ata2.00: configured for UDMA/133
> > [    2.715333] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFF=
FFFFFF, hw segs 61
> >=20
> > dmesg output on Buster:
> >=20
> > [    2.079293] sata_nv 0000:00:07.0: version 3.5
> > [    2.133503] sata_nv 0000:00:07.0: Using ADMA mode
> > [    2.137138] sata_nv 0000:00:07.0: Using MSI
> > [    2.142043] scsi host0: sata_nv
> > [    2.174745] scsi host2: sata_nv
> > [    2.178329] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd000=
 irq 20
> > [    2.181675] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd008=
 irq 20
> > [    2.188680] sata_nv 0000:00:08.0: Using ADMA mode
> > [    2.215676] sata_nv 0000:00:08.0: Using MSI
> > [    2.219649] scsi host4: sata_nv
> > [    2.226626] scsi host5: sata_nv
> > [    2.657732] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [    7.773692] ata1.00: qc timeout (cmd 0x27)
> > [    7.773738] ata1.00: failed to read native max address (err_mask=3D0=
x4)
> > [    7.773785] ata1.00: HPA support seems broken, skipping HPA handling
> > [    8.245678] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [    8.248009] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max UDM=
A/133
> > [    8.248065] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 3=
2)
> > [    8.252593] ata1.00: configured for UDMA/133
> > [    8.252964] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFF=
FFFFFF, hw segs 61
> > [    8.725693] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [   13.917688] ata2.00: qc timeout (cmd 0x27)
> > [   13.920096] ata2.00: failed to read native max address (err_mask=3D0=
x4)
> > [   13.922491] ata2.00: HPA support seems broken, skipping HPA handling
> > [   14.393683] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [   14.398360] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> > [   14.400813] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth =
32)
> > [   14.407722] ata2.00: configured for UDMA/133
> > [   14.412939] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFF=
FFFFFF, hw segs 61
> >=20
> > As can be seen new kernel has problems with handling of both SATA
> > controllers and disks HPA area. Plus before kernel prints
> > "qc timeout (cmd 0x27)" there is nothing on output, seems that kernel
> > waits until 5s timeout occur and it slow down booting by 10s.
> >=20
> > Do you have any idea what is happening there? What those SG_IO errors
> > or dmesg errors means?
> >=20
> > I'm CCing all people who touched sata_nv.c file between 4.9 and 4.19
> > versions, so maybe somebody would know anything about this problem.
> >=20
> > If you need more information or other outputs, please let me know and I
> > can provide it.
>=20
> Now I tested also versions 4.11, 4.12, 4.13, 4.14, 4.15, 4.16, 4.17 and
> 4.18. And problem appeared only in 4.18 (all previous versions work
> fine) In 4.18 dmesg is:
>=20
> [    8.596039] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    8.598489] ata2: illegal qc_active transition (100000000->100000001)
> [   13.792086] ata2.00: qc timeout (cmd 0x27)
> [   13.792122] ata2.00: failed to read native max address (err_mask=3D0x4)
> [   13.792167] ata2.00: HPA support seems broken, skipping HPA handling
> [   14.264041] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   14.268756] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> [   14.271230] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32)
> [   14.278161] ata2.00: configured for UDMA/133
> [   14.283427] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFF=
FFFF, hw segs 61
>=20
> (There is another line "illegal qc_active transition" which is not
> present in 4.19)
>=20
> So this problem must have been introduced during 4.18 release cycle as
> 4.17 version is working fine.

I tried to git bisect this problem between 4.17 and 4.18. I used
following command to filter relevant libata.ko and sata_nv.ko modules:

  $ git bisect start v4.18 v4.17 -- drivers/ata/libata* drivers/ata/sata_nv=
=2Ec

And here are results:

sata_nv.ko and libata.ko compiled from commit 804689 (libata: Fix
command retry decision) for 4.17 kernel are working fine.

sata_nv.ko and libata.ko compiled from commit e3ed89 (libata: bump
->qc_active to a 64-bit type) for 4.18 kernel are broken.

So problem seems to be somehow related with introduction of hardware
tags done by Jens Axboe.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--jahbjbeqaywbbylu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgNr0AAKCRCL8Mk9A+RD
UkC+AJ0UdvstvN+dtMOXdbFjfJesvq9OdQCeLPyNu6uw0s+QyKbvUKN+Zkf0hfQ=
=Fo1Q
-----END PGP SIGNATURE-----

--jahbjbeqaywbbylu--
