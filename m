Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3510EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07250204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153407;
	bh=twzR8Q0I0GB4/XJdHRqv2wG4hGGwxgBwJ7gzfKh5E9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0120wRB87jVtKmiVk1fszuiWXwld7Se95lreq/mGE+4zWSndhsmC322qNg3Srn4zf
	 eNPA+HfFlTsf8tLxiwLSuhpH7QyL6ZqKcxPAE36yHrwc4ApBgwQwCVwfjK5wIb79rW
	 j4rs28+CYo8vSBvmckJfJFMeMjwZmZ5lxt5tCCKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfEFOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbfEFOgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:36:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C2820B7C;
        Mon,  6 May 2019 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153403;
        bh=twzR8Q0I0GB4/XJdHRqv2wG4hGGwxgBwJ7gzfKh5E9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ei++EUW5HPdS8dNVMtpYYXFSm/HwuBPtksRqPYMOy96tUy48BqRQ5wZ7/5NxInGvM
         BOM9IxTA7NRtMNljke9/f1QU6AECNwbT9aRQmSx7C4NsiWU3JXt/YZvFESYPGTJFCb
         JW5bwRj18EuJ7bvCtkilzbB6/EOCKXj7y/GXNnpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 074/122] KVM: SVM: prevent DBG_DECRYPT and DBG_ENCRYPT overflow
Date:   Mon,  6 May 2019 16:32:12 +0200
Message-Id: <20190506143101.546803164@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b86bc2858b389255cd44555ce4b1e427b2b770c0 ]

This ensures that the address and length provided to DBG_DECRYPT and
DBG_ENCRYPT do not cause an overflow.

At the same time, pass the actual number of pages pinned in memory to
sev_unpin_memory() as a cleanup.

Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index e544cec812f9..2a07e43ee666 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6815,7 +6815,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	struct page **src_p, **dst_p;
 	struct kvm_sev_dbg debug;
 	unsigned long n;
-	int ret, size;
+	unsigned int size;
+	int ret;
 
 	if (!sev_guest(kvm))
 		return -ENOTTY;
@@ -6823,6 +6824,11 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
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
@@ -6873,8 +6879,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 						     dst_vaddr,
 						     len, &argp->error);
 
-		sev_unpin_memory(kvm, src_p, 1);
-		sev_unpin_memory(kvm, dst_p, 1);
+		sev_unpin_memory(kvm, src_p, n);
+		sev_unpin_memory(kvm, dst_p, n);
 
 		if (ret)
 			goto err;
-- 
2.20.1



