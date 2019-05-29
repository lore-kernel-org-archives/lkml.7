Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C1AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C667523ECB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="avBaIdcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE2RJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:09:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52274 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2RJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559149764; x=1590685764;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=D34VPipzn/oapeL312CeeZidhriO/NJFGPDENgL1lqc=;
  b=avBaIdcqCF5nm0UNo+KOES0uo0OQ0zwzLKSUJaDNh6jZK7vyUD8LyYap
   I9eQ+6ch0vElvvX8VTgHpTCpzC7AZsbMOGw6FZhd/ro0DOV8owMapNura
   F1IpHFGcrtd9wQ2AA5zZOP4Mo58gmZC8TqFkr6bacDClIt7brCgGhgtSG
   9BX+hYWBiPITuQ4kavLs3zbGrBRwtuRg86v9s9KkZ0N4DUxuenoYTEB/Y
   huxzNJWSK7jANCgQPy0G4FusJxNNKskep/PNKPrZzJupQyjl0rgSkmJk6
   0oeNv8xJmlclNupyf2Ti2Z4M2WonYjS0U/pz2uEnDedpef555HKAFtiFI
   A==;
X-IronPort-AV: E=Sophos;i="5.60,527,1549900800"; 
   d="scan'208";a="110585708"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2019 01:09:21 +0800
IronPort-SDR: 5Q7jNp2Mn5jvrrJHfClb8w7Y1BJefMoxgwQ8SK/hWIOPUNnEy46HqP8hLhr2WpvYhobaQzqDvG
 dWNp78veaqcWpBCWSeWzExSjeL36oAelJ/F3dKVqiQCJ+70tVVs37M9KAkEmBp029TgOjdQFTe
 lAnFCUHDoTijx4vDPKZlgc7EEa89IjOo7ugPf26GpGbI5MM6ih2Rm/hoHlTAQ52GHzA7LhpfEY
 /xEwfP7CxLAbp6BLsJIDM74Bn9giEg9VhlGwFGCBFfoWhbHkJUXB7NqlwO06+qau8sBQB5Cc6k
 sdUOs+azubmo3teaUba0mqgT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 May 2019 09:46:53 -0700
IronPort-SDR: 9bskIwRH3RoF5w+9WdRWx9p8kCic0KhSra1vXgXio7XEsq/AjQDxclsqrawZ1zOPqacy5jDH7m
 g8KUQ40eFChOIN0cTWeXAMthnhw47R7W3XR8+XcPuGsSypGhzPdpMHfKpH85/Cou0TZtyqnUh0
 NSYciRAdH3DXdRVEL93lm1T8HdV1fnOpq1+lCTAPrriwIwQoq/ClIdB6JUxUIYQ96UrKg0fuzC
 ViE/nNOKK7OV/vFyutAqGrTReXcsjg/FzdCY0ZcAfXpflJCss8QP51A1AhENSjUyq+8kFfTrmj
 7jE=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 May 2019 10:09:21 -0700
Subject: Re: Testing the recent RISC-V DT patchsets
To:     Loys Ollivier <lollivier@baylibre.com>,
        Karsten Merker <merker@debian.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com>
 <86o93mpqbx.fsf@baylibre.com>
 <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
 <081611ea-a0d3-b0c9-3e08-8946513f2174@wdc.com> <86woi94lvs.fsf@baylibre.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <42a6c3bd-484b-138b-b0f1-2d4b91c5b0bb@wdc.com>
Date:   Wed, 29 May 2019 10:09:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <86woi94lvs.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 3:04 AM, Loys Ollivier wrote:
> On Wed 29 May 2019 at 00:50, Atish Patra <atish.patra@wdc.com> wrote:
> 
>> On 5/28/19 8:36 AM, Karsten Merker wrote:
>>> On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
>>>> On Tue 28 May 2019 at 01:32, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>>>>
>>>>> An update for those testing RISC-V patches: here's a new branch of
>>>>> riscv-pk/bbl that doesn't try to read or modify the DT data at all, which
>>>>> should be useful until U-Boot settles down.
>>> [...]
>>>>> Here is an Linux kernel branch with updated DT data that can be booted
>>>>> with the above bootloader:
>>>>>
>>>>>      https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-experimental
>>>>>
>>>>> A sample boot log follows, using a 'defconfig' build from that branch.
>>>>
>>>> Thanks Paul, I can confirm that it works.
>>>>
>>>> Something is still unclear to myself.
>>>> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
>>>> Neither FSBL nor riscv-pk/bbl are modifying the DT.
>>>>
>>>> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs on
>>>> running /init.
>>>>
>>>> Would you have any pointer on what riscv-pk does that OpenSBI/U-boot doesn't ?
>>>> Or maybe it is the other way around - OpenSBI/U-boot does something that
>>>> extra that should not happen.
>>>
>>> Hello,
>>>
>>> I don't know which version of OpenSBI you are using, but there is
>>> a problem with the combination of kernel 5.2-rc1 and OpenSBI
>>> versions before commit
>>>
>>>     https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15b577d40c82649c
>>>
>>> that can result in a hang on executing init, so in case you
>>> should be using an older OpenSBI build that might be the source
>>> of the problem that you are experiencing.
>>>
>>> Regards,
>>> Karsten
>>>
>>
>> I verified the updated DT with upstream kernel for the boot flow OpenSBI
>> + U-Boot + Linux or OpenSBI + Linux.
>>
>> OpenSBI should be compiled for sifive platform with following additional
>> argument
>>
>> FW_PAYLOAD_FDT_PATH=<linux kernel
>> source>/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
>>
>> FYI: It will only work when kernel is given a payload to U-Boot/OpenSBI
>> directly.
>>
> 
> Hum, I am surprised by this statement.

That's because U-Boot also using the new DT. With FW_PAYLOAD_FDT_PATH, 
OpenSBI ignores the DT from FSBL and U-Boot gets the updated DT from 
OpenSBI.


> I was able to verify the latest DT patch serie from Paul with:
> OpenSBI + U-Boot + Linux & DT.
> 
> Following the OpenSBI documentation [0] with U-Boot payload:
> FW_PAYLOAD_PATH=<u-boot_build_dir>/u-boot.bin
> 
> I get an U-Boot prompt and then I can just load the linux kernel and
> device tree from the network.
> 

Cool. This approach will also work where DT is loaded separately after 
U-Boot is booted.

> [0]: https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_fu540.md#building-sifive-fu540-platform
> 
>> Network booting is still not working as the clock driver probe doesn't
>> happen because of the updated DT.
>>
>> -- 
>> Regards,
>> Atish
> 


-- 
Regards,
Atish
