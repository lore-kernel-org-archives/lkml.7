Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9162C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E7D20848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8Q1U7LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfLBUNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:13:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50255 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727586AbfLBUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575317599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AAoHzUyrY/MGtK6MVYph2Nv7coxAjaKdNzJNELfvGio=;
        b=a8Q1U7LRpENNlb+aihmSrlojSMhX09IVYal4tzqBr/RNiQZW0xJIcahMsM+Ac4WKaIlEOG
        NEDnf4ZhzVQr6ySy9gOV3yM9w6aDLVmgJIlGCsTpvzho2WGWLp1pLVFM3MfDeotnyWTsqI
        0/JNZnBRrKMEZHqPM91Q/JdSenl96zI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-wvZf-B1xOLS-L0ZZOtYqPQ-1; Mon, 02 Dec 2019 15:13:17 -0500
Received: by mail-qk1-f197.google.com with SMTP id a6so498215qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MeEk0ij29n0kTPi4OJez+UYNwIiLUI6R5zpd+TNY67M=;
        b=YQHfahz0E9KvJ8t/JbuC8ghmyKnqo8Oj159GQTfU+4PjzHQXsCH0JWJxsloxiFd9A1
         WtjnzYhN0MCkaszak7U/3fyLX3EM1G1hJW8+DMrBMeui7tG90ro9NE90zC/uKRrl67RE
         0dfLoHO2JW+RfrAimceLDQflFXdGCjeLyeXtfU5BCc8H/DuSq8DMpeVKW0gSxvsNXfb/
         C8t0BOi5IMKsA3vfgKxlhhtuQkkNnpFBDbtpAp02hVwjazpViriG/P5jCsf84+XjP8dz
         nt6ceY9cvvjH5CLJvaw8TtRGCzo2lsdA/6JRxI4OIEwH8azBOOM9cp2lV3aHMXzleg0o
         Ju5A==
X-Gm-Message-State: APjAAAX8CHs87VawSksi869sFMhK1Lx8myMnOWfPmIAFxd3rB2IBIFpI
        yr/FXQnZZPbswN2AuOOkgl4YrTm93pIVBR6LvIrCOuWI3h84ghCpN8tYQ7N4dbOAmTLZuKsFM+U
        2TlIHL0++YbU/cnjP2DyIngm+
X-Received: by 2002:ac8:607:: with SMTP id d7mr1330144qth.186.1575317596607;
        Mon, 02 Dec 2019 12:13:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEDymFkNuWxzKe4cUT0lCYk0JjSaaXOL4ga2ZDAhsswgDBqGmNFtJsj4EG2GiyhikKxlMgHA==
X-Received: by 2002:ac8:607:: with SMTP id d7mr1330123qth.186.1575317596342;
        Mon, 02 Dec 2019 12:13:16 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id b6sm342410qtp.5.2019.12.02.12.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:13:15 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 0/5] KVM: X86: Cleanups on dest_mode and headers
Date:   Mon,  2 Dec 2019 15:13:09 -0500
Message-Id: <20191202201314.543-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: wvZf-B1xOLS-L0ZZOtYqPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- address all the comments from both Vitaly and Sean
- since at it, added patches:
  "KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand"
  "KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK"

Each patch explains itself.

Please have a look, thanks.

Peter Xu (5):
  KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand
  KVM: X86: Move irrelevant declarations out of ioapic.h
  KVM: X86: Use APIC_DEST_* macros properly in kvm_lapic_irq.dest_mode
  KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK
  KVM: X86: Fix callers of kvm_apic_match_dest() to use correct macros

 arch/x86/include/asm/kvm_host.h |  5 +++++
 arch/x86/kvm/hyperv.c           |  1 +
 arch/x86/kvm/ioapic.c           | 19 ++++++++++++-------
 arch/x86/kvm/ioapic.h           |  6 ------
 arch/x86/kvm/irq.h              |  3 +++
 arch/x86/kvm/irq_comm.c         | 10 ++++++----
 arch/x86/kvm/lapic.c            |  5 +----
 arch/x86/kvm/lapic.h            |  7 ++++---
 arch/x86/kvm/svm.c              |  4 ++--
 arch/x86/kvm/x86.c              |  2 +-
 10 files changed, 35 insertions(+), 27 deletions(-)

--=20
2.21.0

