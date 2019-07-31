Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61F8208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J8S/oDF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfGaBYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:24:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64333 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfGaBYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564536277; x=1596072277;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JNdFTTJDwVdGW8P5Pk91XlkU/IeFj6Dz26xPddYDU28=;
  b=J8S/oDF6Mm6MVr1D7iH8HgGSHVJ2h8E4AQOc1Fsas8o2+y7yCzxUhd0Y
   40R40Er8M/3ufISs1EjjLI+a5K2/hkwfCvCy4SHW6o2DT3o/rNrEbbg3a
   vkAjuTA4IqItR8FI939AjDLWbDZyo58wKvGHuaFJwICcKNBtmROQV5fHT
   ZBGk4Pmym9ucSI3GLnytv7kYn5pj6MFI3tT5G/En8HDMtW5GXywnrD/KZ
   rP4szZsABlcwHXOBmukJ7Ehb4tktEQb4OWuoQ2WEpgX6dx6LOPWtkvCFR
   h/3UybtEoQaUvcgNfedfhNhcW4oCyYCJI/duN0ZnbuI552R6Fk2LrpAuu
   w==;
IronPort-SDR: 2xgsAXPMdD9X2Z6yoJU8NGO2zdX4wrVIBEf0YsnIb1YBHI5Fq7UV+LPn1YEmdJJhl7bAfL2LEq
 lrdCigl8Bf2wtPcLtBa6BQoAGhLO9Nsnr4zdxUyZW21O/g7ZkgNhvmifuGb3mL7HP8Ud1ijJ4c
 0ylbFSHJOXvEujMI7ZTJHk2ODGOtw7I89iklbfxjBcyE6WogEVm9XNsKaBzhCsYHgl1Da0NND3
 JOxNxdH2weTe7I0f8+s6UVPjGMGIulxEyg45pB2cuT3UnoQB77NiKgkLahdYehslEjo4I5zVmG
 KyI=
X-IronPort-AV: E=Sophos;i="5.64,328,1559491200"; 
   d="scan'208";a="115555798"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 09:24:36 +0800
IronPort-SDR: LeChb2mGICxUHdpjkKi8Eth+DqyG3bam8aORBxyxON2WQIPBvbOYlGvWL8Kcxf5QuKMK20iAKC
 R4zFCRGCnlt6Flt3eDpBFt8AipMFp/ASjCybG08goGizRpXoeATWLaAjpG00Zt8tecBU8/hpOo
 1DFuYv48AJwrjJzKp6VaDglysmuxp8s2F67WZxQ7EBCRtuG1jKJbiM36DKCUIwVitX2Vm5rRuL
 JPC1QsglQClSzhr1SX1Pag7VCuOGZLaJ/vEjUhgCKgk0qEZrqK3yS7D4V05yNJF3W2cin7moR4
 zx6n41OygwuUx2m6LxoPW2HX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jul 2019 18:22:38 -0700
IronPort-SDR: R03ASlzY6GN7SI1Abs1LdfvtEfAh/JPexQ2OoDZva26KHh3shgAf1ahUfCObsGpRrqo0lTN8nC
 MqP5rYkp6YuBUXJ59M67mMa317qLfkCpsEMqGVZ0IIp4+C6imSHZPTCB2TD5eLIkecCiO9yDw3
 JMp2/aKq1Cjp4cKpCNUpTSkgmC8qwIvzITxLp0xe6VOCk6GEO0L3WO1/h61XnHh24w/1cYDzlQ
 Nz/7AssexUE7FXCypWkTmUYmkFLw/jLzX7xu08wqUIx5mzOwIJJCIatTexN3wIVK3MONDoFFAR
 vL4=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2019 18:24:36 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/5] Miscellaneous fixes 
Date:   Tue, 30 Jul 2019 18:24:13 -0700
Message-Id: <20190731012418.24565-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series have some unrelated fixes related
to clocksource, dt-bindings and isa strings.

I combined them into series as most of them are
prerequisite for kvm patch series.

Changes from v1->v2:

1. Dropped the case-insensitive support patch and added a dt-bindings
   update patch.
2. Added a export symbol patch.

Anup Patel (1):
RISC-V: Add riscv_isa reprensenting ISA features common across CPUs

Atish Patra (4):
RISC-V: Remove per cpu clocksource
RISC-V: Fix unsupported isa string info.
RISC-V: Export few kernel symbols
dt-bindings: Update the isa string description

.../devicetree/bindings/riscv/cpus.yaml       |  6 ++-
arch/riscv/include/asm/hwcap.h                | 25 ++++++++++
arch/riscv/kernel/cpu.c                       | 47 +++++++++++++++----
arch/riscv/kernel/cpufeature.c                | 41 ++++++++++++++--
arch/riscv/kernel/smp.c                       |  2 +-
arch/riscv/kernel/time.c                      |  1 +
drivers/clocksource/timer-riscv.c             |  6 +--
7 files changed, 109 insertions(+), 19 deletions(-)

--
2.21.0

