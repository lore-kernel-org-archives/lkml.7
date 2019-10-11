Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28EDC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD1821A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+PGC98b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfJKAM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:12:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43976 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfJKAMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:12:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so4941657pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MdMMErkL0TaCB+AMS9GPl9j3KdOjHrVPYKwcXQnru9o=;
        b=H+PGC98bol8nQLCHGKVMnumPCpE3rZsdeAzu/63Zl+MVbbl4Sn0Xj0/MJ8+SrojoRq
         PDLZ+DEdfwhU0nbRPNgAZmDKGI8JIpf0k65nc/pgyy9bqCoX2oIyxBmx8SkXP421+0dD
         CN9qS2yDtmYN+7Q+QtAoazHu9DvsNkSQPOn/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MdMMErkL0TaCB+AMS9GPl9j3KdOjHrVPYKwcXQnru9o=;
        b=NRbDm3nIWrZRAVUFyfD3/wtnu01mdKcEtVZY75/UI8WJr9Md5BqdmoZFIPjDQUpPlI
         c35VFQkIUOaqIG6q8dXCQ+MZG0CUNvnG/KFkGH7QNUYyULHddpCMLN/jmRj4n6+7bU0U
         nK7WRMzaTVXxZB347ZINJzPuWEY7Wl/dKQOKagys/Qch34WtbaMGt5FCtWs3MLkwonkv
         4hB1eBrZNuL/IJ/SGiWe/M2kq0fHMWvM6WJUW7yQFUSySMYzP5fpsOeWMmTa0nR6pxDe
         su4JNlTjPuuofSXniFsNujM8cUbzENp1JI3Xq/h7Q31l+kiKp9MBWYeHxMyidLAz+fmI
         Ou6Q==
X-Gm-Message-State: APjAAAVH3xS/SbEa7H1fIfiB/qkypEhZjpMyKs0hixGVJaEDFf8/5zF9
        1BTGLtBGU+iJ0oDBIksJLHUNxQ==
X-Google-Smtp-Source: APXvYqxGtnvXMUJ3pY0jopkR+VKX/LuW1ntTFWY/1XeIzuIP03PlTUnb++z5MjVk9/9/m40WTFaCbw==
X-Received: by 2002:a63:1201:: with SMTP id h1mr14569419pgl.340.1570752774490;
        Thu, 10 Oct 2019 17:12:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l22sm6398506pgj.4.2019.10.10.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:12:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/29] parisc: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:06:03 -0700
Message-Id: <20191011000609.29728-24-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/parisc/kernel/vmlinux.lds.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 12b3d7d5e9e4..53e29d88f99c 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -19,6 +19,7 @@
 				*(.data..vm0.pte)
 
 #define CC_USING_PATCHABLE_FUNCTION_ENTRY
+#define RO_EXCEPTION_TABLE_ALIGN	8
 
 #include <asm-generic/vmlinux.lds.h>
 
@@ -129,9 +130,6 @@ SECTIONS
 
 	RO_DATA(8)
 
-	/* RO because of BUILDTIME_EXTABLE_SORT */
-	EXCEPTION_TABLE(8)
-
 	/* unwind info */
 	.PARISC.unwind : {
 		__start___unwind = .;
-- 
2.17.1

