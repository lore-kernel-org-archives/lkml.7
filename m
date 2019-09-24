Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746F2C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B2A20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344359;
	bh=gZEbCzvR1/O4Ovsw88o4m4Y9SV68i6dLQbo8HdTZnv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B+KYh1isFJb4ytKNw1vUa/ssI/gJfao89zZvhAX57E0QFHTLbrcQyCUr3K330kvxT
	 XDfYdL0QRGgjqH9RJrf5kZ9mKSVWEwrwCfCywyuuuPgkrhT1uWua0bwwLn97OFXjYu
	 rlBxFDNvgvPrCDAphxv+wQ2ZkIRNm3skQ3rxSfEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410334AbfIXQrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410161AbfIXQrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:47:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D9620673;
        Tue, 24 Sep 2019 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343624;
        bh=gZEbCzvR1/O4Ovsw88o4m4Y9SV68i6dLQbo8HdTZnv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x7AezjFQ8mFXox+A+ohH1vYUf9j3/zw5abkL2QfPMUiQvkf0B0VlBLZFo0xhRQzpi
         ByQLvt3049g/nIEwhOuRJRsBMN39E1UQML5x3kdR/A9NfDEk2Ane93iAUtuG2+hm4c
         WQU1+cyQRmAqt3r/L5IMhoCAjaHKJdUd89ZOu+8I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.2 32/70] powerpc/xmon: Check for HV mode when dumping XIVE info from OPAL
Date:   Tue, 24 Sep 2019 12:45:11 -0400
Message-Id: <20190924164549.27058-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cédric Le Goater <clg@kaod.org>

[ Upstream commit c3e0dbd7f780a58c4695f1cd8fc8afde80376737 ]

Currently, the xmon 'dx' command calls OPAL to dump the XIVE state in
the OPAL logs and also outputs some of the fields of the internal XIVE
structures in Linux. The OPAL calls can only be done on baremetal
(PowerNV) and they crash a pseries machine. Fix by checking the
hypervisor feature of the CPU.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190814154754.23682-2-clg@kaod.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 4a721fd624069..e15ccf19c1533 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2532,13 +2532,16 @@ static void dump_pacas(void)
 static void dump_one_xive(int cpu)
 {
 	unsigned int hwid = get_hard_smp_processor_id(cpu);
-
-	opal_xive_dump(XIVE_DUMP_TM_HYP, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_POOL, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_OS, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_USER, hwid);
-	opal_xive_dump(XIVE_DUMP_VP, hwid);
-	opal_xive_dump(XIVE_DUMP_EMU_STATE, hwid);
+	bool hv = cpu_has_feature(CPU_FTR_HVMODE);
+
+	if (hv) {
+		opal_xive_dump(XIVE_DUMP_TM_HYP, hwid);
+		opal_xive_dump(XIVE_DUMP_TM_POOL, hwid);
+		opal_xive_dump(XIVE_DUMP_TM_OS, hwid);
+		opal_xive_dump(XIVE_DUMP_TM_USER, hwid);
+		opal_xive_dump(XIVE_DUMP_VP, hwid);
+		opal_xive_dump(XIVE_DUMP_EMU_STATE, hwid);
+	}
 
 	if (setjmp(bus_error_jmp) != 0) {
 		catch_memory_errors = 0;
-- 
2.20.1

