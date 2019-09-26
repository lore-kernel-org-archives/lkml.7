Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57313C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCEE222D1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h2p8CR6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfIZR4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:56:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43411 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbfIZR4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:56:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so1941419pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0o22aj+Q2fPal3OzyLNHtFtEJCV1jKXrih1rnY9ZOvQ=;
        b=h2p8CR6CTCVG0EcWBzFZk9M7pS5/grZV7SzSB6Fp/b72sOhC+rJHHanRbr647L3D5O
         3PK+ZsRgr4yUne37ilhSCOXRu+oA9brL1Q3zUBwCc+GNAanTNZBOlRbFkU/6xiHKWXKz
         z9Lk6mr7quDbn6Iv5uFqVP/gtakRm/cG9s24k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0o22aj+Q2fPal3OzyLNHtFtEJCV1jKXrih1rnY9ZOvQ=;
        b=B5+NAsHdBq9EgEI/APKHO1cZDxByw7nvTpk3CedSrsdq+FPlF0FNJhVlY11BokyJ2c
         WduXpmAEyDjFWPpt6z8CYggy8lHstI4l3O92ZpYevXvJ9lHxD//TyE94tEDXIRqNhXU0
         lGf9R8F+bTKMsmHXfYf3SLyQMDvrKLV9M0lVpjHXUBZXJ2od1PiDOp77YYdy781T1Ea+
         m52GoV+VlV5rNlsVNgCAEZoDZyl8bKoLXt8MDWq5ahddcKgPerggXk3R6vJ0BdOAkZcj
         +ai63r2smYX3kdY4P7a3xqoEPnRF8+HegsKrkkx1JwnjFTK5ADn3to+k2QJLC9WEWKA9
         dDjQ==
X-Gm-Message-State: APjAAAVEpdJiuUh+V5aR34CdseqF8eUuldI7jMYiO+fDH4YUh8wvrYFh
        AcYeLOTdUVMtv9hcJp5d1XQKjA==
X-Google-Smtp-Source: APXvYqy6S7VpAjQkHoN68ZupzJjzmnjjpPcZsaZVMPIKEdbkFn7g1SNyoioq3hB1BxaJQAQsFZhPUg==
X-Received: by 2002:a62:7a88:: with SMTP id v130mr5261721pfc.184.1569520595802;
        Thu, 26 Sep 2019 10:56:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t68sm6742712pgt.61.2019.09.26.10.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/29] x86/mm: Remove redundant &s on addresses
Date:   Thu, 26 Sep 2019 10:55:59 -0700
Message-Id: <20190926175602.33098-27-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The &s on addresses are redundant and are better removed to match all
the other similar functions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/mm/init_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 26299e9ce6da..e67ddca8b7a8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1300,9 +1300,9 @@ void mark_rodata_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
-	unsigned long end = (unsigned long) &__end_rodata_hpage_align;
-	unsigned long text_end = PFN_ALIGN(&_etext);
-	unsigned long rodata_end = PFN_ALIGN(&__end_rodata);
+	unsigned long end = (unsigned long)__end_rodata_hpage_align;
+	unsigned long text_end = PFN_ALIGN(_etext);
+	unsigned long rodata_end = PFN_ALIGN(__end_rodata);
 	unsigned long all_end;
 
 	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
-- 
2.17.1

