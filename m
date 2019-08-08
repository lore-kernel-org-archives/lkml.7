Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E226C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6DD21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404435AbfHHRbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:31:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404401AbfHHRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:31:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so95716397wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNGY5/pIZwYc1y8jKoUSUwTNZVrPC80kmGzCCKEMhvY=;
        b=TWfpuBIyLOtLY1XIaNFl5zgcS2BC8/o1JjKNj81C2T0vhluVxfxLyBrOcoaw+eADJN
         Lrm0HglmjvmTHeGidZwVyxMUqh9A3kCbpTK5kwoQQaFDlWVV6PokTFT7L2x9aldPvT6v
         uimbuMPBfpjwvTOBSibzzOo/5aqqzEmw6P26VpFjB22Z7wcOvAH/wXVA1ICIkxKaJzIo
         qwBTsO50rOr7pBDTfW613bL6NiDF2eZIULIarpQijHz0DO5tm1vce0I8cy67SW9ql829
         ufvODvJi1JCkTt52v433VzpSk9DBqv2IGcXUXr8M+/65vFsg4ioU+2dy5mEDb5lue23t
         McAg==
X-Gm-Message-State: APjAAAWEq+j4V+mLhD8Q+O7XwVfyfWkLb0w3kLBEpsfEhi0b/rVN/jbK
        mf4QGQLk+fI5CwjVlf+hakbZdQ==
X-Google-Smtp-Source: APXvYqxRX19w+HZSpjqnjk2q8yQX1DrW5vAe9o12bNsY6Qp/kzsU3+vGBWL86JUiplgXB2BU6bdQcQ==
X-Received: by 2002:adf:f204:: with SMTP id p4mr19188140wro.317.1565285464694;
        Thu, 08 Aug 2019 10:31:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g25sm2136859wmk.39.2019.08.08.10.31.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:31:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 6/7] x86: KVM: svm: eliminate weird goto from vmrun_interception()
Date:   Thu,  8 Aug 2019 19:30:50 +0200
Message-Id: <20190808173051.6359-7-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808173051.6359-1-vkuznets@redhat.com>
References: <20190808173051.6359-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of whether or not nested_svm_vmrun_msrpm() fails, we return 1
from vmrun_interception() so there's no point in doing goto. Also,
nested_svm_vmrun_msrpm() call can be made from nested_svm_vmrun() where
other nested launch issues are handled.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 6d16d1898810..43bc4a5e4948 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3658,6 +3658,15 @@ static bool nested_svm_vmrun(struct vcpu_svm *svm)
 
 	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, &map);
 
+	if (!nested_svm_vmrun_msrpm(svm)) {
+		svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
+		svm->vmcb->control.exit_code_hi = 0;
+		svm->vmcb->control.exit_info_1  = 0;
+		svm->vmcb->control.exit_info_2  = 0;
+
+		nested_svm_vmexit(svm);
+	}
+
 	return true;
 }
 
@@ -3740,20 +3749,6 @@ static int vmrun_interception(struct vcpu_svm *svm)
 	if (!nested_svm_vmrun(svm))
 		return 1;
 
-	if (!nested_svm_vmrun_msrpm(svm))
-		goto failed;
-
-	return 1;
-
-failed:
-
-	svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
-	svm->vmcb->control.exit_code_hi = 0;
-	svm->vmcb->control.exit_info_1  = 0;
-	svm->vmcb->control.exit_info_2  = 0;
-
-	nested_svm_vmexit(svm);
-
 	return 1;
 }
 
-- 
2.20.1

