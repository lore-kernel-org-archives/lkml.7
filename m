Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D796C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E53320578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hX0x2mLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfHOQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:40:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51112 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbfHOQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:39:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so1792649wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQTvfg8Tpo4N8AzFTEat5V09DvUQksH5vgyoMyK5UTo=;
        b=hX0x2mLcA5bsmIzW02jsqVqAJD57y30G2Vk/DUTPY/WBr62ITbGKZzRRen7mbTQ5QW
         iQRg34nzB+zUXOGHealjenzNHOmYJvO6/K42LPlPi+xKjKl4kt370L0FjhPC9by0ro3E
         cCLq2J9qAo68i8NR645wykcHwqICtl1OjiEEDk3AAdDPgi5rwHVlsC89kQlzAN5pxCRc
         vMeUnfrsHAuL+qpo1iqwPjCqIU/vsilK4sxdz/Su8iKOys35LBwvlC4T+QLG0/7KoqzQ
         uWLR926Bsptye1U80TF/X2WAJzj8lbxHXSujK6O6mce/adMTPqecJYezMmyfeA2XiE2n
         FBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQTvfg8Tpo4N8AzFTEat5V09DvUQksH5vgyoMyK5UTo=;
        b=PhMEb2m9uznW8QGx9FEtWSOdJHOM7KZXmTfzZK7pP30wtKI5lBlzSSNuckgkxPwR+W
         G7/O2n2Ri33sin0VC54ojAQ9o5BkuD0Ld7LeOfJbjV8Oo8hdGeXlDKbbDA7/J2khG+VD
         RZF/wgK5aH2D6Qda0QrUmKwQYwW6fKp/+AIkt4fA4X2+gSc3hBtpsBk5hXSQyixbn7qt
         ad8nvKJ/mGehx6y9I67k6NXFDxOb5PFlrKNRfOF+7+9cyZwi2bjQcOzOfCrj4ZSW/RJs
         gpAGIND33xh7jCRB4o3bubNq0QWOynxuB0BqgY/r5w07ywk52AHBrepKVamVLYSO9Fz4
         dQcw==
X-Gm-Message-State: APjAAAX49IPr0nALCGLb/MgyBLaOl8YwY1kqfWx/5bMobLAazdVS0ddz
        MSMZrpfPOCCNWZcHPRxTen0iGxLC92k=
X-Google-Smtp-Source: APXvYqy0tpOwOZT7R7tAsH6bWuXOaoxMrf1x3TqxWVFqxqyr7FdqIfHPpdDpdgEwHicxHLCq/aErnQ==
X-Received: by 2002:a1c:4087:: with SMTP id n129mr3555833wma.3.1565887143868;
        Thu, 15 Aug 2019 09:39:03 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:03 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 18/36] x86/vdso2c: Convert iterator to unsigned
Date:   Thu, 15 Aug 2019 17:38:18 +0100
Message-Id: <20190815163836.2927-19-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i and j are used everywhere with unsigned types.
Cleanup and prettify the code a bit.

Introduce syms_nr for readability and as a preparation for allocating an
array of vDSO entries that will be needed for creating two vdso .so's:
one for host tasks and another for processes inside time namespace.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index a20b134de2a8..80be339ee93e 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -13,7 +13,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long load_size = -1;  /* Work around bogus warning */
 	unsigned long mapping_size;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
-	int i;
+	unsigned int i, syms_nr;
 	unsigned long j;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
 		*alt_sec = NULL;
@@ -86,11 +86,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	strtab_hdr = raw_addr + GET_LE(&hdr->e_shoff) +
 		GET_LE(&hdr->e_shentsize) * GET_LE(&symtab_hdr->sh_link);
 
+	syms_nr = GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
 	/* Walk the symbol table */
-	for (i = 0;
-	     i < GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
-	     i++) {
-		int k;
+	for (i = 0; i < syms_nr; i++) {
+		unsigned int k;
 		ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
 			GET_LE(&symtab_hdr->sh_entsize) * i;
 		const char *sym_name = raw_addr +
-- 
2.22.0

