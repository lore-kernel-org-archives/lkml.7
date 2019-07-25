Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE5CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C78B229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404311AbfGYLtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:49:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55080 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404287AbfGYLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:49:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so44674107wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 04:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwF4mpEiRa45bRWmG8LAm7NBwIkhh6yBccP7Pl5vh7Y=;
        b=OsxibBRVeLF5S63Z+2hpzhEo4QAgjGnPxTy7dfvwwS+O363tx5CjyM8IIV7kGNpGuq
         HArZFB5tDITVD5MZRfIIeCzU9rpw2p3yISqdqxa84AOfx86/tLstsLZbp8ExTQtODeaM
         rGwLfK2STdJM6AewJJFfMhIguamFzKbdSiDwVJhgUGp13UskufjWXpFrYwihk/aeNVZe
         6gytZbuqUq7qKocXTIGusrHoR2++rvdJWBGEvHaiRqrsMkiYlxoaP5CBDsg6AFnlFRX3
         9pDYV744mmsMPrDOg6+hXOx/VVO0lKPKizCBhoJd054qrypGzC5DNexcyFyxFCfGrHC5
         ap2Q==
X-Gm-Message-State: APjAAAUaEiEmPaOXk+tsCV5ISC93Oh8zpXoIUPWN7lvEBRXyYbu5UARe
        Gv41DV83b4fmX5QSufJzQJV2iu/i6Qs=
X-Google-Smtp-Source: APXvYqwHIAbuNzKH1sv37RyUICk9i11ATcpmEGDJP3UlsUFfAdbUyofZsSomxQmloUcfikdX/fDG7Q==
X-Received: by 2002:a05:600c:2245:: with SMTP id a5mr79165913wmm.121.1564055380779;
        Thu, 25 Jul 2019 04:49:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t140sm44784683wmt.0.2019.07.25.04.49.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:49:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH stable-5.1 0/3] KVM: x86: FPU and nested VMX guest reset fixes
Date:   Thu, 25 Jul 2019 13:49:35 +0200
Message-Id: <20190725114938.3976-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few patches were recently marked for stable@ but commits are not
backportable as-is and require a few tweaks. Here is 5.1 stable backport.

[PATCH2 of the series applies as-is, I have it here for completeness]

Jan Kiszka (1):
  KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested

Paolo Bonzini (2):
  KVM: nVMX: do not use dangling shadow VMCS after guest reset
  Revert "kvm: x86: Use task structs fpu field for user"

 arch/x86/include/asm/kvm_host.h |  7 ++++---
 arch/x86/kvm/vmx/nested.c       | 10 +++++++++-
 arch/x86/kvm/x86.c              |  4 ++--
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.20.1

