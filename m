Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D77C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F5620842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="psm7CSLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCEFvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:51:13 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:38856 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfCEFvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 00:51:13 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x255mOrT002400;
        Tue, 5 Mar 2019 14:48:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x255mOrT002400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551764905;
        bh=upricv6fVewsTKjghecoorebp9rRB3J2zizg4F0dOiY=;
        h=From:To:Cc:Subject:Date:From;
        b=psm7CSLg9BijV5QYpGE7GbBhhpCAe6mQnyl8ySC3xeg5QAvvvV2LEjloeMRip4SuO
         2kD4bgx5yeh6gsItH3WqMtheJsOinOTNWDSkqCaCHdapoi7PslPNlh1UyUqJQt42z3
         fp0gYP6WGCbaZ7BtpQU0jH2CseNNfhqaCEdYBkjtGob5ziN5Lrq086s0RBMFlKaJWf
         wIsne5C7SFaF2Rrw26bvyNF2+KySQs3JU2Ckj2qIEsEEO1n2WLsH3MS+RDuw+DJ0Y0
         AHoB6iwdxKKOQ2bjdDLI1Befkmb4Zqm2Ga+H85C09Z8gGDazZNktbbsBOjIZPd1CkG
         KeIp+b3UH59Fg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Meijboom <robin@meijboom.info>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tools: move initial declarations out of 'for' loop
Date:   Tue,  5 Mar 2019 14:48:14 +0900
Message-Id: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was trying to compile this code for hostprogs-y notation of
Kbuild, I was hit by the following error.

  error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode

This is because KBUILD_HOSTCFLAGS specifies -std=gnu89 whereas the tools
Makefile compiles it with -std=gnu99.

Of course, it would be possible to pass -std=gnu99 per file, but it
shouldn't hurt to fix the C code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 tools/lib/subcmd/parse-options.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index dbb9efb..1bd858a2 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -630,6 +630,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			const char *const subcommands[], const char *usagestr[], int flags)
 {
 	struct parse_opt_ctx_t ctx;
+	int i;
 
 	/* build usage string if it's not provided */
 	if (subcommands && !usagestr[0]) {
@@ -637,7 +638,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 
 		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
 
-		for (int i = 0; subcommands[i]; i++) {
+		for (i = 0; subcommands[i]; i++) {
 			if (i)
 				astrcat(&buf, "|");
 			astrcat(&buf, subcommands[i]);
@@ -663,7 +664,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 		exit(130);
 	case PARSE_OPT_LIST_SUBCMDS:
 		if (subcommands) {
-			for (int i = 0; subcommands[i]; i++)
+			for (i = 0; subcommands[i]; i++)
 				printf("%s ", subcommands[i]);
 		}
 		putchar('\n');
-- 
2.7.4

