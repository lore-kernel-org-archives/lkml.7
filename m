Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6931C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EB62054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTNM2Yjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfLKUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:48:48 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42850 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfLKUsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:48:46 -0500
Received: by mail-pl1-f202.google.com with SMTP id b3so45903plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V8+gZI//oIJHuoz/ZeRsxsnZlGzWnWp3v3uXjbH3p+g=;
        b=WTNM2YjpCbOyYnBe9GT6fAZ1ArYu0wM3PiT+MJmFZGX6j+F8TohfOS2bKnExtHAhss
         Z0wWHPuiV3y0OHS+dzvFjIkhQBtl1jgYtgD+DMaDO64qu8xjHXWzYMz4u9laBgReuh1q
         6FiksdGos2cOH213T7Ezyyj/rlbw0DhKdpcWx+xlBMbrt4dvbrBiorj/i5uN+T2lyNe+
         YgNVLqGfUYzq9yAyJZGTVdfcAlLrxXJlQekcwwL1MiTS8UNXE3NTCW+DhItBkqUXhFkV
         U5RE/C/rX/Y87x45223li/KA2CtK5BJnjzm3QQ0yxHr6zlrue4tb4lQc0XP1sRmWZtNW
         nwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V8+gZI//oIJHuoz/ZeRsxsnZlGzWnWp3v3uXjbH3p+g=;
        b=PBh4+wD3VxobUJuR9+rG/xClJChnTo40ytgWAIe8130aecjqkm/bw9/cr2fIAm2QMN
         D1DaTzIpIkk9G4hnZje4s0u65qB+s1K+BGTX8I5HM/K+AbxZ+IKTTW9a5mGq3cNNhTZB
         HStss5q8Z7RtWFg4YJ8sIW98J0swSVmMDcd0IIf5qYaoyXe7YGPmRcT/BBgqcW2NqsCZ
         aT+qZHWgjRv4gScp81WQPASwI7ar/fxAPJGftuaHMoo0th2ih166u6JaKUr7DhGnT5pd
         MiTRfWIzA7HqVT+3pmNM5gQKD99NaarnR6epIhbR9mRyh3xahIDUcWC9nqKAxFxFu5m2
         +QSQ==
X-Gm-Message-State: APjAAAWnIBkYiDLMwwh5VMC84KK892DMVEL1+z+cGnxUST9jwqjzs7Bz
        HHpGjlHDn7nTqBE8P+ka3Ud3Bw2ypDzv
X-Google-Smtp-Source: APXvYqxM2bhaZfdgEAP320RojcgymxqaM2uW7VBYzwsTTen8mf2FPyZN6CH3k6mxVBkkuLCmC/7U7+ulQ3cX
X-Received: by 2002:a63:e608:: with SMTP id g8mr6182692pgh.448.1576097325332;
 Wed, 11 Dec 2019 12:48:45 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:47:45 -0800
In-Reply-To: <20191211204753.242298-1-pomonis@google.com>
Message-Id: <20191211204753.242298-6-pomonis@google.com>
Mime-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v2 05/13] KVM: x86: Protect ioapic_write_indirect() from
 Spectre-v1/L1TF attacks
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
        Marios Pomonis <pomonis@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a Spectre-v1/L1TF vulnerability in ioapic_write_indirect().
This function contains index computations based on the
(attacker-controlled) IOREGSEL register.

This patch depends on patch
"KVM: x86: Protect ioapic_read_indirect() from Spectre-v1/L1TF attacks".

Fixes: commit 70f93dae32ac ("KVM: Use temporary variable to shorten lines.")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kvm/ioapic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 0c672eefaabe..8aa58727045e 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -294,6 +294,7 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
 
 		if (index >= IOAPIC_NUM_PINS)
 			return;
+		index = array_index_nospec(index, IOAPIC_NUM_PINS);
 		e = &ioapic->redirtbl[index];
 		mask_before = e->fields.mask;
 		/* Preserve read-only fields */
-- 
2.24.0.525.g8f36a354ae-goog

