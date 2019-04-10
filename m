Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C069C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC56E217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n3pIRbkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDJXFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:05:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61699 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDJXFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554937502; x=1586473502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2/5jwhYTGQ1JCFD91I9OK6vJ4c5B03XruX+Wm8H9FA=;
  b=n3pIRbkBRUT388QDGfa817fRhG9/TKptbRJ86mWsc7CZstu0LGUQli1F
   st18N1suhuiCHf+5Gm7fVWUmp8QPz0elW9EfK7sbZe1NCA4HegLGgJIz6
   XEa4QeSbVUDxvVqWEXF5Re5dHbnYRrbIMkhT/oId0neGdqU+O1cTa6vWt
   uGUmuiQw+M87XTW7kBExQmEF5rsVw2s77B7ETdpU7t7GMjV1i8YIyaJVr
   KvKRLRAxjRFeD/3Vqb2Cj2nkF29DSXY3J7P/cjjZ4HZX/cMydlwLqa41a
   9qtBbrwGvMp+o0csTVm4JNhdLhg8ChT2uPf+EcGrGQYK3xmQmy+c91rXI
   A==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="110531211"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:05:00 +0800
IronPort-SDR: 6eV2AdQyyG8IRLTDJu1a2ddT1JPStKWShreC/vcKfMIq2911P5MVocfIwN3DNkKu0wKwp+S1wq
 fz7CqkMEkRyvVb+pOrtv69UTapC0mQji9mEhmYnlziQhua7Qgpu25q8F08el0vEaiP6IO4jjhJ
 oFsEprI/M+wGZ0GwQ7o2GmIlx+9YzZgjXPXisuGOGyjvnxQuAo+Iz88DxXNyqhYw3D7szmOUSL
 Ck7b3N4OAQPrwXHJLZ9sVR23YMxb+ZUhNTBBUdHhlW1N2R5Fcb611HkoELUvqubYnfJAwSW4G2
 ISHFDkxlwp7M57W3p2ebnXqh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:41:53 -0700
IronPort-SDR: qSCZ+MB5u8VxvgmD1nPVzJjNR4LtGOvm1wKeEZBnQoylDPQFPADfO/14h5TDqLzxuODWbUL403
 eFYFoZz1x1jMC8i7etI5f0X6+rkbZ5nHV01E/SEWlpM7R881ZFPiAKCH+Icn8KS3+yTlH6gPM4
 i6Z2B6IrtwM22k/f82ZsNDhU98LAoAfJmLU9TdLCdRroZCAQk4MqUWhDF3A4GdYS8DvtdC0J0Q
 68GTD5DS2u6r9iLhGWADLJCPB8tiTHmaKY/CfFxxZGl9e6ZH8qMJqYghtWAqKdvkuSxaGGaryR
 jVY=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Apr 2019 16:04:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 3/4] RISC-V: Implement nosmp commandline option.
Date:   Wed, 10 Apr 2019 16:04:42 -0700
Message-Id: <20190410230443.15729-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410230443.15729-1-atish.patra@wdc.com>
References: <20190410230443.15729-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nosmp command line option sets max_cpus to zero. No secondary harts
will boot if this is enabled. But present cpu mask will still point to
all possible masks.

Fix present cpu mask for nosmp usecase.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smpboot.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index eb533b5c2c8c..a8ad200581aa 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -47,6 +47,17 @@ void __init smp_prepare_boot_cpu(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	int cpuid;
+
+	/* This covers non-smp usecase mandated by "nosmp" option */
+	if (max_cpus == 0)
+		return;
+
+	for_each_possible_cpu(cpuid) {
+		if (cpuid == smp_processor_id())
+			continue;
+		set_cpu_present(cpuid, true);
+	}
 }
 
 void __init setup_smp(void)
@@ -74,7 +85,6 @@ void __init setup_smp(void)
 
 		cpuid_to_hartid_map(cpuid) = hart;
 		set_cpu_possible(cpuid, true);
-		set_cpu_present(cpuid, true);
 		cpuid++;
 	}
 
-- 
2.21.0

