Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853EDC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E29208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Mi4XHVnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfELQBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 12:01:24 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:49534 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfELQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 12:01:24 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x4CG0vea021648;
        Mon, 13 May 2019 01:00:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x4CG0vea021648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557676857;
        bh=gSnTfC101cVhlW7pKCTMV+YfvJIzJeB4oEoqbXOS7xA=;
        h=From:To:Cc:Subject:Date:From;
        b=Mi4XHVnMV0TQx1d/KTilX6YjM+7hZTenCwPfBUrej8ypNoQpYsspwT+MrDf5WK4Nl
         XiiHZHQXn0GhiVY5ncZOVuP6/NWQYfJzTyrKOkGyX2RaWuo3AaAtdkBPTicD6PXrdX
         SUspVQGztXg9/u8Kr7pNf8iLx/3I8c9YZpbcwG69xB4pw9FtJDfFoFJjUSPsqJXOW9
         60PLh77XRHZ4MDf4mz+tdqeQiqhTZDST8/+ONd9uGH2BsR3O26heIn0BdpeQcTS3Ia
         2ejIPYF9BDa6sK/JAQQEnrY2Ro5CVlgZ27AB/5Pz7r/2mWRO8HEif8Hevj0Jc57dZc
         UAwUb9J0Gmpsw==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: make conf_get_autoconfig_name() static
Date:   Mon, 13 May 2019 01:00:53 +0900
Message-Id: <1557676853-8068-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only used in confdata.c

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c | 2 +-
 scripts/kconfig/lkc.h      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 8bb74d4..492ac34 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -226,7 +226,7 @@ const char *conf_get_configname(void)
 	return name ? name : ".config";
 }
 
-const char *conf_get_autoconfig_name(void)
+static const char *conf_get_autoconfig_name(void)
 {
 	char *name = getenv("KCONFIG_AUTOCONFIG");
 
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index d871539..cbc7658 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -49,7 +49,6 @@ const char *zconf_curname(void);
 
 /* confdata.c */
 const char *conf_get_configname(void);
-const char *conf_get_autoconfig_name(void);
 char *conf_get_default_confname(void);
 void sym_set_change_count(int count);
 void sym_add_change_count(int count);
-- 
2.7.4

