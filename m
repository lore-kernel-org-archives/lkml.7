Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568A1C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8222086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="J4KpZPS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfHOQkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:40:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38063 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732506AbfHOQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:39:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so2773514wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJkPu9y+gmExeCUpCA066mqgvfW2S/OqiamBX4Wlaac=;
        b=J4KpZPS7wXz88Nni6ZpvxnXX+K2uvbYds1TcLpaXL/Z5uwIBXN9Ddc2tqoExyKQriq
         PBnjY59uAnaLurHOas1TkBVD5whYXEK7z70a6i247qXRE2ZmKXcmu3tbIO/qJwCyMCGN
         pl5AUYGdrWLH4lpzdGUA664DWH9bwRj5ahw75ilzSbAEdMvoqCajxBi6UrEIildjsaDX
         QBHSEaUhLlWhojYHjvrvxWw1EJaL8HC4aLWkqE9jxz1jPvYCHbwzwA5xjq6X0/ZhEJ1p
         fQa8sJRo+F9elMn+jv5nu9BPstAlDQxFi08QAAv9n64DpKpDzTzSCUF5y0xlrw9GQ+8/
         G5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJkPu9y+gmExeCUpCA066mqgvfW2S/OqiamBX4Wlaac=;
        b=cmpWL/Pzq1zCwEa1AOea+OqHXwt0cVus4R0V+x7z+9GFqynQUVpX6Vkti6G6SO1sG2
         JLA57Z5rpIN2kwzpkXBCPOo+p2p1Dd7V/nU4wQDs5o3m26XcslH8DtNXJT8Jw6AfRqoR
         N1DKLnovIaVUxIzjNE8hGKsRCpxv8H7sVFj9IiV8mVSu3fiGZqATuCwKT0r1AjDn6nRs
         tKT2qoM/5wbZXRRmDb7f0XCMjjL/NkVkDSTSr/8XcqOWUCGnb1M3v/IXsTng0j0ZBpW/
         GfQNQc4wcbRa2TzKc/Yzl5/DWm0+0CtTmpUcDkOrFFLyikJlearLrKqZmstalRQnLk5A
         wxUw==
X-Gm-Message-State: APjAAAX9642lfabrgsWwY4P1vCilgy2F51fhR4nxTw3r+5mo7WnJQ2Kh
        ENZ8JNQP8c4pUSMew4iTwRM03O4UF7I=
X-Google-Smtp-Source: APXvYqzG58GHqWhQt3O95EMpBPl+rbS/dCB4xX33X5WCtgl71eUCMz5eZqiwPYk9hteRQJy1ao79eQ==
X-Received: by 2002:adf:db49:: with SMTP id f9mr6487168wrj.112.1565887156941;
        Thu, 15 Aug 2019 09:39:16 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:16 -0700 (PDT)
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv6 26/36] x86/vdso2c: Process jump tables
Date:   Thu, 15 Aug 2019 17:38:26 +0100
Message-Id: <20190815163836.2927-27-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside time
namespace with clk_to_ns() that subtracts offsets from host's time.

The timens code in vdso looks like this:

      if (timens_static_branch()) {
              clk_to_ns(clk, ts);
      }

Static branch mechanism adds a __jump_table section into vdso.
Vdso's linker script drops all unwanted sections in compile time.

Preserve __jump_table section and add it into (struct vdso_image),
as it's needed for enabling (patching) static branches that are
present on vdso.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 1 +
 arch/x86/entry/vdso/vdso2c.h          | 9 ++++++++-
 arch/x86/include/asm/vdso.h           | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index ba216527e59f..69dbe4821aa5 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -45,6 +45,7 @@ SECTIONS
 	.gnu.version	: { *(.gnu.version) }
 	.gnu.version_d	: { *(.gnu.version_d) }
 	.gnu.version_r	: { *(.gnu.version_r) }
+	__jump_table	: { *(__jump_table) }	:text
 
 	.dynamic	: { *(.dynamic) }		:text	:dynamic
 
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 885b988aea19..318b278ca396 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -14,7 +14,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long mapping_size;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
 	unsigned int i, syms_nr;
-	unsigned long j;
+	unsigned long j, jump_table_addr = -1UL, jump_table_size = -1UL;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
 		*alt_sec = NULL;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
@@ -78,6 +78,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
 			    ".altinstructions"))
 			alt_sec = sh;
+		if (!strcmp(secstrings + GET_LE(&sh->sh_name), "__jump_table")) {
+			jump_table_addr = GET_LE(&sh->sh_offset);
+			jump_table_size = GET_LE(&sh->sh_size);
+		}
 	}
 
 	if (!symtab_hdr)
@@ -166,6 +170,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		fprintf(outfile, "\t.alt_len = %lu,\n",
 			(unsigned long)GET_LE(&alt_sec->sh_size));
 	}
+	fprintf(outfile, "\t.jump_table = %luUL,\n", jump_table_addr);
+	fprintf(outfile, "\t.jump_table_len = %luUL,\n", jump_table_size);
+
 	for (i = 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index ccf89dedd04f..5e83bd3cda22 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -16,6 +16,7 @@ struct vdso_image {
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
 	unsigned long alt, alt_len;
+	unsigned long jump_table, jump_table_len;
 
 	long sym_vvar_start;  /* Negative offset to the vvar area */
 
-- 
2.22.0

