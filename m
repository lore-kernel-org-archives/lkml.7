Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE31C28D18
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E476D20717
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXLkVxE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFFFbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:31:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFFFbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:31:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so657142pgv.10;
        Wed, 05 Jun 2019 22:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M575u1eEZiHgk8vf92wKCesexTtETUM7ILi53nI5aSw=;
        b=tXLkVxE75I/Dg6A5M1s3iC1S+UNHngqctctCTLnOpxu04C9k2gDC0npfpoB5CcZMjl
         ei+y145DdJi3QC0PBVBavH4+wSEyT8zYzoyOiWcpmvXFArudqX0ye/ch7rjzgOsXkVvM
         g6qPuHwwa6a2qyNQuWLi9PNPG533RbwMaaQVDOMfVZ99SYc+rl2DmESu1tFK3vzXp/8m
         3272vo5++i3d7EoKmN47MoN9pcDdQlfBhm7u+CF+JokYCeeJlJ5BAEXVQPSzeVlfbRBb
         dPTwpLzrQfHFpnv/n6tDAdUPdAz7LbhSv3VLANQSxvSy82kT81F1HcoNk/dCfjyN+Nf/
         dlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M575u1eEZiHgk8vf92wKCesexTtETUM7ILi53nI5aSw=;
        b=GaI7n1tBLW7PA0WIndeRtsS7iEFgk181XXUTEN4iw67n/moYP1y0iQgnFvr3RHAvWI
         otFMuR9u+c3o+4HQbR4ZfVciqPL4XY4P0ocPViacGHqVTFGVKnN2QBYbfBzlGPBoeA4h
         MoVMnjMzWhLUm7ARksw/vtuPRN5XbHQGPY36Tx+60cNbWm2ls9ILf2w0NLWcVInUdjTI
         6vM762eaGIIXyYojXorpfITGXwuHfqZxefWo29R/fQ9tfUYiS0YlaMo/faLqBBNRdtBK
         K5KcvhL/TPCY2NJKSZrs5QplAnYhY9z2WatdgX1VLrPMQ8LPSuw44GDPxRa2wHQOQufh
         7m5A==
X-Gm-Message-State: APjAAAUQhzYY61mM9ecswy1zG9hXjuEPH2kcUtIhAB/VrLvyV6dHLlVg
        dtYwlZzQT5HBsmJe30co7HPR6JIf
X-Google-Smtp-Source: APXvYqw5pCfWWq2g3n2NXM5I+Vuv+PvV176R/aGOGPxgJ1qjKkoihkZ9ARH0UkaGBcF9d2wRRTQ8vw==
X-Received: by 2002:aa7:8b0b:: with SMTP id f11mr52405509pfd.142.1559799098021;
        Wed, 05 Jun 2019 22:31:38 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id f11sm721547pjg.1.2019.06.05.22.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 22:31:37 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 3/3] KVM: LAPIC: Ignore timer migration when lapic timer is injected by posted-interrupt
Date:   Thu,  6 Jun 2019 13:31:26 +0800
Message-Id: <1559799086-13912-4-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559799086-13912-1-git-send-email-wanpengli@tencent.com>
References: <1559799086-13912-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

When lapic timer is injected by posted-interrupt, the emulated timer is
offload to the housekeeping cpu. The timer interrupt will be delivered
properly, no need to migrate timer.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index c08e5a8..a3e4ca8 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2532,7 +2532,8 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
 {
 	struct hrtimer *timer;
 
-	if (!lapic_in_kernel(vcpu))
+	if (!lapic_in_kernel(vcpu) ||
+		posted_interrupt_inject_timer_enabled(vcpu))
 		return;
 
 	timer = &vcpu->arch.apic->lapic_timer.timer;
-- 
2.7.4

