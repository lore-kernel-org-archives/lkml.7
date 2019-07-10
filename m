Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634BC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AD5208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfGJVUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 17:20:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfGJVUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:20:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4F8F30B259D;
        Wed, 10 Jul 2019 21:20:18 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-237.rdu2.redhat.com [10.10.122.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 153CB60BFB;
        Wed, 10 Jul 2019 21:20:17 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Forney <mforney@mforney.org>
Subject: [PATCH] objtool: Rename elf_open() to prevent conflict with libelf from elftoolchain
Date:   Wed, 10 Jul 2019 16:20:11 -0500
Message-Id: <7ce2d1b35665edf19fd0eb6fbc0b17b81a48e62f.1562793604.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 10 Jul 2019 21:20:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Forney <mforney@mforney.org>

The elftoolchain version of libelf has a function named elf_open().

The function name isn't quite accurate anyway, since it also reads all
the ELF data.  Rename it to elf_read(), which is more accurate.

[ jpoimboe: rename to elf_read(); write commit description ]

Signed-off-by: Michael Forney <mforney@mforney.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 2 +-
 tools/objtool/elf.c   | 2 +-
 tools/objtool/elf.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..de8f40730b37 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2407,7 +2407,7 @@ int check(const char *_objname, bool orc)
 
 	objname = _objname;
 
-	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
 		return 1;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index e99e1be19ad9..1121926bdc1b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -401,7 +401,7 @@ static int read_relas(struct elf *elf)
 	return 0;
 }
 
-struct elf *elf_open(const char *name, int flags)
+struct elf *elf_read(const char *name, int flags)
 {
 	struct elf *elf;
 	Elf_Cmd cmd;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index e44ca5d51871..2fe0b0aa741d 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -74,7 +74,7 @@ struct elf {
 };
 
 
-struct elf *elf_open(const char *name, int flags);
+struct elf *elf_read(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
-- 
2.20.1

