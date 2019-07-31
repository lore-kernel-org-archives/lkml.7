Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4812EC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190EF206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B5QJPPLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfGaBYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:24:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64336 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfGaBYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564536278; x=1596072278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EgHMt/UGrlopQ8ONP3bfsGEh2iUNdhTT7QH850cl4Xs=;
  b=B5QJPPLpICWSR2HCGVuCDS3SqKazwTC2FBYJe7ybd/r2QTL6DAgtEXgn
   4eYPmcCfd70ePFTmQOw7xaKpB7FSZzuGuLUiR2BVhscGEOxtgk7Q4e04G
   e40+Bm8ryHapHK025HYWfpFWtMYLHV6MHQTktkqAwOQXeZtUrd26GE0DK
   pLQhgrtnYip1R50G9v5440mzHfhH1lvd5kNarlx6t2OvWIOeKhEMRebUi
   of8BusXWg64MBLQqyIjwMuW1KKNrKs9lqQkrP34qJTsGvRBYzbup4MIoq
   GoG1AhOuhK5aSZt6Cemu7BHIo+b0r3NC6Iq2FinIoY+nMJk0eGTQkUinJ
   g==;
IronPort-SDR: 8HzYAN9GJ3zeMDiekiyeS6LZLGzknO0iyclUCd8MoS9DSP0Kff4y8crCuR/qRnN9u0SBE+wZfb
 h0TOEEFVbYDwgG1H4/wasS08qY3a/XRA7UCtK3W408Vd9jAyI5GvX+HqFDON7M/ygknOEh1S3a
 FCHFw/VZPx0YUQovcGFvAvp1eMXo2EyZz2ms3WqcPciM88oLrl0FZkrLkwmPaWNT09Pbbe9zWO
 Z4+iFwyZZD/o6eOL1AMPBK+V4qwzimwaTYcTUOh82VIGNuqB216QUK5Vi53s3vjwl3LD25wgg9
 P0M=
X-IronPort-AV: E=Sophos;i="5.64,328,1559491200"; 
   d="scan'208";a="115555809"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 09:24:38 +0800
IronPort-SDR: A6yOCge3T37vtYaMsEo2k9DKvcq7O28MT5oLJKSA8PIWSqMZY40VejhVR9Ltw6h5qG2aLErqLL
 uWC2T5jw4W/rkcKsSj6oGwV+NOkgQCUA5SrvDY1NKfUn63jnAKCUsIlDGK/ivjeDtAo6Q8tXa4
 V2a94jxCwFuTE9O+0Ha4zCoTNPhlw/e6snRf18FgPY+kAQ6QqnbtqpD5gRqFWhgKBBP7P8l4t9
 WIqAl04eg0nuR5YYGnox5JBJAw+d2QGsPmBaDUjQC1Z6RQ8X2EIEtGOiy55DwZOTfGolOe4GTM
 OTqhtYzcqb302FZonhOpUvTh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jul 2019 18:22:39 -0700
IronPort-SDR: 6WhK99KFChD4uhKSHGkuZlee3PzPR5qo3CSAAgjGPRSkQu2snl96a05sxvbzaGR5qJ3zsthNzq
 LhcsNwSlhqBqRVlpk+2KJvZ/e53UiIl2vxpy8pfxv1DlnIOKVI0jtLj1dl6QdJBvU4sn0zcVEt
 9R7KfnddbM0lhOd8B4om/rbcORIcoqAtijqMEKuEGESPOrdpQ1ctoHW9rkCpBLojn4EAy9KWGQ
 1chiav2O6t788cuwTmsS6g5JwMNBibpKzipWgY3MXmLBpli8xbCNlIxEj/fHaoHNFRKzMT/3V9
 kvA=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2019 18:24:37 -0700
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
Subject: [PATCH v2 4/5] RISC-V: Export few kernel symbols
Date:   Tue, 30 Jul 2019 18:24:17 -0700
Message-Id: <20190731012418.24565-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731012418.24565-1-atish.patra@wdc.com>
References: <20190731012418.24565-1-atish.patra@wdc.com>
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

