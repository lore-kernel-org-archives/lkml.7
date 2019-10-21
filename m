Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113E7CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAF72064B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfJURBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:01:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfJURBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:01:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DE04B17E;
        Mon, 21 Oct 2019 17:01:36 +0000 (UTC)
Message-ID: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        will@kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mm@kvack.org, mbrugger@suse.com, wahrenst@gmx.net,
        phill@raspberrypi.org, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Date:   Mon, 21 Oct 2019 19:01:34 +0200
In-Reply-To: <5E3CD9CA-76C3-4D46-BA0B-DEBF650E8950@lca.pw>
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
         <20190911182546.17094-4-nsaenzjulienne@suse.de>
         <3956E54B-6C7A-4C47-B9B6-75F556EFD3F5@lca.pw>
         <78caa5bcfc0d59e8ec5d6b7060df76896d25248b.camel@suse.de>
         <5E3CD9CA-76C3-4D46-BA0B-DEBF650E8950@lca.pw>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mC8X3toxjV4m8PaRcUwZ"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mC8X3toxjV4m8PaRcUwZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-21 at 10:46 -0400, Qian Cai wrote:
> > On Oct 21, 2019, at 10:34 AM, Nicolas Saenz Julienne <nsaenzjulienne@su=
se.de
> > > wrote:
> >=20
> > On Mon, 2019-10-21 at 10:15 -0400, Qian Cai wrote:
> > > > On Sep 11, 2019, at 2:25 PM, Nicolas Saenz Julienne <
> > > > nsaenzjulienne@suse.de>
> > > > wrote:
> > > >=20
> > > > So far all arm64 devices have supported 32 bit DMA masks for their
> > > > peripherals. This is not true anymore for the Raspberry Pi 4 as mos=
t of
> > > > it's peripherals can only address the first GB of memory on a total=
 of
> > > > up to 4 GB.
> > > >=20
> > > > This goes against ZONE_DMA32's intent, as it's expected for ZONE_DM=
A32
> > > > to be addressable with a 32 bit mask. So it was decided to re-intro=
duce
> > > > ZONE_DMA in arm64.
> > > >=20
> > > > ZONE_DMA will contain the lower 1G of memory, which is currently th=
e
> > > > memory area addressable by any peripheral on an arm64 device.
> > > > ZONE_DMA32 will contain the rest of the 32 bit addressable memory.
> > > >=20
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > >=20
> > > > ---
> > >=20
> > > With ZONE_DMA=3Dy, this config will fail to reserve 512M CMA on a ser=
ver,
> > >=20
> > > https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> > >=20
> > > CONFIG_DMA_CMA=3Dy
> > > CONFIG_CMA_SIZE_MBYTES=3D64
> > > CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
> > > CONFIG_CMA_ALIGNMENT=3D8
> > > CONFIG_CMA=3Dy
> > > CONFIG_CMA_DEBUGFS=3Dy
> > > CONFIG_CMA_AREAS=3D7
> > >=20
> > > Is this expected?
> >=20
> > Not really, just tested cma=3D512M on a Raspberry Pi4, and it went well=
. The
> > only
> > thing on my build that differs from your config is CONFIG_CMA_DEBUGFS.
> >=20
> > Could you post more information on the device you're experiencing this =
on?
> > Also
> > some logs.
>=20
> With the above config, it does not even need "cma=3D512M" kernel cmdline.
>=20
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x431f0af1]
> [    0.000000] Linux version 5.4.0-rc4-next-20191021+ (clang version 8.0.=
1
> (Red Hat 8.0.1-1.module+el8.1.0+3866+6be7f4d8)) #1 SMP Mon Oct 21 10:03:0=
3 EDT
> 2019
> [    0.000000] Setting debug_guardpage_minorder to 1
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.70 by American Megatrends
> [    0.000000] efi:  ESRT=3D0xf935ed98  SMBIOS=3D0xfcc90000  SMBIOS
> 3.0=3D0xfcc80000  ACPI 2.0=3D0xfac80000  MEMRESERVE=3D0xfacd1018=20
> [    0.000000] esrt: Reserving ESRT space from 0x00000000f935ed98 to
> 0x00000000f935edd0.
> [    0.000000] crashkernel reserved: 0x00000097db400000 - 0x00000097fb400=
000
> (512 MB)
> [    0.000000] cma: Reserved 512 MiB at 0x00000000a0000000
>=20
> With ZONE_DMA=3Dy, it will say,
>=20
> cma: Failed to reserve 512 MiB
>=20
> The machine is a ThunderX2 server.
>=20
>=20
https://buy.hpe.com/us/en/servers/apollo-systems/apollo-70-system/apollo-70=
-system/hpe-apollo-70-system/p/1010742472
>=20
> # lscpu
> Architecture:        aarch64
> Byte Order:          Little Endian
> CPU(s):              256
> On-line CPU(s) list: 0-255
> Thread(s) per core:  4
> Core(s) per socket:  32
> Socket(s):           2
> NUMA node(s):        2
> Vendor ID:           Cavium
> Model:               1
> Model name:          ThunderX2 99xx
> Stepping:            0x1
> BogoMIPS:            400.00
> L1d cache:           32K
> L1i cache:           32K
> L2 cache:            256K
> L3 cache:            32768K
> NUMA node0 CPU(s):   0-127
> NUMA node1 CPU(s):   128-255
> Flags:               fp asimd aes pmull sha1 sha2 crc32 atomics cpuid asi=
mdrdm

