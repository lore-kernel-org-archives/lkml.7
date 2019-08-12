Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3DDC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA552067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qz1M7PvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfHLVvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:51:39 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47140 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLVvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:51:38 -0400
Received: by mail-qk1-f201.google.com with SMTP id y67so2488325qkc.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ci0/dDTEQ/TKTYA4PTTz/x+w1WNnSFlT+0iZElVTbkg=;
        b=Qz1M7PvURpf39A2GyB2ThYI6sZWekP4kv2/wK2aFuwloN8lbCxPc3rjZudsxak4kpn
         ajMlDmgK9Lu/NgFxIw4npr3+GQxp/RQRN77R18W7n5T1GJzD68w0MkzsXaIMJTN2I3Le
         IHTkYpbbFG1xRAubUMnsy18g9+4aGGoJv5yhML4ehVYces0T86ip2lzBf4TV3/1dBFmz
         rkizrYzDKRP1z/p0c9ysugw9oGhpmhEmP4orYaxGYbj9wc0ZPxEtrXqTMSL0umYO8f9P
         ZwBLT+KUw35Au9CQtI70zlZPeMbTJ6ylaDdbqr04CdqMW5iZjo+waL464CSdJCPaWl3S
         Z3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ci0/dDTEQ/TKTYA4PTTz/x+w1WNnSFlT+0iZElVTbkg=;
        b=O96RQoFA3Rrtzp49Bwr1iF35pvgOXeweqkkN6UZOgZGpWPkaAbJwIzWmnNnUhoWDOI
         McvfbXYLdMFk5apETtDYbn3JgOfEDrRg6/BwflzWOkDAOwP9TW7PHAVq649G8/N6IjjV
         OEl/4UBPLS/x1QSOXWMQaRWyX4q8iLfDCSN79U2fIsxkUAUP+hPdk481yX2GiIejcMna
         2laBLjwFz6HbKaSU6I5oGTTfBvm+cAAK7aRg5Wk2En7q9oE+ktXJ8e+0KKfMjGFZJZjJ
         wflXnQwwRMnVbibLA8U7yu4FwVDno/IsT/iKr9aj0ZHodVeN9t2j3UGta4xW0h7xGoLZ
         RimQ==
X-Gm-Message-State: APjAAAUlfukEcpi/dKqDpwPmw9UMYQFwA8CEyGZVUJoM5L9KsKRZ918X
        nmIQ1aXQBduj/beFljOnOEUGOvTPvgOevxCilaM=
X-Google-Smtp-Source: APXvYqx/cQmoHx7pahdoX11IzIW90P81FVgmK45vE2bdFVoFA+GBOZlIRuQdPPi0pnv12XzVEJvNaipQjrXdt9hMI8o=
X-Received: by 2002:a0c:98e9:: with SMTP id g38mr31135758qvd.187.1565646697667;
 Mon, 12 Aug 2019 14:51:37 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:36 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 03/16] parisc: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/parisc/include/asm/cache.h | 2 +-
 arch/parisc/include/asm/ldcw.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/cache.h b/arch/parisc/include/asm/cache.h
index 73ca89a47f49..e5de3f897633 100644
--- a/arch/parisc/include/asm/cache.h
+++ b/arch/parisc/include/asm/cache.h
@@ -22,7 +22,7 @@
 
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 void parisc_cache_init(void);	/* initializes cache-flushing */
 void disable_sr_hashing_asm(int); /* low level support for above */
diff --git a/arch/parisc/include/asm/ldcw.h b/arch/parisc/include/asm/ldcw.h
index 3eb4bfc1fb36..e080143e79a3 100644
--- a/arch/parisc/include/asm/ldcw.h
+++ b/arch/parisc/include/asm/ldcw.h
@@ -52,7 +52,7 @@
 })
 
 #ifdef CONFIG_SMP
-# define __lock_aligned __attribute__((__section__(".data..lock_aligned")))
+# define __lock_aligned __section(.data..lock_aligned)
 #endif
 
 #endif /* __PARISC_LDCW_H */
-- 
2.23.0.rc1.153.gdeed80330f-goog

