Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C852C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F42072077B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eMMIlShJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfD1A0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 20:26:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14541 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfD1A0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 20:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556411162; x=1587947162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+oUGHgJqcWHwoouX7Rm0bcEfYEaHBmJ/F/1Xg9NeC+A=;
  b=eMMIlShJFMZa/oUqvXwV7L6lEx1JwoPcsL+t65SxakLtzkdkPAz01XIK
   YO3opmv5D/F3uosm5yHgDHX5Ic3eqsl5xjBumrDT1RQFRCstxkzLBGq9v
   VLmo8fV+wFTgKPRm+wXiSInizGn8CH6SCPo6ns3aSQOJh5LHpuDT/JLxm
   TC1H8hJHlRigbBUHNUmNN0x40hrJxqTGVvKYS3Ankq5qHwbpVyVcCEJMd
   M5iH8/tb4BjxJUKeeMOa856b0kmxIKtjpk/F2WjIjMR7dl+3awvD9VdjY
   7g9toUU8v0zYU+TN4U0/0kpWgGSDDM7G00qwqXI0XM6AZFcBtN3ASR4ua
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,403,1549900800"; 
   d="scan'208";a="106993910"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2019 08:26:02 +0800
IronPort-SDR: FxXD42aQXcam998uSeNMF182biq+/8dEOkZB9t99R7TafWmGt9f3Pa2UlII5Cw1O06MwjpMHXM
 /Nd/5tqJjl21TUMD328QHGkuaijeOvU/twWf/aN0NSepLyc5wjovkC2MnkbVyl3u959R2ZYKmn
 mLBWjcQHKNoXnS2Wzln6MACy1hrlhqHrzOojf2078KpT89fPH7S2YkLqrvwmOub9+lElxxF2aI
 Th4TBMHDZTLeOcm2pz3RmAn4y5msv/V2H445DHZtv48Js4eszzWU8JWqIlTvx3wvDb7nMVQyHq
 ShXRGpjLlcm6jadoL5TBMmUf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Apr 2019 17:04:36 -0700
IronPort-SDR: zKuZNCVXHVbSjmeYi7nZxcRThDHf0m26GzMjdNXhfgSLUb30lnMLtQz0/xWF+1BO5mIZ04MPOc
 uUCtIamZ7WrU5vykrnuS634CxUzyJlEt0qNwDNZNGwsJ5mKmnE0u40uhGsBz4ozIccpZx0ANC0
 Z9U8Tq7pVLGKTvz6jjhQFCIwC1go4pk9jctwlc9LmuovOv93riPIy1mp7X2oSCk+z7u70eJ7Ij
 Du31JaKTwgSIkIJpv9jbOoSmpdmmTe2BpFa4Cy3QvuA64TlAB3QgGMWkXPfmDahsMEVBYcyR4m
 Gz0=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Apr 2019 17:26:02 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v4 0/5] Unify CPU topology across ARM & RISC-V 
Date:   Sat, 27 Apr 2019 17:25:24 -0700
Message-Id: <20190428002529.14229-1-atish.patra@wdc.com>
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

Changes from v3->v4
1. Get rid of ARM32 specific information in topology strucuture.
2. Remove redundant functions from ARM32 and use common code instead. 

Changes from v2->v3
1. Cover letter update with experiment DT for topology changes.
2. Added the patch for [2].

Changes from v1->v2
1. ARM32 can now use the common code as well.

Atish Patra (4):
dt-binding: cpu-topology: Move cpu-map to a common binding.
cpu-topology: Move cpu topology code to common code.
arm: Use common cpu_topology structure and functions.
RISC-V: Parse cpu topology during boot.

Sudeep Holla (1):
Documentation: DT: arm: add support for sockets defining package
boundaries

.../topology.txt => cpu/cpu-topology.txt}     | 134 ++++++--
arch/arm/include/asm/topology.h               |  20 --
arch/arm/kernel/topology.c                    |  60 +---
arch/arm64/include/asm/topology.h             |  23 --
arch/arm64/kernel/topology.c                  | 303 +-----------------
arch/riscv/Kconfig                            |   1 +
arch/riscv/kernel/smpboot.c                   |   3 +
drivers/base/arch_topology.c                  | 300 ++++++++++++++++-
drivers/base/topology.c                       |   1 +
include/linux/arch_topology.h                 |  26 ++
10 files changed, 445 insertions(+), 426 deletions(-)
rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)

--
2.21.0

