Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314A0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059612053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rF/+F8FJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfJUOq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:46:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45842 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJUOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:46:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id q70so5301949qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t36LwNdZN6YmQfewYw028jUsDs9yG7E3JUEc6c5qcLM=;
        b=rF/+F8FJNmGj2yIXmpDOAcgOjsdbv5OZqjWBwZnlW6meNrSXMxR8nZD0drC1BzzMWM
         JdIfIhKxnhv+3qvTDIfz3RC9YkjWOizIS7b05cvmqlPuU8DP0xdu0phTeVlGDQqFgA7n
         j1t+rvaKgdnDcRU9S++OLxxV5zPmH0WxIQfLaq8OZkl6mu4kXcof1ZZ6HNEMCqTIUlV1
         3h+5g78VXCX9YMeeFSyQEmh/UJWDO2VGSYvrnF+ilcrdR6gwDysmW6Jb+YS9UH0M8taS
         fnA2sCK7zBPDD+64TO6FxaVRhqr1GAFF+sNRogq/GQjwv+zbHCVsbvRENuI0Mday/UF7
         xsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t36LwNdZN6YmQfewYw028jUsDs9yG7E3JUEc6c5qcLM=;
        b=JeBFeOt2iBqF6kK0tD95vxhgMFtB5bDgszrCVgVKpoLdH0HZXEj47H2kJSqapLnHU3
         KZSs7WQZ395RKJ9E7oM3mVUNQRfyEZRw2wz4l/DNA/0zhXDsBE23TDLl/7gU5j9posv8
         02O1D9sywy8oR1I63kQinZaVCpw08KPVgud9wAHrMqtuynRblAzT6mkzN0htjglzbyIp
         gOpC/IRqmmUyatLCNLwMzNoTFTDpKudL9kdl5N3X2/yv5xfTRzDoJlnH5BjZRUj9q4la
         zr0NTBOkGfRUZvQKXGr0Rx5T0UEI1kuDTS0oyqrf0bbefl0hU76IYNfpJFzcQuGmShEJ
         tbPw==
X-Gm-Message-State: APjAAAWzX0hONqDUms+P82PVmKN8TB/M6cJXTM+EoAio4IN1YaeQloXB
        C+udPlha6w1ibzXMjkc7BdZNYQ==
X-Google-Smtp-Source: APXvYqwv1QcGfOdDZKfsY6ciLBE7cNoGFYfOnQoXtkYiy8iDXUAVeMJwlCprhZv4OyLBQ6WNfDuuQA==
X-Received: by 2002:ae9:f50a:: with SMTP id o10mr22637446qkg.372.1571669185837;
        Mon, 21 Oct 2019 07:46:25 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c21sm4956270qkg.4.2019.10.21.07.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 07:46:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <78caa5bcfc0d59e8ec5d6b7060df76896d25248b.camel@suse.de>
Date:   Mon, 21 Oct 2019 10:46:23 -0400
Cc:     f.fainelli@gmail.com, mbrugger@suse.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rob Herring <robh+dt@kernel.org>, wahrenst@gmx.net,
        m.szyprowski@samsung.com, phill@raspberrypi.org, will@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E3CD9CA-76C3-4D46-BA0B-DEBF650E8950@lca.pw>
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
 <20190911182546.17094-4-nsaenzjulienne@suse.de>
 <3956E54B-6C7A-4C47-B9B6-75F556EFD3F5@lca.pw>
 <78caa5bcfc0d59e8ec5d6b7060df76896d25248b.camel@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 21, 2019, at 10:34 AM, Nicolas Saenz Julienne =
<nsaenzjulienne@suse.de> wrote:
>=20
> On Mon, 2019-10-21 at 10:15 -0400, Qian Cai wrote:
>>> On Sep 11, 2019, at 2:25 PM, Nicolas Saenz Julienne =
<nsaenzjulienne@suse.de>
>>> wrote:
>>>=20
>>> So far all arm64 devices have supported 32 bit DMA masks for their
>>> peripherals. This is not true anymore for the Raspberry Pi 4 as most =
of
>>> it's peripherals can only address the first GB of memory on a total =
of
>>> up to 4 GB.
>>>=20
>>> This goes against ZONE_DMA32's intent, as it's expected for =
ZONE_DMA32
>>> to be addressable with a 32 bit mask. So it was decided to =
re-introduce
>>> ZONE_DMA in arm64.
>>>=20
>>> ZONE_DMA will contain the lower 1G of memory, which is currently the
>>> memory area addressable by any peripheral on an arm64 device.
>>> ZONE_DMA32 will contain the rest of the 32 bit addressable memory.
>>>=20
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>>=20
>>> ---
>>=20
>> With ZONE_DMA=3Dy, this config will fail to reserve 512M CMA on a =
server,
>>=20
>> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
>>=20
>> CONFIG_DMA_CMA=3Dy
>> CONFIG_CMA_SIZE_MBYTES=3D64
>> CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
>> CONFIG_CMA_ALIGNMENT=3D8
>> CONFIG_CMA=3Dy
>> CONFIG_CMA_DEBUGFS=3Dy
>> CONFIG_CMA_AREAS=3D7
>>=20
>> Is this expected?
>=20
> Not really, just tested cma=3D512M on a Raspberry Pi4, and it went =
well. The only
> thing on my build that differs from your config is CONFIG_CMA_DEBUGFS.
>=20
> Could you post more information on the device you're experiencing this =
on? Also
> some logs.

With the above config, it does not even need "cma=3D512M" kernel =
cmdline.

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x431f0af1]
[    0.000000] Linux version 5.4.0-rc4-next-20191021+ (clang version =
8.0.1 (Red Hat 8.0.1-1.module+el8.1.0+3866+6be7f4d8)) #1 SMP Mon Oct 21 =
10:03:03 EDT 2019
[    0.000000] Setting debug_guardpage_minorder to 1
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi:  ESRT=3D0xf935ed98  SMBIOS=3D0xfcc90000  SMBIOS =
3.0=3D0xfcc80000  ACPI 2.0=3D0xfac80000  MEMRESERVE=3D0xfacd1018=20
[    0.000000] esrt: Reserving ESRT space from 0x00000000f935ed98 to =
0x00000000f935edd0.
[    0.000000] crashkernel reserved: 0x00000097db400000 - =
0x00000097fb400000 (512 MB)
[    0.000000] cma: Reserved 512 MiB at 0x00000000a0000000

With ZONE_DMA=3Dy, it will say,

cma: Failed to reserve 512 MiB

The machine is a ThunderX2 server.

=
https://buy.hpe.com/us/en/servers/apollo-systems/apollo-70-system/apollo-7=
0-system/hpe-apollo-70-system/p/1010742472

# lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              256
On-line CPU(s) list: 0-255
Thread(s) per core:  4
Core(s) per socket:  32
Socket(s):           2
NUMA node(s):        2
Vendor ID:           Cavium
Model:               1
Model name:          ThunderX2 99xx
Stepping:            0x1
BogoMIPS:            400.00
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            32768K
NUMA node0 CPU(s):   0-127
NUMA node1 CPU(s):   128-255
Flags:               fp asimd aes pmull sha1 sha2 crc32 atomics cpuid =
asimdrdm=
