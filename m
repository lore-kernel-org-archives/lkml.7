Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652FFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3582D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I3Jwr286"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbfDXVsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:48:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15282 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbfDXVsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556142497; x=1587678497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7eoJvuEAlEQu53EigOZxTNOMHIT8YN9ACuKN9mjmCeQ=;
  b=I3Jwr2863IwvTyt8rIesT5B4EmUN6ZSp9+nE03iCMcHrjBZdHlSmspNb
   dH8q+N4S2CI6Dd6uBU7T/cHP7zFQi3T6MPevN0oJkrcPPZDLoIL6LECOd
   zQlJM699JJ2oahSnsVTTynuCsJua3RVAGNApG+SKPz48UtqOqI/CZfcvc
   7o3NtcX00RoLEZ8ya9e4LFTeJDyDRpp7idLhOU+Rwv4YXj7lpWwOlVz8c
   CtuJcBbJDNe8fhunXKgvcXvqtWEJgZjGRK7/b5iU6Kuo9/72yS3CYUbQ1
   7Xg0DPemV/63iMJwFHWfpM3jVP65tZBGd+q8SGSO3h7kAgm38tniEXkno
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,391,1549900800"; 
   d="scan'208";a="106739595"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 05:48:17 +0800
IronPort-SDR: ry2ch8VCCkK0fCjZ054yqirhxrSGDGYgpyx3Nm4NW6Z25Col3uZkSAih3eWP86d+T8nsGJHMMY
 YBoas/eeDA3iUBXNN6zC4AHlWixbrzVRj7RBGvq7HDemKLdkf8iWPnf+Qeo877OBFAAoSOj5Eo
 uP2YuLeddOf2lq/vZzPVszgUixERzT45bRF2ASM9vvMdID4MaXoE2MyOVFCYnKgQMc6N0+SEym
 +nz1WMjrZyQqsCCIG4lXSNqiAg/X61VJ7UXTBrI2ngSwEQ6ZEVerH3YYo5UBVsj74wxvCjvuAi
 alI6FjU8L39Uc9/zZl4+S2X5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Apr 2019 14:26:56 -0700
IronPort-SDR: cA8Pn8xMaeGPLKD0hC4+vltHoBCtchkGIiqudpnESp8NmKBaTjoiXKS41bTiOiNWrzF7vWkZ7P
 m8Z0xCcmbaR1LRGGoj68XUI7WmCKUQCNpEKcom1TGicssBlz1FNCC4nSu3sRDZE8ePpKOjrG1p
 kZAqSRIqoIgjihiiuQjlAyo/+INIAK1vY5MnN6vr4QBnvjRCjM2OON8m/g6eCQnjO0Gx7H3hbQ
 r0WTx5mjEwHSukDLGK/tUkbMz/RfhbGRlH0QGYAGQWbEiTjr9Tl7el00az5DdhISI86+RvmW7H
 KrY=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2019 14:48:17 -0700
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
Subject: [PATCH 4/4] RISC-V: Fix minor checkpatch issues.
Date:   Wed, 24 Apr 2019 14:48:01 -0700
Message-Id: <20190424214801.18880-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424214801.18880-1-atish.patra@wdc.com>
References: <20190424214801.18880-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on the patches, I found some minor checkpatch issues.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 89251f8ab754..0115db1368a4 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -42,7 +42,7 @@ unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
 
 void __init smp_setup_processor_id(void)
 {
-       cpuid_to_hartid_map(0) = boot_cpu_hartid;
+	cpuid_to_hartid_map(0) = boot_cpu_hartid;
 }
 
 /* A collection of single bit ipi messages.  */
@@ -53,7 +53,7 @@ static struct {
 
 int riscv_hartid_to_cpuid(int hartid)
 {
-	int i = -1;
+	int i;
 
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpuid_to_hartid_map(i) == hartid)
-- 
2.21.0

