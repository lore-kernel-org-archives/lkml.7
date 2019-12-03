Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F1BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B036920866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGGXHtKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfLCQ7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:59:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726785AbfLCQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575392347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9idJJsQV/2uEwKnGkN4mjfcfOqrJXpGQnakfdpkG6DI=;
        b=cGGXHtKA+seDsh6eU6dLZin/AyVSU9ZyJkvkuwD93zh3Nhk5uQmXhnxsBvhdNkuT0efJki
        oaIDNaqaWpwt/C0XP9TvPOHjV5K+VmBBcfAyEYwTQG/h14wDW773pDTfRGb4an5tO43iqO
        W9cui3U8Zyfpk+gzZmtbij0k1cVc6XA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-u8BARG33ME-VHI_o5KcYsA-1; Tue, 03 Dec 2019 11:59:06 -0500
Received: by mail-qt1-f198.google.com with SMTP id z7so2832995qto.23
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ki0zcq1Hd91HT74Xqb0k5NM023hUsBT8hpjru9BF2VU=;
        b=RyxThn1bVkb3pXc3Zgv+PytKNSIJc0/e4I3fcPspP/6ISgjtoDNt/Rt2M+p9HUCVb3
         Comzfy6En9y4pgPFGisRFgmXtbsksqDe4Wq/8iyQBgo3h+iwrSCkIry4OYNF1N9eJJXx
         DUYpt0ybHVHhRCPIjfP5lBcuu6FuZnJTcct22jd6EAbcO0s/qn/ltOwJDetsBv4ymwvb
         vJJY193DUi9sqeNVt+s2PmDKhY8oDzFaVfxi+9GKwQn8w201q51z2FaaszyFJ8N0eVQY
         Ug+LYt+O9XMsF22gXFDjoSr1JUeDlp9fHc6wGn2mbPn/51UjtOoO57k2pRgoK0aXttmW
         4ezQ==
X-Gm-Message-State: APjAAAWVBh+zyFjerxsnDuMOnfYWjyLy6JdbzptdCuRX/iML1Mu9PnMl
        hruj/I27qu/FU020zcaiyqvtCrbmeCdduafRmuA4WbKJTX2N9mv0QiF/iusdN/Q6B2xbSeneRbM
        yoHG/TEJdD1FAQFPKoDA6z+Lz
X-Received: by 2002:ac8:1017:: with SMTP id z23mr5922475qti.154.1575392345724;
        Tue, 03 Dec 2019 08:59:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJfsAGRsZ+YvZuBbG3sFkoCk1FF9Ev5phxgEhOfqT73zztJ/7/gzPmD1aFE0Ca9XawO46P9Q==
X-Received: by 2002:ac8:1017:: with SMTP id z23mr5922449qti.154.1575392345471;
        Tue, 03 Dec 2019 08:59:05 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a16sm482585qkn.48.2019.12.03.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:59:04 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 0/6] KVM: X86: Cleanups on dest_mode and headers
Date:   Tue,  3 Dec 2019 11:58:57 -0500
Message-Id: <20191203165903.22917-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: u8BARG33ME-VHI_o5KcYsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- address all comments from Vitaly, adding r-bs properly
- added one more trivial patch:
  "KVM: X86: Conert the last users of "shorthand =3D 0" to use macros"

v3:
- address all the comments from both Vitaly and Sean
- since at it, added patches:
  "KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand"
  "KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK"

Each patch explains itself.

Please have a look, thanks.

Peter Xu (6):
  KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand
  KVM: X86: Move irrelevant declarations out of ioapic.h
  KVM: X86: Use APIC_DEST_* macros properly in kvm_lapic_irq.dest_mode
  KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK
  KVM: X86: Fix callers of kvm_apic_match_dest() to use correct macros
  KVM: X86: Conert the last users of "shorthand =3D 0" to use macros

 arch/x86/include/asm/kvm_host.h |  5 +++++
 arch/x86/kvm/hyperv.c           |  1 +
 arch/x86/kvm/ioapic.c           | 24 +++++++++++++++---------
 arch/x86/kvm/ioapic.h           |  6 ------
 arch/x86/kvm/irq.h              |  3 +++
 arch/x86/kvm/irq_comm.c         | 12 +++++++-----
 arch/x86/kvm/lapic.c            |  5 +----
 arch/x86/kvm/lapic.h            |  7 ++++---
 arch/x86/kvm/svm.c              |  4 ++--
 arch/x86/kvm/x86.c              |  4 ++--
 10 files changed, 40 insertions(+), 31 deletions(-)

--=20
2.21.0

