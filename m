Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F2EC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E0320866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSTLds/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfFNC7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:59:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46547 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfFNC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:59:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so635525pgr.13;
        Thu, 13 Jun 2019 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DyBxcguYr0pwpEA8xS0kQBgyqMMk8fvfBxMPOX56hn4=;
        b=DSTLds/txoUxikicIxk+jfatAZ00LsbrrYlHf84ZuDRVrDCmIpKEfeqvv86Q1AIdsq
         lqvNt9+50ZRdjJdo71qYg/DMVOXQ/BFWWOpNsiXs3oTh6JpnzeGs+0lAafUT2td/x0/N
         SpKEZiwmZLt2pJBl0DKRRXo8SJBeCKRHsrN6PYf/lZjqWHosb4ca1+HDIPTT1Bz2wKfL
         5jqgut1Ai65s9HvDwVHdE/xODUiQCSBfWQXlvf37w+oiy85av3c8VyOJeGE/aZN0ppay
         DHHiYsbdlAZeudIBec1hVdNaL5sgCkJZb0KqSNdAvQQIH/U6rAHztznpVA8z5OmaZV9x
         CxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DyBxcguYr0pwpEA8xS0kQBgyqMMk8fvfBxMPOX56hn4=;
        b=nM2nIboDahc6Xx06854Io8lV0W26ipKy/u2/yDDxRuGzOKdQspo7vP/hD2GNhmKknv
         6c2ljMfM+k/fT/16iVpB+a4CK4Nr2dALf6QnWoZH6NuSJWLA45HkjorHv8TIjRHHybDW
         FmR8SbVwJV4KWWShgEjxEQO4En0S5JJub5upBRyBNynaKb/p2GBj7jJ738wXiGsNTMm/
         0nCOuPoM6Pc9CY9t+yvrtgkesfUIxx839pWdKDTp0SucHjF3NmK67GsLO0G/qUICZqnX
         cTgLMN4Qd+LxF4Qs6G+oEWMQogVUMwZKX81YumqFnlZnbvRZqnBPZfm+y/crT8Gj0JdY
         h2Iw==
X-Gm-Message-State: APjAAAVDkM1RBGmvrDt0zuqovoKTOlGKPnCmPVxBYdj8o64J6ZFykPq9
        hiXt10FX05AmPG8ydojKOYh33p5M
X-Google-Smtp-Source: APXvYqxrzBOrrex6Zoyo5EefrUU1+d4fKYIriMstlsBiwbRJ/sVc+YWrkgnxy6eAX9OWatQGJLeMHw==
X-Received: by 2002:a63:8449:: with SMTP id k70mr34549119pgd.208.1560481182361;
        Thu, 13 Jun 2019 19:59:42 -0700 (PDT)
Received: from localhost.localdomain ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l21sm1051079pff.40.2019.06.13.19.59.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 19:59:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@Broadcom.com, ard.biesheuvel@linaro.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: Allow user selection of ARM64_MODULE_PLTS
Date:   Thu, 13 Jun 2019 19:59:32 -0700
Message-Id: <20190614025932.533-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make ARM64_MODULE_PLTS a selectable Kconfig symbol, since some people
might have very big modules spilling out of the dedicated module area
into vmalloc. Help text is copied from the ARM 32-bit counterpart.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/Kconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..36befe987b73 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1418,8 +1418,20 @@ config ARM64_SVE
 	  KVM in the same kernel image.
 
 config ARM64_MODULE_PLTS
-	bool
+	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	select HAVE_MOD_ARCH_SPECIFIC
+	help
+	  Allocate PLTs when loading modules so that jumps and calls whose
+	  targets are too far away for their relative offsets to be encoded
+	  in the instructions themselves can be bounced via veneers in the
+	  module's PLT. This allows modules to be allocated in the generic
+	  vmalloc area after the dedicated module memory area has been
+	  exhausted. The modules will use slightly more memory, but after
+	  rounding up to page size, the actual memory footprint is usually
+	  the same.
+
+	  Disabling this is usually safe for small single-platform
+	  configurations. If unsure, say y.
 
 config ARM64_PSEUDO_NMI
 	bool "Support for NMI-like interrupts"
-- 
2.17.1

