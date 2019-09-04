Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D923C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F33206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620517;
	bh=02PczsOJSc4YfEWE2n6BF+65aGR455I13ZDkZ1cTWWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H6gSxRJreWAOz8ykeVJkoodmpZUWrV5EewAPMF2tFVepDHyIriY89RoXJ+S3ida7Z
	 q2Y49unzXSSvhKr21j8ul63p1QQD8UVtfWPWpdRm90g1Sj2ykokcwO/lH2Qu5sSPED
	 qsxp8uLfL0yqzM1G3zF6o/7e+iRR1nm/wT6CUHa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbfIDSIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388734AbfIDSId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:08:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BAB2087E;
        Wed,  4 Sep 2019 18:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620512;
        bh=02PczsOJSc4YfEWE2n6BF+65aGR455I13ZDkZ1cTWWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmR+vY0d4c8CrqCziuE4aiROWbYtvb3+nl8zpiNES6joYmfVoRjYmQI3btm3fgVkT
         URveJqosvj4CMyIcfjDWb8OclRlKLucs+9SmqzXhgsBKwWM6qkzh6OxOmYJWmDQ010
         lPpfFLHBGYhKHoLozXnX0dfwZUlYNlA6grpiZ9Fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 84/93] KVM: PPC: Book3S: Fix incorrect guest-to-user-translation error handling
Date:   Wed,  4 Sep 2019 19:54:26 +0200
Message-Id: <20190904175310.366751053@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ddfd151f3def9258397fcde7a372205a2d661903 ]

H_PUT_TCE_INDIRECT handlers receive a page with up to 512 TCEs from
a guest. Although we verify correctness of TCEs before we do anything
with the existing tables, there is a small window when a check in
kvmppc_tce_validate might pass and right after that the guest alters
the page of TCEs, causing an early exit from the handler and leaving
srcu_read_lock(&vcpu->kvm->srcu) (virtual mode) or lock_rmap(rmap)
(real mode) locked.

This fixes the bug by jumping to the common exit code with an appropriate
unlock.

Cc: stable@vger.kernel.org # v4.11+
Fixes: 121f80ba68f1 ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 6 ++++--
 arch/powerpc/kvm/book3s_64_vio_hv.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 9a3f2646ecc7e..07a8004c3c237 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -602,8 +602,10 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 
 		if (kvmppc_gpa_to_ua(vcpu->kvm,
 				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
-			return H_PARAMETER;
+				&ua, NULL)) {
+			ret = H_PARAMETER;
+			goto unlock_exit;
+		}
 
 		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
 			ret = kvmppc_tce_iommu_map(vcpu->kvm, stt,
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 6821ead4b4ebc..eb8b11515a7ff 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -528,8 +528,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		ua = 0;
 		if (kvmppc_gpa_to_ua(vcpu->kvm,
 				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
-				&ua, NULL))
-			return H_PARAMETER;
+				&ua, NULL)) {
+			ret = H_PARAMETER;
+			goto unlock_exit;
+		}
 
 		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
 			ret = kvmppc_rm_tce_iommu_map(vcpu->kvm, stt,
-- 
2.20.1



