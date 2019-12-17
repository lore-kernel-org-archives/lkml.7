Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6912072B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576555392;
	bh=I1qVmWQ/6ZD8PCtEJBOKUkHsZu4dVNUSi93DEv6reWE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yP1dsvvZ5qot7zqBxgl4Oa5MNBXGDx9PuVGOt03sSr9pUuocEo/soqFFnPEbro43e
	 gEzBmUYgdyvnRqyqv4qPgq2q6N/rSMD5whyfi8jcuByAXI65IwBZJkloPwY7IwVO4A
	 gOD1IqjbQD0A8QYA/n6O+FEgIEa2ozD+/xX5nWaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfLQEDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:03:11 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:36589 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLQEDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:03:10 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id xBH42mj7022153;
        Tue, 17 Dec 2019 13:02:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com xBH42mj7022153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576555368;
        bh=QtwtpsIrblHUJGhyD5ODjIkuJWwwT4XJdanpt+Mk7pk=;
        h=From:To:Cc:Subject:Date:From;
        b=l8QqBNCbi4848JF9pgsfT0Wo0Et+aRy86X/Ve+k+yoZx0sYABm5t8z6o944SN96LW
         v5xl23q9dFS0HGZftGKpWXQwuXDle21Cky7YiKlcykjfKNyCJ9aHRSo5QhK97cjxUm
         tO+Gvw5RqFZl456R42LTR2egl8icMZYiDv+aGR5ofY16jzY2H0XEItoIKMyDtoR7g7
         8eKlOpzhWDsYZRGoyywHYNir/U+l0vG4oDLekUZ2KxAFAelDS13WM39NmM0jAlNEs9
         nNrx33Y+vkEV/5k/t9A9P5D+FOIs1sFTM7ed1Sy0TvnPCjDEm2Yh6eGymrrp3OjFd0
         Di3k1ilpWUuIw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: warn nested choice
Date:   Tue, 17 Dec 2019 13:02:45 +0900
Message-Id: <20191217040245.24441-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you create a 'choice' inside another 'choice', I do not know how
it should work.

I applied this patch onto v5.5-rc1, and I see one warning:

  drivers/usb/gadget/legacy/Kconfig:458: warning: nested choice. previous choice entry is drivers/usb/gadget/Kconfig:486

This is because entire drivers/usb/gadget/legacy/Kconfig is in the
choice context.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/parser.y | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index b3eff9613cf8..86e75ea74731 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -30,6 +30,9 @@ struct symbol *symbol_hash[SYMBOL_HASHSIZE];
 
 static struct menu *current_menu, *current_entry;
 
+/* while in the choice block, this points to the location of the choice entry */
+static struct menu *current_choice_menu;
+
 %}
 
 %union
@@ -239,6 +242,14 @@ choice: T_CHOICE word_opt T_EOL
 	menu_add_entry(sym);
 	menu_add_expr(P_CHOICE, NULL, NULL);
 	free($2);
+
+	if (current_choice_menu)
+		zconfprint("warning: nested choice. previous choice entry is %s:%d",
+			   current_choice_menu->file->name,
+			   current_choice_menu->lineno);
+
+	current_choice_menu = current_entry;
+
 	printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
 };
 
@@ -439,7 +450,7 @@ prompt:	  T_WORD
 ;
 
 end:	  T_ENDMENU T_EOL	{ $$ = "menu"; }
-	| T_ENDCHOICE T_EOL	{ $$ = "choice"; }
+	| T_ENDCHOICE T_EOL	{ $$ = "choice"; current_choice_menu = NULL; }
 	| T_ENDIF T_EOL		{ $$ = "if"; }
 ;
 
-- 
2.17.1

