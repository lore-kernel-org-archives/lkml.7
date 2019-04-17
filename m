Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CFEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CCE21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V128FBps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbfDQOUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:20:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:20:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEK92R3935682
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:20:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEK92R3935682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510810;
        bh=Gpkgq1St/+1UgjrCVGodsGuw/nxmsofZVvoXWqX1ib4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=V128FBpszklLV5qgfhp7fiI045S4wgWCbLiTjcdjMFImsmVMRw/+ODfQHVXxHXCLd
         omuoL+qMLk2RwSB7MpGnfKpaVAHrcBSJCpD0869dzK4LM2RphEC4ErMbqwG7bxAtAY
         2ouvxXMT9KfX7GDXsO5QqfKYBSC+BDrLL0+CvlIL3I6yHVqjy9PGmo3Svv0WCxc3l1
         wHiI7Gd7RxwRl2iY2W9RoUOtdLeE2OcY6HbV6F9TBklLXc3jqXEiD5VidBigz97NWR
         SbGHwfY8Wjym8P/XF0XAzP/a53T/MK7jxETVOcODL7BV+iH+WLxkSoZyFsab07DLr7
         aEaGPqHYWNadg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEK87s3935675;
        Wed, 17 Apr 2019 07:20:08 -0700
Date:   Wed, 17 Apr 2019 07:20:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-451f743a64e1cf979f5fe21a1b2a015feb559f72@git.kernel.org>
Cc:     rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, sean.j.christopherson@intel.com,
        nstange@suse.de, jgross@suse.com, j.abraham1776@gmail.com,
        mingo@redhat.com, hpa@zytor.com, boris.ostrovsky@oracle.com,
        tglx@linutronix.de, bp@suse.de, sfr@canb.auug.org.au,
        mingo@kernel.org, luto@kernel.org, sstabellini@kernel.org,
        x86@kernel.org
Reply-To: rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, sean.j.christopherson@intel.com,
          nstange@suse.de, jgross@suse.com, mingo@redhat.com,
          j.abraham1776@gmail.com, hpa@zytor.com, tglx@linutronix.de,
          boris.ostrovsky@oracle.com, bp@suse.de, sfr@canb.auug.org.au,
          luto@kernel.org, mingo@kernel.org, x86@kernel.org,
          sstabellini@kernel.org
In-Reply-To: <20190414160146.001162606@linutronix.de>
References: <20190414160146.001162606@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/32: Invoke irq_ctx_init() from init_IRQ()
Git-Commit-ID: 451f743a64e1cf979f5fe21a1b2a015feb559f72
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

Commit-ID:  451f743a64e1cf979f5fe21a1b2a015feb559f72
Gitweb:     https://git.kernel.org/tip/451f743a64e1cf979f5fe21a1b2a015feb559f72
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 18:00:03 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:30:12 +0200

x86/irq/32: Invoke irq_ctx_init() from init_IRQ()

irq_ctx_init() is invoked from native_init_IRQ() or from xen_init_IRQ()
code. There is no reason to have this split. The interrupt stacks must be
allocated no matter what.

Invoke it from init_IRQ() before invoking the native or XEN init
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Abraham <j.abraham1776@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20190414160146.001162606@linutronix.de
---
 arch/x86/kernel/irqinit.c        | 4 ++--
 drivers/xen/events/events_base.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index a0693b71cfc1..26b5cb5386b9 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -91,6 +91,8 @@ void __init init_IRQ(void)
 	for (i = 0; i < nr_legacy_irqs(); i++)
 		per_cpu(vector_irq, 0)[ISA_IRQ_VECTOR(i)] = irq_to_desc(i);
 
+	irq_ctx_init(smp_processor_id());
+
 	x86_init.irqs.intr_init();
 }
 
@@ -104,6 +106,4 @@ void __init native_init_IRQ(void)
 
 	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs())
 		setup_irq(2, &irq2);
-
-	irq_ctx_init(smp_processor_id());
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 117e76b2f939..084e45882c73 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1687,7 +1687,6 @@ void __init xen_init_IRQ(void)
 
 #ifdef CONFIG_X86
 	if (xen_pv_domain()) {
-		irq_ctx_init(smp_processor_id());
 		if (xen_initial_domain())
 			pci_xen_initial_domain();
 	}
