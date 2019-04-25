Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16BC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFD820651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jTYhuZ24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfDYQQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:16:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39693 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfDYQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id k45so393194edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdqS8UeLcHDjf1Umeft7MQ/v3oy3B8NYA1tWuLl7jjg=;
        b=jTYhuZ240qvkUGblKcUv63Qj+gnNz1qUB3kW+2Jxhr4BNyddbstYWaeYNEg4tnjQKh
         lvt1WtPVowUfu/feUKEuy2h3vjlfn5OKHiI7kmV5XiboQ/atN2bbRo3hfnTjaeGRE3SH
         Gvn1DDL6Kky2qti7yhfaKjwOcUgQPN8dDQL4tVeKx9wMhhXNGB1apGHWX4B2l9pmEa0Z
         7FmW6KwYi+80xZvh1t0r3XeVnI+mKldZLV+5ptQPhZs8pOENM5w56N6VTVwItXJzfUr7
         7/v0xTGbbMRfOmVu9c7zwkegK7UNpqW6pQuhJtJxCmkPWjKmcK5u2HHplcnFZgn4tLVR
         5iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdqS8UeLcHDjf1Umeft7MQ/v3oy3B8NYA1tWuLl7jjg=;
        b=aMH9UT6JNeworwQ7wwpSWNZ5zQqPPKpqzxB/quFaLQ2Sj4ZutRaYrVDcRy+5t/CQoA
         AEgB31S8AesnnWrTUoUjMZihdtNd3Ndz+jQFnlj5UxUImtePwhZcEjLaGZCRFt9+4CMN
         0WaUJWWjww21hJAyz8r6BQntZigFbv0xRBDyJFyLdnd8dYoOGeoxX8/jetFBWFl2De1X
         RMDTFhBPmmnWyIwrBK7GOk9o66t0IYljBh6YZ6JrXJxy18VjU3Dllipo0mR/IK0KS9pg
         +8Z5jIjI87IJhl6w4EN5+DF03oU3ULZqXJsNESIYlVed5EcNX5Bbl/7oZ+tjmHT89KjB
         qmGQ==
X-Gm-Message-State: APjAAAWzTRgvkOqBi+ioPnUMkHIDYSx5IIzAtPsvQfh+edDIbmqa/jzs
        d2DX5P0rbRn/mfZYMpnCNLeHeVSAW9w=
X-Google-Smtp-Source: APXvYqyyOjBkkXjM0JyUKHodc6LIVH52GHRo6ZgRWYIG8fK/zCTmU3R0uOY45qrtKzagRdGohJCekw==
X-Received: by 2002:a17:906:1dc5:: with SMTP id v5mr19411747ejh.66.1556208874919;
        Thu, 25 Apr 2019 09:14:34 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:33 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 10/27] x86/vdso2c: Convert iterator to unsigned
Date:   Thu, 25 Apr 2019 17:13:59 +0100
Message-Id: <20190425161416.26600-11-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index fa847a620f40..61c8bb2e5af8 100644
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
 		const char *name = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
-- 
2.21.0

