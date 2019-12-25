Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771BAC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 11:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A67B2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 11:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8lvYcxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLYLFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:05:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56037 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfLYLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 06:05:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so2479600wmj.5;
        Wed, 25 Dec 2019 03:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fx2ugjV4IiCntXArDrYyQyc6SHr8aMH915a2Wl5DHxc=;
        b=O8lvYcxa51rw/lq4D3m85aGdB2/iRC/WTBAJlDgoujQv3qnb483kSm5A6bxwKS0ro7
         JV7/60RNjcQGkJlplkKbJ+Icqvxti8Xh5pqrGPTPA+n6RW5GRkU7CImBb9H9+/WCdDcW
         Ul3TxBNsm5GGo5wnXTfh5r1O40JWW2n0javAltsoEfoQaAz/O8Y87WXuOW2V1dX4AYfF
         LXYhQyGKFXlbnRHoBOwGKd7NuhKtzxCymHbpHmxfaGDG0KX5TlIzDyWE3QYU3drlOT+n
         JqHRRdiz7D8LxyGOQGHwuScIVFCWGjftmUaLTVh1Lz3ryarlx88oSsx9Ua071f1Buvxf
         Fdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fx2ugjV4IiCntXArDrYyQyc6SHr8aMH915a2Wl5DHxc=;
        b=s7gwYpBdLwpLcqKkmFf4Yhb+TczBSQYoJgwWEJci3ZpZD8dID0s84SbRxvwQny0Kd/
         K3u5shIM0XlrXinZaOr1IfiZHmV0Md0GCfYAsk7xGoQm40/QgQeC5SKKJW6Fl6M7TQi4
         9U8ujn4Hokwpar6cKqyBYLlJoOVLJBQp5e7JgibS4hihyH/QvW4Ag/kWq1uexLlgHD29
         OWShqWfcPHZlUbY/TvBWQ+CSEtj2V/wJcECpf6YdEYN+sV5+3TmZ4F/7Vj2HQyJqkn/r
         cJCHEvodFz5IkNZ0Ou6xyfM0m8onsVLYrKvrPALFT6WPjPPV3g5+WTrG2wLHSZPrbGzB
         FjkQ==
X-Gm-Message-State: APjAAAXZmX31T6KQ7/1i3Wd6OrPcNMugdxd1oSWs0PJ94Otn/H0WCr30
        k5OY6BLC2en87gVDT8ncsf/88kRYoGY=
X-Google-Smtp-Source: APXvYqzbtUZGTy8NpfvN0TsL4ssHnXJvaIgOVAL63FvZNNkNZpVLytBd6GbZcHPi+Q/UpF+PO+Z82g==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr8747052wmh.35.1577271933575;
        Wed, 25 Dec 2019 03:05:33 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x17sm27071158wrt.74.2019.12.25.03.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Dec 2019 03:05:32 -0800 (PST)
