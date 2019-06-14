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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AA221473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewW5LVea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfFNS4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:56:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39975 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfFNS4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:56:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so2036104pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kXP6RPbHGxfRHVxshgv418nQMeWFco7bVcG4pxVfdpQ=;
        b=ewW5LVea+JWpRTTQ9Ymq3AhgxtbQ02f34SkC+QSETwdm4+z6yDcvz+zb+e0XxLfrlH
         14a+LuJ+uQL6WLE3nJU72MnrO1/XDgBmc4Xjj5Qml4Jvt6XHo4fMXryaUxQsO+ndf3xk
         2Dz/MV3d6/785nd+1ntM1AhyRXUL6ROs9IyJ7UWlRhOyw+hGnBYS1HsAlvouFDMp1gQq
         qQjH4cuPS7biMshImT86hR1h8o4PqFiBxBDFhu5ClJ70OtUZ/6GDxs9poQK4JP21SwvF
         4YarnjI0rvrp/WkRIT84R3TYrtRYJcoTivp3QGWXAyeCpIPNZ7Iqft45mL7SMo69WNtn
         PghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kXP6RPbHGxfRHVxshgv418nQMeWFco7bVcG4pxVfdpQ=;
        b=Y0J9hCOa4RD+KZrnbS2KsDzcnWAAeQ5NNJSx9+4/LCF8xBUG27F+71IomHYKjRU/Yl
         dNtWLE4gkNnSNrDBgvDhzOuaUTfze1SQ7ZHr1AM1k8kjIKQ5iaI3S0Du58U1PsG72mTV
         HcxVFmCRn4mm3+SslRwTdheU5+s28oJJmzNj4/EZSgCFu/PWlMtu4H1RZyr6habTY3q4
         +LBsA92zSdmvCsCow+zXih9Rz/nXFUj/n6mVdJwpfurr06BHXT0l1ZnReLCogGjEX6CG
         CEyseDjlYgLCeeLzt/tcrgvLxWdze9qtDTEmtpuTtXQHx6PsMqeIfPjPRx6t2T8W5aUM
         FQJQ==
X-Gm-Message-State: APjAAAUCOxsuY5rbvwSe/DnqUdeFvx+212wNHAzMckhSdzG3uOSScSzw
        LZL6u0GD+V8MDkqK85QxHtA=
X-Google-Smtp-Source: APXvYqx70/CMTi+44qQfPlpiZj6yXBUe3eSw9DeC4HVnXisOv4Q2JZU9DYQc9Ym0dnZJizUCFkJ2gQ==
X-Received: by 2002:a63:f95d:: with SMTP id q29mr30978918pgk.368.1560538605919;
        Fri, 14 Jun 2019 11:56:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r9sm3466072pgv.24.2019.06.14.11.56.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:56:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ard.biesheuvel@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] arm64: Allow user selection of ARM64_MODULE_PLTS
Date:   Fri, 14 Jun 2019 11:56:34 -0700
Message-Id: <20190614185635.6982-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make ARM64_MODULE_PLTS a selectable Kconfig symbol, since some people
might have very big modules spilling out of the dedicated module area
into vmalloc. Help text is copied from the ARM 32-bit counterpart and
modified to a mention of KASLR and specific ARM errata workaround(s).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- added Ard's paragraph about KASLR
- added a paragraph about specific workarounds also requiring
  ARM64_MODULE_PLTS

 arch/arm64/Kconfig | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..7bfaeeeee9bc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1418,8 +1418,28 @@ config ARM64_SVE
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
+	  When running with address space randomization (KASLR), the module
+	  region itself may be too far away for ordinary relative jumps and
+	  calls, and so in that case, module PLTs are required and cannot be
+	  disabled.
+
+	  Specific errata workaround(s) might also force module PLTs to be
+	  enabled (ARM64_ERRATUM_843419).
+
+	  Disabling this is usually safe for small single-platform
+	  configurations. If unsure, say y.
 
 config ARM64_PSEUDO_NMI
 	bool "Support for NMI-like interrupts"
-- 
2.17.1

