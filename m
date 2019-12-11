Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86415C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9252465C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576076975;
	bh=+cME4i6w/HOFktWu1TlD6KxQeCzpussbdm5Do3MnTqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cYF1N3e8H4cR3Ddu3lHqK3QlGI8xvo0x66/t43NmXaxwS9KFvlr02kJbG12j+Flp9
	 Lc2mF+QSpFpVACl0fuIklyN9VMtJKaQWT6BHpnPMMqmU26J6VfMGTGRGpzwtbER4Jq
	 1VSRlJUVnVH4+s1MVkUu52VH78xsM0yYsi5tX7HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfLKPJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfLKPJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:09:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4C824656;
        Wed, 11 Dec 2019 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076971;
        bh=+cME4i6w/HOFktWu1TlD6KxQeCzpussbdm5Do3MnTqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2Y40fXB/fV1mI8ybxaPctGPEHXVngRH6bjZfp6XHCEtYYiM3vX5ZC+BbZpXaok0l
         AWPEoaz1MytPoSwHkTou2Y+qa+0nlVcEyJtRTkzrN/NrI6sB6uIWPYGG6/ZOz8XKW3
         SiTEAkcN1aSYico0I2KZEScA7CEubHE4I+QxVnOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 5.4 60/92] KVM: PPC: Book3S HV: XIVE: Fix potential page leak on error path
Date:   Wed, 11 Dec 2019 16:05:51 +0100
Message-Id: <20191211150249.277334111@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kurz <groug@kaod.org>

commit 30486e72093ea2e594f44876b7a445c219449bce upstream.

We need to check the host page size is big enough to accomodate the
EQ. Let's do this before taking a reference on the EQ page to avoid
a potential leak if the check fails.

Cc: stable@vger.kernel.org # v5.2
Fixes: 13ce3297c576 ("KVM: PPC: Book3S HV: XIVE: Add controls for the EQ configuration")
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_xive_native.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -637,12 +637,6 @@ static int kvmppc_xive_native_set_queue_
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 	gfn = gpa_to_gfn(kvm_eq.qaddr);
-	page = gfn_to_page(kvm, gfn);
-	if (is_error_page(page)) {
-		srcu_read_unlock(&kvm->srcu, srcu_idx);
-		pr_err("Couldn't get queue page %llx!\n", kvm_eq.qaddr);
-		return -EINVAL;
-	}
 
 	page_size = kvm_host_page_size(kvm, gfn);
 	if (1ull << kvm_eq.qshift > page_size) {
@@ -651,6 +645,13 @@ static int kvmppc_xive_native_set_queue_
 		return -EINVAL;
 	}
 
+	page = gfn_to_page(kvm, gfn);
+	if (is_error_page(page)) {
+		srcu_read_unlock(&kvm->srcu, srcu_idx);
+		pr_err("Couldn't get queue page %llx!\n", kvm_eq.qaddr);
+		return -EINVAL;
+	}
+
 	qaddr = page_to_virt(page) + (kvm_eq.qaddr & ~PAGE_MASK);
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 


