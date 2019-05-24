Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E7BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398C2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZVsxYz34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbfEXAH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:07:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37265 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388423AbfEXAH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558656447; x=1590192447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LSOwfC4cbYJ0j98wN25Yv8d8VqJ1wUG9SMGFdxybDGA=;
  b=ZVsxYz345gtwZ9UcZhlfaTwl82h+FHKPLW7N2bO6qEqW06Tz37gxiyCZ
   XtBV/dG9r0oaob7eSOBhckBs2Qa7UlXETSC7J6Ni/VG1/7VyGjwe07kbt
   0OgWYVKa90Uz7Zl/hA9x8kbOaxa4cSfpOAoKLm26yw13UItkFxKDOpNq7
   3mr+UxPG0mUsUzOZbegnZbLMC9q1Hv06t3WQ3lRna+NYTwzg/jch07QSU
   Xo094Gna2SCCzpxSdUsKxBhVMiaBMERuAx9HDnRwNzOcKW0a1g/XUZR14
   5gNv14JFtWrUbruq6C5S2OgjrAvxA4wo+Au7CAwRZIE6/yT+gE0S7Hs48
   g==;
X-IronPort-AV: E=Sophos;i="5.60,505,1549900800"; 
   d="scan'208";a="108976451"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2019 08:07:26 +0800
IronPort-SDR: gCtmWnq/bH1zWmjeMuhFmiSh/hx5nLIKt6Jj4kvRstC31OWj2pX4iULTFJNwnlnL26nmBfAL6h
 2ASwA4G6xPNJjKpsbUtvnZuD7g2fbUItuYrZ2Ger/6MnxuzZ8J/BWARdc3ok/3xndC8C58QLdH
 vuu8M7TOIDj960Qp2jB0ls88sTTeR1e1HPK2ejQYa+hcaaukoA0bjG7Kxzo1uaANYqaEVjt4qZ
 I2y1axepZHZV5FthQcZeGI+D85lQopVPoVbVToGSlwrt2WhUfv+P69uJEv7IeOhEaC90kN69pn
 yPUIg5F0mFvyM/eg0R5vktYR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 May 2019 16:45:07 -0700
IronPort-SDR: VcAjlWyhrUmApDzJanM4Dp4zOOK9Obpa0fPsjcqxS3qx30cgihTszdbsUaHJ9IY4X0rKJQZx5M
 S5aAe3LLtPrPz15pm0R1nU5yAGAB3qsKrkWvAhl8ygttkgvVknRnY/nv4SmZBT5/JUcZXKV++M
 0inDP/9cQ8W39io95mF56MiQlquQPdUAE0H5I+Z7agEDuvuVaZxgVJSQff+4JYz2QjZmA9YeVI
 YWUbKRHei8uberUca5/AzjPhItHix9OWdpx6LFOsxbBbtXxcX5aH+jrelUvNHtW4UscaZksn4O
 tjM=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 May 2019 17:07:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
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
Subject: [RFT PATCH v5 0/5] Unify CPU topology across ARM & RISC-V 
Date:   Thu, 23 May 2019 17:06:47 -0700
Message-Id: <20190524000653.13005-1-atish.patra@wdc.com>
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

Changes from v4-v5
1. Removed the arch_topology.h header inclusion from topology.c and arch_topology.c
file. Added it in linux/topology.h.
2. core_id is set to -1 upon reset. Otherwise, ARM topology store function does not
work.

Changes from v3->v4
1. Get rid of ARM32 specific information in topology structure.
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
drivers/base/arch_topology.c                  | 298 +++++++++++++++++
include/linux/arch_topology.h                 |  26 ++
include/linux/topology.h                      |   1 +
10 files changed, 444 insertions(+), 425 deletions(-)
rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)

--
2.21.0

