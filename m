Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDF4C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 04:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91712087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 04:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MvD94gkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfD2EHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 00:07:07 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:61852 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfD2EHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:07:06 -0400
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x3T46o87012916;
        Mon, 29 Apr 2019 13:06:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x3T46o87012916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556510810;
        bh=Bob1QfvAat3FkajVVhYUSYwY5ffmgFQaoKrn24XXkYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MvD94gkAOFNDETi657i9eQDDhRGRZMq+BR9PUQbs1j6XF4eDJGRz7KRBIfXN6tu1e
         2baD7oMaJf5x39DjplW4/ulYYhpSZJ+pNIQRrljHRQZI7sEomgNU38NEUcZOfykvFb
         4b8nm/CrRhtUDsQp4byhGj2R4YZLh0nrqqe2jOETA+VKmpq8DJ/WSzcPct0AAgkFE2
         C479QpNFXsk9cGy8fz9z41Pai66vDYuA2kI9prgCi4e5mVNQHWbDzWOqQyTaYfUZKK
         ap390UF3XOiVXCHff8mab5gK3kE7nXa9sDEuYTX3mdZ0WeEVe2nIVHh9t8V0oIdWrh
         QnAdasnPxkl4Q==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags.sh: fix direct execution of scripts/tags.sh
Date:   Mon, 29 Apr 2019 13:06:43 +0900
Message-Id: <1556510803-5628-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought this script was run via "make tags" etc. but some people
run it directly.

Prior to commit a9a49c2ad9b9 ("kbuild: use $(srctree) instead of
KBUILD_SRC to check out-of-tree build"), in such a usecase, "tree"
was set empty since KBUILD_SRC is undefined. Now, "tree" is set to
"${srctree}/", which is evaluated to "/".

Fix it by taking into account the case where "srctree" is unset.

Link: https://lkml.org/lkml/2019/4/19/501
Fixes: a9a49c2ad9b9 ("kbuild: use $(srctree) instead of KBUILD_SRC to check out-of-tree build")
Reported-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 6a55180..70e14c6 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -19,7 +19,7 @@ ignore="$ignore ( -name *.mod.c ) -prune -o"
 # Do not use full path if we do not use O=.. builds
 # Use make O=. {tags|cscope}
 # to force full paths for a non-O= build
-if [ "${srctree}" = "." ]; then
+if [ "${srctree}" = "." -o -z "${srctree}" ]; then
 	tree=
 else
 	tree=${srctree}/
-- 
2.7.4

