Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD5FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1422075E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 18:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYci5wRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfLYSIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 13:08:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40625 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 13:08:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so22125036wrn.7;
        Wed, 25 Dec 2019 10:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AsMRw0W8h1ltr8Iu827R4QfFuec0aKEPoTfIzBG60TE=;
        b=pYci5wRX5OYKT3/kJrjTJoi94ZUEGPgkEgqBcUOKSz5PzstrKc4FBPyI+S7cYzbkqq
         a5GkzZrqL5hxLiqKGZOaNyuaUFKfCxz9qAOlqoLc1xS4eGr2tnhQbEF5e3kHuLtBhGx1
         Q20P+1ibxWfcCdmrc6S3Rl0025yKD5p5Ukmj0YMEM518Lkh+HsxbNHEp443lMpZ66Zps
         UuM9gWXHTw+2aIg7Gnf17qDR8EmE2IU30WDS7ubVBkZPvfBCw9ERze79TgvW1noOWtcc
         468g5n4MVa4PDuKXAQ38lNfYL03Hvm8qlp2uyf6G/+I5EyiLXsMEHlqJyojmpUhXzYbA
         0Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AsMRw0W8h1ltr8Iu827R4QfFuec0aKEPoTfIzBG60TE=;
        b=sJLzKWLg9gmj5K6MN6hKJI/PgVAK4M4vazoU+rperguF0a51nrvB9IfkCnS6CL2ada
         ZILszB05mOax6FTlCw3P9CFvWdG2I6cTnMVvm+AMEdSMETm2KUiejEMjMUJZBceC2tSx
         Q8Qkkgtzs9i0oqf+LZKbg0blsNaP3X7W8nbQcECQl5s7AA5Z/h+0bOb0yvgc1m5OlmnR
         RfkSBK2X+ykk2xSCOeTII6XJdnubzCYYkbVbYSp3cNh+intjTpjjaYjrgYgepXhZPxOm
         gLt5FfN8xH2LNkgcb6OtmKUsgEvYtPcsNQKdheKB3UYKdPD8ghfY4wmyQtr7edY8dCMG
         v4gw==
X-Gm-Message-State: APjAAAVHbhw2UkpXrbI3yYswT4Awx3AsDeCkfyCK8EEg2rykgwiALB1G
        TyCZMhEvjhZhwZoKmlzSCPA=
X-Google-Smtp-Source: APXvYqx43MnUGHhDN3HRkPSnenCqM4h6uVLB7/zy1tpVojgXNVmP+ouqqTY/2INRGJsbWIuLD/QJ7A==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr42197579wrq.196.1577297306622;
        Wed, 25 Dec 2019 10:08:26 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r15sm6093305wmh.21.2019.12.25.10.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Dec 2019 10:08:25 -0800 (PST)
Date:   Wed, 25 Dec 2019 19:08:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Broken sata_nv since 4.19
Message-ID: <20191225180824.bql2o5whougii4ch@pali>
References: <20191224173529.zudlfsjvdqrbayqx@pali>
 <20191225110531.devfxvumnxwgtsif@pali>
 <20191225140158.eeh2immcbi3ou633@pali>
 <956ff5fc-4d2e-415b-80da-5efe1448c7a8@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p2tgevmu2lu4b4iy"
Content-Disposition: inline
In-Reply-To: <956ff5fc-4d2e-415b-80da-5efe1448c7a8@kernel.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2tgevmu2lu4b4iy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 December 2019 08:00:05 Jens Axboe wrote:
> On 12/25/19 7:01 AM, Pali Roh=C3=A1r wrote:
> > Hi Jens, can you please try to look at this problem?
> >=20
> > On Wednesday 25 December 2019 12:05:31 Pali Roh=C3=A1r wrote:
> >> On Tuesday 24 December 2019 18:35:29 Pali Roh=C3=A1r wrote:
> >>> Hello!
> >>>
> >>> I upgraded machine with NVIDIA SATA controller (nforce4 chipse) from
> >>> Debian Stretch to Debian Buster and SATA disks started to have proble=
ms.
> >>> I booted back to Debian Stretch kernel version (having userspace
> >>> untouched in Buster) and everything was like before, so problem is 10=
0%
> >>> kernel related. Problematic is APM support (it does not work at all),
> >>> HPA support (kernel show warnings at boot time) and whole booting is
> >>> delayed by 10 seconds. Also broken is disk speed test.
> >>>
> >>> SATA controller is using sata_nv.ko kernel driver and in lspci is
> >>> identified as:
> >>>
> >>>   00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA C=
ontroller [10de:0054] (rev f3)
> >>>   00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA C=
ontroller [10de:0055] (rev f3)
> >>>
> >>> Debian Stretch has kernel version (which is working fine):
> >>>
> >>>   4.9.0-11-amd64 #1 SMP Debian 4.9.189-3+deb9u2 (2019-11-11) x86_64
> >>>
> >>> Debian Buster has kernel version (which is problematic):
> >>>
> >>>   4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) x86_64
> >>>
> >>> So kernel regression happened somewhere between 4.9 and 4.19 versions.
> >>>
> >>> APM on Stretch:
> >>>
> >>>   $ sudo hdparm -B /dev/sda
> >>>
> >>>   /dev/sda:
> >>>    APM_level      =3D not supported
> >>>
> >>>   $ sudo hdparm -B /dev/sdb
> >>>
> >>>   /dev/sdb:
> >>>    APM_level      =3D off
> >>>
> >>> APM on Buster:
> >>>
> >>>   $ sudo hdparm -B /dev/sda
> >>>
> >>>   /dev/sda:
> >>>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa=
 55 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>>    APM_level      =3D not supported
