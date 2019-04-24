Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57CFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D0221903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127170;
	bh=3xQOJn8PT+SIFijIIaVzNyivPjxOv7QG8T97OZmuZmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QF3dyRQSjYkX0AhFId/UeCtp4LN7juMnXgG7AOsjlxqQD0U9opqhO5KoeH+A+EcRz
	 Wig+8s41NKfGzC3qNsN70XKlV2EuoJA9UihKRbgF9B9SGhHWWaEpNhoJ5iNZ2KtO3R
	 t/+y4ejsP6bQE8nwljwkEXipw1pCaiB2eY7s5d/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391438AbfDXRct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391402AbfDXRcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:46 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E5D21904;
        Wed, 24 Apr 2019 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127166;
        bh=3xQOJn8PT+SIFijIIaVzNyivPjxOv7QG8T97OZmuZmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nl79auvrZ5vVtlxkEtmeHn/C6r3HuMP4/+rlDt2RG1iZ0sWk2Ml0U+5NTxjIc6y27
         1oDuPleVfxuNTd7v2j1tSWf/mKwoOmXqYezVQVDtSKXdIE+vsAx3fnc58vZ6eKbKog
         U9w8K1oa4wywRHgEtvIoJi9+aFI6LoEUFh+0J1ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Malaterre <malat@debian.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 85/96] modpost: file2alias: check prototype of handler
Date:   Wed, 24 Apr 2019 19:10:30 +0200
Message-Id: <20190424170925.549766879@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f880eea68fe593342fa6e09be9bb661f3c297aec ]

Use specific prototype instead of an opaque pointer so that the
compiler can catch function prototype mismatch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/file2alias.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 9f3ebde7a0cd..7f40b6aab689 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -47,7 +47,7 @@ typedef struct {
 struct devtable {
 	const char *device_id; /* name of table, __mod_<name>__*_device_table. */
 	unsigned long id_size;
-	void *function;
+	int (*do_entry)(const char *filename, void *symval, char *alias);
 };
 
 /* Define a variable f that holds the value of field f of struct devid
@@ -1288,12 +1288,11 @@ static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 static void do_table(void *symval, unsigned long size,
 		     unsigned long id_size,
 		     const char *device_id,
-		     void *function,
+		     int (*do_entry)(const char *filename, void *symval, char *alias),
 		     struct module *mod)
 {
 	unsigned int i;
 	char alias[500];
-	int (*do_entry)(const char *, void *entry, char *alias) = function;
 
 	device_id_check(mod->name, device_id, size, id_size, symval);
 	/* Leave last one: it's the terminator. */
@@ -1410,7 +1409,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 
 			if (sym_is(name, namelen, p->device_id)) {
 				do_table(symval, sym->st_size, p->id_size,
-					 p->device_id, p->function, mod);
+					 p->device_id, p->do_entry, mod);
 				break;
 			}
 		}
-- 
2.19.1



