Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F24C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6382133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hHQuEBik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfF0TzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:55:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23412 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0TzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561665324; x=1593201324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OBRreVPl8/1uZ8733sksixlMzFip9pXYBiHmIUFSRKk=;
  b=hHQuEBikoDVNqYu5S9ImCiCDXG+j0zA2JJ61G8AOFezRlbrlF7pa44Hc
   E3lFe3+pVATKkWNjCcB8dyT8Njud1/0DQjgJAhnSG35i3Y+6DlwDI3qU0
   U3+VKVfb0ZTDr8JIQl83foL7Vqyjg/P5x1TjHQC70MUB/QIfxBn/fXvjA
   upQ+4HFg6cncgMyRlVPnNWFnIr/obvYHX8FxNKTw+F+/E9McrOlNZ4tHg
   5XkI4fdCybwpJSf88+YRfugvYC+GZ47F8MjVkxE8JiiJLRkEtHk/W1bfK
   RpSH/YCioKe9qPhnBvw2dAie8cCbUF0n9ODKMGsZyLIcM1+TjEgIlEe2m
   w==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="112927430"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 03:55:24 +0800
IronPort-SDR: mJ0v9LQzpOE575mcO+Uky+5JQpAmy1umCE8ica4I+p/BgVI84fXfKvtw760Cm1Li7dt3bNdDKE
 UPjW9pa9wIqz1xu+zCEl5NNw9+gAirnftykAN+hUjfKyxdiQqluiv2zpxv+CCbOkB2rcaSJMwI
 6P+5LWC8X79LjV0JMSlyDHxhA0VWi1PxVw2H60W7QIEI9DwWNnLMD0PVtZZ9ZaJfiRQ6eGtzRv
 DsaXKTGOgYeTQrhUK0lpdztKXvLxdFY2UWHFxtAAEUTXnEd7J+JDfR+Vmy0daWP6zz39gUZxde
 XDnKf1vNxyz9beStapibOaUJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Jun 2019 12:54:37 -0700
IronPort-SDR: QZfOZnobUoIlq7QA0oz41TT5jgDsxp1aB5nnN69VvT8K1DSzCnndUMF1HY+s5RqvAZhZkmY3GM
 VeO1OT8mI7wZ8eNBVoevsc8J4zeiVtbeP4YuEDFs+vyzRxulRFVm1xKLfyFoRel7EPkrWt+r1s
 Gr0RKX4GZwvu7o3r8YE903nVlo7x9/xuzE48qkgcppHDtM5y4R0iEBPW36hKiSlJqf1vmAMgdo
 Tu3PwJnlsUqC3/ImjypBeOVyoY6LLqCMolukiGhrI2NsOAFHrEkRr5N9Y2Jfrq/x/bt30aPhzA
 EzI=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 12:55:23 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
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
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V 
Date:   Thu, 27 Jun 2019 12:52:55 -0700
Message-Id: <20190627195302.28300-1-atish.patra@wdc.com>
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

The patches have been tested for RISC-V, ARM64, ARM32 & compile tested for
x86.

From Jeremy,

"I applied these to 5.2rc2, along with my PPTT/MT change and verified the 
system & scheduler topology/etc on DAWN and ThunderX2 using ACPI on arm64.
They appear to be working correctly.

so for the series,
Tested-by: Jeremy Linton <jeremy.linton@arm.com>"

The socket change[2] is also now part of this series.

[1] https://lkml.org/lkml/2018/11/6/19
[2] https://lkml.org/lkml/2018/11/7/918

This patch series can also be found at
https://github.com/atishp04/linux/tree/5.2-rc6_topology

QEMU changes for RISC-V topology are available here
https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg05974.html

HiFive Unleashed DT with topology node is available here.
https://patchwork.kernel.org/patch/11014313/

Changes from v7->v8
1. Regenerated the patch series without -b option in git format-patch.
   Without that, git apply from email won't work because ignored space
   changes.
 
Changes from v6->v7
1. Added socket to HiFive Unleashed topology example.
2. Added Acked-by & Reviewed-by.

Changes from v5->v6
1. Added two more patches from Sudeep about maintainership of arch_topology.c
   and Kconfig update.
2. Added Tested-by & Reviewed-by
3. Fixed a nit (reordering of variables)

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

Sudeep Holla (3):
Documentation: DT: arm: add support for sockets defining package
boundaries
base: arch_topology: update Kconfig help description
MAINTAINERS: Add an entry for generic architecture topology

.../topology.txt => cpu/cpu-topology.txt}     | 256 ++++++++++-----
MAINTAINERS                                   |   7 +
arch/arm/include/asm/topology.h               |  20 --
arch/arm/kernel/topology.c                    |  60 +---
arch/arm64/include/asm/topology.h             |  23 --
arch/arm64/kernel/topology.c                  | 303 +-----------------
arch/riscv/Kconfig                            |   1 +
arch/riscv/kernel/smpboot.c                   |   3 +
drivers/base/Kconfig                          |   2 +-
drivers/base/arch_topology.c                  | 298 +++++++++++++++++
include/linux/arch_topology.h                 |  26 ++
include/linux/topology.h                      |   1 +
12 files changed, 514 insertions(+), 486 deletions(-)
rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)

--
2.21.0

