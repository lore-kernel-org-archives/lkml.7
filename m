Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2641C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21E9216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbfHFGCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:02:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36596 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbfHFGB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:01:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so86644587wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0Ev3p94bFZcOBtAj2tXYSUGySXDoFmcSIvRC97mli0=;
        b=pxLNIQF6sfNCLBbfV3nvkkkolUeTcDMCNLutJLFqooDaWC95TvF0WJkpVFrdkxpKZC
         3Mmi7pK25RxAVAhQoRlbEX/JS0ATLgSYUgdfQ5XDWy64ydYO5M8ZR7a/vMds3N57yhRp
         fw+WzOSteRv3fpmk6drWvEpxjc4xraapuTKNHoqkSAEDRdA3BcK8x5zQe70Ln3HB5QYP
         3xZQKgrQ8UTWG2r1vcYCiCZbuPyeWEL526p1Myth70S9Xtj2QzVprIhkJWxAzrQNZVU4
         cyimhv3Wbxl0Ru9ZbVsl8alpKn9n85eHGk4J18GjzXs2/Mvkw3DvmKXhY5rAmurfNrA8
         yNvg==
X-Gm-Message-State: APjAAAWWHJDXkw1nlJIjIVugXywsNRlAqLy78uyOdjWnvlP05BWvcP1N
        yUng3HEBTtGTC7U9uOL5k0qwLSBwbAo=
X-Google-Smtp-Source: APXvYqwP9Zzy60aDGWWgds+ahxo2L68kGsBd9jl629Unyb7waA9fRwq/O3Jk3pB0tas0oMMvz4jHlg==
X-Received: by 2002:adf:8364:: with SMTP id 91mr2255022wrd.13.1565071315768;
        Mon, 05 Aug 2019 23:01:55 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id r5sm94216756wmh.35.2019.08.05.23.01.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 23:01:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v2 2/5] x86: KVM: svm: avoid flooding logs when skip_emulated_instruction() fails
Date:   Tue,  6 Aug 2019 08:01:47 +0200
Message-Id: <20190806060150.32360-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806060150.32360-1-vkuznets@redhat.com>
References: <20190806060150.32360-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we're unable to skip instruction with kvm_emulate_instruction() we
will not advance RIP and most likely the guest will get stuck as
consequitive attempts to execute the same instruction will likely result
in the same behavior.

As we're not supposed to see these messages under normal conditions, switch
to pr_err_once().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 7e843b340490..80f576e05112 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -782,7 +782,8 @@ static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	if (!svm->next_rip) {
 		if (kvm_emulate_instruction(vcpu, EMULTYPE_SKIP) !=
 				EMULATE_DONE)
-			printk(KERN_DEBUG "%s: NOP\n", __func__);
+			pr_err_once("KVM: %s: unable to skip instruction\n",
+				    __func__);
 		return;
 	}
 	if (svm->next_rip - kvm_rip_read(vcpu) > MAX_INST_SIZE)
-- 
2.20.1

