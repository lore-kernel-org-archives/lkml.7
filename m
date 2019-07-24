Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8916C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B77205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998299;
	bh=Vax62tHC2q2vWRdRMEAKXHwMW8ilLjfLVc3SadFx3+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ao26aiY9conzRJ1jQiFntYHazHHt+r0s1tRhNsCiwC113FNVjvzKG9/oANrVCjzs2
	 k21hlf3FwteYtmlXcUo7HJ44WcC/oAU9ACfwcQff7F3JMHBb1YO7vetRssieapusTb
	 yoWTNDDm5+u9VNcVQGAcOh07on6t5ghVXulpWL0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404914AbfGXT6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404492AbfGXT6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:58:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B39205C9;
        Wed, 24 Jul 2019 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998295;
        bh=Vax62tHC2q2vWRdRMEAKXHwMW8ilLjfLVc3SadFx3+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpLb10wXglm/50D0yYxYoY2hLbfXolvFyqEoGJgtlkH+pZMqRy8I6N5mtVV+P+7gN
         W1akWEX6twV331c7ajiNbVouaPsbvj/hYLlszMiQf8AsE4Uj2d6W3ru+1Dz6ZdlmBm
         XnrA7qqa5mZgiPuST/bB1Zp2HUrAbUG3Va/LrCWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 5.1 298/371] KVM: nVMX: Dont dump VMCS if virtual APIC page cant be mapped
Date:   Wed, 24 Jul 2019 21:20:50 +0200
Message-Id: <20190724191746.740511100@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 73cb85568433feadb79e963bf2efba9b3e9ae3df upstream.

... as a malicious userspace can run a toy guest to generate invalid
virtual-APIC page addresses in L1, i.e. flood the kernel log with error
messages.

Fixes: 690908104e39d ("KVM: nVMX: allow tests to use bad virtual-APIC page address")
Cc: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/nested.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2891,9 +2891,6 @@ static void nested_get_vmcs12_pages(stru
 			 */
 			vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
 					CPU_BASED_TPR_SHADOW);
-		} else {
-			printk("bad virtual-APIC page address\n");
-			dump_vmcs();
 		}
 	}
 


