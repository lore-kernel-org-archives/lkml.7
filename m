Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD875C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C82218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155243;
	bh=HeXPMqH5tAKQGHu9NocNCCP0qUlEnYkyuaHmGmv0X7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sNLNfb/nXKQ8LIe5y+0Dlmt2dcH6BEcLjB+FOSjV+kxfd+EAtmAq+wt/GiWKIXNAE
	 7gkjju4GJDWjutBHiEQS1Mild6pq1naicfo1WooPt5V/u7UtFKe/S8qcTobYYs3wcm
	 niZH78wb6eWHUxfx7OlLqMWlLC5V++xJBq3xgO5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389779AbfGZPeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389755AbfGZPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:34:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A2732054F;
        Fri, 26 Jul 2019 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155239;
        bh=HeXPMqH5tAKQGHu9NocNCCP0qUlEnYkyuaHmGmv0X7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NS2l73f0uPNs+U/SDJJOTxleWVlishza9EuHTw1KXUdi0wUQF8iqTpdUgGmi6JSIY
         CE2kfC7Dt3/t8tSKNd+VLxhi2L+1aK4PEewQk6e9JcvLE6Kua7nC2TGIoLeEcgMVJG
         XQKWk+nrbdq8iBlFU3I5T5uYgJd1C4Xfy3njGOW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 49/50] KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested
Date:   Fri, 26 Jul 2019 17:25:24 +0200
Message-Id: <20190726152305.944211946@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152300.760439618@linuxfoundation.org>
References: <20190726152300.760439618@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit cf64527bb33f6cec2ed50f89182fc4688d0056b6 upstream.

Letting this pend may cause nested_get_vmcs12_pages to run against an
invalid state, corrupting the effective vmcs of L1.

This was triggerable in QEMU after a guest corruption in L2, followed by
a L1 reset.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Cc: stable@vger.kernel.org
Fixes: 7f7f1ba33cf2 ("KVM: x86: do not load vmcs12 pages while still in SMM")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8490,6 +8490,8 @@ static void free_nested(struct vcpu_vmx
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
 
+	kvm_clear_request(KVM_REQ_GET_VMCS12_PAGES, &vmx->vcpu);
+
 	hrtimer_cancel(&vmx->nested.preemption_timer);
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;


