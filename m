Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A288C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611C0206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aAai5wdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfHAA6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:58:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61763 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHAA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564621119; x=1596157119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FWCvTJxjE4nbG5EzQVW0+OdaZm/kjwh5FJ9fOMQwHxg=;
  b=aAai5wdJjCrqm6pSrtpnbqKwSDEIQ2k6+N4/1H0Z3jfrNVWDeNgU/M8F
   ARbWEPQW57VXskRQSRQyEZmADX4vcquJfcaVwjz/ynbRgoQoJdUbXM208
   m2svZG4tOXjRPJ/feh8gvsTeMFPGvKXx74fBNPg4EBsmo3XvqVI3/clQP
   4rWyRn7849pJHTaW/SqnpmxkX6om++YCP06cssg+D/Zsp9u//c87xZgzI
   4SDLZSXuL5kwe0gykOPzBOuMMmgYftCUzO6kB1tGNyueuZ1eHWo8RUVvu
   zbeyMWdU1pWKr8C5FZIi+v8jbaQIguj8RvakeGM1AqJOMjKj5mYzByIux
   w==;
IronPort-SDR: Icgp8o0Xgdrdr/qQ0oXGz2ksEQ5wG73aaajvyudviDBrucs0loWw0rvV5uF4/DmWTQIw5tWGCP
 lf7HIxZ0nHen5QHU4C61vifREizA6Yh4Phl+IOLiuAE7P+0sPd6n3iZLiP+DDv3Q1gF+b7lBwx
 8NAYCxbUSj1AzbSCNIplrBokjCYeDRgpgsgi5psP0J3FQH42ZUYHQBZcics+kndSliwezENGRd
 v1zW60aMV+Txl6v33nVP67EURrM23fYWgwWkAbaSOrxOvI+cG/pWIC2ryo+qEeGYp58pAmF6Mv
 aas=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="116247205"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 08:58:38 +0800
IronPort-SDR: DneZ+8MG4XUvZqiu9m7wykPjvSHp00IM2+BDpwS6ZdXQnV8zclRZHI+ePqxw10LuBPyjdPJ/uM
 oLzFBCJF/qF1SlJrNdAbp9KcR8QOYrm5S4gNOaXuxGeLvkKye9WB0BSbSLdN4vb3783yAiXCX1
 aywpCEsQ1vanasP3/w78ZxX6wUhEwgGArZtN/Rlr7TP+axSO/dyzxgNeVysbGQ6JOpQYrShFWO
 mgHtLpe+p5ZHXrcKezlwkKRTwQTmeNU0ijd0U2URPq75WJtW1s1r2jhRH2vsypLrY8wMU0dfuT
 OhSylgFZhgFjnq5jsAFrTA3U
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 17:56:38 -0700
IronPort-SDR: Lzx+5+peY9Ag2NCHOMt1rfBbb8n5F8P7ljHyrRWzVWCca9oIo3RTSCeZ9XVt5mIxBs+SAOsDhc
 /b15VyZFG5aC+FHAT72OM6usDZ9klXwxjqFUU2/L1grb99Ftg5YeCOlpSjtWOZQ4eAzjTeHyjH
 At0nDTHQxjppS11q+cVcW09uM4jkQGo435cP1WjMzATjoFZoeMnQ1kkFy3rX+x+33HRr7D6hPU
 s4B8ynnY/ycopm5sWCnXXkvEAKT02vi5vlaYcPwD137zyZ3tUsvZbcRpP8JaGjwzoPFOFa99FQ
 U4c=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Jul 2019 17:58:37 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 0/5] Miscellaneous fixes 
Date:   Wed, 31 Jul 2019 17:58:38 -0700
Message-Id: <20190801005843.10343-1-atish.patra@wdc.com>
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

Changes from v2->v3:
1. Updated commit text of dt binding patch.
2. Removed couple of remaining uppercase usage.

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
dt-bindings: Update the riscv,isa string description

.../devicetree/bindings/riscv/cpus.yaml       |  4 +-
arch/riscv/include/asm/hwcap.h                | 16 +++++++
arch/riscv/kernel/cpu.c                       | 47 +++++++++++++++----
arch/riscv/kernel/cpufeature.c                | 39 +++++++++++++--
arch/riscv/kernel/smp.c                       |  2 +-
arch/riscv/kernel/time.c                      |  1 +
drivers/clocksource/timer-riscv.c             |  6 +--
7 files changed, 96 insertions(+), 19 deletions(-)

--
2.21.0