> >>>
> >>>
> >>>   $ sudo hdparm -B /dev/sdb
> >>>
> >>>   /dev/sdb:
> >>>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa=
 55 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>>    APM_level      =3D not supported
> >>>
> >>> /dev/sda does not support APM, but /dev/sdb supports. I do not
> >>> understand what above SG_IO error means, but because it works fine on
> >>> older kernel version, it is not hardware problem.
> >>>
> >>> Disk speed test on Stretch:
> >>>
> >>>   $ sudo hdparm -Tt /dev/sda
> >>>
> >>>   /dev/sda:
> >>>    Timing cached reads:   118 MB in  2.00 seconds =3D  58.91 MB/sec
> >>>    Timing buffered disk reads: 116 MB in  3.09 seconds =3D  37.54 MB/=
sec
> >>>
> >>>   $ sudo hdparm -Tt /dev/sdb
> >>>
> >>>   /dev/sdb:
> >>>    Timing cached reads:   1242 MB in  2.00 seconds =3D 620.93 MB/sec
> >>>    Timing buffered disk reads: 388 MB in  3.00 seconds =3D 129.31 MB/=
sec
> >>>
> >>> Disk speed test on Buster:
> >>>
> >>>   $ sudo hdparm -Tt /dev/sda
> >>>
> >>>   /dev/sda:
> >>>   read() hit EOF - device too small
> >>>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa=
 55 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>>    Timing buffered disk reads: read() hit EOF - device too small
> >>>
> >>>   $ sudo hdparm -Tt /dev/sdb
> >>>
> >>>   /dev/sdb:
> >>>   read() hit EOF - device too small
> >>>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa=
 55 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>>    Timing buffered disk reads: read() hit EOF - device too small
> >>>
> >>> As can be seen disk speed test is completely broken on new kernel
> >>> version and hdparm returns same error as for APM.
> >>>
> >>> dmesg output on Stretch:
> >>>
> >>> [    1.716970] sata_nv 0000:00:07.0: version 3.5
> >>> [    1.717309] sata_nv 0000:00:07.0: Using ADMA mode
> >>> [    1.717358] sata_nv 0000:00:07.0: Using MSI
> >>> [    1.717810] scsi host0: sata_nv
> >>> [    1.717954] scsi host1: sata_nv
> >>> [    1.718016] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd0=
00 irq 20
> >>> [    1.718024] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd0=
08 irq 20
> >>> [    1.718308] sata_nv 0000:00:08.0: Using ADMA mode
> >>> [    1.718345] sata_nv 0000:00:08.0: Using MSI
> >>> [    1.718757] scsi host2: sata_nv
> >>> [    1.718886] scsi host3: sata_nv
> >>> [    2.192111] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>> [    2.194691] ata1.00: HPA detected: current 976771055, native 97677=
3168
> >>> [    2.194701] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max U=
DMA/133
> >>> [    2.194709] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth=
 31/32)
