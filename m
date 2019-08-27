Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5742186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hReFQ8hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfH0Ukt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:49 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45200 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0Uks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:48 -0400
Received: by mail-pg1-f202.google.com with SMTP id 141so219275pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=69o5Grxjv62QvQRHvmQYsH04Y/pWfPSVibkBDTUpZck=;
        b=hReFQ8hCxEL6bw2JDh/MqNIvy644a7nuoCq3WHEhQzVrMCKSuBPRsE4ojzK+e76jk7
         fd9z0VUbRz9rzsaUz2pd3Vbk3Dzi/MWW4TGuqY6YaNj1mzqQUWaq4ezq60DCs171Trz+
         K+0bAGR/QBc0P3/grOBtOJGrYkkZ086qqtpr/0V25KNgNAdtBQg+pWzBFaFQXWgAk4iW
         f6I3hwFjbGDqgIRAjEcUC5q1OptG59hoHMCn9N01FAqTt4BAC5gBjgq88iLnl5AnsPD7
         oup+hkyJLNlgHcOTwGVtmRybWt0hVzlFa+oCNucvdqwBJy7PREzmiSOIFNfgNT1ArD+I
         /7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=69o5Grxjv62QvQRHvmQYsH04Y/pWfPSVibkBDTUpZck=;
        b=YXplXWSAubCYeI4dpw7cMwOFjD/quayUbediKydm0osEyfxZzS2iVtf0MTwtHYnf5i
         L3lhP+id5YzFA1tBzyCrlglnC+RYY4fMtYfGvyeutUTZX2e1ItS4qCJ+xca3RrZmaDNB
         yXyBzyb0M/niu2HmVQNxTPiHMOWF9Ijh9AROfYHAo1PJlNQt9rl02mLioDrr0JGGtNzu
         HgQdxzWl7RfCuF6ABlkWDb4Xr6dvCFGf3izeEz9oAJGASjjMkOPplescpBWfSkAedF47
         NCjqvbswCFsj8cEyYAZ//JOQzRy3MpqW0C7NGHRlXTMqwmB8ZALqGo8AfEdj7tXPjS08
         gpJw==
X-Gm-Message-State: APjAAAXME9VralA9vo/5yq/J9ZZuF6DkJa58+Qtray/gVpy77ezKVo/O
        M4hMrM0rp/JHwmxF+9gKp9T8nL13bwKIBzzfL3I=
X-Google-Smtp-Source: APXvYqysvUlqmjv/zp+5jadC8yMl0v0AC5K3IkDddt9ihR0pKYJuj2wBLTQA048InhUSTME6dA2ZcPwWet1QHiS304s=
X-Received: by 2002:a63:24a:: with SMTP id 71mr260306pgc.273.1566938447325;
 Tue, 27 Aug 2019 13:40:47 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:40:00 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-8-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 07/14] mips: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Acked-by: Paul Burton <paul.burton@mips.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/mips/include/asm/cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cache.h b/arch/mips/include/asm/cache.h
index 8b14c2706aa5..af2d943580ee 100644
--- a/arch/mips/include/asm/cache.h
+++ b/arch/mips/include/asm/cache.h
@@ -14,6 +14,6 @@
 #define L1_CACHE_SHIFT		CONFIG_MIPS_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif /* _ASM_CACHE_H */
-- 
2.23.0.187.g17f5b7556c-goog

