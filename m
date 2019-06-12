Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442CEC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CEF21743
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VlXoC4OJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfFLT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:26:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39665 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbfFLT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so15487522wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQTvfg8Tpo4N8AzFTEat5V09DvUQksH5vgyoMyK5UTo=;
        b=VlXoC4OJvgPVQSvv3/OUXNAQAaphb+hnyt0euoP89ggnl3AS2fPxmRFhJgpKGz0deK
         43UuuOn6i/PQH+kbDg1w+idcC0H1tCCEKQiN+EcxpOFDT+iP1bW3zTXL8K3f6HCTXFlX
         xQszSB4m5BnKGRdPdyKSWPD2mJxVI9pEkfWn4b3te9o59clJx6v4hNPNBfj6oG+yWD6Z
         m2/sM2POrjD4VSjS6ZLyRuRuAVMr1xQmssRFzt7KTPlueUJEzmUisok+qdgB2MZ8Vh2y
         6Z9WkhiTNtkHQ5dGqB0ssztFosDhrcoT+h2KoM0ESg7vtuGCctVlZuCtIvkS5/MCnsHv
         67zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQTvfg8Tpo4N8AzFTEat5V09DvUQksH5vgyoMyK5UTo=;
        b=T7jxxgKYkpvOWCRYpaq6838uecoBm1MeQy1/lsVDYaQSEjOodS1Ra/q1kjGlZwzkXl
         TKaHk2CHmD7C3kb4Zr7Y4dBcnzth6VwBBUtNxT/uy4awnWkqakT31heWKf6hPeqMe41a
         TP352Ed4gkzkLB3ArZxdjnCEGxXe47Di/1Kg++VBPPFCpHJZ4tUKluDpaA4ucAd5LEkz
         4QpQsDXrytV/pr108KAP70yJ+6aLbci28e2/PycMAIK6bgf7309w5H2LzpJW6V2pCRRu
         GfhLDUJU6FmxWylcF+Ht8D0ze5rvvhfy6i35pQIcO2HX18gDJoYBqYRYd534PvXEqWko
         EcLg==
X-Gm-Message-State: APjAAAW6p7AW1D2Ah6P1vTzC6eDQy3fkLsi7DrxIUHD/5zFs7/MCoUBX
        sws6y8Co5pSKepumk4OAQIVp+F6axSU=
X-Google-Smtp-Source: APXvYqzqxJJh+TcPUGfWE7o/3hDSArrr7ndoGURZcvlBJ53+Si+juwQGHwh6g2vk5jA1VO0bPBh3mQ==
X-Received: by 2002:adf:a201:: with SMTP id p1mr24494679wra.113.1560367605839;
        Wed, 12 Jun 2019 12:26:45 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:45 -0700 (PDT)
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
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 11/28] x86/vdso2c: Convert iterator to unsigned
Date:   Wed, 12 Jun 2019 20:26:10 +0100
Message-Id: <20190612192628.23797-12-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
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

