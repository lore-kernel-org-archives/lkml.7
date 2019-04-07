Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357EAC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB5C20B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mir15gv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDGKD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:03:26 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:57862 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfDGKD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 06:03:26 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x37A3K5I014201;
        Sun, 7 Apr 2019 19:03:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x37A3K5I014201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554631401;
        bh=UWHnQmX6eW2n3Qh+U9rGF7HsMZ1uVw/OMgj6JlL7h3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=mir15gv8GnC22/lVbm5NTYl6b5/Xl5hu9WmQ6k88Hgpe3qLsDGfeF6IEH8TcZ0IsR
         +t8I7Ty117oIgWizTzWJMirRPBTUCPA/ig4Nf/SOFtEAeda4UW0k4QkPgN1L6AQWuG
         1Wp/U3leZsI8s7el6E7L7U05oH3PVrzjfA9nyeTGue+YKtXFuTjj0PClcDvN1AbCHV
         ZRIdVlKzLGuVfWEn/7dbQjXncSITcVMJIb9WJLd2rADqmnHjURajlYy9SdtAWNPYYN
         wCAB7PiUFJpKzXWChzx4PbsFS8L2m2EjO9UB+Py5DTj4acQJTjKZNDNvhyvEGbBI1D
         ElOv6uMVA3E9A==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unneeded dependency for include/config/kernel.release
Date:   Sun,  7 Apr 2019 19:03:18 +0900
Message-Id: <1554631398-29297-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is unneeded since commit 43fee2b23895 ("kbuild: do not redirect
the first prerequisite for filechk").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 895022b..10643c3 100644
--- a/Makefile
+++ b/Makefile
@@ -1067,7 +1067,7 @@ filechk_kernel.release = \
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
 
 # Store (new) KERNELRELEASE string in include/config/kernel.release
-include/config/kernel.release: $(srctree)/Makefile FORCE
+include/config/kernel.release: FORCE
 	$(call filechk,kernel.release)
 
 # Additional helpers built in scripts/
-- 
2.7.4

