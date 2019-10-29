Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2250FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F2C21734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Wx5lpNCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfJ2Min (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:38:43 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:33928 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfJ2Min (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:38:43 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x9TCcFU9026616;
        Tue, 29 Oct 2019 21:38:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x9TCcFU9026616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572352702;
        bh=rRs8Ed7t4bAer/X1dc9tlKv3gE2rP5G57gkcJJvIIzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wx5lpNCAWh0/fyhSglgPtgut//wljqNN4vx7Lbqx1ZhuPpRivg83hoCLnyCcntuzu
         U9RPsoIpsytpjbkToeJY+5WYt82+HYbs0pJd3BtbJMfMcBPcgOHuPZ2a+NbVs/4KBY
         AKaFq3Ky3cZ2t+BemZLqYWnSPrH/mekrlSpwcMCUWODxeoUYzmpnP8MVzO2qdSAZdt
         s27bGUd7tePUX8QCrh9dwaykFQx/SvgZ/ao/EBBNfww0FW6fZ59oWvrTJFa6Sda5U6
         aU/iw2JlhQxBCOIFNY5eUHLyP/Je4/BknAL4de9oZJP9A5eA20yaCwVQIkIN8cP014
         Qgm4BCvojQSxw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mospost: remove unneeded local variable in contains_namespace()
Date:   Tue, 29 Oct 2019 21:38:09 +0900
Message-Id: <20191029123809.29301-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029123809.29301-1-yamada.masahiro@socionext.com>
References: <20191029123809.29301-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable, ns_entry, is unneeded.

While I was here, I also cleaned up the comparison with NULL or 0.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f7425f5d4ab0..f70b924f379f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -239,10 +239,8 @@ static struct symbol *find_symbol(const char *name)
 static bool contains_namespace(struct namespace_list *list,
 			       const char *namespace)
 {
-	struct namespace_list *ns_entry;
-
-	for (ns_entry = list; ns_entry != NULL; ns_entry = ns_entry->next)
-		if (strcmp(ns_entry->namespace, namespace) == 0)
+	for (; list; list = list->next)
+		if (!strcmp(list->namespace, namespace))
 			return true;
 
 	return false;
-- 
2.17.1

