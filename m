Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42AAC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF972077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382729;
	bh=mQdz/+sTN9w/3HUjMARMd6h9kIN8On1i9z/MGYBHrTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lc61C8HSOhm5qkwgrDbymteuScQxGwddETXQqkjgUgJDa6kceFdGFWgTZJoyh5p6q
	 GtAUM0oX5r4DlZYYPfnEefP4W50l6jQsMR3XyHiNsHKuJVDsB1w4Ft6C+aI8Wr8lFf
	 SYqeNmfIbG1Q6AHTJMhPeu9gR8Zc04QrHjriP+fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfJFRZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfJFRZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:25:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417DB2077B;
        Sun,  6 Oct 2019 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382719;
        bh=mQdz/+sTN9w/3HUjMARMd6h9kIN8On1i9z/MGYBHrTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nud7Y144B4BxQ4FsKm9zgutJYtycgccrD7UXBSIZtF1CXqknDF3V6/N6EAJUljHdl
         yiz3jHPvdRa4Pyh8rgVAdd/SEqagrWR4kYpA2RgAWXy13ntqp4f/j/zAT2meRW2EdX
         BP055vpkCNdlYz2n/Q16mK6hVIrSEAqGWY1vcAd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 15/68] powerpc/xmon: Check for HV mode when dumping XIVE info from OPAL
Date:   Sun,  6 Oct 2019 19:20:51 +0200
Message-Id: <20191006171115.575359804@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 arch/powerpc/xmon/xmon.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 6b9038a3e79f0..5a739588aa505 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2438,13 +2438,16 @@ static void dump_pacas(void)
 static void dump_one_xive(int cpu)
 {
 	unsigned int hwid = get_hard_smp_processor_id(cpu);
+	bool hv = cpu_has_feature(CPU_FTR_HVMODE);
 
-	opal_xive_dump(XIVE_DUMP_TM_HYP, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_POOL, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_OS, hwid);
-	opal_xive_dump(XIVE_DUMP_TM_USER, hwid);
-	opal_xive_dump(XIVE_DUMP_VP, hwid);
-	opal_xive_dump(XIVE_DUMP_EMU_STATE, hwid);
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



