Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78726C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0A4214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udtjEyCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfH0Ukh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:37 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45204 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfH0Ukg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:36 -0400
Received: by mail-pl1-f201.google.com with SMTP id c14so197621plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pMRR3udv7zUt55udgy/JnJSChNtnGj7LBE8r938k6XI=;
        b=udtjEyCDVwYq/FK3kBeTb3nH8Aa7vL9kuHCFwllx1BaX/30WXSHx6kZYDXQ7Q+voCO
         cK/gu8GvhtQ36YbkCBbyMFDS1/DLu+qYijMvJFH5APSWGaS9EoRiWUmfTTs102uoutds
         WrWXfIy8nJf3Io7Dsmrfo+DF6TzSDatNANOWeaTRc/PeYESbP6O8Q+9MAl2oE+eUuyDM
         WLi/k40Mz/YxM3rUzFk/5JdQBAbl2nlbxiaysh8/ku9XqHmQQbMIxCss2j9KNXL3dwjt
         nwDrCze8E57svT2Qpwd05NkuaR8T0Wd8XQuXchUbZ/yUTKgxjwXeph5z5nP+k6Akieyr
         Ot6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pMRR3udv7zUt55udgy/JnJSChNtnGj7LBE8r938k6XI=;
        b=pM64XVsj4hCueTErparp360gQ0EjOajShVPzIeUcmjt5RHkF2szFPFS88mX9hj2GiB
         g4G8eMH7maCwFwWzuUDz4AIFURbUBaP4uIXHvifnKfVP/AsB3lwKb4vBPCR0/wTTjoCX
         rvOU7iZAR5SlhWysfsm1yNkbt7zghaUvFYxUT+XCuJE3743uqC39P+m+3tPJJj6JWtzp
         nwghEYHzOXXcQM9HVmWYtWDFN7AJ8F5sUdxIATqbpNx4IxQX61geASyqQf1sQDa0zegn
         15Mclag2qHXde/aGYxPEQ48eBggUeYPatO29ZfXkoyjfoVaC+ia/oYxvAc4vEu7krxtW
         SgDg==
X-Gm-Message-State: APjAAAVO/pG7nSavXQw6/qSXKbPOeV/8Ey0/t0Je1QWclyM+H6f2nXBl
        osfZKROBaIvoSG7tk0/b6d6kvSJO+/hL0VyfoWY=
X-Google-Smtp-Source: APXvYqwQnrJ8a4HdAkrGNY4Dfc+w/PoGvmdIMpsINr0t4qe6rAPdpNtGI0S60pWuQmI7r9CaD9PYh7u/lP+qQU1gX3o=
X-Received: by 2002:a65:6152:: with SMTP id o18mr255957pgv.279.1566938435091;
 Tue, 27 Aug 2019 13:40:35 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:39:56 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 03/14] parisc: prefer __section from compiler_attributes.h
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
2.23.0.187.g17f5b7556c-goog

