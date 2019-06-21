Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E55C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CE221530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okEQYw/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFUI6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:58:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46806 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFUI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:58:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so5712027wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFfPvkWjkkrjWmIO9mwmRCrRTqpdUG3kSxHSiTlM+a8=;
        b=okEQYw/yOdLIiBcSL/MJhiUQ4KzzI4k0KswWUFAIRv4nTaOJl+uXH52wlUTTU7zJn6
         LFF93u/LnNl5csBdDYw5HuXsXzVb/Zryc3h99C/Rt6y4KO2k00VXji4RoU4EsdwhiRm9
         gvN5zgYdlZdLzFwBkF3MwQmSNGpWbdBew/jEu9MYaREdqB5z0h2tnl1UPM0E3BDrk3hy
         cysbQKPnrhSlU5Gmqe+sp0zVpzmpdo6nsivWnpGK8zmvkmLWIVvl1cCh7FdhNpnvjMG0
         /79YPwylaRi6XEGsbLsNbALUa0JTCzOGJ4hmpB/yzjMKaG7oi6jjtmCmGxl3dePP31h5
         3BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yFfPvkWjkkrjWmIO9mwmRCrRTqpdUG3kSxHSiTlM+a8=;
        b=rVFixYzsVlZ2YgPtqekfIkP+hImToBznYg7Klu9P1jnz3GloGxI2Qmp+/avBPL2rat
         lddaF9qi5Ul6vBBs9ALLoLA9IvofFB9piUSqN557Esu5ns2olwBdNK7Ov4O1KcKRmP6S
         M8Cl9DxQ7ZpEmRRpcioIFDN7vcL8rxSWU2crHEvW23siymfo+woHlRRiJMSCDxKdEQcf
         UxmePDFm0ZfrSPzLD5zq7N3P6n1Zb5JQxTgStpPI7OCMeQk92bASgsYPyOMHpuDadSAL
         VvRDsRWbWrn0f+9VfX9k83HyvDn+JyA1v45FBRfBywZDOkUjt6nAXNlbaH4ejdiyCtoA
         dK9A==
X-Gm-Message-State: APjAAAU9HyW3+amtRQxKVyjLzbfBlKA7k3X0o5holqm9RJ+b/PfmZHr4
        uFi0+LqJZKdZnZ7pcufdXPM=
X-Google-Smtp-Source: APXvYqwu3QJoLLix0JPme99XociPLUyVBqqIaJQwLHO3pMm10WMLt1XDSZpTcbpXbWyCXEyg7cJ/YA==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr1576725wru.49.1561107530600;
        Fri, 21 Jun 2019 01:58:50 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id z5sm2059189wrh.16.2019.06.21.01.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 01:58:50 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 047AA11459C9; Fri, 21 Jun 2019 10:58:49 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/lib/xor_vmx: Relax frame size for clang
Date:   Fri, 21 Jun 2019 10:58:22 +0200
Message-Id: <20190621085822.1527-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang-8 the frame size limit is hit:

  ../arch/powerpc/lib/xor_vmx.c:119:6: error: stack frame size of 1200 bytes in function '__xor_altivec_5' [-Werror,-Wframe-larger-than=]

Follow the same approach as commit 9c87156cce5a ("powerpc/xmon: Relax
frame size for clang") until a proper fix is implemented upstream in
clang and relax requirement for clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/563
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/lib/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index c55f9c27bf79..b3f7d64caaf0 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -58,5 +58,9 @@ obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
 CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+ifdef CONFIG_CC_IS_CLANG
+# See https://github.com/ClangBuiltLinux/linux/issues/563
+CFLAGS_xor_vmx.o += -Wframe-larger-than=4096
+endif
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
-- 
2.20.1

