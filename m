Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6781EC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA5420857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VVP0CUW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCZE1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:27:24 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:56907 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZE1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:27:24 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x2Q4R5cf022680;
        Tue, 26 Mar 2019 13:27:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x2Q4R5cf022680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553574426;
        bh=luaBYMoq4WHRW4hlBUkSayGbn0IoOPI5Kl//OZWr9Zg=;
        h=From:To:Cc:Subject:Date:From;
        b=VVP0CUW9SUp2L0deEQyuLVk4Z6DPFoQXURh4sLlw+8f3wflI5yny7tebNNtWsUsh4
         JoJ9vLZiWwkMGOod2/7+m8TKC32AHNrh2xxK3IlDK3mC84WuJSaBGJ9PxTNHX73TU8
         befG44PU09DgTOByJrJTtvzUngQtJTKdcNiH9xPv5b+LkVx8AxATYm1dlqRLITjIH+
         lSTpD90hZdAmo5WgNN1mhrvE1fnUBAL6gA18npQ8OjGrhZUINPK069KzPXNDkUz8jx
         j6091w8HeMbejLqEa4NmkpmczoAqO5rP1wND+Z73Gm/29WH5LQfrgz6XvmkeOr7q6w
         qM28DBof75qFQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: do not overwrite .gitignore in output directory
Date:   Tue, 26 Mar 2019 13:26:58 +0900
Message-Id: <1553574418-21033-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3a51ff344204 ("kbuild: gitignore output directory") seemed to
bother people who version-control output directories.

Andre Przywara says:
"Unfortunately this breaks my setup, because I keep a totally separate
git repository in my build directories to track (various versions of)
.config. So .gitignore there is carefully crafted to ignore most build
artefacts, but not .config, for instance."

Link: https://lkml.org/lkml/2019/3/22/1819
Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5fe5431..70fc778 100644
--- a/Makefile
+++ b/Makefile
@@ -499,7 +499,8 @@ outputmakefile:
 ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree) source
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
-	$(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
+	$(Q)test -e .gitignore || \
+	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif
 
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
-- 
2.7.4

