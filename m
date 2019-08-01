Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BB0C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98F520B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAXWVqyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfHADad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:30:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43331 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfHADac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:30:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so24486838pld.10;
        Wed, 31 Jul 2019 20:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jyl7Q+fNfa4JowIqcItEgbQqxdMDKkuTAtedoCYt2UY=;
        b=eAXWVqyoPQAaeEe6yu4toJk8mRWTJbseagq1nJrw5sMhs4P6uYhFHtTyz9abUsIyoS
         +1C/gPQOtsY7wYSHqJh6/+ymKVJE4dU2mLklv1+z0EcvlqUsabQxa2dC/07UFd5rkjB+
         NipenViZYX+QQxoq1tupXA5esLfuQbOJ9ZLtSoQbYzv8FEDeg3rtPin9IdyRsrAk+BHy
         qyfBu1pt24TVdvdMkEkAmntraEWxmdLbOayTVvpv53g+CWQK4N6Dcs6jIYJc+mKzyGTK
         6uSe/ztCqWFn2JSf7r/tgWwMWlOJrrhMXt7E6bdKMUcOP4E7O9k8nicGVpJ5UvPINXHe
         0GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jyl7Q+fNfa4JowIqcItEgbQqxdMDKkuTAtedoCYt2UY=;
        b=JPb+6uJML5KU7PharXJUB7CV05abq21qXnsxK/Krmi/NAYaTqWdaI+3BiHB5E818Rt
         c6CIvFfdHfAld6e7rPZ3dfDhTuF9V77JuK+aJpH4Y7beuKixsH0tUrwBjfPKSd8czGYl
         cIGR6z+S4Q1OGKoar3EmhvHqF8Fyo15IyFO71jTxHLUvsROaY8JM5SNG+SLGneoT0R0l
         9+lEewoLjKxwHmc7uqG9nnpjAdGB4GJD8XGtyChMRrPc4l6y6hJmdUW49HDdzl507Rqa
         8r8qrr0oE8AQIj8nlsNLULSNSwjyX76bN0DBrvzxxNiAmjspbyWssKuVRRWgAs8nfP4A
         r4dg==
X-Gm-Message-State: APjAAAULMVeeaRw/Fftu8liHJ3GUK580LsfQECOS2Axs4zz2lvvXZFyr
        Qij1dSrphmKEqmj57KWkz0Qu6PJY0DM=
X-Google-Smtp-Source: APXvYqziS4FRketT79XtL+Ydj0CSV86miadJPbR5wvvXJFppRqj2P83ew5kcYd1GUN55v04+6eLV4w==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr69055281plk.99.1564630231290;
        Wed, 31 Jul 2019 20:30:31 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id d14sm86158055pfo.154.2019.07.31.20.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 20:30:30 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v3 2/3] KVM: LAPIC: Don't need to wakeup vCPU twice afer timer fire
Date:   Thu,  1 Aug 2019 11:30:13 +0800
Message-Id: <1564630214-28442-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564630214-28442-1-git-send-email-wanpengli@tencent.com>
References: <1564630214-28442-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

kvm_set_pending_timer() will take care to wake up the sleeping vCPU which
has pending timer, don't need to check this in apic_timer_expired() again.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0aa1586..685d17c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1548,7 +1548,6 @@ static void kvm_apic_inject_pending_timer_irqs(struct kvm_lapic *apic)
 static void apic_timer_expired(struct kvm_lapic *apic)
 {
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	struct swait_queue_head *q = &vcpu->wq;
 	struct kvm_timer *ktimer = &apic->lapic_timer;
 
 	if (atomic_read(&apic->lapic_timer.pending))
@@ -1566,13 +1565,6 @@ static void apic_timer_expired(struct kvm_lapic *apic)
 
 	atomic_inc(&apic->lapic_timer.pending);
 	kvm_set_pending_timer(vcpu);
-
-	/*
-	 * For x86, the atomic_inc() is serialized, thus
-	 * using swait_active() is safe.
-	 */
-	if (swait_active(q))
-		swake_up_one(q);
 }
 
 static void start_sw_tscdeadline(struct kvm_lapic *apic)
-- 
2.7.4

