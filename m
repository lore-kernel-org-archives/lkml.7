Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74521C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4523821906
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116865;
	bh=z9Ph+u3z/cdC8VIUzt6g/rNyUJvfx33XXPQ94lnPhM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CYTyG68zczoo0ua0vvp8O4JR+BLHNsSbpdiLrElJwXW1wkxMGa3Q/67RfHK0eKoL6
	 2GToqHlJo/qsLrYx/9WqC28m76LZtUzdB1Iwq+cpzRXh44UXIv04bob5HD4H+ttwqx
	 GKb1FTsjq9kXcz1l5LFzZ93eTv0zYGMuRqmxr9Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfDXOlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbfDXOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:41:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7293821901;
        Wed, 24 Apr 2019 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116859;
        bh=z9Ph+u3z/cdC8VIUzt6g/rNyUJvfx33XXPQ94lnPhM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3qBSuIolSjKqXElzBWI6IzOg7FBW0/XNWxp+zZ7aMu55cQJD35lvPWMqi4Bywd4f
         9qI5cjePuePEfU2enNAVVIraJhDizKdfvJ8NdPePXdDvYvsRs30CS8/oQHDF51LHYK
         85IEAeo40M1Svf1IQ9xj0jcumeevu68ub0z73ZYo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 43/52] KVM: SVM: prevent DBG_DECRYPT and DBG_ENCRYPT overflow
Date:   Wed, 24 Apr 2019 10:39:01 -0400
Message-Id: <20190424143911.28890-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>

[ Upstream commit b86bc2858b389255cd44555ce4b1e427b2b770c0 ]

This ensures that the address and length provided to DBG_DECRYPT and
DBG_ENCRYPT do not cause an overflow.

At the same time, pass the actual number of pages pinned in memory to
sev_unpin_memory() as a cleanup.

Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 6dc72804fe6e..cb3926c0a4cc 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6775,7 +6775,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	struct page **src_p, **dst_p;
 	struct kvm_sev_dbg debug;
 	unsigned long n;
-	int ret, size;
+	unsigned int size;
+	int ret;
 
 	if (!sev_guest(kvm))
 		return -ENOTTY;
@@ -6783,6 +6784,11 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	if (copy_from_user(&debug, (void __user *)(uintptr_t)argp->data, sizeof(debug)))
 		return -EFAULT;
 
+	if (!debug.len || debug.src_uaddr + debug.len < debug.src_uaddr)
+		return -EINVAL;
+	if (!debug.dst_uaddr)
+		return -EINVAL;
+
 	vaddr = debug.src_uaddr;
 	size = debug.len;
 	vaddr_end = vaddr + size;
@@ -6833,8 +6839,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 						     dst_vaddr,
 						     len, &argp->error);
 
-		sev_unpin_memory(kvm, src_p, 1);
-		sev_unpin_memory(kvm, dst_p, 1);
+		sev_unpin_memory(kvm, src_p, n);
+		sev_unpin_memory(kvm, dst_p, n);
 
 		if (ret)
 			goto err;
-- 
2.19.1

