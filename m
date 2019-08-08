Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E5C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3221021743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404359AbfHHRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:30:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36233 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404297AbfHHRa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:30:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so3209528wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZC0jDq9siC882owlOIi/dn8ZAzGWdWlZvUaAcIsKJJ0=;
        b=flwWIOmtJtaMKQCetsdYTilL4KoH/5ZNuuStPkKggRqqzR+Sch6QVNVXUbqULiq8s+
         osC6GkN3iVGDgg0tnmpI+NFkvKyyhXLshOcgA9XTnhOps07W2pHut5rQspLtQMa/taIF
         +lfpBEOuD3BbidUDrLl+qu+aYgb9f6rlKwl+qhxvsK6UWcLkuCpDk3PUq7PicfNPWaEg
         vMK+AsnEpSi5FTZystcZGGMjFzZ35UJcXnpNer7ZSl+VN4JeJNf0yP5ZlrBV/Y3If8KU
         xhgpFompwf//2LDXDMc9Q719PncI+UtxZdZBzZDOIAMjF8kzHRZwLXCHmpFlk1wmQJeF
         74lg==
X-Gm-Message-State: APjAAAWR575AIjOvhQDTezElNn6dWSG2v8tYlV07vHnMnJdo+4d6TpW9
        9Imfs7XDfXKYImHX+wK51rnRXw==
X-Google-Smtp-Source: APXvYqwVAGL4jlttMY7DPiKgvoXEAX4Gtj+3vXIMWc6nv6zg9eT/yzjB7iWyxDufwMQFCfCn6We9TQ==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr5701266wmg.48.1565285454628;
        Thu, 08 Aug 2019 10:30:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g25sm2136859wmk.39.2019.08.08.10.30.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:30:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 0/7] x86: KVM: svm: get rid of hardcoded instructions lengths
Date:   Thu,  8 Aug 2019 19:30:44 +0200
Message-Id: <20190808173051.6359-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [Sean Christopherson]:
- Add Reviewed-by tags:
- PATCH2 replaced with the suggested "x86: kvm: svm: propagate errors from
  skip_emulated_instruction()" approach.
- PATCH5 split into three separating vmrun_interception() from others and
  implementing the suggested solution.

Original description:

Jim rightfully complains that hardcoding instuctions lengths is not always
correct: additional (redundant) prefixes can be used. Luckily, the ugliness
is mostly harmless: modern AMD CPUs support NRIP_SAVE feature but I'd like
to clean things up and sacrifice speed in favor of correctness.

Vitaly Kuznetsov (7):
  x86: KVM: svm: don't pretend to advance RIP in case
    wrmsr_interception() results in #GP
  x86: kvm: svm: propagate errors from skip_emulated_instruction()
  x86: KVM: clear interrupt shadow on EMULTYPE_SKIP
  x86: KVM: add xsetbv to the emulator
  x86: KVM: svm: remove hardcoded instruction length from intercepts
  x86: KVM: svm: eliminate weird goto from vmrun_interception()
  x86: KVM: svm: eliminate hardcoded RIP advancement from
    vmrun_interception()

 arch/x86/include/asm/kvm_emulate.h |  3 +-
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/kvm/emulate.c             | 23 ++++++-
 arch/x86/kvm/svm.c                 | 98 +++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.c             |  8 ++-
 arch/x86/kvm/x86.c                 | 13 +++-
 6 files changed, 83 insertions(+), 64 deletions(-)

-- 
2.20.1

