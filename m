Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C778229F7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Wyo7UKxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfFDKPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:15:55 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:39611 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfFDKPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:15:53 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x54AEC7C032511;
        Tue, 4 Jun 2019 19:14:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x54AEC7C032511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559643260;
        bh=SRMHg0IpoERvkCvtt+MdEA3HXdaBY06TLuJd2kcOM8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wyo7UKxFMBHIhbSEfEStq4ZJX/1enP0S4yg0HdvkfmfVToQqkqnScLLeq53gQE5za
         UzQ5PMfKvCiSG09nGjslEwlWkSMIEFXXLSJ2XVkaA/KCeKlXdcaUQb0LX9sINk9K9d
         nTNG/1tzmggZl/DLljcTWuwokwCiMNjuRD5Ow1PmQ+8l6g9bBNJqwMCV7MbNN5Huvu
         igtNKOEs1W8tLtM4nwv0rkmmTU35RV9/5OAreKgH9JdSYbIvSrAEFr/dyc8gprIuj5
         0z2z1QXGHwKoD06HrTVnjzB1Qt46PdB3HOnk5hIOyCh/cF/MM6PDeKY98tSRB79LBe
         KyEO295SLSW5Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] kbuild: remove build_unifdef target in scripts/Makefile
Date:   Tue,  4 Jun 2019 19:14:00 +0900
Message-Id: <20190604101409.2078-7-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604101409.2078-1-yamada.masahiro@socionext.com>
References: <20190604101409.2078-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2aedcd098a94 ("kbuild: suppress annoying "... is up to date."
message"), if_changed and friends nicely suppress "... is up to date"

We do not need per-Makefile tricks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile         | 2 +-
 scripts/Makefile | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index ce5a9551860d..e998c40c94b4 100644
--- a/Makefile
+++ b/Makefile
@@ -1182,7 +1182,7 @@ PHONY += archheaders archscripts
 
 PHONY += __headers
 __headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
-	$(Q)$(MAKE) $(build)=scripts build_unifdef
+	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
 
 PHONY += headers_install
 headers_install: __headers
diff --git a/scripts/Makefile b/scripts/Makefile
index 9d442ee050bd..16bcb8087899 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -31,11 +31,6 @@ always		:= $(hostprogs-y) $(hostprogs-m)
 # The following hostprogs-y programs are only build on demand
 hostprogs-y += unifdef
 
-# These targets are used internally to avoid "is up to date" messages
-PHONY += build_unifdef
-build_unifdef: $(obj)/unifdef
-	@:
-
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
-- 
2.17.1