Date:   Wed, 25 Dec 2019 12:05:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Broken sata_nv since 4.19
Message-ID: <20191225110531.devfxvumnxwgtsif@pali>
References: <20191224173529.zudlfsjvdqrbayqx@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="suw7wih4m323lw4u"
Content-Disposition: inline
In-Reply-To: <20191224173529.zudlfsjvdqrbayqx@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--suw7wih4m323lw4u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 24 December 2019 18:35:29 Pali Roh=C3=A1r wrote:
> Hello!
>=20
> I upgraded machine with NVIDIA SATA controller (nforce4 chipse) from
> Debian Stretch to Debian Buster and SATA disks started to have problems.
> I booted back to Debian Stretch kernel version (having userspace
> untouched in Buster) and everything was like before, so problem is 100%
> kernel related. Problematic is APM support (it does not work at all),
> HPA support (kernel show warnings at boot time) and whole booting is
> delayed by 10 seconds. Also broken is disk speed test.
>=20
> SATA controller is using sata_nv.ko kernel driver and in lspci is
> identified as:
>=20
>   00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Contr=
oller [10de:0054] (rev f3)
>   00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Contr=
oller [10de:0055] (rev f3)
>=20
> Debian Stretch has kernel version (which is working fine):
>=20
>   4.9.0-11-amd64 #1 SMP Debian 4.9.189-3+deb9u2 (2019-11-11) x86_64
>=20
> Debian Buster has kernel version (which is problematic):
>=20
>   4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) x86_64
>=20
> So kernel regression happened somewhere between 4.9 and 4.19 versions.
>=20
> APM on Stretch:
>=20
>   $ sudo hdparm -B /dev/sda
>=20
>   /dev/sda:
>    APM_level      =3D not supported
>=20
>   $ sudo hdparm -B /dev/sdb
>=20
>   /dev/sdb:
>    APM_level      =3D off
>=20
> APM on Buster:
>=20
>   $ sudo hdparm -B /dev/sda
>=20
>   /dev/sda:
>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 =
40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    APM_level      =3D not supported
>=20
>=20
>   $ sudo hdparm -B /dev/sdb
>=20
>   /dev/sdb:
>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 =
40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    APM_level      =3D not supported
>=20
> /dev/sda does not support APM, but /dev/sdb supports. I do not
> understand what above SG_IO error means, but because it works fine on
> older kernel version, it is not hardware problem.
>=20
> Disk speed test on Stretch:
>=20
>   $ sudo hdparm -Tt /dev/sda
>=20
>   /dev/sda:
>    Timing cached reads:   118 MB in  2.00 seconds =3D  58.91 MB/sec
>    Timing buffered disk reads: 116 MB in  3.09 seconds =3D  37.54 MB/sec
>=20
>   $ sudo hdparm -Tt /dev/sdb
>=20
>   /dev/sdb:
>    Timing cached reads:   1242 MB in  2.00 seconds =3D 620.93 MB/sec
>    Timing buffered disk reads: 388 MB in  3.00 seconds =3D 129.31 MB/sec
>=20
> Disk speed test on Buster:
>=20
>   $ sudo hdparm -Tt /dev/sda
>=20
>   /dev/sda:
>   read() hit EOF - device too small
>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 =
40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    Timing buffered disk reads: read() hit EOF - device too small
>=20
>   $ sudo hdparm -Tt /dev/sdb
>=20
>   /dev/sdb:
>   read() hit EOF - device too small
>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 =
40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    Timing buffered disk reads: read() hit EOF - device too small
>=20
> As can be seen disk speed test is completely broken on new kernel
> version and hdparm returns same error as for APM.
>=20
> dmesg output on Stretch:
>=20
> [    1.716970] sata_nv 0000:00:07.0: version 3.5
> [    1.717309] sata_nv 0000:00:07.0: Using ADMA mode
> [    1.717358] sata_nv 0000:00:07.0: Using MSI
> [    1.717810] scsi host0: sata_nv
> [    1.717954] scsi host1: sata_nv
> [    1.718016] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd000 i=
rq 20
> [    1.718024] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd008 i=
rq 20
> [    1.718308] sata_nv 0000:00:08.0: Using ADMA mode
> [    1.718345] sata_nv 0000:00:08.0: Using MSI
> [    1.718757] scsi host2: sata_nv
> [    1.718886] scsi host3: sata_nv
> [    2.192111] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    2.194691] ata1.00: HPA detected: current 976771055, native 976773168
> [    2.194701] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max UDMA/=
133
> [    2.194709] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 31/=
32)
> [    2.199241] ata1.00: configured for UDMA/133
> [    2.199501] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFF=
FFFF, hw segs 61
> [    2.708030] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    2.710442] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> [    2.710455] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31=
/32)
> [    2.715066] ata2.00: configured for UDMA/133
> [    2.715333] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFF=
FFFF, hw segs 61
>=20
> dmesg output on Buster:
>=20
> [    2.079293] sata_nv 0000:00:07.0: version 3.5
> [    2.133503] sata_nv 0000:00:07.0: Using ADMA mode
> [    2.137138] sata_nv 0000:00:07.0: Using MSI
> [    2.142043] scsi host0: sata_nv
> [    2.174745] scsi host2: sata_nv
> [    2.178329] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd000 i=
rq 20
> [    2.181675] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd008 i=
rq 20
> [    2.188680] sata_nv 0000:00:08.0: Using ADMA mode
> [    2.215676] sata_nv 0000:00:08.0: Using MSI
> [    2.219649] scsi host4: sata_nv
> [    2.226626] scsi host5: sata_nv
> [    2.657732] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    7.773692] ata1.00: qc timeout (cmd 0x27)
> [    7.773738] ata1.00: failed to read native max address (err_mask=3D0x4)
> [    7.773785] ata1.00: HPA support seems broken, skipping HPA handling
> [    8.245678] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    8.248009] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max UDMA/=
133
> [    8.248065] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 32)
> [    8.252593] ata1.00: configured for UDMA/133
> [    8.252964] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFF=
FFFF, hw segs 61
> [    8.725693] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   13.917688] ata2.00: qc timeout (cmd 0x27)
> [   13.920096] ata2.00: failed to read native max address (err_mask=3D0x4)
> [   13.922491] ata2.00: HPA support seems broken, skipping HPA handling
> [   14.393683] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   14.398360] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> [   14.400813] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32)
> [   14.407722] ata2.00: configured for UDMA/133
> [   14.412939] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFF=
FFFF, hw segs 61
>=20
> As can be seen new kernel has problems with handling of both SATA
> controllers and disks HPA area. Plus before kernel prints
> "qc timeout (cmd 0x27)" there is nothing on output, seems that kernel
> waits until 5s timeout occur and it slow down booting by 10s.
>=20
> Do you have any idea what is happening there? What those SG_IO errors
> or dmesg errors means?
>=20
> I'm CCing all people who touched sata_nv.c file between 4.9 and 4.19
> versions, so maybe somebody would know anything about this problem.
>=20
> If you need more information or other outputs, please let me know and I
> can provide it.

Now I tested also versions 4.11, 4.12, 4.13, 4.14, 4.15, 4.16, 4.17 and
4.18. And problem appeared only in 4.18 (all previous versions work
fine) In 4.18 dmesg is:

[    8.596039] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.598489] ata2: illegal qc_active transition (100000000->100000001)
[   13.792086] ata2.00: qc timeout (cmd 0x27)
[   13.792122] ata2.00: failed to read native max address (err_mask=3D0x4)
[   13.792167] ata2.00: HPA support seems broken, skipping HPA handling
[   14.264041] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   14.268756] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
[   14.271230] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32)
[   14.278161] ata2.00: configured for UDMA/133
[   14.283427] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFF=
FF, hw segs 61

(There is another line "illegal qc_active transition" which is not
present in 4.19)

So this problem must have been introduced during 4.18 release cycle as
4.17 version is working fine.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--suw7wih4m323lw4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgNCeQAKCRCL8Mk9A+RD
Un79AJ0bpkOYDOYgxJq9zkQUMu2DqtVCVgCcChSAj9g/sd7yLnPWN/K+ldfOZYc=
=vW5K
-----END PGP SIGNATURE-----

--suw7wih4m323lw4u--
