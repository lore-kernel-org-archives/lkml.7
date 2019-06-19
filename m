Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47323C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2818621721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfFSSO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:14:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34242 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfFSSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:14:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hdf6c-0006Re-Uu; Wed, 19 Jun 2019 18:14:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] x86/apic: fix integer overflow on 10 bit left shift of cpu_khz
Date:   Wed, 19 Jun 2019 19:14:46 +0100
Message-Id: <20190619181446.13635-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The left shift of unsigned int cpu_khz will overflow for large values
of cpu_khz, so cast it to a long long before shifting it to avoid
overvlow.  For example, this can happen when cpu_khz is 4194305 (just
less than 4.2 GHz).  Also wrap line to avoid checkpatch wide line
warning.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 8c3ba8d04924 ("x86, apic: ack all pending irqs when crashed/on kexec")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/kernel/apic/apic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 8956072f677d..31426126e5e0 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1464,7 +1464,8 @@ static void apic_pending_intr_clear(void)
 		if (queued) {
 			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
 				ntsc = rdtsc();
-				max_loops = (cpu_khz << 10) - (ntsc - tsc);
+				max_loops = ((long long)cpu_khz << 10) -
+					    (ntsc - tsc);
 			} else {
 				max_loops--;
 			}
-- 

V2: replace right with left in commit subject and message. Doh.

--
2.20.1

