Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E091BC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D7922CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619917;
	bh=pTbEKI2NeT8O2v0+l8eAcK9osEbWPeItOXW2CZb+5E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWGljSCplI4TylPGzy/woi/bE9JNkUrWlHroGoROXFS6mu+sVHfU1t9xozGaQq8du
	 2qTZYD9O+Hb4CTQ77MVg60I6kvBeA8iV1r7m5KrWVkRGZFWu4sdotyyYcSy4giZJaQ
	 RdEatS3GgQR+R+xH2R5FIVs28gBXIpSMfgE5OJRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbfIDR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388074AbfIDR6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:58:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E3821883;
        Wed,  4 Sep 2019 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619913;
        bh=pTbEKI2NeT8O2v0+l8eAcK9osEbWPeItOXW2CZb+5E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8+9/UV+ZZYN6psxsr7YsWKbkEiQWRdc4FMHCv49332h0o1FX6DGZdQ3X5PBWYFSf
         NL1HACthJ2+A22rAmEtDZZmdJQsOvBZD5p8g+IH/AMveviafuZbNN7aMyVQ+0M+M+i
         Mmqpc0Z4X58PLnbhuNXaQynASt7AnmDUNaijDcmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bandan Das <bsd@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.4 63/77] x86/apic: Include the LDR when clearing out APIC registers
Date:   Wed,  4 Sep 2019 19:53:50 +0200
Message-Id: <20190904175309.263911224@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.317468926@linuxfoundation.org>
References: <20190904175303.317468926@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bandan Das <bsd@redhat.com>

commit 558682b5291937a70748d36fd9ba757fb25b99ae upstream.

Although APIC initialization will typically clear out the LDR before
setting it, the APIC cleanup code should reset the LDR.

This was discovered with a 32-bit KVM guest jumping into a kdump
kernel. The stale bits in the LDR triggered a bug in the KVM APIC
implementation which caused the destination mapping for VCPUs to be
corrupted.

Note that this isn't intended to paper over the KVM APIC bug. The kernel
has to clear the LDR when resetting the APIC registers except when X2APIC
is enabled.

This lacks a Fixes tag because missing to clear LDR goes way back into pre
git history.

[ tglx: Made x2apic_enabled a function call as required ]

Signed-off-by: Bandan Das <bsd@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190826101513.5080-3-bsd@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/apic.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1031,6 +1031,10 @@ void clear_local_APIC(void)
 	apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
 	v = apic_read(APIC_LVT1);
 	apic_write(APIC_LVT1, v | APIC_LVT_MASKED);
+	if (!x2apic_enabled()) {
+		v = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+		apic_write(APIC_LDR, v);
+	}
 	if (maxlvt >= 4) {
 		v = apic_read(APIC_LVTPC);
 		apic_write(APIC_LVTPC, v | APIC_LVT_MASKED);


