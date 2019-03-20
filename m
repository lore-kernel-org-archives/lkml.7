Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5462183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kr3YBScL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCTBXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:23:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58800 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCTBXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553044989; x=1584580989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lYOiNVXIFijZTchZR9w80k81iGI9ZC4OCoqKQHxX6mo=;
  b=kr3YBScLHwoJdGOcx7jXPImDtp8v8opEiF84T0FxTGtioaqbVvDEIR5M
   BUzJbTn2G+pbT1pOs/LK4qeLAwmCPmxxFMc5iwBPEEDuUHaRWV8rVQpDF
   wju5lbRaEjiCgmmzixUK6jycxKx0LW4kblCPNIKhdnBI6Yh2Y++wraV8N
   NzozGtUaae/twQMOCBAPqS58FASs9j7c5OjfbI+wHtRLjWRS3STjl19BZ
   Zj5JqqI5w+x7nySHq+J6TNtsetg3ljNs5OKZvFSnVNz5hEbhwRGK4Vb+W
   kHQeCQM4QvTosm11ih7qme00nFmuyq0UPOLIYVjaSLIvJo2bZXn4ahgCx
   A==;
X-IronPort-AV: E=Sophos;i="5.58,498,1544457600"; 
   d="scan'208";a="209334023"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 09:22:58 +0800
IronPort-SDR: Oh3s+4X+vdGirdMSoaSC3KvKzRE6I/x8HEw1DnKeSlT4rlrnHNjvCZ5aWHvp3LNMONr3cHfSv5
 gt+Yg5oAI/ZRMg5iKyQOoD2JZ2EBjRXE5j1etM3ExXk7G0oxScfVoyHE6xiRhux5ZtXFuycVJH
 WTTH1ydNGOEO0Dav3p3KfaPKQhGsX2a/ymV973016ZAO5wV9/S8BMtA3WOUsKTXRJAVR+Jr/Ze
 bIR/PJjRKhHg95fZZulqzDU0Q3JiXRuzKu7sThOXew0jHAf+yqhsHwvIwWP85rLDEGXF23NSNA
 D94bf5FlwWpp6/aWeKe+MLla
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Mar 2019 18:02:37 -0700
IronPort-SDR: n7npuR/gzPCjoFn/NcxReeL9xQgP7vgrhpS9wgdRryR4DGcWftyVtRbhu66rfftDYHvc+6SiMe
 R0fQJloMOcvFy3lFdGLOv9jc2XCDRArw+YRNf6vac2X0hXfNog6po0A9DsGfVvp+2uB5r5Ujrg
 xks9uurhN+8iVmGuhlNVJLzZWaCZtxPpZPhMHICRtFOvTSxELo+1hTllgFUMpMTJ2U+v0aNpM3
 cEatKLEbu7tuCVC2eFWCPT7AqTS/qEQfQj7OSUiFgvctPfPM8j8d8trGKURTkaFo+AdDUGIk4F
 9qs=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2019 18:22:58 -0700
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
        Will Deacon <will.deacon@arm.com>
Subject: [RFT/RFC PATCH v2 0/4] Unify CPU topology across ARM & RISC-V 
Date:   Tue, 19 Mar 2019 18:22:47 -0700
Message-Id: <20190320012251.2728-1-atish.patra@wdc.com>
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
very well versed with original intention for some of the functions that
are present in arch_topology.c. I hope this patch series can be served
as a baseline for such changes in the future.

The patches have been tested for RISC-V and compile tested for ARM64,
ARM32 & x86.

The socket change[2] is also now part of this series.

[1] https://lkml.org/lkml/2018/11/6/19
[2] https://lkml.org/lkml/2018/11/7/918

QEMU changes for RISC-V topology are available at

https://github.com/atishp04/qemu/tree/riscv_topology_dt

Changes from v1->v2
1. ARM32 can now use the common code as well.

Atish Patra (4):
dt-binding: cpu-topology: Move cpu-map to a common binding.
cpu-topology: Move cpu topology code to common code.
arm: Use common cpu_topology
RISC-V: Parse cpu topology during boot.

.../topology.txt => cpu/cpu-topology.txt}     |  82 ++++-
arch/arm/include/asm/topology.h               |  22 +-
arch/arm/kernel/topology.c                    |  10 +-
arch/arm64/include/asm/topology.h             |  23 --
arch/arm64/kernel/topology.c                  | 303 +-----------------
arch/riscv/Kconfig                            |   1 +
arch/riscv/kernel/smpboot.c                   |   3 +
drivers/base/arch_topology.c                  | 298 ++++++++++++++++-
drivers/base/topology.c                       |   1 +
include/linux/arch_topology.h                 |  36 +++
10 files changed, 414 insertions(+), 365 deletions(-)
rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)

--
2.21.0

