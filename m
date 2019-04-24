Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A55C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BB1218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116648;
	bh=otjoxQm7BFcGcORn54cq0kegkDdiEt5ib0Jw454B8ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jqy8xw6DjN00CBPwzyNCncW9RSd85wQpXtKLhqgB0EDQ7pRvgcjrUa8seI77gNF1x
	 CRKvsjzawmKLlczUIeIWTKDdYiBP34A8sPJ5BZIl7zp9TeYhSkEE6DMNRFIDNrMeWy
	 UpTSsELph0TfZDBROo6u0dSeoK+gFNBof1IJtPE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfDXOh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731505AbfDXOgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:36:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90AF721902;
        Wed, 24 Apr 2019 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116561;
        bh=otjoxQm7BFcGcORn54cq0kegkDdiEt5ib0Jw454B8ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYIBq3GUn86wnPp9qfAOg3aiRLKJN4jdM9YwjDqXiWS2P7lXJ1vSER58icbnJgdok
         GlQTTeYXlIWoF6TuLZ+igXuslgF8p5utwfaGS4wA/qPBmGpAVl6+U2zet/3/rr9Vd8
         4zmga4peHSlb1FR0+86vZ2lpbVQ4oCVJTc3LI7Mo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Avi Kivity <avi@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.0 53/66] kmemleak: powerpc: skip scanning holes in the .bss section
Date:   Wed, 24 Apr 2019 10:33:27 -0400
Message-Id: <20190424143341.27665-53-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit 298a32b132087550d3fa80641ca58323c5dfd4d9 ]

Commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
kvm_tmp[] into the .bss section and then free the rest of unused spaces
back to the page allocator.

kernel_init
  kvm_guest_init
    kvm_free_tmp
      free_reserved_area
        free_unref_page
          free_unref_page_prepare

With DEBUG_PAGEALLOC=y, it will unmap those pages from kernel.  As the
result, kmemleak scan will trigger a panic when it scans the .bss
section with unmapped pages.

This patch creates dedicated kmemleak objects for the .data, .bss and
potentially .data..ro_after_init sections to allow partial freeing via
the kmemleak_free_part() in the powerpc kvm_free_tmp() function.

Link: http://lkml.kernel.org/r/20190321171917.62049-1-catalin.marinas@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Qian Cai <cai@lca.pw>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Tested-by: Qian Cai <cai@lca.pw>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Avi Kivity <avi@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/powerpc/kernel/kvm.c |  7 +++++++
 mm/kmemleak.c             | 16 +++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 683b5b3805bd..cd381e2291df 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -22,6 +22,7 @@
 #include <linux/kvm_host.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kmemleak.h>
 #include <linux/kvm_para.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -712,6 +713,12 @@ static void kvm_use_magic_page(void)
 
 static __init void kvm_free_tmp(void)
 {
+	/*
+	 * Inform kmemleak about the hole in the .bss section since the
+	 * corresponding pages will be unmapped with DEBUG_PAGEALLOC=y.
+	 */
+	kmemleak_free_part(&kvm_tmp[kvm_tmp_index],
+			   ARRAY_SIZE(kvm_tmp) - kvm_tmp_index);
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 707fa5579f66..6c318f5ac234 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1529,11 +1529,6 @@ static void kmemleak_scan(void)
 	}
 	rcu_read_unlock();
 
-	/* data/bss scanning */
-	scan_large_block(_sdata, _edata);
-	scan_large_block(__bss_start, __bss_stop);
-	scan_large_block(__start_ro_after_init, __end_ro_after_init);
-
 #ifdef CONFIG_SMP
 	/* per-cpu sections scanning */
 	for_each_possible_cpu(i)
@@ -2071,6 +2066,17 @@ void __init kmemleak_init(void)
 	}
 	local_irq_restore(flags);
 
+	/* register the data/bss sections */
+	create_object((unsigned long)_sdata, _edata - _sdata,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	/* only register .data..ro_after_init if not within .data */
+	if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
+		create_object((unsigned long)__start_ro_after_init,
+			      __end_ro_after_init - __start_ro_after_init,
+			      KMEMLEAK_GREY, GFP_ATOMIC);
+
 	/*
 	 * This is the point where tracking allocations is safe. Automatic
 	 * scanning is started during the late initcall. Add the early logged
-- 
2.19.1