Hi Qian,
I happen to have access to a very similar machine:

thunderx25:~ # lscpu=20
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              224
On-line CPU(s) list: 0-223
Thread(s) per core:  4
Core(s) per socket:  28
Socket(s):           2
NUMA node(s):        2
Vendor ID:           Cavium
Model:               1
Model name:          ThunderX2 99xx
Stepping:            0x1
CPU max MHz:         2500.0000
CPU min MHz:         1000.0000
BogoMIPS:            400.00
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            32768K
NUMA node0 CPU(s):   0-111
NUMA node1 CPU(s):   112-223
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics cpu=
id
asimdrdm

I tested a kernel with your configuration plus CONFIG_ZONE_DMA=3Dy yet I'm =
unable
to reproduce the error. The CMA allocation is successful.

[    0.000000][    T0] Booting Linux on physical CPU 0x0000000000 [0x431f0a=
f1]
[    0.000000][    T0] Linux version 5.4.0-rc4-next-20191021 (nico@linux-9q=
gx) (gcc version 9.2.1 20190903 [gcc-9-branch revision 275330] (SUSE Linux)=
) #60 SMP Mon Oct 21 18:48:51 CEST 2019
[    0.000000][    T0] printk: debug: ignoring loglevel setting.
[    0.000000][    T0] efi: Getting EFI parameters from FDT:
[    0.000000][    T0] efi: EFI v2.70 by American Megatrends
[    0.000000][    T0] efi:  ESRT=3D0xf10b4198  SMBIOS=3D0xfcc90000  SMBIOS=
 3.0=3D0xfcc80000  ACPI 2.0=3D0xf9670000  MEMRESERVE=3D0xf1117018
