Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9BDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1656021A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnquzFop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfJXWwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:50 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49174 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbfJXWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:37 -0400
Received: by mail-pf1-f202.google.com with SMTP id r187so322986pfc.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1o2AK/x7KnetiIYq4sD6lyk+Z1PFoM7PTIwarlqCwx8=;
        b=KnquzFopxhgUh+yJfoei8gVVx1UFevR3Wi9RJ0Dct5s/wjoLo0UIULHJ52iyDlFB6P
         94/Io21URIBdRGDxFS0tbpT8pf9wFw8CXp+hb35OeyzhyhJZzuNbeeXwAhpUtwNbkNqL
         edchxQirUe1MwQD/Bh4qSgXOeqnChy0v7mDVdemPsERGoJorUBOTSCiz1vXHX3iTQXqK
         L/AQoYVVPSbkYTN+kSNfz4S5Cfd9VFTM/5mH+ilYFDv/qrO8wemOh+JMQ//CnpweWdoe
         mgXlVK8nsRV8k399Qz5bXX+5b7BlTlHNqA1J8uDhWD+EG7ALlgdLoLxjV63C4rvVMaoN
         Kpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1o2AK/x7KnetiIYq4sD6lyk+Z1PFoM7PTIwarlqCwx8=;
        b=gI0RnjbPKCHThLwOTK3kvdSyraGBK/fJ2MQvil9fUsf9TazTwOXxwqDh+GkNhxi8Uz
         0qiwV4jWWrW/UHuhbO9oYNZRYl24VMo7TQcT8LqYtvyaWkvr29AbuVqSoNvh0J5q1YCX
         od6wqfDaBKEKO17O8SlmRttCaTtiaocREv9Ho9y6MeHcyiEYIKZuT1/FbK1YFxppi0uA
         7YBxBTb33sBNy3FeqW7fWV0T9pKzqPSpnFrMmFhIkX0PWHnckpatxvk/0cvKnRwyBi2a
         LkPlw2qP2HtlIRz/M+GkqSs3wBU2peDcyqHKTesES77qruf9GqeF/agGnBusCl64ZSwq
         7C7w==
X-Gm-Message-State: APjAAAXY5+YTnhR9evu0CaMG5lXEtaaJ4/2rJXCrFw7rdfvx1YSm4DzH
        qES2yaRDS6GtaSd4qVVRSLIq+YVsEkdeD8tciGY=
X-Google-Smtp-Source: APXvYqxqUYVuoLyhOB6Va7uYpgm1rgX3n1dq9Gi5p5wkBMwq0WVn5KMyKDwxuEEfjT/w/yrqMmcBrDqFtfNYzjT3hHU=
X-Received: by 2002:a63:3c19:: with SMTP id j25mr558800pga.12.1571957554655;
 Thu, 24 Oct 2019 15:52:34 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:31 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 16/17] arm64: disable SCS for hypervisor code
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

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index ea710f674cb6..8289ea086e5e 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -28,3 +28,6 @@ GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
+
+ORIG_CFLAGS := $(KBUILD_CFLAGS)
+KBUILD_CFLAGS = $(subst $(CC_FLAGS_SCS),,$(ORIG_CFLAGS))
-- 
2.24.0.rc0.303.g954a862665-goog

