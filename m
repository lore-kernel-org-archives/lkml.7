Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8215C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62302087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfHAFOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:14:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43090 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfHAFOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:14:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so72037584wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAuOdcFvKcJE+TJQBnlj7YZrsenOZm0DkL2Ya79xDlk=;
        b=rcKWNdvw8bEQOeYOt8xq7jm/DbJ+uUwiZcD7dnfc1nzIpnqw9s/3c35LLUIE/kbdqb
         S57uN1hVeb+Zmdtr4Dv22YcFF30Gx11D4n1VAA+MPQEtYmORKoYyN7Za2yDPEsexAWEL
         3bYQxgEEt3sBMz7eIwGWzqUZ1cRa/Goj6f0sQzSmfyUL+FNnIePrRpG5TW5jrtZPGQ0/
         lt1sTYZowJ5ZM12pkwtqOow0rCOZPB2rfvH/qjlLKtx3j1gotb0HhwL6NLGVgpATorgq
         fqfVdAuts1NfsCqnOyI2Xu7NC0+DDaqcz4WjyewhzDLBa6j2TU9+LSmzpUUryQ3AFBCI
         6hEQ==
X-Gm-Message-State: APjAAAVhX9pc2PD6ndsEmaxv7xmVrCVLyT31KJgDCbOTy0FWdWkmJUE7
        7Ab627gvSGRtkGHBxdgvVLFOcA==
X-Google-Smtp-Source: APXvYqxGr1k6z/5aukJhARWDztMaUzfRv7qON3x9aDo/AOjnn+DXp9dJsmkrTq0CaT2g5O1DakAPCA==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr35053386wrp.287.1564636462452;
        Wed, 31 Jul 2019 22:14:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id a2sm73855351wmj.9.2019.07.31.22.14.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 22:14:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 1/5] x86: KVM: svm: don't pretend to advance RIP in case wrmsr_interception() results in #GP
Date:   Thu,  1 Aug 2019 07:14:14 +0200
Message-Id: <20190801051418.15905-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801051418.15905-1-vkuznets@redhat.com>
References: <20190801051418.15905-1-vkuznets@redhat.com>
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

