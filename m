Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22816C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62F520730
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8+D/g8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfLXRfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37133 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfLXRff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:35:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so7717273wru.4;
        Tue, 24 Dec 2019 09:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=thPYP74qbpTfSIEtJkPX+tZWPselwUnvQUu7iAHzb54=;
        b=O8+D/g8FcqX/LkeYuIsy+ruXY0I4cS1Ul1HZdK6k8qMhKFJYSj3IDQbmC3F1pFnddh
         tjn3XKf5/A9+BsuWPro0+kvb6lNPnFiT+GS25q6Ezrt4EuQrLraoecN6WM2RWqURWO1T
         Qnxfc7VieWDpzXb0sWzN2n7wXUT/aeSdkQSx2jFRV6wlkCzlPT7h5Ib/IXSgW4rbUaZG
         rx1FyEvlpeX5GGwLcrwI5dXON3nti9nIGOroup+tWa9Gy513uJS8wJ13xOie8tZssfZC
         +vuf1jl83Fu4USg2rsCLMtmBgi3ACYi2LUJD7MEK+2zc8MF7xuKIbIptzp1zkkxC07nj
         gEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=thPYP74qbpTfSIEtJkPX+tZWPselwUnvQUu7iAHzb54=;
        b=ecARZPrIDGyLyebYJTpGQYuwmORt92j4hb2FR4u7iJczRGr1t49TSuSyRU368skNf9
         oaisbo4CoOO+W0Nnudb0CexXFv3RNsmg673obuOkbTMs5WqgaKjxSyVHzBK0ZzApN8fW
         L5sWFOsXaBj0UYgugK0vhDSfXXRRHg0FvuqAGOMOp47y7X2gjy0ie8f1DaAdOKUp13fF
         G2k6WDldcIxx6SNV40aHXL3IP7Ie8MIaYwR8xMbcXEYI+6rL5objPRp4BgXM7muoMCtW
         728nlV9ATyWqjvr8iMwl5R0YmOu0kMrBffAQHaUHi56PO95dBRRB3eYqsedRZOakXRuy
         /Iqg==
X-Gm-Message-State: APjAAAVBlbJ27uMrVqr5B9AeycHJMa5o2to3MurwJH36vgpSu2H6JID6
        tLj8XHUq2F1IAwkQ6IfV/6c=
X-Google-Smtp-Source: APXvYqwlvirQja/YJQpOg7b5jLcZMyFxGpBx5n6JJXI/HapRiiOqJbux4icgDM4DbTH9JVlnrOK60g==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr36449937wrm.293.1577208931723;
        Tue, 24 Dec 2019 09:35:31 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id m21sm3122864wmi.27.2019.12.24.09.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Dec 2019 09:35:30 -0800 (PST)
Date:   Tue, 24 Dec 2019 18:35:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Broken sata_nv since 4.19
Message-ID: <20191224173529.zudlfsjvdqrbayqx@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vyk2wwh2i5mfqkgm"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vyk2wwh2i5mfqkgm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I upgraded machine with NVIDIA SATA controller (nforce4 chipse) from
Debian Stretch to Debian Buster and SATA disks started to have problems.
I booted back to Debian Stretch kernel version (having userspace
untouched in Buster) and everything was like before, so problem is 100%
kernel related. Problematic is APM support (it does not work at all),
HPA support (kernel show warnings at boot time) and whole booting is
delayed by 10 seconds. Also broken is disk speed test.

SATA controller is using sata_nv.ko kernel driver and in lspci is
identified as:

  00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Control=
ler [10de:0054] (rev f3)
  00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Control=
ler [10de:0055] (rev f3)

Debian Stretch has kernel version (which is working fine):

  4.9.0-11-amd64 #1 SMP Debian 4.9.189-3+deb9u2 (2019-11-11) x86_64

Debian Buster has kernel version (which is problematic):

  4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) x86_64

So kernel regression happened somewhere between 4.9 and 4.19 versions.

APM on Stretch:

  $ sudo hdparm -B /dev/sda

  /dev/sda:
   APM_level      =3D not supported

  $ sudo hdparm -B /dev/sdb

  /dev/sdb:
   APM_level      =3D off

APM on Buster:

  $ sudo hdparm -B /dev/sda

  /dev/sda:
  SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 40=
 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   APM_level      =3D not supported


  $ sudo hdparm -B /dev/sdb

  /dev/sdb:
  SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 40=
 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   APM_level      =3D not supported

/dev/sda does not support APM, but /dev/sdb supports. I do not
understand what above SG_IO error means, but because it works fine on
older kernel version, it is not hardware problem.

