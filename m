Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAAFC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4858C218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239276;
	bh=J0uk805EP9l5Ca02BBLotKgTkavHTiUxv4DsCvLcthw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hPp36xDQNozG2PqzVWqPsrqhKO0S9BcISxEVuT159ZpDc0+MWVcelMULRcBvGYD4S
	 I/wpCXI9QlNU+/oCReqdXrclahs3me5m8zBmrwMyYrxjOU5Nt4KW70q/7RzH4VFn/d
	 fwkpESJo3OuvS7EZlzs1TQCNsivETieknEm+4zCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbfKHSyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732994AbfKHSyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:54:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064382178F;
        Fri,  8 Nov 2019 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239272;
        bh=J0uk805EP9l5Ca02BBLotKgTkavHTiUxv4DsCvLcthw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtLRhT1HVd1hZ/Zwx8teLi3qje+Swhhsmjzmfvktj+XfigWjyQMK+aLiGgglOa6F8
         fn2xbBOIYDBD2P17OXbyD5on+sJSImUkc11K0hL7Pz7H2S5gTHMIxoWw/GNuQHmB8x
         Zbj3FjOd224mFqzhCz0FvfY4ZAFm8XpC2ifb9KJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, Ard Biesheuvel" 
        <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 58/75] ARM: spectre-v1: mitigate user accesses
Date:   Fri,  8 Nov 2019 19:50:15 +0100
Message-Id: <20191108174759.863122443@linuxfoundation.org>
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

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit a3c0f84765bb429ba0fd23de1c57b5e1591c9389 upstream.

Spectre variant 1 attacks are about this sequence of pseudo-code:

	index = load(user-manipulated pointer);
	access(base + index * stride);

In order for the cache side-channel to work, the access() must me made
to memory which userspace can detect whether cache lines have been
loaded.  On 32-bit ARM, this must be either user accessible memory, or
a kernel mapping of that same user accessible memory.

The problem occurs when the load() speculatively loads privileged data,
and the subsequent access() is made to user accessible memory.

Any load() which makes use of a user-maniplated pointer is a potential
problem if the data it has loaded is used in a subsequent access.  This
also applies for the access() if the data loaded by that access is used
by a subsequent access.

Harden the get_user() accessors against Spectre attacks by forcing out
of bounds addresses to a NULL pointer.  This prevents get_user() being
used as the load() step above.  As a side effect, put_user() will also
be affected even though it isn't implicated.

Also harden copy_from_user() by redoing the bounds check within the
arm_copy_from_user() code, and NULLing the pointer if out of bounds.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/assembler.h |    4 ++++
 arch/arm/lib/copy_from_user.S    |    9 +++++++++
 2 files changed, 13 insertions(+)

--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -454,6 +454,10 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	adds	\tmp, \addr, #\size - 1
 	sbcccs	\tmp, \tmp, \limit
 	bcs	\bad
+#ifdef CONFIG_CPU_SPECTRE
+	movcs	\addr, #0
+	csdb
+#endif
 #endif
 	.endm
 
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -90,6 +90,15 @@
 	.text
 
 ENTRY(arm_copy_from_user)
+#ifdef CONFIG_CPU_SPECTRE
+	get_thread_info r3
+	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	adds	ip, r1, r2	@ ip=addr+size
+	sub	r3, r3, #1	@ addr_limit - 1
+	cmpcc	ip, r3		@ if (addr+size > addr_limit - 1)
+	movcs	r1, #0		@ addr = NULL
+	csdb
+#endif
 
 #include "copy_template.S"
 