[    0.000000][    T0] esrt: Reserving ESRT space from 0x00000000f10b4198 t=
o 0x00000000f10b41d0.
[    0.000000][    T0] cma: Reserved 512 MiB at 0x00000000a0000000
[    0.000000][    T0] ACPI: Early table checksum verification disabled
[    0.000000][    T0] ACPI: RSDP 0x00000000F9670000 000024 (v02 HPE   )
[    0.000000][    T0] ACPI: XSDT 0x00000000F9670028 0000DC (v01 HPE    Ser=
verCL 01072009 AMI  00010013)
[    0.000000][    T0] ACPI: FACP 0x00000000F9670108 000114 (v06 HPE    Ser=
verCL 01072009 AMI  00010013)
[    0.000000][    T0] ACPI: DSDT 0x00000000F9670220 000714 (v02 HPE    Ser=
verCL 20150406 INTL 20170831)
[    0.000000][    T0] ACPI: FIDT 0x00000000F9670938 00009C (v01 HPE    Ser=
verCL 01072009 AMI  00010013)
[    0.000000][    T0] ACPI: DBG2 0x00000000F96709D8 000062 (v00 HPE    Ser=
verCL 00000000 INTL 20170831)
[    0.000000][    T0] ACPI: SPMI 0x00000000F9670A40 000041 (v05 HPE    Ser=
verCL 00000000 AMI. 00000000)
[    0.000000][    T0] ACPI: PCCT 0x00000000F9670A88 000FB0 (v01 HPE    Ser=
verCL 00000001 INTL 20170831)
[    0.000000][    T0] ACPI: SLIT 0x00000000F9671A38 000030 (v01 HPE    Ser=
verCL 00000001 INTL 20170831)
[    0.000000][    T0] ACPI: SPMI 0x00000000F9671A68 000041 (v04 HPE    Ser=
verCL 00000001 INTL 20170831)
[    0.000000][    T0] ACPI: SSDT 0x00000000F9671AB0 004217 (v02 HPE    N0B=
XPCI  20150406 INTL 20170831)
[    0.000000][    T0] ACPI: SSDT 0x00000000F9675CC8 019654 (v02 HPE    Ser=
verCL 20150406 INTL 20170831)
[    0.000000][    T0] ACPI: SSDT 0x00000000F968F320 0041CB (v02 HPE    N1B=
XPCI  20150406 INTL 20170831)
[    0.000000][    T0] ACPI: SSDT 0x00000000F96934F0 01980C (v02 HPE    Ser=
verCL 20150406 INTL 20170831)
[    0.000000][    T0] ACPI: BERT 0x00000000F96ACD00 000030 (v01 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: GTDT 0x00000000F96ACD30 00007C (v02 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: HEST 0x00000000F96ACDB0 000308 (v01 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: APIC 0x00000000F96AD0B8 00468C (v04 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: MCFG 0x00000000F96B1748 00003C (v01 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: NFIT 0x00000000F96B1788 000028 (v01 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: PPTT 0x00000000F96B17B0 0018B4 (v01 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: SRAT 0x00000000F96B3068 0010A8 (v03 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: IORT 0x00000000F96B4110 000688 (v00 HPE    Ser=
verCL 20150406 CAVM 00000099)
[    0.000000][    T0] ACPI: BGRT 0x00000000F96B4798 000038 (v01 HPE    Ser=
verCL 01072009 AMI  00010013)
[    0.000000][    T0] ACPI: SPCR 0x00000000F96B47D0 000050 (v02 HPE    Ser=
verCL 01072009 AMI. 0005000D)
[    0.000000][    T0] ACPI: WSMT 0x00000000F96B4820 000028 (v01 HPE    Ser=
verCL 01072009 AMI  00010013)
[    0.000000][    T0] ACPI: SPCR: Unexpected SPCR Access Width.  Defaultin=
g to byte size
[    0.000000][    T0] ACPI: SPCR: console: pl011,mmio,0x402020000,115200
[    0.000000][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0xfeffffff]
[    0.000000][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x880000000-0xffffffff=
f]
[    0.000000][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x8800000000-0x89fcfff=
fff]
[    0.000000][    T0] ACPI: SRAT: Node 1 PXM 1 [mem 0x89fd000000-0x93fcfff=
fff]
[    0.000000][    T0] NUMA: NODE_DATA [mem 0x89fcff5bc0-0x89fcffffff]
[    0.000000][    T0] NUMA: NODE_DATA [mem 0x93fc5b5bc0-0x93fc5bffff]
[    0.000000][    T0] Zone ranges:
[    0.000000][    T0]   DMA      [mem 0x00000000802f0000-0x00000000bffffff=
f]
[    0.000000][    T0]   DMA32    [mem 0x00000000c0000000-0x00000000fffffff=
f]
[    0.000000][    T0]   Normal   [mem 0x0000000100000000-0x00000093fcfffff=
f]
[    0.000000][    T0] Movable zone start for each node
[    0.000000][    T0] Early memory node ranges
[    0.000000][    T0]   node   0: [mem 0x00000000802f0000-0x000000008030ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x0000000080310000-0x00000000bfffff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000c0000000-0x00000000c0cbff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000c0cc0000-0x00000000f104ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000f1050000-0x00000000f10aff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000f10b0000-0x00000000f96fff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000f9700000-0x00000000f98aff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000f98b0000-0x00000000fa92ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fa930000-0x00000000faa6ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000faa70000-0x00000000fabbff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fabc0000-0x00000000fabdff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fabe0000-0x00000000fadeff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fadf0000-0x00000000fae4ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fae50000-0x00000000fc8cff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fc8d0000-0x00000000fc8dff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fc8e0000-0x00000000fca9ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fcaa0000-0x00000000fcaaff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fcab0000-0x00000000fcb3ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fcb40000-0x00000000fd1eff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fd1f0000-0x00000000feceff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fecf0000-0x00000000fed1ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fed20000-0x00000000fed2ff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fed30000-0x00000000feddff=
ff]
[    0.000000][    T0]   node   0: [mem 0x00000000fede0000-0x00000000feffff=
ff]
[    0.000000][    T0]   node   0: [mem 0x0000000880000000-0x0000000fffffff=
ff]
[    0.000000][    T0]   node   0: [mem 0x0000008800000000-0x00000089fcffff=
ff]
[    0.000000][    T0]   node   1: [mem 0x00000089fd000000-0x00000093fcffff=
ff]
[    0.000000][    T0] Zeroed struct page in unavailable ranges: 440 pages
[    0.000000][    T0] Initmem setup node 0 [mem 0x00000000802f0000-0x00000=
089fcffffff]
[    0.000000][    T0] On node 0 totalpages: 654289
[    0.000000][    T0]   DMA zone: 16 pages used for memmap
[    0.000000][    T0]   DMA zone: 0 pages reserved
[    0.000000][    T0]   DMA zone: 16337 pages, LIFO batch:3
[    0.000000][    T0]   DMA32 zone: 16 pages used for memmap
[    0.000000][    T0]   DMA32 zone: 16128 pages, LIFO batch:3
[    0.000000][    T0]   Normal zone: 608 pages used for memmap
[    0.000000][    T0]   Normal zone: 621824 pages, LIFO batch:3
[    0.000000][    T0] Initmem setup node 1 [mem 0x00000089fd000000-0x00000=
093fcffffff]
[    0.000000][    T0] On node 1 totalpages: 655360
[    0.000000][    T0]   Normal zone: 640 pages used for memmap
[    0.000000][    T0]   Normal zone: 655360 pages, LIFO batch:3

Could you enable CMA debugging to see if anything interesting comes out of =
it.

Regards,
Nicolas


--=-mC8X3toxjV4m8PaRcUwZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2t5G4ACgkQlfZmHno8
x/5W4wgAnmPIWY3UxNn0LW0SmooThLriDp3dM6IySfkKLGVBdLsmMWFmT+Q/AFb+
fJdm5pQrnzyt93bXNGFNdTrq5Ija+3eKp1cVxFkCHKlTDcV11AykTypNgyzd95f5
EI6rFEo9Ssg63+FxLgUn5f26IyhfYrSEm+VqxRVdPMCdIMW4TRZ66uNu2mMdrBP3
Pyz5zS1V5gqp0iytLBvLhbQkyNIoWlk/B/IvWUtJazu7MYoU9LJ1m/6wEyawhLCZ
RjGRbE4VzMPr3DV2P3b0/dGF+O0fQjIEnu5NLfS7/aJzQcvEQwkM93fG9i2w4OgC
z8qwO+hpvUz/VyeJaHxWTgh8frhDYg==
=HEMp
-----END PGP SIGNATURE-----

--=-mC8X3toxjV4m8PaRcUwZ--

