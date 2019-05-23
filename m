Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCB320881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640542;
	bh=zo4BNT2y5vGThUf1YBTI4tm47+GcKrXMdYgr+k3oHic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZUsXdMkqL62gJXjyqTCjsysCRuXFh/t02b1Te0XGgTCdYBgKoCCbQsDuCqOFWcNuM
	 XvsHmHJT4d2n+QOX+uUCIJM/+Mw5ylhbQAMSsTUpjRcyMo12DOL3rziINYI0tJgRU6
	 jCV9zL+++Y8X3fXz8vb3/1ZPliG2vgnYIrXXZAPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbfEWTmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389747AbfEWTTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15A0205ED;
        Thu, 23 May 2019 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639148;
        bh=zo4BNT2y5vGThUf1YBTI4tm47+GcKrXMdYgr+k3oHic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUHS9hsMhTSISoqAsSQ1IhyM1ZB2UeGuvb93Veqcn9cLtHVCmM3FqBLWitkTTc/I3
         CJBYb8rJ9fptANOclPCCm9lcmOLgyiHmE3ihtG6itMq+HvXDbcFLCEqAPGltXcGj60
         nYtGuHJb7zCBVymaeiT55WQS/Q4S/aJgS3p3DDZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/114] x86: kvm: hyper-v: deal with buggy TLB flush requests from WS2012
Date:   Thu, 23 May 2019 21:06:34 +0200
Message-Id: <20190523181739.956056404@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit da66761c2d93a46270d69001abb5692717495a68 ]

It was reported that with some special Multi Processor Group configuration,
e.g:
 bcdedit.exe /set groupsize 1
 bcdedit.exe /set maxgroup on
 bcdedit.exe /set groupaware on
for a 16-vCPU guest WS2012 shows BSOD on boot when PV TLB flush mechanism
is in use.

Tracing kvm_hv_flush_tlb immediately reveals the issue:

 kvm_hv_flush_tlb: processor_mask 0x0 address_space 0x0 flags 0x2

The only flag set in this request is HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES,
however, processor_mask is 0x0 and no HV_FLUSH_ALL_PROCESSORS is specified.
We don't flush anything and apparently it's not what Windows expects.

TLFS doesn't say anything about such requests and newer Windows versions
seem to be unaffected. This all feels like a WS2012 bug, which is, however,
easy to workaround in KVM: let's flush everything when we see an empty
flush request, over-flushing doesn't hurt.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/hyperv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 01d209ab5481b..229d996051653 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1291,7 +1291,16 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 				       flush.address_space, flush.flags);
 
 		sparse_banks[0] = flush.processor_mask;
-		all_cpus = flush.flags & HV_FLUSH_ALL_PROCESSORS;
+
+		/*
+		 * Work around possible WS2012 bug: it sends hypercalls
+		 * with processor_mask = 0x0 and HV_FLUSH_ALL_PROCESSORS clear,
+		 * while also expecting us to flush something and crashing if
+		 * we don't. Let's treat processor_mask == 0 same as
+		 * HV_FLUSH_ALL_PROCESSORS.
+		 */
+		all_cpus = (flush.flags & HV_FLUSH_ALL_PROCESSORS) ||
+			flush.processor_mask == 0;
 	} else {
 		if (unlikely(kvm_read_guest(kvm, ingpa, &flush_ex,
 					    sizeof(flush_ex))))
-- 
2.20.1



