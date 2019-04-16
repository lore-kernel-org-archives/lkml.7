Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA91EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61A320693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfDPKbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:31:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDPKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:31:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GAV1Nt3408636
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:31:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GAV02M3408631;
        Tue, 16 Apr 2019 03:31:00 -0700
Date:   Tue, 16 Apr 2019 03:31:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-ba696429d290690db967e5f49463df4b2c1314a4@git.kernel.org>
Cc:     longli@microsoft.com, bp@alien8.de, kys@microsoft.com,
        hpa@zytor.com, sthemmin@microsoft.com, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, sixiao@microsoft.com,
        tglx@linutronix.de, sashal@kernel.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, Michael.H.Kelley@microsoft.com
Reply-To: Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
          haiyangz@microsoft.com, sashal@kernel.org, tglx@linutronix.de,
          sixiao@microsoft.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, sthemmin@microsoft.com, hpa@zytor.com,
          kys@microsoft.com, bp@alien8.de, longli@microsoft.com
In-Reply-To: <20190403170309.4107-1-vkuznets@redhat.com>
References: <20190403170309.4107-1-vkuznets@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/hyper-v: Implement EOI assist
Git-Commit-ID: ba696429d290690db967e5f49463df4b2c1314a4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ba696429d290690db967e5f49463df4b2c1314a4
Gitweb:     https://git.kernel.org/tip/ba696429d290690db967e5f49463df4b2c1314a4
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Wed, 3 Apr 2019 19:03:09 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:28:23 +0200

x86/hyper-v: Implement EOI assist

Hyper-V TLFS suggests an optimization to avoid imminent VMExit on EOI:
"The OS performs an EOI by atomically writing zero to the EOI Assist field
of the virtual VP assist page and checking whether the "No EOI required"
field was previously zero. If it was, the OS must write to the
HV_X64_APIC_EOI MSR thereby triggering an intercept into the hypervisor."

Implement the optimization in Linux.

Tested-by: Long Li <longli@microsoft.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Simon Xiao <sixiao@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-hyperv@vger.kernel.org
Link: http://lkml.kernel.org/r/20190403170309.4107-1-vkuznets@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/hyperv/hv_apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 8eb6fbee8e13..5c056b8aebef 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -86,6 +86,11 @@ static void hv_apic_write(u32 reg, u32 val)
 
 static void hv_apic_eoi_write(u32 reg, u32 val)
 {
+	struct hv_vp_assist_page *hvp = hv_vp_assist_page[smp_processor_id()];
+
+	if (hvp && (xchg(&hvp->apic_assist, 0) & 0x1))
+		return;
+
 	wrmsr(HV_X64_MSR_EOI, val, 0);
 }
 
