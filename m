Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C4C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7900B206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iD1FzuN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfHUHDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:03:54 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:46625 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHUHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:03:54 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7L73obt020055;
        Wed, 21 Aug 2019 16:03:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7L73obt020055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566371030;
        bh=sMFPtLuGDuqHPGp8bbKvCgqciiiU1yw2wz53C7izrOw=;
        h=From:To:Cc:Subject:Date:From;
        b=iD1FzuN4oVpqcAMVZKMaQTdOJpL+e9O5HkbgvBpZu+ff4KIkRJI8prPuq5ybO6zDt
         3uYDFIXfrhqG+wLskRbc4zFMicClH+YyEpF6AevKXac6K3bv9jYetcIkg2oSK9v/Z9
         df4KvplaBtWLfAIXN0lIVIxFKEDT0ykcD+7b0YCuD5MG8VKDO0q7xkEAsy8JlwSh/i
         QdRMdIsqlwT/oacO70t6AsIqDiBwU2FkcNtw7hgOpXSCtoqooK6ifq4z50ACurEjKs
         vppH+uMj3DJg/mTlctf6vHYMCuzfYXkv93V/+lnPt+kIk6BtE4NWC56BVmbcdY+rFP
         sEQ2Z+w0VDdVQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unneeded '+' marker from kselftest-merge
Date:   Wed, 21 Aug 2019 16:03:48 +0900
Message-Id: <20190821070348.8596-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This line contains $(MAKE), so Make knows that it will invoke sub-make
without help of the '+' marker.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ec2a6b85a0fa..c0be1a4dbfdd 100644
--- a/Makefile
+++ b/Makefile
@@ -1253,7 +1253,7 @@ kselftest-merge:
 	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
 	$(Q)find $(srctree)/tools/testing/selftests -name config | \
 		xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
-	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
+	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 # ---------------------------------------------------------------------------
 # Devicetree files
-- 
2.17.1