> >>> [    2.199241] ata1.00: configured for UDMA/133
> >>> [    2.199501] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0x=
FFFFFFFF, hw segs 61
> >>> [    2.708030] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>> [    2.710442] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> >>> [    2.710455] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (dept=
h 31/32)
> >>> [    2.715066] ata2.00: configured for UDMA/133
> >>> [    2.715333] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0x=
FFFFFFFF, hw segs 61
> >>>
> >>> dmesg output on Buster:
> >>>
> >>> [    2.079293] sata_nv 0000:00:07.0: version 3.5
> >>> [    2.133503] sata_nv 0000:00:07.0: Using ADMA mode
> >>> [    2.137138] sata_nv 0000:00:07.0: Using MSI
> >>> [    2.142043] scsi host0: sata_nv
> >>> [    2.174745] scsi host2: sata_nv
> >>> [    2.178329] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd0=
00 irq 20
> >>> [    2.181675] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd0=
08 irq 20
> >>> [    2.188680] sata_nv 0000:00:08.0: Using ADMA mode
> >>> [    2.215676] sata_nv 0000:00:08.0: Using MSI
> >>> [    2.219649] scsi host4: sata_nv
> >>> [    2.226626] scsi host5: sata_nv
> >>> [    2.657732] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>> [    7.773692] ata1.00: qc timeout (cmd 0x27)
> >>> [    7.773738] ata1.00: failed to read native max address (err_mask=
=3D0x4)
> >>> [    7.773785] ata1.00: HPA support seems broken, skipping HPA handli=
ng
> >>> [    8.245678] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>> [    8.248009] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max U=
DMA/133
> >>> [    8.248065] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth=
 32)
> >>> [    8.252593] ata1.00: configured for UDMA/133
> >>> [    8.252964] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0x=
FFFFFFFF, hw segs 61
> >>> [    8.725693] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>> [   13.917688] ata2.00: qc timeout (cmd 0x27)
> >>> [   13.920096] ata2.00: failed to read native max address (err_mask=
=3D0x4)
> >>> [   13.922491] ata2.00: HPA support seems broken, skipping HPA handli=
ng
> >>> [   14.393683] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>> [   14.398360] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> >>> [   14.400813] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (dept=
h 32)
> >>> [   14.407722] ata2.00: configured for UDMA/133
> >>> [   14.412939] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0x=
FFFFFFFF, hw segs 61
> >>>
> >>> As can be seen new kernel has problems with handling of both SATA
> >>> controllers and disks HPA area. Plus before kernel prints
> >>> "qc timeout (cmd 0x27)" there is nothing on output, seems that kernel
> >>> waits until 5s timeout occur and it slow down booting by 10s.
> >>>
> >>> Do you have any idea what is happening there? What those SG_IO errors
> >>> or dmesg errors means?
> >>>
> >>> I'm CCing all people who touched sata_nv.c file between 4.9 and 4.19
> >>> versions, so maybe somebody would know anything about this problem.
> >>>
> >>> If you need more information or other outputs, please let me know and=
 I
> >>> can provide it.
> >>
> >> Now I tested also versions 4.11, 4.12, 4.13, 4.14, 4.15, 4.16, 4.17 and
> >> 4.18. And problem appeared only in 4.18 (all previous versions work
> >> fine) In 4.18 dmesg is:
> >>
> >> [    8.596039] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> [    8.598489] ata2: illegal qc_active transition (100000000->10000000=
1)
> >> [   13.792086] ata2.00: qc timeout (cmd 0x27)
> >> [   13.792122] ata2.00: failed to read native max address (err_mask=3D=
0x4)
> >> [   13.792167] ata2.00: HPA support seems broken, skipping HPA handling
> >> [   14.264041] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> [   14.268756] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> >> [   14.271230] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth=
 32)
> >> [   14.278161] ata2.00: configured for UDMA/133
> >> [   14.283427] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xF=
FFFFFFF, hw segs 61
> >>
> >> (There is another line "illegal qc_active transition" which is not
> >> present in 4.19)
> >>
> >> So this problem must have been introduced during 4.18 release cycle as
> >> 4.17 version is working fine.
> >=20
> > I tried to git bisect this problem between 4.17 and 4.18. I used
> > following command to filter relevant libata.ko and sata_nv.ko modules:
> >=20
> >   $ git bisect start v4.18 v4.17 -- drivers/ata/libata* drivers/ata/sat=
a_nv.c
> >=20
> > And here are results:
> >=20
> > sata_nv.ko and libata.ko compiled from commit 804689 (libata: Fix
> > command retry decision) for 4.17 kernel are working fine.
> >=20
> > sata_nv.ko and libata.ko compiled from commit e3ed89 (libata: bump
> > ->qc_active to a 64-bit type) for 4.18 kernel are broken.
> >=20
> > So problem seems to be somehow related with introduction of hardware
> > tags done by Jens Axboe.
>=20
> Can you try with this patch:
>=20
> https://lore.kernel.org/linux-ide/20191213080408.27032-1-s.hauer@pengutro=
nix.de/T/#u
>=20

Great! This patch fixes above problem with sata_nv.ko. Thank you for
quick response.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--p2tgevmu2lu4b4iy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgOllgAKCRCL8Mk9A+RD
UgwyAJ0biXAIFyGBPOzS8/bvaRmSppaMzACfTTMEzPapuXKv7MKGuzcu6BbbnXM=
=U6of
-----END PGP SIGNATURE-----

--p2tgevmu2lu4b4iy--
