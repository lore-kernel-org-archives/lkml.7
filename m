Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9B92176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3zxl2u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfK2Qck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:32:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726934AbfK2Qcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575045158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9V/qFvH8waqtXVKvhRpmWCEM/9qP0sAeZeU83cy8EOE=;
        b=S3zxl2u7OacaWD/m2W8RQhJXmuV7EEVAXmBkH1S0n6gH8kJ9uvTgHmcndmLjMmW3JyauZd
        1TBa23TcFcqyVJG7mC9fSjtzrf+2Db/rcALIvQLjsPL0jPYLel7+BgF6m2iJcqVXta1DID
        c3GMlboYEGwjR9W9Zk/tGeyVeGbP2/Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-H30r759ON5yFFUksOxzvpg-1; Fri, 29 Nov 2019 11:32:37 -0500
Received: by mail-qv1-f70.google.com with SMTP id w5so19222067qvp.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 08:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5iCofYmIjfyUSG8vHZf7wpoJnDoheL6AALy8kyz1tx8=;
        b=ZCAky/WJnCYVy+psjKXeohcuJ7iN/BwHAU2MvtStTE38CuVxiNtGGpYnxnq3AtCyTV
         gLd2v/ZDpkpR4hlCl66bSgl6P+WlCjXq3ska9jGbNFovYEfyKNjGI0R6rpiUz8HhC/tq
         gvwR3RmcdvtoM32dDL+B/aaBVpiwx5FR797uVFSaYTG0QZ4cK0xHIBRt5QJhPVIvsHrU
         h7eltGKYSWMLNY/r8B3sJinUupE0nRD/dHrOZSHg2WbtOZLSbVrRIYJDmUX85CXUw/eh
         mUltFI8kltIAMV2k16tlClHrbuMTYhVcV7JLPTqM270S1pOacihd+p+U/YCMRwJ4b7WH
         AEiQ==
X-Gm-Message-State: APjAAAUAkjWJ6QAYai7Ud+xKWnvk5uA6s6T9eyF16sScDHf+T6H7Nvat
        cOtqeAcUKFmAkdsv7pttJVekisF60TLFG9pus/k65oZTLfbOU86m0JPPvyr3vQUsVv0ggZ+k0Vs
        OwV4DdU4y5+/DVWL2NlpHWB3V
X-Received: by 2002:a05:620a:2f1:: with SMTP id a17mr9045637qko.252.1575045156580;
        Fri, 29 Nov 2019 08:32:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwt6klFGFPdiFCxtdNXCaWr4i8+5EKri2pR8sDM3UzAXUglAuAkDeGNQx+NxQAmWUnSI1w0ew==
X-Received: by 2002:a05:620a:2f1:: with SMTP id a17mr9045611qko.252.1575045156321;
        Fri, 29 Nov 2019 08:32:36 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id d9sm4568329qtj.52.2019.11.29.08.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 08:32:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2 0/3] KVM: X86: Cleanups on dest_mode and headers
Date:   Fri, 29 Nov 2019 11:32:31 -0500
Message-Id: <20191129163234.18902-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: H30r759ON5yFFUksOxzvpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each patch explains itself.

Please have a look, thanks.

Peter Xu (3):
  KVM: X86: Some cleanups in ioapic.h/lapic.h
  KVM: X86: Use APIC_DEST_* macros properly
  KVM: X86: Fixup kvm_apic_match_dest() dest_mode parameter

 arch/x86/kvm/ioapic.c   | 9 ++++++---
 arch/x86/kvm/ioapic.h   | 6 ------
 arch/x86/kvm/irq_comm.c | 7 ++++---
 arch/x86/kvm/lapic.c    | 5 +++--
 arch/x86/kvm/lapic.h    | 7 +++++--
 arch/x86/kvm/x86.c      | 2 +-
 6 files changed, 19 insertions(+), 17 deletions(-)

--=20
2.21.0

