Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EFBC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9CE2067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573241042;
	bh=BklGw2CHk0rhA5E7/1cYkeaiRWPgm4YdmDA/LT6GVH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ekwYqbubiXKwAfg0VBhV388mde6UfIJb60UXtON8hz65HBW5ir4SNH9ZSmvY5rsjN
	 WREMr22rSY8qXv0Zh34C6dnlfVlsuCa8zQBeWozalcS9lrWw99czbRbA4bfwTdM8GC
	 bJK5qjfVusuEinA/t1/tTzTeQBGvR/Ye9ggbG59k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389950AbfKHTYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732258AbfKHSxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:53:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBD0218AE;
        Fri,  8 Nov 2019 18:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239199;
        bh=BklGw2CHk0rhA5E7/1cYkeaiRWPgm4YdmDA/LT6GVH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+OVtS0NF4D8rr5dZDM1Zj3FRU2NymJ+eWbce0Y3zKzL9Tt1lsJOzEhDwJW4n0O+4
         mSX/o6Flm4gUVgwOtU7zwiXhYYyj0S7Gq++nogGII4s6RAAqjVA2kORt0VTIbS6Qtk
         RgH5eqa7pUZgrY1JGF+dYWc6sN+rRUEiATeJWwjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.4 32/75] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
Date:   Fri,  8 Nov 2019 19:49:49 +0100
Message-Id: <20191108174741.407382517@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit 6167ec5c9145cdf493722dfd80a5d48bafc4a18a upstream.

A new feature of SMCCC 1.1 is that it offers firmware-based CPU
workarounds. In particular, SMCCC_ARCH_WORKAROUND_1 provides
BP hardening for CVE-2017-5715.

If the host has some mitigation for this issue, report that
we deal with it using SMCCC_ARCH_WORKAROUND_1, as we apply the
host workaround on every guest exit.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: account for files moved to virt/ upstream]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ardb: restrict to include/linux/arm-smccc.h]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/arm-smccc.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -70,6 +70,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 1)
 
+#define ARM_SMCCC_ARCH_WORKAROUND_1					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0x8000)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>


