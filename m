Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3C9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F262075B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 15:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0xKjWPsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLYPAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 10:00:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46397 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLYPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 10:00:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so11685004pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GVdWyY874o7JVf2aJuqzy5XJxCy8y/H8THsWhze5AZI=;
        b=0xKjWPsJZvdjAjzB5i6fBM2oe4+zgpx0CH4iYQTWi914ftdOkLIuL3KFFJMxGB3bQX
         WIWxRFKFzcgU0hpwy8eSljwikvQSJ0csjJI3wzzdfQUYbff3f8gSDm8oBV2z+f9H6ySC
         KtA1I/06AhpfUon12lEj1vHTBiC5646PCUKBLfDtOeZ4MXVk63tt0BEgjsEJDF9f49ad
         oYoiEOXOoy+bBlblWIAsx8Wk9PzAhjwTDvbdriAyFkJ1hrvLy8sS/Y6FGTCLBQph96xS
         tKGW+/eZffv3m9IQpTOIB9QtCI6VzF6er9K5jJuEOP2fc41UhZOWIf36bQ7DbiOvxKP7
         RGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GVdWyY874o7JVf2aJuqzy5XJxCy8y/H8THsWhze5AZI=;
        b=Y6vTdRpdd2KliWipVhwc34Kh72cJY0qu0iI9xsAirlBIhz/HY6+PJ9yGw9dCEwHljK
         j8z6ewx5TWhjlvx2BbnffOxzeN1j61JnXr9IIvm5xZS2vmfSmZ56C24mKW0F8NFgw3NF
         lF/x+6WXplbAhKE0XXicmiCZ28D42wfiLsdFcvtEO9izLlO/DrsF/a0VsIai42T9RQbm
         KbW+PcDt3YEozArEBfh1NVCU/Zb62TH7Js9PMrzv2PUnBPWtSGo2wudQm5b1qKO9rkCE
         3s5cg5Kom+n2nfbZIUBmLKzGTtEqJ96O9JdM01T80I4YbKGza0ynC4EP/kd1geYfkvy2
         A9BQ==
X-Gm-Message-State: APjAAAWLFcQ2lV4mRPWikmjrELCDHozzWy37ZzKnVyyht0jrYWveCEyQ
        TRtuFi2mM9peytoSjnJo238p19tFIzdmPg==
X-Google-Smtp-Source: APXvYqwTHzs2OBLbBVVWSi64E4HAe4bnBI0dud1RmHItIENkC4YmDBJ7S0mogeRb0l2KspiLTqJh1w==
X-Received: by 2002:aa7:92c2:: with SMTP id k2mr20370846pfa.93.1577286006780;
        Wed, 25 Dec 2019 07:00:06 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o19sm7888509pjr.2.2019.12.25.07.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 07:00:06 -0800 (PST)
Subject: Re: Broken sata_nv since 4.19
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191224173529.zudlfsjvdqrbayqx@pali>
 <20191225110531.devfxvumnxwgtsif@pali> <20191225140158.eeh2immcbi3ou633@pali>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <956ff5fc-4d2e-415b-80da-5efe1448c7a8@kernel.dk>
