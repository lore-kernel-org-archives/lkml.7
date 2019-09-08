Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22196C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5D921971
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946944;
	bh=uldvdnQtccwzl2Fu+7GwSHUtMFCoTg+WbS+B7cuuhI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8Hc/f5rW6vZo40ttHorRIhmkL4dPfqSKOGAsOpqRblvkoBVexjPbCKk9WcdsoS/H
	 gwnP2Ls2LsPVsOXGYW2trHvsc7CCcQxPmCPAnqxLmG2B4u0YeN614n6SVKB3w4g3cN
	 NDvfoV6D1fHOMAkQeItCYq7aKwzlJd6oo8Xh8wHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbfIHMtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731252AbfIHMs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:48:59 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A4E3218AC;
        Sun,  8 Sep 2019 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946938;
        bh=uldvdnQtccwzl2Fu+7GwSHUtMFCoTg+WbS+B7cuuhI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1xpCyrf63llK37oXJOeUYB9ubLSZ/gUAHWaJGkXd1X/RBbXFKy3TvPDxAEF0QPOC
         3VWqwBJuOwtpcUwQHr11bjFTBSWuqFa5XtKE3iyxFvAcsELPCdiF2fNBc2eV4AUWsS
         HpLFFv1OQ0Au6vgFHXW6eJCUDnyZAfSm39zjHuOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bandan Das <bsd@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 57/57] Revert "x86/apic: Include the LDR when clearing out APIC registers"
Date:   Sun,  8 Sep 2019 13:42:21 +0100
Message-Id: <20190908121146.679875798@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 950b07c14e8c59444e2359f15fd70ed5112e11a0 ]

This reverts commit 558682b5291937a70748d36fd9ba757fb25b99ae.

Chris Wilson reports that it breaks his CPU hotplug test scripts.  In
particular, it breaks offlining and then re-onlining the boot CPU, which
we treat specially (and the BIOS does too).

The symptoms are that we can offline the CPU, but it then does not come
back online again:

    smpboot: CPU 0 is now offline
    smpboot: Booting Node 0 Processor 0 APIC 0x0
    smpboot: do_boot_cpu failed(-1) to wakeup CPU#0

Thomas says he knows why it's broken (my personal suspicion: our magic
handling of the "cpu0_logical_apicid" thing), but for 5.3 the right fix
is to just revert it, since we've never touched the LDR bits before, and
it's not worth the risk to do anything else at this stage.

[ Hotpluging of the boot CPU is special anyway, and should be off by
  default. See the "BOOTPARAM_HOTPLUG_CPU0" config option and the
  cpu0_hotplug kernel parameter.

  In general you should not do it, and it has various known limitations
  (hibernate and suspend require the boot CPU, for example).

  But it should work, even if the boot CPU is special and needs careful
  treatment       - Linus ]

Link: https://lore.kernel.org/lkml/156785100521.13300.14461504732265570003@skylake-alporthouse-com/
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bandan Das <bsd@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 90be3a1506d3f..b316bd61a6ace 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1140,10 +1140,6 @@ void clear_local_APIC(void)
 	apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
 	v = apic_read(APIC_LVT1);
 	apic_write(APIC_LVT1, v | APIC_LVT_MASKED);
-	if (!x2apic_enabled()) {
-		v = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
-		apic_write(APIC_LDR, v);
-	}
 	if (maxlvt >= 4) {
 		v = apic_read(APIC_LVTPC);
 		apic_write(APIC_LVTPC, v | APIC_LVT_MASKED);
-- 
2.20.1



