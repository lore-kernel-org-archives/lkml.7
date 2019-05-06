Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21CB2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155118;
	bh=3z1Fx/ysaX/9QBrtU064uvhtjuzLx7SX+k95KYaEq7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Ne3UmCh0Mrwrr7wSMU1a59aa6kBkqmA5rksx9zOLB9MKpLL3iP4Lzxk2RM7WpAZT
	 6wxusO0qkmC28dMfrnWFCt7vCuLefEwIwNTm03yilIXoXFQQpueHaP0oN5mQ3iJf1c
	 xK/IWcsWPybSiDFEWceF+vDmJkZZFdTcAjbi6Ibc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfEFPFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfEFOih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632B621479;
        Mon,  6 May 2019 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153516;
        bh=3z1Fx/ysaX/9QBrtU064uvhtjuzLx7SX+k95KYaEq7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JKd3VM5zf0jyJ+7YW+J8bDqMblUQwwJGBcGb4Mskv76rsqh8yU5QiOFR7UpLdJgw
         1yBIxIopHtVoVTQDysbApclKuM4yEDP1/Vv4E0JOIa192JVxet9vDDqfGRmL0vtDTB
         ZaVpcBdJMU2415dEEhKjoXEzsVCU424TRdHQKam0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 101/122] KVM: nVMX: Remove a rogue "rax" clobber from nested_vmx_check_vmentry_hw()
Date:   Mon,  6 May 2019 16:32:39 +0200
Message-Id: <20190506143103.836917849@linuxfoundation.org>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 9ce0a07a6f49822238fd4357c02e0dba060a43cc upstream.

RAX is not touched by nested_vmx_check_vmentry_hw(), directly or
indirectly (e.g. vmx_vmenter()).  Remove it from the clobber list.

Fixes: 52017608da33 ("KVM: nVMX: add option to perform early consistency checks via H/W")
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/nested.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2793,7 +2793,7 @@ static int nested_vmx_check_vmentry_hw(s
 		[fail]"i"(offsetof(struct vcpu_vmx, fail)),
 		[host_rsp]"i"(offsetof(struct vcpu_vmx, host_rsp)),
 		[wordsize]"i"(sizeof(ulong))
-	      : "rax", "cc", "memory"
+	      : "cc", "memory"
 	);
 
 	preempt_enable();


