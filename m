Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE01CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978D0222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSG0XzUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbfJRQLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:22 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45760 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502568AbfJRQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:20 -0400
Received: by mail-pg1-f202.google.com with SMTP id v10so4587377pge.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fICIDxFYsM9a9Ff5jMCA2HNdKL4X15DyG8HPfHVUdX4=;
        b=NSG0XzUqxk2+63gPHHlONBw5Q4nS2y744Eo1rGIDmimGan5ZvchrFconEmIXiVv79S
         0SiQYCOcKQncsgO+OjD18O6E+2SSMSAk43T8F4SPII5CwYW5Z2DpjcXEvu90lABe0T7d
         54pDxZVczkH9+W6UKw5BGz/1SAtjmaCTeJP9IigFW7/8iSrzVXwx+vaItOIgEL2NFpn8
         PCwsy3taMFVH2Is9tZDbWuOIcT/YBmZIupi5pgO/dSJwAnrHQ+9LRhx/mZ3aQl1rS+Hn
         PYSAfr/54k98LWSAkxuS0/kkDyQ70rjvHFcfVRO0CwmtYXN/ED4JgjMIrSHGnZhfeFY/
         nwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fICIDxFYsM9a9Ff5jMCA2HNdKL4X15DyG8HPfHVUdX4=;
        b=H5LCf2d2tljOcvrheMPApmwb9z5+XGKfhBo3Jh3Q6vyaqJwxgtAgt0gosf7idjjDm7
         YYqcA2wJ1UXjUS7zlNtlNYs2tQmlCHSQ/RKZKBAJZoMnprP+MO98rh1Gf5QlgBgUsurD
         CTD4ErHSJsdSKrSSixBHmJZI04XAYHtlMO7WgW71Yy3RPCF5wI+7mnSnQhzbjEhCBxSN
         tspeoB8ErdjLQJnldxn+WUV39/toYDid309qD3tUizE3RIz+zKDLrbhcKKJqHJC++6de
         oB5x1ccnts3jRwbfUZceaFgFYWCdhKiODwmPYdSIt5QDngKd98YsG0eedxQ1bbeDzhVF
         z/hg==
X-Gm-Message-State: APjAAAVq2lsazAPmtW4xP24Ep10cIiv2s6EBe9l58NFg2AOEA9CqyA/B
        7zaTJg+bj8RF2cmIHxo4d7vjbvBnYmv8o44BxUU=
X-Google-Smtp-Source: APXvYqy2IPmHgVzSQFLWH/l27Qtv31FYTpjwXUbB8shECHuqpnU1nIwwQdz+u4oVI6rxTnp6d2Le2ZcdmFuior/slJo=
X-Received: by 2002:a65:6092:: with SMTP id t18mr11012516pgu.418.1571415077997;
 Fri, 18 Oct 2019 09:11:17 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:26 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 11/18] kprobes: disable kretprobes with SCS
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

With CONFIG_KRETPROBES, function return addresses are modified to
redirect control flow to kretprobe_trampoline. This is incompatible with
return address protection.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a222adda8130..4646e3b34925 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -171,7 +171,7 @@ config ARCH_USE_BUILTIN_BSWAP
 
 config KRETPROBES
 	def_bool y
-	depends on KPROBES && HAVE_KRETPROBES
+	depends on KPROBES && HAVE_KRETPROBES && ROP_PROTECTION_NONE
 
 config USER_RETURN_NOTIFIER
 	bool
-- 
2.23.0.866.gb869b98d4c-goog

