Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28662C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEAE2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfH0QEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:04:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfH0QEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:04:08 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87B9481103
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:04:08 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a17so11635719wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wTmTh7xa6ZjBJ+aMQDQrAGuc/LFXChDSJhLsWUK+WTw=;
        b=Fx7kTkO08wpS2WM/amJhG7TAoYZsMo9tftCqbq7fHkaLudyO5u/D7WbuogybQe97t5
         JnUQZhzeM/GdHIpiwjBoLQXC3TZDo7jFG+E1Qp/noJ4sSTRExzTQznEyx6f/yCO+e9AY
         AJFx8EFtrMIeG0pRbjdUfdNHW0LWfTiv+HNITy07am1gVHS1EM3s5uWJ9M9XnDT/bgfb
         tCRvX+tasowtG32SwtOjaWezOPalcx+/BRrfrxd/P1d9eteHTeOrNi/dqb7DkqNgoI6N
         xFv1PvUKkFAjPJ8CrFxBm+rSeADZ4fnQNPwsneor9BGNNqxa4xPCXYaOiab3NdEXWXjq
         HjLg==
X-Gm-Message-State: APjAAAXJ/icnGR+7murB+1Hoviiy4dpTOuacPGAX56wEc/UtnPI4Pjdu
        J7b8xN/HIDKOlFgoc9ZWMe+X1kQQBj8pCDJsG3MiSxE1jZ34ID8nvI8wBXSfTko9D5qd3xgc75D
        mRvw2q2ZUhirWo4JM31j2DLRn
X-Received: by 2002:a1c:c5c4:: with SMTP id v187mr29313146wmf.30.1566921847293;
        Tue, 27 Aug 2019 09:04:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJHNnJawjO+y0F2tak8NF6NDyr9x8KCsDnGG8but4Gv7XNoZibGMzwkLEL53g+R/qOWuQihw==
X-Received: by 2002:a1c:c5c4:: with SMTP id v187mr29313126wmf.30.1566921847093;
        Tue, 27 Aug 2019 09:04:07 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n8sm13461246wro.89.2019.08.27.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:04:06 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 0/3] KVM: x86: fix a couple of issues with Enlightened VMCS enablement
Date:   Tue, 27 Aug 2019 18:04:01 +0200
Message-Id: <20190827160404.14098-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was discovered that:
- hyperv_cpuid test fails on AMD
- hyperv_cpuid test crashes kernel on Intel when nested=0
The test itself is good, we need to fix the issues.

Vitaly Kuznetsov (3):
  KVM: x86: hyper-v: don't crash on KVM_GET_SUPPORTED_HV_CPUID when
    kvm_intel.nested is disabled
  KVM: x86: svm: remove unneeded nested_enable_evmcs() hook
  KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS support only when
    it is available

 arch/x86/kvm/hyperv.c  |  5 ++++-
 arch/x86/kvm/svm.c     | 17 ++---------------
 arch/x86/kvm/vmx/vmx.c |  1 +
 arch/x86/kvm/x86.c     |  3 ++-
 4 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.20.1