Disk speed test on Stretch:

  $ sudo hdparm -Tt /dev/sda

  /dev/sda:
   Timing cached reads:   118 MB in  2.00 seconds =3D  58.91 MB/sec
   Timing buffered disk reads: 116 MB in  3.09 seconds =3D  37.54 MB/sec

  $ sudo hdparm -Tt /dev/sdb

  /dev/sdb:
   Timing cached reads:   1242 MB in  2.00 seconds =3D 620.93 MB/sec
   Timing buffered disk reads: 388 MB in  3.00 seconds =3D 129.31 MB/sec

Disk speed test on Buster:

  $ sudo hdparm -Tt /dev/sda

  /dev/sda:
  read() hit EOF - device too small
  SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 40=
 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   Timing buffered disk reads: read() hit EOF - device too small

  $ sudo hdparm -Tt /dev/sdb

  /dev/sdb:
  read() hit EOF - device too small
  SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 40=
 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   Timing buffered disk reads: read() hit EOF - device too small

As can be seen disk speed test is completely broken on new kernel
version and hdparm returns same error as for APM.

dmesg output on Stretch:

[    1.716970] sata_nv 0000:00:07.0: version 3.5
[    1.717309] sata_nv 0000:00:07.0: Using ADMA mode
[    1.717358] sata_nv 0000:00:07.0: Using MSI
[    1.717810] scsi host0: sata_nv
[    1.717954] scsi host1: sata_nv
[    1.718016] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd000 irq=
 20
[    1.718024] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd008 irq=
 20
[    1.718308] sata_nv 0000:00:08.0: Using ADMA mode
[    1.718345] sata_nv 0000:00:08.0: Using MSI
[    1.718757] scsi host2: sata_nv
[    1.718886] scsi host3: sata_nv
[    2.192111] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.194691] ata1.00: HPA detected: current 976771055, native 976773168
[    2.194701] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max UDMA/133
[    2.194709] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.199241] ata1.00: configured for UDMA/133
[    2.199501] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFF=
FF, hw segs 61
[    2.708030] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.710442] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
[    2.710455] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/3=
2)
[    2.715066] ata2.00: configured for UDMA/133
[    2.715333] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFF=
FF, hw segs 61

dmesg output on Buster:

[    2.079293] sata_nv 0000:00:07.0: version 3.5
[    2.133503] sata_nv 0000:00:07.0: Using ADMA mode
[    2.137138] sata_nv 0000:00:07.0: Using MSI
[    2.142043] scsi host0: sata_nv
[    2.174745] scsi host2: sata_nv
[    2.178329] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd000 irq=
 20
[    2.181675] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd008 irq=
 20
[    2.188680] sata_nv 0000:00:08.0: Using ADMA mode
[    2.215676] sata_nv 0000:00:08.0: Using MSI
[    2.219649] scsi host4: sata_nv
[    2.226626] scsi host5: sata_nv
[    2.657732] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    7.773692] ata1.00: qc timeout (cmd 0x27)
[    7.773738] ata1.00: failed to read native max address (err_mask=3D0x4)
[    7.773785] ata1.00: HPA support seems broken, skipping HPA handling
[    8.245678] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.248009] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max UDMA/133
[    8.248065] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 32)
[    8.252593] ata1.00: configured for UDMA/133
[    8.252964] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFF=
FF, hw segs 61
[    8.725693] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   13.917688] ata2.00: qc timeout (cmd 0x27)
[   13.920096] ata2.00: failed to read native max address (err_mask=3D0x4)
[   13.922491] ata2.00: HPA support seems broken, skipping HPA handling
[   14.393683] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   14.398360] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
[   14.400813] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32)
[   14.407722] ata2.00: configured for UDMA/133
[   14.412939] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFF=
FF, hw segs 61

As can be seen new kernel has problems with handling of both SATA
controllers and disks HPA area. Plus before kernel prints
"qc timeout (cmd 0x27)" there is nothing on output, seems that kernel
waits until 5s timeout occur and it slow down booting by 10s.

Do you have any idea what is happening there? What those SG_IO errors
or dmesg errors means?

I'm CCing all people who touched sata_nv.c file between 4.9 and 4.19
versions, so maybe somebody would know anything about this problem.

If you need more information or other outputs, please let me know and I
can provide it.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--vyk2wwh2i5mfqkgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgJMXwAKCRCL8Mk9A+RD
Urb3AKDLc6IPDlsDFe5kR4+GYsj9QXOu/ACfTOC1e4gZegC2rK8fAX6ZpsWsCQU=
=v79B
-----END PGP SIGNATURE-----

--vyk2wwh2i5mfqkgm--
