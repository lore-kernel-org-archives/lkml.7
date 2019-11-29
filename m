Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14FAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D58920833
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfK2GX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:23:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36283 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfK2GX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:23:27 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iaZgP-0001NW-4C; Fri, 29 Nov 2019 06:23:13 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, harry.pan@intel.com, feng.tang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] x86/intel: Disable HPET on Intel Ice Lake platforms
Date:   Fri, 29 Nov 2019 14:23:03 +0800
Message-Id: <20191129062303.18982-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191129062303.18982-1-kai.heng.feng@canonical.com>
References: <20191129062303.18982-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like CFL and CFL-H, ICL SoC has skewed HPET timer once it hits PC10.
So let's disable HPET on ICL.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 arch/x86/kernel/early-quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 606711f5ebf8..2f9ec14be3b1 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -714,6 +714,8 @@ static struct chipset early_qrk[] __initdata = {
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x8a12,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
 	{}
-- 
2.17.1

