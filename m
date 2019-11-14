Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CC5206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TeCwteFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKNRmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:42:50 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:64709 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:42:34 -0500
Received: from grover.flets-west.jp (softbank126021098169.bbtec.net [126.21.98.169]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id xAEHgSo1028428;
        Fri, 15 Nov 2019 02:42:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com xAEHgSo1028428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573753349;
        bh=D/eJT32mBwbeMEWygMHfIeG/R76XAZJvY7EI4TTqWrc=;
        h=From:To:Cc:Subject:Date:From;
        b=TeCwteFO4rbpVkL6GZBxzkSITG1wka4bBagnguZvWG9oeaDuZxba8ofnIobOLyT6i
         ktVfWGQbvo20kFZppd1ukVCuyShjml7oh060Wxy3Y+3ogP/EBvPT+mljmcIwbsrESx
         VK79FOirnxcQQnJ5L1G8YkNI5AjC3Akt7BX5eHqWHpmlev7QxS8TSKemLkubTga0bM
         RrEgsEg3W5KmLfreCTM9Dir4Jf7ZBVAL2r/zu7QJ3o0UZ3AjM4dyIjffXdlD5y1QO3
         JNPPCuElkzoQIHg3GTktn6F2DS3Ezb0nWSVMTgV31NP43Z87FicDX0S32k7SF3D78B
         AAhvPH7c8H2/A==
X-Nifty-SrcIP: [126.21.98.169]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] modpost: add a helper to get data pointed by a symbol
Date:   Fri, 15 Nov 2019 02:42:21 +0900
Message-Id: <20191114174226.7201-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MODULE_REL_CRCS is enabled, the value of __crc_* is not
an absolute value, but the address to the CRC data embedded in the
.rodata section.

Getting the data pointed by the symbol value is somewhat complex.
Split it out into a new helper, sym_get_data().

I will reuse it to refactor namespace_from_kstrtabns() in the next
commit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 46d7f695fe7f..cd885573daaf 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -308,6 +308,18 @@ static const char *sec_name(struct elf_info *elf, int secindex)
 	return sech_name(elf, &elf->sechdrs[secindex]);
 }
 
+static void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
+{
+	Elf_Shdr *sechdr = &info->sechdrs[sym->st_shndx];
+	unsigned long offset;
+
+	offset = sym->st_value;
+	if (info->hdr->e_type != ET_REL)
+		offset -= sechdr->sh_addr;
+
+	return (void *)info->hdr + sechdr->sh_offset + offset;
+}
+
 #define strstarts(str, prefix) (strncmp(str, prefix, strlen(prefix)) == 0)
 
 static enum export export_from_secname(struct elf_info *elf, unsigned int sec)
@@ -697,10 +709,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 			unsigned int *crcp;
 
 			/* symbol points to the CRC in the ELF object */
-			crcp = (void *)info->hdr + sym->st_value +
-			       info->sechdrs[sym->st_shndx].sh_offset -
-			       (info->hdr->e_type != ET_REL ?
-				info->sechdrs[sym->st_shndx].sh_addr : 0);
+			crcp = sym_get_data(info, sym);
 			crc = TO_NATIVE(*crcp);
 		}
 		sym_update_crc(symname + strlen("__crc_"), mod, crc,
-- 
2.17.1

