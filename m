Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EED3C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744602173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOXWFSPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLKUsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:48:19 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36767 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLKUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:48:18 -0500
Received: by mail-pf1-f201.google.com with SMTP id 6so1269610pfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2gC640IyhH5dA8WbV5f5/xeewX2HczJxP4vBYhavCEY=;
        b=QOXWFSPQYjnuJDMP0a4El8Kh5ujIbG0XtwVP1iVHds8uiUZsbjpHgG5WPdWl96GsCo
         q7mpMlt3B9pzVIYZHTKFtDCCu4Cvr0XBTzrrkwca0VvGL/x98Agf/uml2HXIsWn03J/l
         WoO+n1BkNjMXj+5AkWjhI5FAQqE+nZbr7cOSbOohyp/aWnmAVnsqkkfHpvoi7r8vgBUH
         sH301tcL19NGm1CgMJX76L3AFHahIWAjDQj43FZ32PTFZktgX/o2GS8BxEahhUYaBGVK
         7rzzv81Tk+0hZarU6nZi777LGxgGHFMLeu7JUR5JgFrTckNSQF4iBL6hi9nBElJsQ6iE
         /HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2gC640IyhH5dA8WbV5f5/xeewX2HczJxP4vBYhavCEY=;
        b=MLRy3Tma0mA82o8nNCUMPtEQZVNIO6GwGz5Mdruo/aAiQqVuHIpASNUG1PBYF594L6
         AKoIOmW8Ig8B0uUiq8Kt8Qij1ySX7ruEeDrp8UjgJSYRY2d4OUD/0QwCqrrB8lKSxC1a
         SO6pONqybZYvozTJFRsw6dEfGYSwJ25MXZRuDPwgRFsEyeoNErFuwb1hFgc6n+t1YLiS
         +eaEKem9Veui33XX1pWtfIQunXV9yCdtMGWkOihDQcbihJupl2GcC8oxFYlfPLK+syBV
         /x+3XWkVoiZZB16QQODx0Suybw6Ud2Wz0ENMPKI4jd2YYcCE2XyCar6JdWUYSZxCkOPM
         Awvw==
X-Gm-Message-State: APjAAAWOJgoOXe1/NRtEiXscQIRS/W2U0jYh3J3mixZ6LyAJaa49ffUH
        cDiNEOcffVxwVREsIYfqXKRkbJE8zxz5
X-Google-Smtp-Source: APXvYqwOL7uivEwokJX5aYM9537r8vrIEKgGR7nmvHWO9lF7B4kYZsHBsBQwsuUkGzh4uQRzcSr4YlBVlX8t
X-Received: by 2002:a63:c804:: with SMTP id z4mr6386725pgg.440.1576097297767;
 Wed, 11 Dec 2019 12:48:17 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:47:40 -0800
Message-Id: <20191211204753.242298-1-pomonis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v2 00/13] KVM: x86: Extend Spectre-v1 mitigation
From:   Marios Pomonis <pomonis@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        Marios Pomonis <pomonis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Finco <nifi@google.com>

This extends the Spectre-v1 mitigation introduced in
commit 75f139aaf896 ("KVM: x86: Add memory barrier on vmcs field lookup")
and commit 085331dfc6bb ("x86/kvm: Update spectre-v1 mitigation") in light
of the Spectre-v1/L1TF combination described here:
https://xenbits.xen.org/xsa/advisory-289.html

As reported in the link, an attacker can use the cache-load part of a
Spectre-v1 gadget to bring memory into the L1 cache, then use L1TF to
leak the loaded memory. Note that this attack is not fully mitigated by
core scheduling; firstly when "kvm-intel.vmentry_l1d_flush" is not set
to "always", an attacker could use L1TF on the same thread that loaded the
memory values in the cache on paths that do not flush the L1 cache on
VMEntry. Otherwise, an attacker could perform this attack using a
collusion of two sibling hyperthreads: one that loads memory values in
the cache during VMExit handling and another that performs L1TF to leak
them.

This patch uses array_index_nospec() to prevent index computations from
causing speculative loads into the L1 cache. These cases involve a
bounds check followed by a memory read using the index; this is more
common than the full Spectre-v1 pattern. In some cases, the index
computation can be eliminated entirely by small amounts of refactoring.

Marios Pomonis (13):
  KVM: x86: Protect x86_decode_insn from Spectre-v1/L1TF attacks
  KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data() from
    Spectre-v1/L1TF attacks
  KVM: x86: Refactor picdev_write() to prevent Spectre-v1/L1TF attacks
  KVM: x86: Protect ioapic_read_indirect() from Spectre-v1/L1TF attacks
  KVM: x86: Protect ioapic_write_indirect() from Spectre-v1/L1TF attacks
  KVM: x86: Protect kvm_lapic_reg_write() from Spectre-v1/L1TF attacks
  KVM: x86: Protect MSR-based index computations in
    fixed_msr_to_seg_unit()
  KVM: x86: Protect MSR-based index computations in pmu.h
  KVM: x86: Protect MSR-based index computations from Spectre-v1/L1TF
    attacks in x86.c
  KVM: x86: Protect memory accesses from Spectre-v1/L1TF attacks in
    x86.c
  KVM: x86: Protect exit_reason from being used in Spectre-v1/L1TF
    attacks
  KVM: x86: Protect DR-based index computations from Spectre-v1/L1TF
    attacks
  KVM: x86: Protect pmu_intel.c from Spectre-v1/L1TF attacks

 arch/x86/kvm/emulate.c       | 11 ++++--
 arch/x86/kvm/hyperv.c        | 10 +++--
 arch/x86/kvm/i8259.c         |  6 ++-
 arch/x86/kvm/ioapic.c        | 15 +++++---
 arch/x86/kvm/lapic.c         | 13 +++++--
 arch/x86/kvm/mtrr.c          |  8 +++-
 arch/x86/kvm/pmu.h           | 18 +++++++--
 arch/x86/kvm/vmx/pmu_intel.c | 24 ++++++++----
 arch/x86/kvm/vmx/vmx.c       | 71 +++++++++++++++++++++---------------
 arch/x86/kvm/x86.c           | 18 +++++++--
 10 files changed, 129 insertions(+), 65 deletions(-)

-- 
2.24.0.393.g34dc348eaf-goog

