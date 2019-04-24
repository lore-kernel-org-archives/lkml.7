Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48341C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E2520811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IHNJ6npa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfDXVsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:48:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15282 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfDXVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556142490; x=1587678490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XB0jNm8XAmZo+/vy/Z4p8xplRHuYAnev6DXaDcrItTg=;
  b=IHNJ6npa/FJ68pk6SIA1/3tvEvN3YPe3BNkcqyq8HOP8FOIkJ81SyiGA
   pwWUKMPbEdcDjVLqUXT3Ez9MKZGW/yzWsnIj9BF/gy+/VuJLGNBDZ1iR6
   0jiohTM874J7PBRL4oKE3qU3itTRmFZh0mcRenIQeBqMdggEnIJ+c2kOO
   22iEjUn5m82D0suuY6FUzRcTrs5YSCKl9h++31cTIJkfjciZJW/4xW5cG
   qXoQn79okMy0X4be9ZsOJynUboEwXLE1pA0LvlcaxF2ISpRb1glYl/jub
   xc2YmlO95PEy0CZBUSrP95IYmtiIsV9PcDXQ23Vqa9UDfu+11F1LN55C8
   A==;
X-IronPort-AV: E=Sophos;i="5.60,391,1549900800"; 
   d="scan'208";a="106739571"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 05:48:09 +0800
IronPort-SDR: Q4SkDT2QZma0Ih23bnsRCIckv8cgDlwjYcF2ZanEusLVOSVHnOww6KZ+IPAPxYV9wLJqz0eeNU
 jni+XoKaLHkLv1G0dQ4OajwVwH/tz6kIE/UdGPKc8gIG7AFs4b0KrbVgkkgQ1UzR5BcwnJg8JJ
 kytOrak38i6MPPuJILwDQ0D6HEIQl8E6XORLdb3iBqWH5Ac/yrlIGRvGvwr2m80lecOvxDFTyk
 V08iPuV6Edh/5OQIBbnAClCSYWUXYACVWNl3iId8k07bhZfCAENBa8WkARxVEVvifMpUgOYm//
 a+esa4+aHDK4EOdLJfFRpqXT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Apr 2019 14:26:48 -0700
IronPort-SDR: HLkDr4BUsM9O2QFWPr3nEUiN5P3LUaDU6JBXt/kqUeRrDEIkSnCaz6SdfwxdnINKhXUlwrQukO
 0oXxnessp/5y57i64ZMlIBpWwCnSeJyGptiU9XJ4bjs/M3yCkLU+x7fSNxWs34DqpwoGUFAzwC
 jj22z1kBSqrEpbqVfuk/Wcm9tM0gHt/Yqs3pKPxigHkBrJdq2JxXDYxMg2Ki4ax6x/5xNmSxNN
 5HLO2nXzam2pATOgsLP1OVa4D4IIh80H/sLg2x/eowj3Xw67eC+a9JfuxONpfKEhvqlCB/RQF8
 1ps=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2019 14:48:09 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH v4 0/4] Miscellaneous kernel command line fixes
Date:   Wed, 24 Apr 2019 14:47:57 -0700
Message-Id: <20190424214801.18880-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assorted command line option fixes for RISC-V.

Changes from v3->v4.
1. Fixed few checkpatch warnings.

Changes from v2->v3.
1. Merged patch 1 & 2 into one patch.

Changes from v1->v2.
1. Update pr_err string in patch (4/4) as per review.

Atish Patra (4):
RISC-V: Add RISC-V specific arch_match_cpu_phys_id
RISC-V: Implement nosmp commandline option.
RISC-V: Support nr_cpus command line option.
RISC-V: Fix minor checkpatch issues.

arch/riscv/kernel/cpu.c     |  3 +--
arch/riscv/kernel/smp.c     |  8 +++++++-
arch/riscv/kernel/smpboot.  |  0
arch/riscv/kernel/smpboot.c | 22 ++++++++++++++++++++--
4 files changed, 28 insertions(+), 5 deletions(-)
create mode 100644 arch/riscv/kernel/smpboot.

--
2.21.0

