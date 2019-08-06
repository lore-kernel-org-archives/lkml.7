Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE0AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564DB216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfHFGB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:01:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51875 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbfHFGBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:01:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so76881454wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFg6eLE4tRBG84YrEoHYB/BIyFyiiiQYscHt8vqgCkw=;
        b=kcJMTD8u7t17DeFKBU/HY7tufVprkDykc8xD6Y8Y7KRi7o5BKUCxuTxEj4jyX0Hm6p
         OhcnotSyKrKb34cgP3ub5DO+Cf0dBviZpnBVlgeS3f6yqGitE3dQuAQU79nV/AyAjikR
         0r2+SLfTj0vLKLQwhXFAVGiBuzTUrhE364zEotK0m7fiFh4FwAOFK7Zzkijy80hn7nZE
         DSECaVFRksWR9AB6yJvd6982p6DfZhOnpOUGa4tp4v37wTVFVvqzimf1VhuIbw07TahQ
         XaRpZzWtH3bQxYg27CM1/+QOQjXB0yGrQxNf90BiLfxUUE8JY6N9hgzqQwKYkLkJg2ui
         DtwQ==
X-Gm-Message-State: APjAAAVSl5Fc8iUjPyowY6spUt/IqCJswmxfQZHtqrjGh1nXKaG1+pNR
        eQnyQzKknqlHgw0WYFtexEPHyQ==
X-Google-Smtp-Source: APXvYqxlQw+IOcJ0mdkOCdR0mvOlyWq1HXZbiweIxKjahx35vXgtU7UvgaElJ9XuPUTtHWGt1w0IJA==
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr2198674wmg.159.1565071313085;
        Mon, 05 Aug 2019 23:01:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id r5sm94216756wmh.35.2019.08.05.23.01.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 23:01:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v2 0/5] x86: KVM: svm: get rid of hardcoded instructions lengths
Date:   Tue,  6 Aug 2019 08:01:45 +0200
Message-Id: <20190806060150.32360-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Clear interrupt shadow in x86_emulate_instruction() instead of SVM's
  skip_emulated_instruction() to generalize the fix [Sean Christopherson]

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
  x86: KVM: clear interrupt shadow on EMULTYPE_SKIP
  x86: KVM: add xsetbv to the emulator
  x86: KVM: svm: remove hardcoded instruction length from intercepts

 arch/x86/include/asm/kvm_emulate.h |  3 ++-
 arch/x86/kvm/emulate.c             | 23 ++++++++++++++++++++++-
 arch/x86/kvm/svm.c                 | 19 +++++--------------
 arch/x86/kvm/x86.c                 |  7 +++++++
 4 files changed, 36 insertions(+), 16 deletions(-)

-- 
2.20.1

