Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73522C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3704927DCA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bvI9XwuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfFCIu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:50:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29804 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfFCIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559551827; x=1591087827;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MIAH61ZDoSTIi8UI2nEz3ddvY2H2UI9t9luM6KSxPSM=;
  b=bvI9XwuWtJ8mGVBhNjtdMlLgv1q78WRWn/tDESnNFLaMQEzgf/JFE81G
   r9tyY2tGN7Zdf8zMhtICZVgA4uIVFDHbHKOhp0QzTDlo7QfnT/O4KhUAC
   Nx76IHw0+NbjzA+glcY1TFIHhuvBkFd4m/r078eLGJHLWc0UzFimTTBfh
   LJSyfhvun2/ThVrwrWRj+vbB07TfWIcndg284xV5MGS4Zm91Netd13ZQf
   kD2Oym7wa4uKkLL5s9vgCtirqfuyEm+pGTBHKmGsjcSvDgbV2GtQiViy2
   YC1EhyUmqB7JIoPmE1DVN1u/mQXoDQFrBp76RIGizMfBT+l4+YACFd0OQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,546,1549900800"; 
   d="scan'208";a="111325541"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2019 16:50:27 +0800
IronPort-SDR: RHUdCOpaCuK+GnHCXgTSr+fTX96tq1gDqW858vt+6S/6Vg4Obk17Ehme7tAduqoFHW+LFZsxKm
 LVCpcXxVW5loEcWHvNSL4cLsFs0VLwOajBZHxHcFwZ7xgIA2NHfYEwzNFju669GkY/f0o8FLdi
 JKpkSyW2j9MH22jq47Chuoo1CnX6R/6Lisqkk44Q9/ngIquZOFY5xwQVyXdG4SkkK2nc+dHK+v
 Gj5m5INYVOEIMB9r/3235DfaMISM7WOs41j5NVuApmRcDUZ12p2jeUTwu0xSOpY5Q+snJuYuqy
 w9mItNJdLH5Rp0a5pZ8CHKJy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 03 Jun 2019 01:27:50 -0700
IronPort-SDR: BFoXFGYP9juvqbXuMHbRgJh6jvpVhIbp0yQpP2IxiYAHVF0SyJtFKGxa+lYptSpbrh8ATdj/2F
 Uu3ojGhtuBMTdltS2t/r7PY7QW0py++iuHKLIhIzOeyED/NrJJByCIU8tpsacS6wyksSX5u1Nk
 UcjV6Voz5PGI1p8paSbgIZxpp5QgWd8PZU6LjGi43+EQlRDSbV3Kx5/qHa6uajicArdYbArPRi
 v4k7q/8pXcgz6iJXQmenVN0WYlE/ViGNZ3ns1s8Ag8xhwY1EnjEfCUUAFakjmQg99MqTlkE+JW
 UxI=
Received: from unknown (HELO [10.225.104.42]) ([10.225.104.42])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Jun 2019 01:50:26 -0700
Subject: Re: [PATCH v6 0/7] Unify CPU topology across ARM & RISC-V
To:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <1b61e699-79c7-bbfd-c7ed-d51d321ae7ef@arm.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <ed23bed6-91bf-f132-1b8f-03b02c6dd28a@wdc.com>
Date:   Mon, 3 Jun 2019 01:50:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1b61e699-79c7-bbfd-c7ed-d51d321ae7ef@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 2:12 PM, Jeremy Linton wrote:
> Hi,
> 
> On 5/29/19 4:13 PM, Atish Patra wrote:
>> The cpu-map DT entry in ARM can describe the CPU topology in much better
>> way compared to other existing approaches. RISC-V can easily adopt this
>> binding to represent its own CPU topology. Thus, both cpu-map DT
>> binding and topology parsing code can be moved to a common location so
>> that RISC-V or any other architecture can leverage that.
>>
>> The relevant discussion regarding unifying cpu topology can be found in
>> [1].
>>
>> arch_topology seems to be a perfect place to move the common code. I
>> have not introduced any significant functional changes in the moved code.
>> The only downside in this approach is that the capacity code will be
>> executed for RISC-V as well. But, it will exit immediately after not
>> able to find the appropriate DT node. If the overhead is considered too
>> much, we can always compile out capacity related functions under a
>> different config for the architectures that do not support them.
>>
>> There was an opportunity to unify topology data structure for ARM32 done
>> by patch 3/4. But, I refrained from making any other changes as I am not
>> very well versed with original intention for some functions that
>> are present in arch_topology.c. I hope this patch series can be served
>> as a baseline for such changes in the future.
>>
>> The patches have been tested for RISC-V and compile tested for ARM64,
>> ARM32 & x86.
>>
> 
> I applied these to 5.2rc2, along with my PPTT/MT change and verified the
> system & scheduler topology/etc on DAWN and ThunderX2 using ACPI on
> arm64. They appear to be working correctly.
> 
> so for the series,
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> The code itself looks fine to me as well:
> 
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> 
Thank you the review and testing on arm64 server.

