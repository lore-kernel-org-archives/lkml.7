Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0E2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254672176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576556102;
	bh=nHBZARSCljW8/8hjS8btsfR0kX5K0JKPnXWrNmqybTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZFRpQHXt2o0VCPsyQSuR1goGEINgfZgBr9EvbBb/CfXoc5UwXlA4mDakR2QDdi4bI
	 9MXedcc1HIWz4LGsWUkCELALQ9X1VRc0mzvWvA4nfSsDQ0Vj+8p4bLICEK8ZPSowUP
	 /SOI6K4LoDCcLmHXbOIzWnYoN5e+yLoigOXpzhNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfLQEO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:14:58 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49418 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfLQEOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:14:52 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xBH4EPAH024524;
        Tue, 17 Dec 2019 13:14:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xBH4EPAH024524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576556071;
        bh=a17nZoX2gmVNQ4RyqbzSYYjo3e0s9uhnamYb1ruGEGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LiE6IMaPP9ehZN+dvlxyyzzzJmXkTuhpeWon0y25ZSwbnNsqbneQRAE0XVEzQ8s7
         RmoUTBQou3XprADyX27eyReBJaF9Yoma+Sv8y429iOz/XsuNdaEZ+wsVp3kApgcCgO
         m/YPQSX/BB1ILaoaua57eca0GlZHtO8OuH6at2GMNrkKRmLAOIJ71c+4XgnjqLFQWI
         HI+JahCUfcHFwd2QDclWkpQdc+gOSJLNHzCoL//NGZXcLWrCIVfR0J4g1ogBRjaI75
         2IHa403kHzvsgoQ7cpJA9jLZYgJjmY1WTeUhDXyGRfcIq0WOtwUEGtuw5wrXe8kzLi
         am8EiHbpkDV5g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] kconfig: remove sym from struct property
Date:   Tue, 17 Dec 2019 13:14:22 +0900
Message-Id: <20191217041424.29285-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217041424.29285-1-masahiroy@kernel.org>
References: <20191217041424.29285-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct property can reference to the symbol that it is associated with
by prop->menu->sym.

Fix up the one usage of prop->sym, and remove sym from struct property.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h   | 1 -
 scripts/kconfig/parser.y | 2 +-
 scripts/kconfig/symbol.c | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 017843c9a4f4..6e102a3b8bd5 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -191,7 +191,6 @@ enum prop_type {
 
 struct property {
 	struct property *next;     /* next property - null if last */
-	struct symbol *sym;        /* the symbol for which the property is associated */
 	enum prop_type type;       /* type of property */
 	const char *text;          /* the prompt value - P_PROMPT, P_MENU, P_COMMENT */
 	struct expr_value visible;
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 40e46996e6a5..d5c41a5c370c 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -671,7 +671,7 @@ static void print_symbol(FILE *out, struct menu *menu)
 			break;
 		case P_SYMBOL:
 			fputs( "  symbol ", out);
-			fprintf(out, "%s\n", prop->sym->name);
+			fprintf(out, "%s\n", prop->menu->sym->name);
 			break;
 		default:
 			fprintf(out, "  unknown prop %d!\n", prop->type);
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index f56eec5ea4c7..dbc5365d8bbc 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1281,7 +1281,6 @@ struct property *prop_alloc(enum prop_type type, struct symbol *sym)
 	prop = xmalloc(sizeof(*prop));
 	memset(prop, 0, sizeof(*prop));
 	prop->type = type;
-	prop->sym = sym;
 	prop->file = current_file;
 	prop->lineno = zconf_lineno();
 
-- 
2.17.1

