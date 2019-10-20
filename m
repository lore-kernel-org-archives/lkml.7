Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB171CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 09:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D9C2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 09:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfJTJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 05:26:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:39083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfJTJ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 05:26:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 02:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,319,1566889200"; 
   d="scan'208";a="348494036"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.57])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2019 02:26:06 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] KVM: VMX: Remove vmx->hv_deadline_tsc initialization from vmx_vcpu_setup()
Date:   Sun, 20 Oct 2019 17:10:59 +0800
Message-Id: <20191020091101.125516-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191020091101.125516-1-xiaoyao.li@intel.com>
References: <20191020091101.125516-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... It can be removed here because the same code is called later in
vmx_vcpu_reset() as the flow:

kvm_arch_vcpu_setup()
	-> kvm_vcpu_reset()
		-> vmx_vcpu_reset()

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 279f855d892b..ec7c42f57b65 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4178,7 +4178,6 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 
 	/* Control */
 	pin_controls_set(vmx, vmx_pin_based_exec_ctrl(vmx));
-	vmx->hv_deadline_tsc = -1;
 
 	exec_controls_set(vmx, vmx_exec_control(vmx));
 
-- 
2.19.1

