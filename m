Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FBB22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfH1H7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfH1H7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:59:11 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 246278665A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:59:11 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f10so665707wmh.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqAYNYe6Ug0GzLuBdmUlgIsXKA4zYv5rxY3t4CUPVFQ=;
        b=nUi+n0j5Fx+5c8yxDtZwA0G3FDX8zKmFtWlOSisV+BE1+/p3K46hKMT5DXXAJXpvaV
         DUCZy3Agw6MRPOxzAjXvvBod4gcGcHDM6svd9lEc/9XNG25eujh32jMZ53hBszO54Rd8
         AtnWhoqo8NM5lYiLd9ReWtnJU07IlN8G5c/CC1sfA1lmC4CckIID1KOc20psq304AeEA
         WjvBjqxRkl2QRUnp9ea0ss6CfwOLpggG4mK+PDTtsHCVg1HUlzySL+z3cjB+Hpai/ftf
         N7DTgYXqz0NJ7BJqiQiZ1rTem14ewBqdJu3kXM/USXZAFXLupw0AfSay4VoI1NRNItp3
         xrJg==
X-Gm-Message-State: APjAAAX9ekAGk8kNkiZpmXECFW4gnnqq54OHPZLk/95NNuWUfLGFGFix
        PliN4Zm8Wj47VpzCKtKoFL3en6qia4BCjlia3Gc0UsNs+GLmUGxj3dS44STO2iq9xv3eHXqUXlg
        zrQTRA9YZOKBoW0zHDsTkO0oZ
X-Received: by 2002:adf:82d4:: with SMTP id 78mr2668208wrc.85.1566979149800;
        Wed, 28 Aug 2019 00:59:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAgGjUe2XPR9J6yRmKjEXklPepwazpcGdHUVGFoBlK2l13Y0XcluoZTglZdM8C09USuZ9JBQ==
X-Received: by 2002:adf:82d4:: with SMTP id 78mr2668192wrc.85.1566979149600;
        Wed, 28 Aug 2019 00:59:09 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a190sm2448469wme.8.2019.08.28.00.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:59:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH v2 2/2] KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS support only when it is available
Date:   Wed, 28 Aug 2019 09:59:05 +0200
Message-Id: <20190828075905.24744-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828075905.24744-1-vkuznets@redhat.com>
References: <20190828075905.24744-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was discovered that after commit 65efa61dc0d5 ("selftests: kvm: provide
common function to enable eVMCS") hyperv_cpuid selftest is failing on AMD.
The reason is that the commit changed _vcpu_ioctl() to vcpu_ioctl() in the
test and this one can't fail.

Instead of fixing the test is seems to make more sense to not announce
KVM_CAP_HYPERV_ENLIGHTENED_VMCS support if it is definitely missing
(on svm and in case kvm_intel.nested=0).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/x86.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d1cd0fcff9e7..149511f47377 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3106,7 +3106,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_EVENTFD:
 	case KVM_CAP_HYPERV_TLBFLUSH:
 	case KVM_CAP_HYPERV_SEND_IPI:
-	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
 	case KVM_CAP_HYPERV_CPUID:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
@@ -3183,6 +3182,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_x86_ops->get_nested_state ?
 			kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
 		break;
+	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
+		r = kvm_x86_ops->nested_enable_evmcs != NULL;
+		break;
 	default:
 		break;
 	}
-- 
2.20.1

