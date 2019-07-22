Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE9EC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BAE20578
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bPSbV3gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfGVJLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:11:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfGVJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:11:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M9AqK03755287
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 02:10:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M9AqK03755287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563786653;
        bh=gUj5C5lTbP25XVJ9KfGxyaHAWhhuXovzSfOifoUwors=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bPSbV3gGD5cQVNIvW3MBuKsdnS751LyZBcTrOSTSRA60UomjLAly+G5Yk6I1dKV5y
         5hzI/OVr07ikP0Ock1YNmuxQpOb0RYM88YC7ueINBW2Bl3m96CGrdga0F/q0FXRVAX
         d8wkzFEgVVc1QcH6OjYUHNkRmAc+ydzdQEd+gR28txMCw6Wd9uwUxSYuiotO1S62++
         P7OX3idWYwZZYtSBxDP4M67EQiS4vjl73KIyEpvVpsoaFwmM+77Mh2rY2bHsyRmOrA
         j/2kQoL+yoruAo+E4kWfZWg+/VFP1LFs/vMG1fEoCmc4FgN3uyHZ2NQ5FZv/XVPizq
         DRcUn8heIi2sQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M9Aq0C3755284;
        Mon, 22 Jul 2019 02:10:52 -0700
Date:   Mon, 22 Jul 2019 02:10:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Maya Nakamura <tipbot@zytor.com>
Message-ID: <tip-8c3e44bde7fd1b8291515f046008225711ac7beb@git.kernel.org>
Cc:     vkuznets@redhat.com, linux-kernel@vger.kernel.org,
        m.maya.nakamura@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, mikelley@microsoft.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mikelley@microsoft.com,
          vkuznets@redhat.com, m.maya.nakamura@gmail.com
In-Reply-To: <706b2e71eb3e587b5f8801e50f090fae2a00e35d.1562916939.git.m.maya.nakamura@gmail.com>
References: <706b2e71eb3e587b5f8801e50f090fae2a00e35d.1562916939.git.m.maya.nakamura@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyperv: Add functions to allocate/deallocate
 page for Hyper-V
Git-Commit-ID: 8c3e44bde7fd1b8291515f046008225711ac7beb
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

Commit-ID:  8c3e44bde7fd1b8291515f046008225711ac7beb
Gitweb:     https://git.kernel.org/tip/8c3e44bde7fd1b8291515f046008225711ac7beb
Author:     Maya Nakamura <m.maya.nakamura@gmail.com>
AuthorDate: Fri, 12 Jul 2019 08:21:25 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 11:06:45 +0200

x86/hyperv: Add functions to allocate/deallocate page for Hyper-V

Introduce two new functions, hv_alloc_hyperv_page() and
hv_free_hyperv_page(), to allocate/deallocate memory with the size and
alignment that Hyper-V expects as a page. Although currently they are not
used, they are ready to be used to allocate/deallocate memory on x86 when
their ARM64 counterparts are implemented, keeping symmetry between
architectures with potentially different guest page sizes.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1906272334560.32342@nanos.tec.linutronix.de/
Link: https://lore.kernel.org/lkml/87muindr9c.fsf@vitty.brq.redhat.com/
Link: https://lkml.kernel.org/r/706b2e71eb3e587b5f8801e50f090fae2a00e35d.1562916939.git.m.maya.nakamura@gmail.com

---
 arch/x86/hyperv/hv_init.c       | 14 ++++++++++++++
 arch/x86/include/asm/mshyperv.h |  5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0d258688c8cf..d314cf1e15fd 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
+
+	return (void *)__get_free_page(GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	free_page(addr);
+}
+EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
+
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 2ef31cc8c529..f4138aeb4280 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -218,7 +218,8 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-
+void *hv_alloc_hyperv_page(void);
+void hv_free_hyperv_page(unsigned long addr);
 void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
@@ -241,6 +242,8 @@ static inline void hv_apic_init(void) {}
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
+static inline void *hv_alloc_hyperv_page(void) { return NULL; }
+static inline void hv_free_hyperv_page(unsigned long addr) {}
 static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
 static inline void clear_hv_tscchange_cb(void) {}
 static inline void hyperv_stop_tsc_emulation(void) {};
