Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8ACC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9816D21726
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B1V8eWAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfHCE1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 00:27:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20709 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHCE1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 00:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564806444; x=1596342444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WGA9LNHmgoVjWNUYeIrs9rW619vN81TklxixEztnNLM=;
  b=B1V8eWADGSkrYUFDZ/ZMQ4w74tGGF9Dvc25CT3aLYn+T0BfWDG0H289q
   WRif4C5kykvgneWStJzh7Vz3C3bPwz0qH6hrDh94s96Nk1gnlFuSuIaXP
   1D55lAj1sSH+JNczuQRhh7s+Pa+/O3QiZgj1FlcwPBMse0obZO92yRchr
   CeKzIDDUrTWE8yoEDTEszdFbRbG21lNSvPAon2l6v7t6L3xqyDFgVEQXK
   ulC/f89rBFISw+G2+HrbeWqj4MKTqzK3iT8YUdD5Nd7GJ8voY7dI6NOkO
   PgQNYUB7HuuG9vWuuN9fZrTnhSlpK9SxuMUWqipTfvAsPKdrLE9S8IB3t
   Q==;
IronPort-SDR: ce8LwsTAQqL3CR+9JjjbjNIKjXHvg3d7bgM6FESm97RdhPH8DAlpwVpUmMovz3VjRwao46lLya
 cNih3AeXaQRU6ZPdQrbHHtAyiRtMbetMRgQFDSo+o5UkM8ml4iWYuhlrvBx9t2/1O5FtnL7W0M
 l/SusShq4C2SoHROR+31MVk88HySM06u6rpU57ZbTYFLD425mp+cGpDLr0QNyceJl2jHsRApXr
 jU5foArlEEUuQ7J2C5M4Kq3CfuZ75QsyOmF544VuQKJe7rB4cPOzjJNOqdHz8ZKU1BamrQC/pp
 yaE=
X-IronPort-AV: E=Sophos;i="5.64,340,1559491200"; 
   d="scan'208";a="114857027"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2019 12:27:24 +0800
IronPort-SDR: swoI6hO3CerZebrmSrcWFGTWXXQtgwgacSgtib9t9Zlh7JdRSmpfk3wNiHb9ghvSFDkAvX99vN
 FTIUFN9vAUqVgrDCc0oUHFOiGw3a4mMU2LTmAFaYup0Vk466Y7rxCMFGk0sgFbWQFemnEJ2nUA
 MniMfw+sZs1AvTM+KHIbe5k1o+V4atg/NJoP9ZXERlpdzslBwZ7NFA/VxASwRsUCHZsZe/Tk3t
 KJPJ4r6gGLEtJvad+jzfz4ukkR/HDsZSk08P8ngDsYSUmL0c736w+Juypk14ftAInqxf+72+z2
 kMDI61Vty4q/LtJycTSqiAOf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 21:25:18 -0700
IronPort-SDR: QXW8xcKK5nFNUmRNgUr/m0wldyNbVndOvpTNiNeTvE0moFFjOp9Ub+Ee/L6VfiNmNggTMwmJ8r
 CAnVg8TA3d6xkLB09DKJSy1uEesSSnvhvMVmIxH4+RdqkiOB1A12LwDgeehVptgUm67QfvOSmh
 uNnwGrUbMFPuhFp7iLEIkXNCZjxNhxNYDZbefXEnjJNCSxZgt0FZrY7M/JLZle4OChfDFUyFN0
 Uso741IWCnJefG04G+bZP47adDLO8zj/3CseWcC6JAXEea+X1u485icJhcOasvBTR2/PQmBeGM
 ilw=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Aug 2019 21:27:24 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: [PATCH v4 0/4] Miscellaneous fixes 
Date:   Fri,  2 Aug 2019 21:27:19 -0700
Message-Id: <20190803042723.7163-1-atish.patra@wdc.com>
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

Changes from v3->v4:
1. Removed export module patch.
2. Updated dt binding description.

Changes from v2->v3:
1. Updated commit text of dt binding patch.
2. Removed couple of remaining uppercase usage.

Changes from v1->v2:

1. Dropped the case-insensitive support patch and added a dt-bindings
   update patch.
2. Added a export symbol patch.

Anup Patel (1):
RISC-V: Add riscv_isa reprensenting ISA features common across CPUs

Atish Patra (3):
RISC-V: Remove per cpu clocksource
RISC-V: Fix unsupported isa string info.
dt-bindings: Update the riscv,isa string description

.../devicetree/bindings/riscv/cpus.yaml       |  4 ++
arch/riscv/include/asm/hwcap.h                | 16 +++++++
arch/riscv/kernel/cpu.c                       | 47 +++++++++++++++----
arch/riscv/kernel/cpufeature.c                | 39 +++++++++++++--
drivers/clocksource/timer-riscv.c             |  6 +--
5 files changed, 95 insertions(+), 17 deletions(-)

--
2.21.0

