Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4817DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D2220820
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393863AbfITVZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:25:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393802AbfITVZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:25:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD8DCC054C52;
        Fri, 20 Sep 2019 21:25:15 +0000 (UTC)
Received: from mail (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80AAB60BF4;
        Fri, 20 Sep 2019 21:25:13 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] KVM: monolithic: x86: adjust the section prefixes
Date:   Fri, 20 Sep 2019 17:24:59 -0400
Message-Id: <20190920212509.2578-8-aarcange@redhat.com>
In-Reply-To: <20190920212509.2578-1-aarcange@redhat.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 20 Sep 2019 21:25:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjusts the section prefixes of some KVM common code function because
with the monolithic methods the section checker can now do a more
accurate analysis at build time and this allows to build without
CONFIG_SECTION_MISMATCH_WARN_ONLY=n.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/kvm/svm.c     | 2 +-
 arch/x86/kvm/vmx/vmx.c | 2 +-
 arch/x86/kvm/x86.c     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 3041abbd643b..5a48beb58083 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1407,7 +1407,7 @@ static __init int svm_hardware_setup(void)
 	return r;
 }
 
-static __exit void svm_hardware_unsetup(void)
+static void svm_hardware_unsetup(void)
 {
 	int cpu;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9fc3969f6443..09e6a477e06f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7642,7 +7642,7 @@ static __init int hardware_setup(void)
 	return r;
 }
 
-static __exit void hardware_unsetup(void)
+static void hardware_unsetup(void)
 {
 	if (nested)
 		nested_vmx_hardware_unsetup();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dfd641243568..c04894b61384 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9206,7 +9206,7 @@ void kvm_arch_hardware_disable(void)
 	drop_user_return_notifiers();
 }
 
-int kvm_arch_hardware_setup(void)
+__init int kvm_arch_hardware_setup(void)
 {
 	int r;
 
@@ -9237,7 +9237,7 @@ void kvm_arch_hardware_unsetup(void)
 	kvm_x86_ops->hardware_unsetup();
 }
 
-int kvm_arch_check_processor_compat(void)
+__init int kvm_arch_check_processor_compat(void)
 {
 	return kvm_x86_ops->check_processor_compatibility();
 }
