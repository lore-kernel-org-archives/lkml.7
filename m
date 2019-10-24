Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F156DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45D621929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7CmDroH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfJXWwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:13 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51811 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbfJXWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:11 -0400
Received: by mail-qk1-f202.google.com with SMTP id h4so347748qkd.18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mYL9Vajfp90RBhmOr5x+royOTK5ijTSQrnKKnKdSwP8=;
        b=h7CmDroHNc2GUxa+g8sWKLD1CcV9gP1uFZesaZzVHnU2a/VBAGDrWFnqCRU+m5Vbxp
         eaGC73Zpw9RZWybSnsktpUOkuEDcpbZIwlHpDgN79dPEQKA6imXqfphOHV6fZIX1vhay
         UCpiNG3JtiEVtrMytjk/nHqhnqy0gmdjuwm2NOkx0ncwhVH/+Zpkk8+VEcnFqvyBPvs2
         m5wks6dUtk7GMFS4ou0w6XEB2b6UOzqqnC4RoG6rt3wfmnkP2N6JtRALXiO9ySr4Fq8U
         CorUFaTzeYq9F1zwhAtdXHWC+48gHjKj20BQ918yQIZSbJoZWQzd8WGDJiFqjX+ZtINR
         p1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mYL9Vajfp90RBhmOr5x+royOTK5ijTSQrnKKnKdSwP8=;
        b=KqFAaLOmgmlsDjjvIAqk+kd8HhCNcVVxPYxqjKMlq2tlpwsMWSxhChz1KDYm7THFOM
         VhCnedBQ6o+39RUKqBi7VuCCiy7ULh/oNl+oAyb36OVWKUXQop3KRoM8ylaaaCvvJass
         MpXlv7PmAHi1ENFo7ACsqFlsbcezNfRt3tUbH9q9WY7eIw/AU3MbvQTvuSbo4eyviuVk
         vcD4h0VGzU6BbpbhuSxefxOHSQKGctV49cQm/2IBnL0twNFjuwJwCFHl5oveuy4Uc9Jl
         mnRvESdzvMgNZB9zTzFdoc12S3Ee9/gKlxojHblgnKM7Vwcp7+xrZ7mAq/GJBl++MZmK
         zP9A==
X-Gm-Message-State: APjAAAUCafAK/UUngXTjGr5uyFkuKPNFw75LVBkZFclFQs0uvoRlZpvp
        AHsd5661Rs0yH/P0cp3/ldFB7YJjNF4r71kJMOo=
X-Google-Smtp-Source: APXvYqyjPZYDLgJTlGq99OGbhTAPtQvVAb9tamVCQRwQTsZBBJQIlLhZeafbs0GYaiDEFKiGX8NWZ+1DbuMz+1REocU=
X-Received: by 2002:ae9:e885:: with SMTP id a127mr114159qkg.427.1571957529972;
 Thu, 24 Oct 2019 15:52:09 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:24 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 09/17] arm64: disable function graph tracing with SCS
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_FUNCTION_GRAPH_TRACER, function return addresses are
modified in ftrace_graph_caller and prepare_ftrace_return to redirect
control flow to ftrace_return_to_handler. This is incompatible with
SCS.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3f047afb982c..8cda176dad9a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -148,7 +148,7 @@ config ARM64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER if !SHADOW_CALL_STACK
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
-- 
2.24.0.rc0.303.g954a862665-goog

