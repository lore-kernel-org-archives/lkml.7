Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F40C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53BA21479
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153535;
	bh=/s6rXOI8IV/DPvBnhM0ct5g2KPuwwczgCDOBFL9FudM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yr8y2fSuh2nrE+jGQ1K/FFZXzftAurHL84e2/mk6SMwFHO7EQNZxFpINIBtowxuyb
	 mhIWjTcR5TI5cTyGk0HQEs5qiWHyx9znPH7H5h/DgbmaDpsLTG19LCtJtdQpyoo1BL
	 QVf4a2bvyZinKER6v1paijzZbRUju7C+NIADPkDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfEFOiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfEFOiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7806720449;
        Mon,  6 May 2019 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153529;
        bh=/s6rXOI8IV/DPvBnhM0ct5g2KPuwwczgCDOBFL9FudM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8F40JcAl1m3X77wnEpE+OvJcQURU/OtCqcWUWEMwOi56LG8nt6llmq1S5R+9kGOQ
         T3+oBDPWrBhLzbpNjFv1xSf8giOiFC0nC6XqMnCoT/eo3jcR1b0Va6IGXmgHN9sjSa
         Q365uRv+jsKFkQivxsb+rB/0p17YRLGkQCpCzoow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 102/122] kvm: vmx: Fix typos in vmentry/vmexit control setting
Date:   Mon,  6 May 2019 16:32:40 +0200
Message-Id: <20190506143103.899030465@linuxfoundation.org>
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

From: Yu Zhang <yu.c.zhang@linux.intel.com>

commit d92935979adba274b1099e67b7f713f6d8413121 upstream.

Previously, 'commit f99e3daf94ff ("KVM: x86: Add Intel PT
virtualization work mode")' work mode' offered framework
to support Intel PT virtualization. However, the patch has
some typos in vmx_vmentry_ctrl() and vmx_vmexit_ctrl(), e.g.
used wrong flags and wrong variable, which will cause the
VM entry failure later.

Fixes: 'commit f99e3daf94ff ("KVM: x86: Add Intel PT virtualization work mode")'
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -444,7 +444,8 @@ static inline u32 vmx_vmentry_ctrl(void)
 {
 	u32 vmentry_ctrl = vmcs_config.vmentry_ctrl;
 	if (pt_mode == PT_MODE_SYSTEM)
-		vmentry_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP | VM_EXIT_CLEAR_IA32_RTIT_CTL);
+		vmentry_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP |
+				  VM_ENTRY_LOAD_IA32_RTIT_CTL);
 	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
 	return vmentry_ctrl &
 		~(VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VM_ENTRY_LOAD_IA32_EFER);
@@ -454,9 +455,10 @@ static inline u32 vmx_vmexit_ctrl(void)
 {
 	u32 vmexit_ctrl = vmcs_config.vmexit_ctrl;
 	if (pt_mode == PT_MODE_SYSTEM)
-		vmexit_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP | VM_ENTRY_LOAD_IA32_RTIT_CTL);
+		vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
+				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
 	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
-	return vmcs_config.vmexit_ctrl &
+	return vmexit_ctrl &
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
 }
 


