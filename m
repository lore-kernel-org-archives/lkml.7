Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BB7C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 15:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB83208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 15:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="axcmuWsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfHJPya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 11:54:30 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:34081 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 11:54:21 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x7AFrG8w009713;
        Sun, 11 Aug 2019 00:53:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x7AFrG8w009713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565452400;
        bh=KecbMzZwJmwYQUVDejPwmn2JvmhFXY02Xy+SlXS+v/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axcmuWsGYPgVRb8Z2O8uu/otKnz12VRAUP+qIP8MwftpsEOznOjLHRJ2HQ+fnUMvv
         Gh+F00b84fuYGb4oFuecwHrHuvx0ssiY3j6TJ6LC/Vz10ji159IOdTy/wKsfTnJYCF
         1zzSkMUGEtj3P4wCFTB1JUXKAtN+9ssqmI3BvZCnfq/4YYjdVm7C4jZ86bErr+v2w9
         ITu4g2nFrVKY2x/O/W0s5I7qaicAe37feejQ6y+F2cKQ9BAdS07YOlT5Rk8OzEN2/l
         p83A2Uum7HaHARYq6t+MP1CJXdir/jCqukRUnuuXmohE7yuK6D6OEoOTUS69K6578q
         2vzSHFTDfRZnA==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] kbuild: fix modkern_aflags implementation
Date:   Sun, 11 Aug 2019 00:52:59 +0900
Message-Id: <20190810155307.29322-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810155307.29322-1-yamada.masahiro@socionext.com>
References: <20190810155307.29322-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the single target building %.symtypes from %.S, $(a_flags) is
expanded into the _KERNEL flags even if the object is a part of a
module.

$(real-obj-m:.o=.symtypes): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)

... would fix the issue, but it is not nice to duplicate similar code
for every suffix.

Implement modkern_aflags in the same way as modkern_cflags.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 64e47a9a54c5..3633558f7861 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -309,10 +309,9 @@ $(obj)/%.h.s: $(src)/%.h FORCE
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 
-modkern_aflags := $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)
-
-$(real-obj-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
-$(real-obj-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
+modkern_aflags = $(if $(part-of-module),				\
+			$(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE),	\
+			$(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL))
 
 # .S file exports must have their C prototypes defined in asm/asm-prototypes.h
 # or a file that it includes, in order to get versioned symbols. We build a
-- 
2.17.1

