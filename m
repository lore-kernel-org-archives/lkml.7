Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A966BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F552087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfHAFO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:14:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43092 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfHAFOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:14:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so72037617wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0Ev3p94bFZcOBtAj2tXYSUGySXDoFmcSIvRC97mli0=;
        b=V+8v3g8CDQSXqOUDRW+DNyckPLpV2Y0vQnszPUiU8s+PgN9UXOGaibVzLreF8HxBqb
         pjoJEw/GpkSw+If/PyFcwz2unSnFiFJrpV1GFQutAfrj5by9lDhl4FmpF3oBpKU2MJMW
         2VVWbjOJ1DgCoMNl+m7/0vXpCJnE0kdEKhdhaGGzBDUozSCx3UNyHtgkyRt0eEy8l+sw
         +U1dCJ7pi2ohKoaNm/L2YHLsaKcxSe0beZmfY9NEU91vZ7U4gnICE3focITr3FPGEb+g
         hW+CZRCbs5bTX4iMpqT4gepSmxZJWHw8QuiDcSCt1mEesrnDSz/OHwsTgsxX1FLTTxMx
         LSng==
X-Gm-Message-State: APjAAAUUQqy7kuiuSHVJ+3splDJw85/RowIWivJSLZAakjazBAbNfscY
        c3/OUmJ3S1LSqLF4gjNmMtmMGQ==
X-Google-Smtp-Source: APXvYqxFMKDgaHVtw5HXmLs+H9FxYBBsQIrfWfc/Wtqd3xYMD85MvLpK0srCqZOwviF6l316rS7CQg==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr137051859wrv.180.1564636463692;
        Wed, 31 Jul 2019 22:14:23 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id a2sm73855351wmj.9.2019.07.31.22.14.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 22:14:23 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 2/5] x86: KVM: svm: avoid flooding logs when skip_emulated_instruction() fails
Date:   Thu,  1 Aug 2019 07:14:15 +0200
Message-Id: <20190801051418.15905-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801051418.15905-1-vkuznets@redhat.com>
References: <20190801051418.15905-1-vkuznets@redhat.com>
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

