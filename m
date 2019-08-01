Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D803C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D730216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfHAFOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:14:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45602 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfHAFO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:14:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so72044498wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW0RHrkUqApLquoqHBaQ5OfrV+rmiadrYX9W4LRi2U4=;
        b=Ny9M15uLS2lZvPb6q7tHwvAOXLHZhKQvQVig1AhQEL4MEwgQm2dxM1SPVlIfOZ7W1B
         Q3rOIEsBcYP2FqSinkg0dPu+n2T8i9LesW7bzVqPndFFwZE2CDkLmWSqUgDhqwAw1rk1
         XYD7+hRUZsTH9kGtNtWjiusDAoulyRzJp0NIVcrWKZy0bj7O+hsfYvsrjNKLhuJGebqt
         REsgwMbSqJFStPdyIA03foJ2DutFgF1RiLnIPN5XFMldF3BRMjTWAxlFQo3FEUqDkrmy
         YTRAtHfxByrO9Putv3kvnwvCGMEejptGHMV/xaxLXpcwvUSXkt7C4sXXvkgMTaqdKTMb
         BL/g==
X-Gm-Message-State: APjAAAUzW/x1Uoe0sEZ71zGF1r+u4jxHWv8QbDdz01UggOsZEFUBSeP3
        jxzuPJZXSIbxz9E21888t+sA6w==
X-Google-Smtp-Source: APXvYqwzdq14++WQOuAsiG7JqsnQ4Ca3E3y8fhSOYWjN1aZAp8kI/MSMpScbD5ELoO6WQl4HHOe0/g==
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr117453218wrv.146.1564636464751;
        Wed, 31 Jul 2019 22:14:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id a2sm73855351wmj.9.2019.07.31.22.14.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 22:14:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 3/5] x86: KVM: svm: clear interrupt shadow on all paths in skip_emulated_instruction()
Date:   Thu,  1 Aug 2019 07:14:16 +0200
Message-Id: <20190801051418.15905-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801051418.15905-1-vkuznets@redhat.com>
References: <20190801051418.15905-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of the way how we skip instruction, interrupt shadow needs to be
cleared.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 80f576e05112..7c7dff3f461f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -784,13 +784,15 @@ static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
 				EMULATE_DONE)
 			pr_err_once("KVM: %s: unable to skip instruction\n",
 				    __func__);
-		return;
+		goto clear_int_shadow;
 	}
 	if (svm->next_rip - kvm_rip_read(vcpu) > MAX_INST_SIZE)
 		printk(KERN_ERR "%s: ip 0x%lx next 0x%llx\n",
 		       __func__, kvm_rip_read(vcpu), svm->next_rip);
 
 	kvm_rip_write(vcpu, svm->next_rip);
+
+clear_int_shadow:
 	svm_set_interrupt_shadow(vcpu, 0);
 }
 
-- 
2.20.1

