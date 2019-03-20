Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F1FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ED42190A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h0N9QHeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfCTXsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:48:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11921 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553125694; x=1584661694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MXoKOqnmh4glr82XcmuusqJSAAOR3fVo1vwmgG/zsgo=;
  b=h0N9QHeNTaS8Hew+J7+u+VgdPKzTbBZCkcQGIASpoXeAuLFhyLRhOm8I
   GIwoKlQm45cq+cemKsNxc8csdlYDi0bSTAio9qK9w+0dWzXhZJJFTdChF
   PfPb24toittCM2rizHZpySTtXXupfyb4ja4heKD4ViWIcx2UGc2lJuMOM
   fUqMaAb3OhMOpEi/g8yKorzEsJwfO/DnxcdGny1auySWcpf85wSFcpkb8
   HXaRke+IK0RSUp1plrXarvJZbHM4tI2Iebr+ZwIFznMcZg/56RLH+X+XO
   yM3ng6oRa2u3/kE6I1uDL2AHSybdQ2FsjwrLLSnGd/nukTZMghZoBzHJD
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,250,1549900800"; 
   d="scan'208";a="103874310"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 07:48:14 +0800
IronPort-SDR: o3pvRh/zaDgSs6bHmil/KT5JaB+bVJy0PMkufzdEd2y3RLIP+GC2H5zV93gumEm+eUAGRIugH1
 1Zke1klBJ6v3wriJrvB3/DfZ58rvouPeX8XodhQuMOgtvpdpIx/bAEaepThobNnpRGpeX/Nm9r
 2RlI0Blz6SzyRsCaG5DO+rzXdFgQoZH3UqkbGupx/RsTKJ8QAxZIvf4MJI8JqniCAzKRJ/6qST
 SlJe7I2uFy3oNbAkFaSG7sv5yHIFb9+vSSzAdxTPfz2TNiYYb+ZZO5STxGViqG3ai9rz52XlG2
 Ll+8dGVomm0ttamDI0ZAIN6I
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Mar 2019 16:27:51 -0700
IronPort-SDR: IhuVAZBifJqI9IKuS0jMxBGdTiTGwyls+8KLoVoQxR+MZbq17NQMJCS0zCKmfv0FIyjO5ER+xU
 uKuBwqw/ciq7haWhaHEIk3iVr3tST6zhbS0LPkrpPy5EeDNgiqX3bVX278b8DCIcf+TvF8yB8P
 od3lJ8UVXt6YkRV6SQonasIb1Py4zUs+W0nWwynSyOsV5qt3dj3wBaQRQ4ULYfxBfcrLk4MgDr
 GcCUZHd/G16Iswe9a6I/0aEFqnhvrprV/s/sj7igbIhsMn3J1LW6/qV9jVc8tkJm/NekKVyY4o
 Fr0=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Mar 2019 16:48:14 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
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
Subject: [RFT/RFC PATCH v3 0/5] Unify CPU topology across ARM & RISC-V 
Date:   Wed, 20 Mar 2019 16:48:01 -0700
Message-Id: <20190320234806.19748-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu-map DT entry in ARM can describe the CPU topology in much better
way compared to other existing approaches. RISC-V can easily adopt this
binding to represent its own CPU topology. Thus, both cpu-map DT
binding and topology parsing code can be moved to a common location so
that RISC-V or any other architecture can leverage that.

The relevant discussion regarding unifying cpu topology can be found in
[1].

arch_topology seems to be a perfect place to move the common code. I
have not introduced any significant functional changes in the moved code.
The only downside in this approach is that the capacity code will be
executed for RISC-V as well. But, it will exit immediately after not
able to find the appropriate DT node. If the overhead is considered too
much, we can always compile out capacity related functions under a
different config for the architectures that do not support them.

There was an opportunity to unify topology data structure for ARM32 done
by patch 3/4. But, I refrained from making any other changes as I am not
very well versed with original intention for some functions that
are present in arch_topology.c. I hope this patch series can be served
as a baseline for such changes in the future.

The patches have been tested for RISC-V and compile tested for ARM64,
ARM32 & x86.

The socket change[2] is also now part of this series.

[1] https://lkml.org/lkml/2018/11/6/19
[2] https://lkml.org/lkml/2018/11/7/918

QEMU changes for RISC-V topology are available at

https://github.com/atishp04/qemu/tree/riscv_topology_dt

HiFive Unleashed DT with topology node is available here.
https://github.com/atishp04/opensbi/tree/HiFive_unleashed_topology

It can be verified with OpenSBI with following additional compile time
option.

FW_PAYLOAD_FDT="unleashed_topology.dtb"

Changes from v2->v3
1. Cover letter update with experiment DT for topology changes.
2. Added the patch for [2].

Changes from v1->v2
1. ARM32 can now use the common code as well.

Atish Patra (4):
dt-binding: cpu-topology: Move cpu-map to a common binding.
cpu-topology: Move cpu topology code to common code.
arm: Use common cpu_topology
RISC-V: Parse cpu topology during boot.

Sudeep Holla (1):
Documentation: DT: arm: add support for sockets defining package
boundaries

.../topology.txt => cpu/cpu-topology.txt}     | 134 ++++++--
arch/arm/include/asm/topology.h               |  22 +-
arch/arm/kernel/topology.c                    |  10 +-
arch/arm64/include/asm/topology.h             |  23 --
arch/arm64/kernel/topology.c                  | 303 +-----------------
arch/riscv/Kconfig                            |   1 +
arch/riscv/kernel/smpboot.c                   |   3 +
drivers/base/arch_topology.c                  | 298 ++++++++++++++++-
drivers/base/topology.c                       |   1 +
include/linux/arch_topology.h                 |  36 +++
10 files changed, 453 insertions(+), 378 deletions(-)
rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)

--
2.21.0