Date:   Wed, 25 Dec 2019 08:00:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191225140158.eeh2immcbi3ou633@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/19 7:01 AM, Pali Rohár wrote:
> Hi Jens, can you please try to look at this problem?
> 
> On Wednesday 25 December 2019 12:05:31 Pali Rohár wrote:
>> On Tuesday 24 December 2019 18:35:29 Pali Rohár wrote:
>>> Hello!
>>>
>>> I upgraded machine with NVIDIA SATA controller (nforce4 chipse) from
>>> Debian Stretch to Debian Buster and SATA disks started to have problems.
>>> I booted back to Debian Stretch kernel version (having userspace
>>> untouched in Buster) and everything was like before, so problem is 100%
>>> kernel related. Problematic is APM support (it does not work at all),
>>> HPA support (kernel show warnings at boot time) and whole booting is
>>> delayed by 10 seconds. Also broken is disk speed test.
>>>
>>> SATA controller is using sata_nv.ko kernel driver and in lspci is
>>> identified as:
>>>
>>>   00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Controller [10de:0054] (rev f3)
>>>   00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Controller [10de:0055] (rev f3)
>>>
>>> Debian Stretch has kernel version (which is working fine):
>>>
>>>   4.9.0-11-amd64 #1 SMP Debian 4.9.189-3+deb9u2 (2019-11-11) x86_64
>>>
>>> Debian Buster has kernel version (which is problematic):
>>>
>>>   4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) x86_64
>>>
>>> So kernel regression happened somewhere between 4.9 and 4.19 versions.
>>>
>>> APM on Stretch:
>>>
>>>   $ sudo hdparm -B /dev/sda
>>>
>>>   /dev/sda:
>>>    APM_level      = not supported
>>>
>>>   $ sudo hdparm -B /dev/sdb
>>>
>>>   /dev/sdb:
>>>    APM_level      = off
>>>
>>> APM on Buster:
>>>
>>>   $ sudo hdparm -B /dev/sda
>>>
>>>   /dev/sda:
>>>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>    APM_level      = not supported
>>>
>>>
>>>   $ sudo hdparm -B /dev/sdb
>>>
>>>   /dev/sdb:
>>>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>    APM_level      = not supported
>>>
>>> /dev/sda does not support APM, but /dev/sdb supports. I do not
>>> understand what above SG_IO error means, but because it works fine on
>>> older kernel version, it is not hardware problem.
>>>
>>> Disk speed test on Stretch:
>>>
>>>   $ sudo hdparm -Tt /dev/sda
>>>
>>>   /dev/sda:
>>>    Timing cached reads:   118 MB in  2.00 seconds =  58.91 MB/sec
>>>    Timing buffered disk reads: 116 MB in  3.09 seconds =  37.54 MB/sec
>>>
>>>   $ sudo hdparm -Tt /dev/sdb
>>>
>>>   /dev/sdb:
>>>    Timing cached reads:   1242 MB in  2.00 seconds = 620.93 MB/sec
>>>    Timing buffered disk reads: 388 MB in  3.00 seconds = 129.31 MB/sec
>>>
>>> Disk speed test on Buster:
>>>
>>>   $ sudo hdparm -Tt /dev/sda
>>>
>>>   /dev/sda:
>>>   read() hit EOF - device too small
>>>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>    Timing buffered disk reads: read() hit EOF - device too small
>>>
>>>   $ sudo hdparm -Tt /dev/sdb
>>>
>>>   /dev/sdb:
>>>   read() hit EOF - device too small
>>>   SG_IO: bad/missing sense data, sb[]:  f0 00 05 00 00 00 00 0a 00 aa 55 40 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>    Timing buffered disk reads: read() hit EOF - device too small
>>>
>>> As can be seen disk speed test is completely broken on new kernel
>>> version and hdparm returns same error as for APM.
>>>
>>> dmesg output on Stretch:
>>>
>>> [    1.716970] sata_nv 0000:00:07.0: version 3.5
>>> [    1.717309] sata_nv 0000:00:07.0: Using ADMA mode
>>> [    1.717358] sata_nv 0000:00:07.0: Using MSI
>>> [    1.717810] scsi host0: sata_nv
>>> [    1.717954] scsi host1: sata_nv
>>> [    1.718016] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd000 irq 20
>>> [    1.718024] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd008 irq 20
>>> [    1.718308] sata_nv 0000:00:08.0: Using ADMA mode
>>> [    1.718345] sata_nv 0000:00:08.0: Using MSI
>>> [    1.718757] scsi host2: sata_nv
>>> [    1.718886] scsi host3: sata_nv
>>> [    2.192111] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [    2.194691] ata1.00: HPA detected: current 976771055, native 976773168
>>> [    2.194701] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max UDMA/133
>>> [    2.194709] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 31/32)
>>> [    2.199241] ata1.00: configured for UDMA/133
>>> [    2.199501] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
>>> [    2.708030] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [    2.710442] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
>>> [    2.710455] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
>>> [    2.715066] ata2.00: configured for UDMA/133
>>> [    2.715333] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
>>>
>>> dmesg output on Buster:
>>>
>>> [    2.079293] sata_nv 0000:00:07.0: version 3.5
>>> [    2.133503] sata_nv 0000:00:07.0: Using ADMA mode
>>> [    2.137138] sata_nv 0000:00:07.0: Using MSI
>>> [    2.142043] scsi host0: sata_nv
>>> [    2.174745] scsi host2: sata_nv
>>> [    2.178329] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd000 irq 20
>>> [    2.181675] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd008 irq 20
>>> [    2.188680] sata_nv 0000:00:08.0: Using ADMA mode
>>> [    2.215676] sata_nv 0000:00:08.0: Using MSI
>>> [    2.219649] scsi host4: sata_nv
>>> [    2.226626] scsi host5: sata_nv
>>> [    2.657732] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [    7.773692] ata1.00: qc timeout (cmd 0x27)
>>> [    7.773738] ata1.00: failed to read native max address (err_mask=0x4)
>>> [    7.773785] ata1.00: HPA support seems broken, skipping HPA handling
>>> [    8.245678] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [    8.248009] ata1.00: ATA-8: WDC WD5000AADS-00S9B0, 01.00A01, max UDMA/133
>>> [    8.248065] ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 32)
>>> [    8.252593] ata1.00: configured for UDMA/133
>>> [    8.252964] ata1: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
>>> [    8.725693] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [   13.917688] ata2.00: qc timeout (cmd 0x27)
>>> [   13.920096] ata2.00: failed to read native max address (err_mask=0x4)
>>> [   13.922491] ata2.00: HPA support seems broken, skipping HPA handling
>>> [   14.393683] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [   14.398360] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
>>> [   14.400813] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32)
>>> [   14.407722] ata2.00: configured for UDMA/133
>>> [   14.412939] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
>>>
>>> As can be seen new kernel has problems with handling of both SATA
>>> controllers and disks HPA area. Plus before kernel prints
>>> "qc timeout (cmd 0x27)" there is nothing on output, seems that kernel
>>> waits until 5s timeout occur and it slow down booting by 10s.
>>>
>>> Do you have any idea what is happening there? What those SG_IO errors
>>> or dmesg errors means?
>>>
>>> I'm CCing all people who touched sata_nv.c file between 4.9 and 4.19
>>> versions, so maybe somebody would know anything about this problem.
>>>
>>> If you need more information or other outputs, please let me know and I
>>> can provide it.
>>
>> Now I tested also versions 4.11, 4.12, 4.13, 4.14, 4.15, 4.16, 4.17 and
>> 4.18. And problem appeared only in 4.18 (all previous versions work
>> fine) In 4.18 dmesg is:
>>
>> [    8.596039] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    8.598489] ata2: illegal qc_active transition (100000000->100000001)
>> [   13.792086] ata2.00: qc timeout (cmd 0x27)
>> [   13.792122] ata2.00: failed to read native max address (err_mask=0x4)
>> [   13.792167] ata2.00: HPA support seems broken, skipping HPA handling
>> [   14.264041] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [   14.268756] ata2.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
>> [   14.271230] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32)
>> [   14.278161] ata2.00: configured for UDMA/133
>> [   14.283427] ata2: DMA mask 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
>>
>> (There is another line "illegal qc_active transition" which is not
>> present in 4.19)
>>
>> So this problem must have been introduced during 4.18 release cycle as
>> 4.17 version is working fine.
> 
> I tried to git bisect this problem between 4.17 and 4.18. I used
> following command to filter relevant libata.ko and sata_nv.ko modules:
> 
>   $ git bisect start v4.18 v4.17 -- drivers/ata/libata* drivers/ata/sata_nv.c
> 
> And here are results:
> 
> sata_nv.ko and libata.ko compiled from commit 804689 (libata: Fix
> command retry decision) for 4.17 kernel are working fine.
> 
> sata_nv.ko and libata.ko compiled from commit e3ed89 (libata: bump
> ->qc_active to a 64-bit type) for 4.18 kernel are broken.
> 
> So problem seems to be somehow related with introduction of hardware
> tags done by Jens Axboe.

Can you try with this patch:

https://lore.kernel.org/linux-ide/20191213080408.27032-1-s.hauer@pengutronix.de/T/#u

-- 
Jens Axboe

