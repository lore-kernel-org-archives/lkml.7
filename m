Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09167CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD68421D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7xenBDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442986AbfJRQLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:37 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44226 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436621AbfJRQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:35 -0400
Received: by mail-pf1-f202.google.com with SMTP id b204so4972871pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5u5MugUg2eXeQck5Unb3LYQo29vaVROeFk+dSkSebHA=;
        b=B7xenBDHHI7ayNn+BP1Q6X8wnTR9uTlyid2Lxqej61gj2k9iN/wuKOJNKBobLxaFjR
         hT53He9gZ81WBRA7k1srlE5y9pRls5zgdJRc8CkufohNb7pDylEtWxFwrE2uoJHPqVMe
         SXZ+LI2gVL3V+ZFsZVGAp19D4zWSpAGia2X5kfETCOjg6mYUy8e3oO5INhcW9tdCJs3Z
         R+qaaFeh57hjiYMhdf3zjE/30gJ8GCvzwq1j+lgdEDaXxK/SXne8U2YrUzyBDK25HLGv
         sScwvilKx4tvHpfuXY9/27TdPb7wP+y5Fbv94C3Elzkmapg0qVwLdFfipvrL/n4U5zdf
         mmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5u5MugUg2eXeQck5Unb3LYQo29vaVROeFk+dSkSebHA=;
        b=OgajzZz4mz0Kw1oyWFDR+krKJMkV/RnmCc68SKoPgB6ymsz1LfR+DeET0AmIshv0yV
         2+ZhDPyR7xIjX6GrQsok+ffzuMLJiuNocTkCH3cS5sdvZxaFHhVZEkbKCeOPxZ9CSOaP
         Qr9JakpRYjYvTgtlYozufCKXT5xNO3KPuzJaDP14niP4uGFhxFbeHwHMYYnhTBTNAU2V
         5IPqOiADDkHPsEI/hroyGIB26/Djuj4a2SaGOfzoK25ukNoH07GO0/AgCD/zCPN7/AS0
         Lcq5tuyVbdvHVW+GAx7dPL5z2cU/HlQy0QMT9gtHyHJrSvwDXYYZbnVRvrlvWDLM4DzO
         5vFg==
X-Gm-Message-State: APjAAAVuqFF9Xbj8Fc92T2+cfSeU9VI8yc/DyeLXeCi8ijc7paL/XEMd
        E4iFHGzmdOIgInKp/VV3P29IX2gLQVaU48yO62U=
X-Google-Smtp-Source: APXvYqzL1rNkHTnWVT3YklNHjYJF0z1ethJHe5MAlJ9H7HUMSZwkLdmWhiBEeQet4XLN4HbPHGGrf5qLcex/d/OTBLw=
X-Received: by 2002:a63:541e:: with SMTP id i30mr10990238pgb.130.1571415092950;
 Fri, 18 Oct 2019 09:11:32 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:32 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 17/18] arm64: disable SCS for hypervisor code
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index ea710f674cb6..96073d81cb3b 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -4,7 +4,8 @@
 #
 
 ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
-		$(DISABLE_STACKLEAK_PLUGIN)
+		$(DISABLE_STACKLEAK_PLUGIN) \
+		$(DISABLE_SCS)
 
 KVM=../../../../virt/kvm
 
-- 
2.23.0.866.gb869b98d4c-goog