> Thanks!
> 
>> The socket change[2] is also now part of this series.
>>
>> [1] https://lkml.org/lkml/2018/11/6/19
>> [2] https://lkml.org/lkml/2018/11/7/918
>>
>> QEMU changes for RISC-V topology are available at
>>
>> https://github.com/atishp04/qemu/tree/riscv_topology_dt
>>
>> HiFive Unleashed DT with topology node is available here.
>> https://github.com/atishp04/opensbi/tree/HiFive_unleashed_topology
>>
>> It can be verified with OpenSBI with following additional compile time
>> option.
>>
>> FW_PAYLOAD_FDT="unleashed_topology.dtb"
>>
>> Changes from v5->v6
>> 1. Added two more patches from Sudeep about maintainership of arch_topology.c
>>      and Kconfig update.
>> 2. Added Tested-by & Reviewed-by
>> 3. Fixed a nit (reordering of variables)
>>
>> Changes from v4-v5
>> 1. Removed the arch_topology.h header inclusion from topology.c and arch_topology.c
>> file. Added it in linux/topology.h.
>> 2. core_id is set to -1 upon reset. Otherwise, ARM topology store function does not
>> work.
>>
>> Changes from v3->v4
>> 1. Get rid of ARM32 specific information in topology structure.
>> 2. Remove redundant functions from ARM32 and use common code instead.
>>
>> Changes from v2->v3
>> 1. Cover letter update with experiment DT for topology changes.
>> 2. Added the patch for [2].
>>
>> Changes from v1->v2
>> 1. ARM32 can now use the common code as well.
>>
>> Atish Patra (4):
>> dt-binding: cpu-topology: Move cpu-map to a common binding.
>> cpu-topology: Move cpu topology code to common code.
>> arm: Use common cpu_topology structure and functions.
>> RISC-V: Parse cpu topology during boot.
>>
>> Sudeep Holla (3):
>> Documentation: DT: arm: add support for sockets defining package
>> boundaries
>> base: arch_topology: update Kconfig help description
>> MAINTAINERS: Add an entry for generic architecture topology
>>
>> .../topology.txt => cpu/cpu-topology.txt}     | 134 ++++++--
>> MAINTAINERS                                   |   7 +
>> arch/arm/include/asm/topology.h               |  20 --
>> arch/arm/kernel/topology.c                    |  60 +---
>> arch/arm64/include/asm/topology.h             |  23 --
>> arch/arm64/kernel/topology.c                  | 303 +-----------------
>> arch/riscv/Kconfig                            |   1 +
>> arch/riscv/kernel/smpboot.c                   |   3 +
>> drivers/base/Kconfig                          |   2 +-
>> drivers/base/arch_topology.c                  | 298 +++++++++++++++++
>> include/linux/arch_topology.h                 |  26 ++
>> include/linux/topology.h                      |   1 +
>> 12 files changed, 452 insertions(+), 426 deletions(-)
>> rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)
>>
>> --
>> 2.21.0
>>
> 
> 


-- 
Regards,
Atish
