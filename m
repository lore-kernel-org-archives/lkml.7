Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B342EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9578B2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfH0QEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbfH0QEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:04:13 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C75F85365
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:04:13 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 19so1250065wmk.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATtFby2HHOKxvIMlAxWSWxfBwEvUPTz5bp6RBKSRe98=;
        b=NvVpMSas016F3XZX6xTXjsmnySSIR/oY7lWVC3CBVO6rol7lixs88W8WF6Flc7Nm/E
         mWgSF8FWRBkr1X7MEoIS6hXVicf3F9mbmoyk3DGeCgwc+NAP3ki39+Xfn3h+XQ3olh0n
         bCLcor8jsmO+WaRC+Q+/jDHF9DyeN5Rx12ZvVVTqyMRoGCZKKqjQUcUKif7hu3qIOMnS
         Ns77mOE4Yv3yJlWcEo8wmiDv+A53j3lFQMQo63AepvrhbjCzYmyHS6tY/3jXndt9WsVR
         4JEGzaxpUKnkB1j2q1UwV/My3phbzn0Q7tjQ/d98Zep//jXnGSw2bGze12pjd6g8bUst
         qjbw==
X-Gm-Message-State: APjAAAUuFoJU9sY76Ixdj+ubzE2RmcmlNxX7oc7emsilrR+bvNOY2eJX
        NERyRfKROEMLPWOUAb3GQZUAWyclM0jlKWQBxur0ThW+kxefM+Mtg/rXsmzBAW/mdKvvxqZxbuB
        2M4kJvTyCW5JDcB2EATJIMF7K
X-Received: by 2002:a1c:b342:: with SMTP id c63mr29455680wmf.84.1566921851187;
        Tue, 27 Aug 2019 09:04:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5+ZjwKbX+HfEYgJbnHxYapRoHIk9gLuCdB4RLCgMobGff6yZoB0Y/LUoJdbxRNnPysx3N+A==
X-Received: by 2002:a1c:b342:: with SMTP id c63mr29455658wmf.84.1566921850970;
        Tue, 27 Aug 2019 09:04:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n8sm13461246wro.89.2019.08.27.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:04:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 3/3] KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS support only when it is available
Date:   Tue, 27 Aug 2019 18:04:04 +0200
Message-Id: <20190827160404.14098-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190827160404.14098-1-vkuznets@redhat.com>
References: <20190827160404.14098-1-vkuznets@redhat.com>
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
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d1cd0fcff9e7..ef2e8b138300 100644
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
@@ -3183,6 +3182,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_x86_ops->get_nested_state ?
 			kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
 		break;
+	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
+		r = kvm_x86_ops->nested_enable_evmcs != NULL;
 	default:
 		break;
 	}
-- 
2.20.1

