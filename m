Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF4BC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407CA208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="v63F/0+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfGQXLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:11:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfGQXLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:11:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HNArCG1727011
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:10:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HNArCG1727011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563405053;
        bh=+zy0zTOL7hWrGpB/2EvHDXOhpis6yGUILgZQBqu7ghQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=v63F/0+tss7rZKmnF1nL3P+l4q3O/LAqVpiGYGfYdSX7+c5LWU9b3+OsU583lvX2t
         aSlPTR3xmG+0SF0KGFzNwZQ9Y5ILzk20B0Aq6kQYFWujOcKK0Csy3Cf71zDQn9xVwj
         mLEL/eRCfofF90n07Y9wPsfW/G1Y/9K97jlAMwBWtjHGDcdRWrHj27efoJzi46BdSA
         IewevWxjGLz5nA8JXj5tL6aOUjoS1WvjEwpMFoinI5won6yyUGKzjpme81cZEMt28L
         WOU9KYETpRZRbGWypP4XxmDDD6DtPkByfW7HnEcOTxT534NSsDTdGd/FpQMKqcV6z8
         cGC9ZWiUUFIiA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HNAqQX1727008;
        Wed, 17 Jul 2019 16:10:52 -0700
Date:   Wed, 17 Jul 2019 16:10:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Forney <tipbot@zytor.com>
Message-ID: <tip-8e144797f1a67c52e386161863da4614a23ad913@git.kernel.org>
Cc:     hpa@zytor.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mforney@mforney.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, mforney@mforney.org,
          mingo@kernel.org
In-Reply-To: <7ce2d1b35665edf19fd0eb6fbc0b17b81a48e62f.1562793604.git.jpoimboe@redhat.com>
References: <7ce2d1b35665edf19fd0eb6fbc0b17b81a48e62f.1562793604.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Rename elf_open() to prevent conflict
 with libelf from elftoolchain
Git-Commit-ID: 8e144797f1a67c52e386161863da4614a23ad913
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8e144797f1a67c52e386161863da4614a23ad913
Gitweb:     https://git.kernel.org/tip/8e144797f1a67c52e386161863da4614a23ad913
Author:     Michael Forney <mforney@mforney.org>
AuthorDate: Wed, 10 Jul 2019 16:20:11 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 00:50:14 +0200

objtool: Rename elf_open() to prevent conflict with libelf from elftoolchain

The elftoolchain version of libelf has a function named elf_open().

The function name isn't quite accurate anyway, since it also reads all
the ELF data.  Rename it to elf_read(), which is more accurate.

[ jpoimboe: rename to elf_read(); write commit description ]

Signed-off-by: Michael Forney <mforney@mforney.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/7ce2d1b35665edf19fd0eb6fbc0b17b81a48e62f.1562793604.git.jpoimboe@redhat.com

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
index 76e4f7ceab82..e18698262837 100644
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
