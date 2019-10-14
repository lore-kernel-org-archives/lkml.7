Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5363C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 02:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9492083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 02:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAHcZpcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfJNCv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 22:51:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46216 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbfJNCv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 22:51:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id k25so12526927oiw.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 19:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ELg5bkMi+FoappyTCFIUx1Rg8zAW2tMRA+teB43Z1gY=;
        b=DAHcZpcHRxIEH+BjxCNkrpahqtOtpNE8Wov9Ku5GbbLrWCYS6wZZY8TxY5xsTvnRcI
         cx/tv3jnL40q4qAna6T/lHY6gVi2sQk9AMYAbtRLOt5DOGVB8MDmRowbngBngLe11bHw
         /W3qsCzLy6Q5QynUELtKB6qPYh4pb3q2CS7qxjMfjBbr+Swzlgc9B7GtkNilk3l/rIrG
         CxPEjXn8sulp19LAonhdDj+koKA2aU0diP1aofLiHm7E7SZqb/sbIiAn4xY29E7fVKWP
         6xnU+o2lELxjR137GkPGzDjV3Uwef9cz96XbN9OUWi8VAZrm2GCQrCRjkd2h99eFgc5h
         Cs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELg5bkMi+FoappyTCFIUx1Rg8zAW2tMRA+teB43Z1gY=;
        b=KNfPDNHfnTMCLRUkrusOkQSedp4oU9XsF5Xx9a5LJg6Gdhaz+fovY2ppTQs4SfI1WT
         nq8cOsSkCn9yeVVP3CLG8/zBNz2a9WOGpE0nAmcLyIpTZa1ur/lS9l+n41i/2ArmE/47
         DKOfMxXYb3o65PB7CVKBCIegFcAcjsM/xWIENak1ZQlGPVdOyckoNVxxKsWLoEc3CJ/r
         Ykfi3TwVZsxDg0UxLmHfFdP3X+I6XjSyrqaMUkyudiHDs22wt1MWzJr04LtoAlKqqOW8
         GtwIM9sWgPed/Qdzcy8hcnKSCEiu6nL1SDsf9kuJOSkTOn+bbee0wL9Z2LyoGfAOylv0
         BfAg==
X-Gm-Message-State: APjAAAWOffPhOSTQjckv1b5afUx+HIJnAYbiJ6XE6PCZGCdAkONfMInQ
        988TY191xOEJKDzOUQvs4Uo=
X-Google-Smtp-Source: APXvYqxidzN5tutwxdHg98hmZURUZDkArUJX8YnsN19/vfIrWs3pMFVf3dOO84FGEF13ujyo5Vsozg==
X-Received: by 2002:a54:418c:: with SMTP id 12mr22608906oiy.154.1571021484434;
        Sun, 13 Oct 2019 19:51:24 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 11sm5612491otg.62.2019.10.13.19.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 19:51:23 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v4 3/3] powerpc/prom_init: Use -ffreestanding to avoid a reference to bcmp
Date:   Sun, 13 Oct 2019 19:51:01 -0700
Message-Id: <20191014025101.18567-4-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014025101.18567-1-natechancellor@gmail.com>
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20191014025101.18567-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r374662 gives LLVM the ability to convert certain loops into a reference
to bcmp as an optimization; this breaks prom_init_check.sh:

  CALL    arch/powerpc/kernel/prom_init_check.sh
Error: External symbol 'bcmp' referenced from prom_init.c
make[2]: *** [arch/powerpc/kernel/Makefile:196: prom_init_check] Error 1

bcmp is defined in lib/string.c as a wrapper for memcmp so this could be
added to the whitelist. However, commit 450e7dd4001f ("powerpc/prom_init:
don't use string functions from lib/") copied memcmp as prom_memcmp to
avoid KASAN instrumentation so having bcmp be resolved to regular memcmp
would break that assumption. Furthermore, because the compiler is the
one that inserted bcmp, we cannot provide something like prom_bcmp.

To prevent LLVM from being clever with optimizations like this, use
-ffreestanding to tell LLVM we are not hosted so it is not free to make
transformations like this.

Link: https://github.com/ClangBuiltLinux/linux/issues/647
Link: https://github.com/llvm/llvm-project/commit/76cdcf25b883751d83402baea6316772aa73865c
Reviewed-by: Nick Desaulneris <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v3:

* New patch in the series

v3 -> v4:

* Rebase on v5.4-rc3.

* Add Nick's reviewed-by tag.

* Update the LLVM commit reference to the latest applied version (r374662)
  as it was originally committed as r370454, reverted in r370788, and
  reapplied as r374662.

 arch/powerpc/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f1f362146135..7f0ee465dfb6 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -21,7 +21,7 @@ CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
-CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
+CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector) -ffreestanding
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-- 
2.23.0

