Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6432C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC7B21873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9wxZJxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfGZGLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:11:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43155 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGZGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:11:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so17352498pld.10;
        Thu, 25 Jul 2019 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=teO2U84Y0voCyxdSkIrBITdgvhHGO6vzIDrKZreXFsk=;
        b=D9wxZJxn3sd0HpyPeGr+R+wMT5IHozXCoc52u14dK2VN/AeMaLlxCvC890zNu/Ys0u
         1C2BfkFREdN7TWp9Wjr5lQAZQ9Ep7jGbb8Gk6o2vf/ExbsJhhlj9L+TrcrapVquVG6uP
         +NiMwpTYINUy+AuU272Vzs/A1K4z8IR4ezd/9Mu9fpFefRYEsE696h2Cy/3zlYbm0MSb
         Ao7qAwtEHlmiJb0u+8WP/he/qx7L/pKoyE8Bi3j9QBT1w4xrw2R7L7yxmulKBalJH/J5
         jMV+beRk9nubwGuGullwc+M1Bd5TB+Q2pMT1u1TH7v/Q2DZ2P51ne0s3ycBHiIEGXR0o
         yEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=teO2U84Y0voCyxdSkIrBITdgvhHGO6vzIDrKZreXFsk=;
        b=ITlYa+FMAdSWtZ0xpDsZ8eOBDY3TxQq5pMWtjLMZhYYi8w5xraetMf0ohGFPMmoKdB
         YykOmg2+C2iE4XcqvZavaFCBrvuwoGGcreMrb4NM2r5avWEYCvdgiOTQXOX0d1Rdiw+F
         8IDwqXZr2tpAix0j7Q9IRvQec9g+Ntz3JiPus1/LyZi15kat2JM006qrYd6OdnqCrCr9
         TXK8lqJG6MCaNJHoAPFw5IErF8z+vFZmP/BfCRVE20uyvwoKOFfjZlPMXxK3ZMHe6UQd
         TnhRPs1gAA/OTm0vMsY/Lw7joDIz39izsb7UJIcyZotg6z5Xy/kn9ukdlSQh+aCOfHiQ
         ODiQ==
X-Gm-Message-State: APjAAAWW68QpkAy4Rs21mMcXcqL1Xh/t1EK5v5VhPc2zj2Qq8TVtujDN
        HOCJjIVkLHE/fvsDpw8ApdaFpUsVZXU=
X-Google-Smtp-Source: APXvYqzTjlzElXLdO+TnRFzyYoBzBq5jrZA6yXs8fpf0wME10+b4JHuMBHDo+EbmndrCM4fGgXgdig==
X-Received: by 2002:a17:902:70cc:: with SMTP id l12mr53193007plt.87.1564121467067;
        Thu, 25 Jul 2019 23:11:07 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id i6sm54622455pgi.40.2019.07.25.23.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 23:11:06 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH RESEND 1/2] KVM: LAPIC: Add pv ipi tracepoint
Date:   Fri, 26 Jul 2019 14:11:02 +0800
Message-Id: <1564121463-29448-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Add pv ipi tracepoint.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c |  2 ++
 arch/x86/kvm/trace.h | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 42da7eb..403ae3f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -562,6 +562,8 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 	irq.level = (icr & APIC_INT_ASSERT) != 0;
 	irq.trig_mode = icr & APIC_INT_LEVELTRIG;
 
+	trace_kvm_pv_send_ipi(irq.vector, min, ipi_bitmap_low, ipi_bitmap_high);
+
 	if (icr & APIC_DEST_MASK)
 		return -KVM_EINVAL;
 	if (icr & APIC_SHORT_MASK)
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index b5c831e..ce6ee34 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1462,6 +1462,31 @@ TRACE_EVENT(kvm_hv_send_ipi_ex,
 		  __entry->vector, __entry->format,
 		  __entry->valid_bank_mask)
 );
+
+/*
+ * Tracepoints for kvm_pv_send_ipi.
+ */
+TRACE_EVENT(kvm_pv_send_ipi,
+	TP_PROTO(u32 vector, u32 min, unsigned long ipi_bitmap_low, unsigned long ipi_bitmap_high),
+	TP_ARGS(vector, min, ipi_bitmap_low, ipi_bitmap_high),
+
+	TP_STRUCT__entry(
+		__field(u32, vector)
+		__field(u32, min)
+		__field(unsigned long, ipi_bitmap_low)
+		__field(unsigned long, ipi_bitmap_high)
+	),
+
+	TP_fast_assign(
+		__entry->vector = vector;
+		__entry->min = min;
+		__entry->ipi_bitmap_low = ipi_bitmap_low;
+		__entry->ipi_bitmap_high = ipi_bitmap_high;
+	),
+
+	TP_printk("vector %d min 0x%x ipi_bitmap_low 0x%lx ipi_bitmap_high 0x%lx",
+		  __entry->vector, __entry->min, __entry->ipi_bitmap_low, __entry->ipi_bitmap_high)
+);
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.7.4

