Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B239206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576556084;
	bh=xXnA/lHHiCJV7DGw9UzJDey2YGRAyarwW3/3K3QAnPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yjm2FxI6p6dnpl1TbZr6GsVWW4/tQmDxJ72ZnqAxRsNgGV/qQ/0cC6nIn3xmbXekT
	 gZOyR7MOOfMqXr90Pfyzjku01JGBi04J3xEtFvds+5Sgd4FCLuS+1lV6nTD0hIcPrF
	 43RhpHmawImiC5VvlAc4MggVnVDyJCxENa+bP45k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfLQEOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:14:44 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49221 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfLQEOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:14:43 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xBH4EPAC024524;
        Tue, 17 Dec 2019 13:14:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xBH4EPAC024524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576556067;
        bh=foPF+zAHGQEanKdZGF+9RSpEod3LbyDsyqscpmeIdk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1PvA19yrPQGbDl0vAXkYNDEZFLDq2H3A1PSxvI6/ZZGGxD8fCrAAh2nSehnYh2z0
         4etxh7AGL7OEibGjo9aJqTgKkHypdtBkq+u/f0Y2HshigwB3UQwSHe5vSI/a6to7ey
         ECTf+RI6OBYLvFglRPFGag7PKaPddf/U1YbWhBQ2ThKdNaMT5E0C7BtLroYgUMABe3
         Q7vHVQdYqEo5z1iY0uDlDLIo/Q7J1nRsAzxo5aGOmL3/pOSngpX8pkxsKhy+bv2pFY
         OfeSj0VFKS7OJbeOzT8uOdzcjT0w6XtA5qCKor3FvN6OQWTp713qFvMdE75hK2Hfwn
         Te3TQcQSkiKRA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] kconfig: use parent->dep as the parentdep of 'menu'
Date:   Tue, 17 Dec 2019 13:14:17 +0900
Message-Id: <20191217041424.29285-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217041424.29285-1-masahiroy@kernel.org>
References: <20191217041424.29285-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In menu_finalize(), the dependency of a menu entry is propagated
downwards.

For the 'menu', ->dep and ->prompt->visible.expr are the same.
Both accumulate the 'depends on' of itself and upper menu entries.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/menu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index b1b1ee8cf987..bbabf0a59ac4 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -326,12 +326,10 @@ void menu_finalize(struct menu *parent)
 			 * choice value symbols.
 			 */
 			parentdep = expr_alloc_symbol(sym);
-		} else if (parent->prompt)
-			/* Menu node for 'menu' */
-			parentdep = parent->prompt->visible.expr;
-		else
-			/* Menu node for 'if' */
+		} else {
+			/* Menu node for 'menu', 'if' */
 			parentdep = parent->dep;
+		}
 
 		/* For each child menu node... */
 		for (menu = parent->list; menu; menu = menu->next) {
-- 
2.17.1

