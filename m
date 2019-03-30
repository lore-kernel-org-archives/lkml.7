Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779C6217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1f8uCkfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfC3ME3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:04:29 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:36046 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfC3ME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:04:28 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2UC4MsP021262;
        Sat, 30 Mar 2019 21:04:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2UC4MsP021262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553947465;
        bh=uVzljSN+7FodKIL08wsjW9LWqryQWeeomDXG3kJzSxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1f8uCkfF3pECtf0HJc5H88nAd4mEuW6N4TxjyK2jMBX8krDlSF8+rgHSPnbZNeOxC
         r04vf4QSIF8rP+iz2BOXXqf7oQP8TwmaZO8kiWwTByCNyxnbkfZR96BVbxyELB/lQt
         jSoxx8zc19d+xsMaSryBzz01DVO2r0BP0FHV0JUsBsOl0JqSs9sY1wnBP3Up7KPYSs
         UB6UviH4G+/+EQbFynGM9IBFun1a+2laN7bCdB5c4jTwpGMAZcANu7MoMRO9OodtYB
         xpuJoNAaQBFruGl1uvIktDGm5+1xVv2N8Tnh60HC7DWzWpwcgIRlkCHCiVUWgqrnma
         imMXBvcKVicnw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] kbuild: mkmakefile: do not check the generated Makefile marker
Date:   Sat, 30 Mar 2019 21:04:15 +0900
Message-Id: <1553947458-8311-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553947458-8311-1-git-send-email-yamada.masahiro@socionext.com>
References: <1553947458-8311-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hunk was added to avoid accidental overwrite of the top Makefile
in case O= points to the top of the source tree.

As commit 4f1127e20437 ("kbuild: fix infinite make recursion"),
it caused some troubles in the past because Kbuild assumes O=
as out-of-tree build, while it actually works in the source tree.

Now this works more properly; if O= points to the source directory,
it is handled as in-tree build. So, this sanity check is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mkmakefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/mkmakefile b/scripts/mkmakefile
index 412f13f..31de468 100755
--- a/scripts/mkmakefile
+++ b/scripts/mkmakefile
@@ -7,12 +7,6 @@
 # Usage
 # $1 - Kernel src directory
 
-# Only overwrite automatically generated Makefiles
-# (so we do not overwrite kernel Makefile)
-if test -e Makefile && ! grep -q Automatically Makefile
-then
-	exit 0
-fi
 if [ "${quiet}" != "silent_" ]; then
 	echo "  GEN     Makefile"
 fi
-- 
2.7.4

