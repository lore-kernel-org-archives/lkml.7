Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D66AC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FA2215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355135;
	bh=yd/2s7NgD5N/H4tCXDGVVAgmUhkj7AtVXMSL9P/ctck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ec7VUO4CijtyR34OB/hC5kBDjXhPSMqf01HLNDbkczD5hZaOnTu1yviH8Nfj2E/N0
	 HZe8ZQGMnveVm5/6ZekuxNdgfsccC9qoQQCpOHAKVefI1hyLSRDkT9eM2NeC0gbLfb
	 ikJkn34rj1W9IZv3ZSEiEiKmtNAF7OewFmXduLxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfKJCqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:46:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbfKJCqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:46:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5809F2085B;
        Sun, 10 Nov 2019 02:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353968;
        bh=yd/2s7NgD5N/H4tCXDGVVAgmUhkj7AtVXMSL9P/ctck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLo+7FU5KSHjF2/4vfa2EImOP+gR3NUxgn6KkezdbSMoVkUzpykfZ42y090ObMvBp
         7F46CbwP2upAvhF46h6pdbAuiSwWK4HHTK8mI+4ZmQK72vLzFiiZjjAsmOdHMMAChG
         N7W0iBcZihpoDdLBiVqVyyPCi8qzuvAcS2Q/FA0o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 016/109] libfdt: Ensure INT_MAX is defined in libfdt_env.h
Date:   Sat,  9 Nov 2019 21:44:08 -0500
Message-Id: <20191110024541.31567-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 53dd9dce6979bc54d64a3a09a2fb20187a025be7 ]

The next update of libfdt has a new dependency on INT_MAX. Update the
instances of libfdt_env.h in the kernel to either include the necessary
header with the definition or define it locally.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/compressed/libfdt_env.h | 2 ++
 arch/powerpc/boot/libfdt_env.h        | 2 ++
 include/linux/libfdt_env.h            | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
index 07437816e0986..b36c0289a308e 100644
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ b/arch/arm/boot/compressed/libfdt_env.h
@@ -6,6 +6,8 @@
 #include <linux/string.h>
 #include <asm/byteorder.h>
 
+#define INT_MAX			((int)(~0U>>1))
+
 typedef __be16 fdt16_t;
 typedef __be32 fdt32_t;
 typedef __be64 fdt64_t;
diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
index f52c31b1f48fa..39155d3b2cefa 100644
--- a/arch/powerpc/boot/libfdt_env.h
+++ b/arch/powerpc/boot/libfdt_env.h
@@ -5,6 +5,8 @@
 #include <types.h>
 #include <string.h>
 
+#define INT_MAX			((int)(~0U>>1))
+
 #include "of.h"
 
 typedef u32 uint32_t;
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index 14997285e53d3..1aa707ab19bbf 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -2,6 +2,7 @@
 #ifndef _LIBFDT_ENV_H
 #define _LIBFDT_ENV_H
 
+#include <linux/kernel.h>	/* For INT_MAX */
 #include <linux/string.h>
 
 #include <asm/byteorder.h>
-- 
2.20.1

