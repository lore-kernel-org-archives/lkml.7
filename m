Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DAC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D0D21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404266AbfHHRbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:31:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39523 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404297AbfHHRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:30:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so5601280wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opuSm2G6gYcM4qXZGufoG5jzs7R2voT6tX4ZJqRDemo=;
        b=j7J0fKIgK3dq7xG2GHCgbcvwe3AKqOKBOsUiUKBl50AbIpgefvHDih+sngdlI2f0Q+
         hW/WRdqnGNjIIsUuH0rucU5t5LNQDttw1ewV8K3ZkQQj98YCowGDZ6kZLsaL2Gs9DqS0
         kjIAX/TL9283yH+XZwIue8/UsTULoh4qquoCN5KbgepSLyvcA7KQwg4hwV32838DVw33
         0MnR97H+rfCyGXVvTTAK+wYiqPJqzT7LsnhGbgCEpRJEMxqaFFLMyBbhmBTqQZA4T7CF
         Mc9gIrgQovwLMsN7ZgL3vV3AQ/LA3cWzVWrh07+TGSIDZs6yMVyCrsRjazo12t6RkCuu
         IZEQ==
X-Gm-Message-State: APjAAAW6zFrrQwoYVr12E4Ii1X+xUsvGpsvchGeaHjSye6W37zHJ/fHF
        arOAKj0KFSPEHtQUfKuq6CSQSDexiDU=
X-Google-Smtp-Source: APXvYqyUVqYAQ2UvaxoCGqK9ceqXcGh57DEZNtxscWVW21P5Hs1wAi/nlcToykofZ6QtlBr6x+TNkQ==
X-Received: by 2002:a5d:628d:: with SMTP id k13mr18529949wru.69.1565285456583;
        Thu, 08 Aug 2019 10:30:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g25sm2136859wmk.39.2019.08.08.10.30.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:30:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 1/7] x86: KVM: svm: don't pretend to advance RIP in case wrmsr_interception() results in #GP
Date:   Thu,  8 Aug 2019 19:30:45 +0200
Message-Id: <20190808173051.6359-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808173051.6359-1-vkuznets@redhat.com>
References: <20190808173051.6359-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svm->next_rip is only used by skip_emulated_instruction() and in case
kvm_set_msr() fails we rightfully don't do that. Move svm->next_rip
advancement to 'else' branch to avoid creating false impression that
it's always advanced (and make it look like rdmsr_interception()).

This is a preparatory change to removing hardcoded RIP advancement
from instruction intercepts, no functional change.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 7eafc6907861..7e843b340490 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4447,13 +4447,13 @@ static int wrmsr_interception(struct vcpu_svm *svm)
 	msr.index = ecx;
 	msr.host_initiated = false;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 	if (kvm_set_msr(&svm->vcpu, &msr)) {
 		trace_kvm_msr_write_ex(ecx, data);
 		kvm_inject_gp(&svm->vcpu, 0);
 		return 1;
 	} else {
 		trace_kvm_msr_write(ecx, data);
+		svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 }
-- 
2.20.1

