Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8F2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE362189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1KaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:30:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46547 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1KaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:30:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2vDL-0000vr-EB; Wed, 28 Aug 2019 12:30:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EF47B1C07D2;
        Wed, 28 Aug 2019 12:30:06 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:30:06 -0000
From:   "tip-bot2 for Tianyu Lan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/hyperv: Hide pv_ops access for CONFIG_PARAVIRT=n
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828080747.204419-1-Tianyu.Lan@microsoft.com>
References: <20190828080747.204419-1-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Message-ID: <156698820683.8007.9582744413346389871.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     41cfe2a2a7f4fad5647031ad3a1da166452b5437
Gitweb:        https://git.kernel.org/tip/41cfe2a2a7f4fad5647031ad3a1da166452b5437
Author:        Tianyu Lan <Tianyu.Lan@microsoft.com>
AuthorDate:    Wed, 28 Aug 2019 16:07:47 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 12:25:06 +02:00

x86/hyperv: Hide pv_ops access for CONFIG_PARAVIRT=n

hv_setup_sched_clock() references pv_ops which is only available when
CONFIG_PARAVIRT=Y.

Wrap it into a #ifdef

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190828080747.204419-1-Tianyu.Lan@microsoft.com

---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 53afd33..267daad 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -346,7 +346,9 @@ static void __init ms_hyperv_init_platform(void)
 
 void hv_setup_sched_clock(void *sched_clock)
 {
+#ifdef CONFIG_PARAVIRT
 	pv_ops.time.sched_clock = sched_clock;
+#endif
 }
 
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
