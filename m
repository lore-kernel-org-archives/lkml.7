Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D277C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20FA206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KsSwN8uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfHAA66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:58:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61763 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfHAA6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564621120; x=1596157120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EgHMt/UGrlopQ8ONP3bfsGEh2iUNdhTT7QH850cl4Xs=;
  b=KsSwN8uGWskg1VV3VYwKjxblxk6c6f/wP7uhDtcaDeqxCrbRp9bS1NZa
   wHapu66M7Sn29oxquSM+w3Fe+6Pb7mt21P27TElpAMV4C57srGDKYZNy5
   ZgjQFL/eWJSjyuTN91LakoKSJx3R1/pAVA1cuyV8ulZakVEBz2hdbdn31
   cJj9HkOoQ5LPjcZUfAbikYTIQJ1yzgaQL9oNlgcnClnaT53YFOub+TBwO
   zX4BPN8YIK0mFpLZuNZ2veRjSOUNIQDO6ZsJKtmL3G/Bxwvlzncw3NaTU
   xNEcDR0VvaF7Df9xxlW6Ym5KZbteF3a/En9cUA+MpSMAp5Po4VPqv6mpY
   w==;
IronPort-SDR: JrD0MhVqz+XXcTuf9B6Wb3Ic0pEZKQnHRIy3sTxea5fsxNGacykjk+Dlu+W9ST9gimboDXFYbQ
 XrKB4f3ZywUouPYCLj1iLQqmbk9zwkYiqhRibNfzAROnhTrsd6TtjsNZwLLDH35wj9LDUP01TX
 HHCdCSnxq6mEMLBC86i2E5vRE8ahl7FmzZdlrCDPbhpmfv/84005nan4Uo+bNNRnXI+IsKxNfZ
 R/gmpa/ax7B8rTsap3hfd56lgNKPByUGJYxObT6X2ohC7HXv+hsQo4C+Hsct+/o83triXJY6ry
 vC8=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="116247217"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 08:58:40 +0800
IronPort-SDR: hH5S7eDwyiSjwJ79G2KyY9K7ew7eYf5yP9aAwYCmteAfnkTaNfMb6M6PI14/tBYxYC1Bxau8hV
 qcLB51zH5u2hLQ7bCstuDQMb72VavKIANbRZpD0R0B001UfTDKNwG/TwZcvDelcw56hV8IRFxg
 ItS+QSXXJlFZcbx6H38nHn1xh8uV/laZd3rOM8tHMVpKlCfa85WvO23o6ogfT+gVs1NCCC886J
 52/vVsZdTEcSyBRiz4Ri6tJg25BjOw/se2eoerLHv72Wx7Rna9Zc7rmjIiGD0c6R6e7xYuIJvg
 M37Qk9OVBp69hmqw0qlfz+7i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 17:56:39 -0700
IronPort-SDR: vB0wWq2g5VV0TXjRYxActlFjCpILQXjTEq4ugNlJDp2TqO/ZK2OOY0Dlhb009q/s7ft8HAdxBu
 IhKw36nvIfY7stv34BJEtkttLD3H8bBhk3ZMUti3CMRVJgkX5Uups95qBb9dvX9InN9jqPFnon
 tGcyUmGj3MZoYpfhq+g+GowPPHTq1b2YGxZveEKK0VM4OIAPCV2KViQcHw7ZBpZ+C2uvI+QxOf
 phjgQoFz4bRa8s+eRujUlM2H32JPZC8Nk8g39aZbYOaOUE9k+/5suzpdl++3i0UUfc2p7FJnfF
 ZME=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Jul 2019 17:58:39 -0700
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
Subject: [PATCH v3 4/5] RISC-V: Export few kernel symbols
Date:   Wed, 31 Jul 2019 17:58:42 -0700
Message-Id: <20190801005843.10343-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801005843.10343-1-atish.patra@wdc.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export few symbols used by kvm module. Without this, kvm can not
be compiled as a module.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smp.c  | 2 +-
 arch/riscv/kernel/time.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 5a9834503a2f..402979f575de 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -193,4 +193,4 @@ void smp_send_reschedule(int cpu)
 {
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
-
+EXPORT_SYMBOL_GPL(smp_send_reschedule);
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 541a2b885814..9dd1f2e64db1 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -9,6 +9,7 @@
 #include <asm/sbi.h>
 
 unsigned long riscv_timebase;
+EXPORT_SYMBOL_GPL(riscv_timebase);
 
 void __init time_init(void)
 {
-- 
2.21.0

