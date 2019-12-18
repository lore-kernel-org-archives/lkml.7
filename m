Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E226E218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576683327;
	bh=VWAET7kJ6luBa8nqDGJmKGq80Hk71VIjKcZkcyhBUxw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QkrYz8GOXjwwDwiMYt86oDAem1u36/BLnH0aZ9VVx+FfH024L2mpH1OO/13pvrUd1
	 QK4M5wSPwKvff/B1vX+18ShcDsSueHS/eku9tjQ/CjnNS2cziZ64XoGWY58AMB7/2y
	 /DyO0rzu839XtjlMdtoneZDWt52XafAt7vptOoPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfLRPf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:35:26 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:50784 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfLRPfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:35:25 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xBIFYQjT027260;
        Thu, 19 Dec 2019 00:34:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xBIFYQjT027260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576683267;
        bh=vr+kfw+UdhSf2hUfOR0RaGQx/oD7qidfiBWZc/GiY68=;
        h=From:To:Cc:Subject:Date:From;
        b=tXl4szyoWcZKl0uD0jpCwfnubNbnCCUMflulOTsL+7Jb58kjwPt+KnWsIu3EYNgnO
         dNyXt+Gq9iT4WcdC4yMcvmBIl+UKbq4gPWy/dumFo1MRwP2GnO7iIcSulcdMR8uYTi
         PwUzwylO07qX1qJ6MCF+G833WanqKOmA/Ue1RkFq7yQJ7Py061s59IaH3+ChK7l3+U
         4U7036+McnvaCAfHtArAvWngkaMNwkA3rCF2Hfip9nZKW2Y9g6rz+i5Zi0ugzQb4nb
         xObewx8Opxy/vQAYrSlGZ1RdU8YzzQZWAM0yMJcz1H78XjpiMM2S7ezYsF5WZiHCi+
         dlGDgG7t/WAzw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: detect missing include guard for exported headers
Date:   Thu, 19 Dec 2019 00:34:21 +0900
Message-Id: <20191218153422.14557-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding an include guard to every header file is good practice in case
it is included multiple times.

Exported headers are compile-tested for the comprehensive sanity checks.
Let's include the same header twice. If an include guard is missing,
the header will fail to build due to redefinition of something.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---

 usr/include/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 84598469e6ff..e90f5f7903bb 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -93,10 +93,11 @@ header-test- += asm-generic/%
 
 extra-y := $(patsubst $(obj)/%.h,%.hdrtest, $(shell find $(obj) -name '*.h' 2>/dev/null))
 
+# Include the header to detect missing include guard.
 quiet_cmd_hdrtest = HDRTEST $<
       cmd_hdrtest = \
 		$(CC) $(c_flags) -S -o /dev/null -x c /dev/null \
-			$(if $(filter-out $(header-test-), $*.h), -include $<); \
+			$(if $(filter-out $(header-test-), $*.h), -include $< -include $<); \
 		$(PERL) $(srctree)/scripts/headers_check.pl $(obj) $(SRCARCH) $<; \
 		touch $@
 
-- 
2.17.1

