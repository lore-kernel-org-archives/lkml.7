Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C183C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C0320830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fWcmmRay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDJWuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:50:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50298 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJWuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554936605; x=1586472605;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YfDM8y1jUvGmA5+FC2aYt2d1GKWwr2xeQQzppluCf58=;
  b=fWcmmRayIK1Tk11d6Qv8nNeneHE8LYnTdrKFc5Lz/3MvCnvd/zo18bGd
   3hN0pAdLS0sf2VL/u+4X4oVww6qVsN3J8tt72nngxjFsIgKK4f7Jk5Wqm
   yXKnlDIhC0zvA38/+sefu126+h9htwTLPunzNj95DpCOKUjzOH5H5pA39
   J1GxeDUtcPejrKjGFCzZdWwm5PjqLGFPBwTi9Oy6HiAjAFLtCN5awvaoY
   N4xgbmmYYSsciKMm1+huJPKT1Vd005JxQ74t2n6D3T5oioIdvzzC4hfES
   q9zR4/+NGHoMPRc4qGxf6v2dlFNSMZcihYH9JJOUBEp7xFWj9iwp2ZghF
   g==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="105470866"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 06:50:05 +0800
IronPort-SDR: aGe2I3E0EOI1pRtoYqCabQ+UXwJ0292IpplXLEZ6K7Y16kQn6L57AR8uHy2Xnk9niO1jaDtxjz
 qHLzORG2rEOkygPmX9aiM5p/2D16dzEIDlQDDMng93zEf8QjXkH49ibt4hHEuXmmFMZAouBVjD
 tOKJBlnuWojhpG5c+Mh8LH2ZNFjvdVc/vrtuR1A353MY4f/idwl+aesRWaE2DZ3E1C/QbLLXGa
 nSAVH4zEntCCy5L1rDVGbUUcLkZObj/GS0ow5JbqPVFIj01ahcXisyJhh6qqrZabwYmipOBsn+
 MQtr6XDf9qV4HXZ3DgsJNffA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:26:59 -0700
IronPort-SDR: 7mSdHEoCianBaHf7rrpda0MqEGGKw/fw+SdX6j1stqwolJRtrx8c8wTjw0Z5OJTcJHgohDh66O
 ar41LAeDakEZlMd4IVjYTkxaBst+HHQuW9vbEP0BiA5i7bAGty1K9+nnC+DFW9AS88o5q2RnDU
 YNje4lZ2k93vmmddcG2XXahNZxr7rFL4JMqHrXe5k7GCDWfwmu3STxRB8lIbXG/H2IbNSmem8M
 HOl5rlCNrpUM4gGGjf1oJrUlnrKKbi3C1Ijs8kkrhPCv4WzR/4PDP1NlR76quB+3upjlx9a7+5
 mLU=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Apr 2019 15:50:05 -0700
Subject: Re: [RFT/RFC PATCH v3 0/5] Unify CPU topology across ARM & RISC-V
From:   Atish Patra <atish.patra@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20190320234806.19748-1-atish.patra@wdc.com>
Message-ID: <12c9f8b0-cdeb-2b9c-5662-6c5a08cd0a95@wdc.com>
Date:   Wed, 10 Apr 2019 15:49:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190320234806.19748-1-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/19 4:48 PM, Atish Patra wrote:
> The cpu-map DT entry in ARM can describe the CPU topology in much better
> way compared to other existing approaches. RISC-V can easily adopt this
> binding to represent its own CPU topology. Thus, both cpu-map DT
> binding and topology parsing code can be moved to a common location so
> that RISC-V or any other architecture can leverage that.
> 
> The relevant discussion regarding unifying cpu topology can be found in
> [1].
> 
> arch_topology seems to be a perfect place to move the common code. I
> have not introduced any significant functional changes in the moved code.
> The only downside in this approach is that the capacity code will be
> executed for RISC-V as well. But, it will exit immediately after not
> able to find the appropriate DT node. If the overhead is considered too
> much, we can always compile out capacity related functions under a
> different config for the architectures that do not support them.
> 
> There was an opportunity to unify topology data structure for ARM32 done
> by patch 3/4. But, I refrained from making any other changes as I am not
> very well versed with original intention for some functions that
> are present in arch_topology.c. I hope this patch series can be served
> as a baseline for such changes in the future.
> 
> The patches have been tested for RISC-V and compile tested for ARM64,
> ARM32 & x86.
> 
> The socket change[2] is also now part of this series.
> 
> [1] https://lkml.org/lkml/2018/11/6/19
> [2] https://lkml.org/lkml/2018/11/7/918
> 
> QEMU changes for RISC-V topology are available at
> 
> https://github.com/atishp04/qemu/tree/riscv_topology_dt
> 
> HiFive Unleashed DT with topology node is available here.
> https://github.com/atishp04/opensbi/tree/HiFive_unleashed_topology
> 
> It can be verified with OpenSBI with following additional compile time
> option.
> 
> FW_PAYLOAD_FDT="unleashed_topology.dtb"
> 
> Changes from v2->v3
> 1. Cover letter update with experiment DT for topology changes.
> 2. Added the patch for [2].
> 
> Changes from v1->v2
> 1. ARM32 can now use the common code as well.
> 
> Atish Patra (4):
> dt-binding: cpu-topology: Move cpu-map to a common binding.
> cpu-topology: Move cpu topology code to common code.
> arm: Use common cpu_topology
> RISC-V: Parse cpu topology during boot.
> 
> Sudeep Holla (1):
> Documentation: DT: arm: add support for sockets defining package
> boundaries
> 
> .../topology.txt => cpu/cpu-topology.txt}     | 134 ++++++--
> arch/arm/include/asm/topology.h               |  22 +-
> arch/arm/kernel/topology.c                    |  10 +-
> arch/arm64/include/asm/topology.h             |  23 --
> arch/arm64/kernel/topology.c                  | 303 +-----------------
> arch/riscv/Kconfig                            |   1 +
> arch/riscv/kernel/smpboot.c                   |   3 +
> drivers/base/arch_topology.c                  | 298 ++++++++++++++++-
> drivers/base/topology.c                       |   1 +
> include/linux/arch_topology.h                 |  36 +++
> 10 files changed, 453 insertions(+), 378 deletions(-)
> rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)
> 
> --
> 2.21.0
> 
> 

Ping?

Specifically, patch 3 & 4 affects ARM & ARM64. Any tests on real 
hardware would be great.

Regards,
Atish
