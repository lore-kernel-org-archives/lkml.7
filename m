Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7021C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB17206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JknW6pMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGaGOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:14:25 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26868 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGaGOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:14:24 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6V6Dxu9013384;
        Wed, 31 Jul 2019 15:14:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6V6Dxu9013384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564553642;
        bh=sH+MOh98g+QOM+ma4Nt6m2kGY+caY9b/ArIx5nWicj4=;
        h=From:To:Cc:Subject:Date:From;
        b=JknW6pMU374gaB26mJvjXH2rgUZMUq42WovhVMPPHqdNfCmWWaQgcUyGLnbjDmvcE
         IgDg8mV4cvJWu9zD1Ex1dM/LFGvSEgb8LIacb1Emw/zjghU0QwJJLjSVm5eYDde8Ff
         eFb6a9y1N0b6oF6PFaGNscffxvbhdppJSUP5fHoISREaXmM6c7TB61SXMaon+2RFXd
         IuRtQdLL/Yo0dzQCTtl/XMlxGnlQZYB1x0MKs3QE4DwwEi59bx+XybU8bNKIDM7lXA
         kdd9TJPKdNSZCDhfw60BocLGzus7k+11C8DhMOLXtrFjNfp4JqGrtz742RIsMVH3Cr
         rjPPgcNjJUy8w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: add [M] marker for build log of *.mod.o
Date:   Wed, 31 Jul 2019 15:13:58 +0900
Message-Id: <20190731061358.30117-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This builds module objects, so [M] makes sense.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.modpost | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 6e328190d609..6c237af41417 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -112,7 +112,7 @@ $(modules:.ko=.mod.c): modules-modpost ;
 # modname is set to make c_flags define KBUILD_MODNAME
 modname = $(notdir $(@:.mod.o=))
 
-quiet_cmd_cc_o_c = CC      $@
+quiet_cmd_cc_o_c = CC [M]  $@
       cmd_cc_o_c = $(CC) $(c_flags) $(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE) \
 		   -c -o $@ $<
 
-- 
2.17.1

