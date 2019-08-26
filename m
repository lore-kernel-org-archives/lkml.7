Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4148CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2046A21872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfHZKP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfHZKPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:15:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C4EA30821AE;
        Mon, 26 Aug 2019 10:15:51 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA630608C1;
        Mon, 26 Aug 2019 10:15:50 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] x86/apic: include the LDR when clearing out apic registers
Date:   Mon, 26 Aug 2019 06:15:13 -0400
Message-Id: <20190826101513.5080-3-bsd@redhat.com>
In-Reply-To: <20190826101513.5080-1-bsd@redhat.com>
References: <20190826101513.5080-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 26 Aug 2019 10:15:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although apic initialization will typically clear out the LDR before
setting it, the apic cleanup code should reset the LDR.

This was discovered with a 32 bit kvm guest loading the kdump kernel.
Stale bits in the LDR exposed a bug in the kvm lapic code that creates
logical destination maps for vcpus. If multiple bits are set, kvm
could potentially overwrite a valid logical destination with an
invalid one.

Note that this fix isn't intended to paper over the kvm lapic bug;
clear_local_APIC() should correctly clear out any set bits in the LDR
when resetting apic registers.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 arch/x86/kernel/apic/apic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index aa5495d0f478..e75f3782b915 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1179,6 +1179,10 @@ void clear_local_APIC(void)
 	apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
 	v = apic_read(APIC_LVT1);
 	apic_write(APIC_LVT1, v | APIC_LVT_MASKED);
+	if (!x2apic_enabled) {
+		v = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+		apic_write(APIC_LDR, v);
+	}
 	if (maxlvt >= 4) {
 		v = apic_read(APIC_LVTPC);
 		apic_write(APIC_LVTPC, v | APIC_LVT_MASKED);
-- 
2.20.1

