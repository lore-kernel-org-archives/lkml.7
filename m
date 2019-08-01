Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24C2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8382087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfHAFOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:14:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55434 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHAFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:14:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so63144469wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQl7edwn+BBaD98menQlIuR4CRzjnAz72gInVhmciPI=;
        b=oxqycUPwUKdeiArSV9qLmmtwdd4CICdk+0ptYskbN/NuId4Uui/9UFpS5920JvSw2Y
         fRqisjRG2tTJrjN3fOnJK41uT0Psv/GxzCSdkSWfdUYmsmBxb5DI+bX2doEwSf4Nb0Qf
         tZy5L5WhHVw1VyQx33ZK1QSqIdgfbRzFxl+1HHHzrJ5anOAbVKjyTG+T8MrUIkR7AOCD
         Dpumb/5lAS6vlLXKscZb6WcBeBqao0edAP4hdjVLLPG2iavDVfEwggjBEKqvhpRpt53N
         wuaCP7xlBTFL/vCG/AzHnrtgwWqLdv/RrxoZlb68PbZZBSIJ2avPuaPXRuKmBkih/Qm+
         SGmQ==
X-Gm-Message-State: APjAAAW8rDw1HF3R75mM9GbxfUjVRDEjKtqlT8twuzaKm1FY8HFBU0qO
        A8fU3Zxb9OHz8CsugRhMLgFpUg==
X-Google-Smtp-Source: APXvYqxFEk5MxsMb9SRS0F9z/AOdjaxGzOmYxgzH33mkkzGt4IVLGLkSCjTMz3xWeerxX8qNq8kB9g==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr111847194wmj.20.1564636461354;
        Wed, 31 Jul 2019 22:14:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id a2sm73855351wmj.9.2019.07.31.22.14.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 22:14:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 0/5] x86: KVM: svm: get rid of hardcoded instructions lengths
Date:   Thu,  1 Aug 2019 07:14:13 +0200
Message-Id: <20190801051418.15905-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC (It's been awhile and I apologize for that):
- Dropped ' + 3' from vmrun_interception() as well.
- Added xsetbv's implementation to the emulator [Paolo Bonzini]
- Added Jim's R-b tags to PATCHes 2 and 3. 
- Tested with the newly added 'nrips' svm module parameter.

Original description:

Jim rightfully complains that hardcoding instuctions lengths is not always
correct: additional (redundant) prefixes can be used. Luckily, the ugliness
is mostly harmless: modern AMD CPUs support NRIP_SAVE feature but I'd like
to clean things up and sacrifice speed in favor of correctness.

Vitaly Kuznetsov (5):
  x86: KVM: svm: don't pretend to advance RIP in case
    wrmsr_interception() results in #GP
  x86: KVM: svm: avoid flooding logs when skip_emulated_instruction()
    fails
  x86: KVM: svm: clear interrupt shadow on all paths in
    skip_emulated_instruction()
  x86: KVM: add xsetbv to the emulator
  x86: KVM: svm: remove hardcoded instruction length from intercepts

 arch/x86/include/asm/kvm_emulate.h |  3 ++-
 arch/x86/kvm/emulate.c             | 23 ++++++++++++++++++++++-
 arch/x86/kvm/svm.c                 | 23 ++++++++---------------
 arch/x86/kvm/x86.c                 |  6 ++++++
 4 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.20.1

