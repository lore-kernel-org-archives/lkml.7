Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801E1C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53762222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lNyrmzkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfDSSWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:22:02 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:53141 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfDSSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:57 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-09.nifty.com with ESMTP id x3J9nQpD030506;
        Fri, 19 Apr 2019 18:49:26 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x3J9mDiS012304;
        Fri, 19 Apr 2019 18:48:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x3J9mDiS012304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555667305;
        bh=anDfa6W5ONHce754PAdi2seOW7FOosRRq63TZhqjhq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNyrmzkrEzGdMdwdrwqYzWssnU73a1VE4o5EHE/QGOpC5eRh1jIeLJfgHCUNbbRZf
         P4fGEzjVdDAQfOVvzk/YsYpkQSYmCLsf5To/YlPN73ztVlDU5Rh0r5JUcnC7G2OsOH
         VpYq4BJw/uwG7phH5Dp3rCKdJXd2RgEb6fCPq33mQopk0novAobnQfoJYb7nbXZnRF
         nnYQf7w/ZMmRIpCQTlT1WW5gkd5vsBLTsbmcT0wM640XY3LvoLoK5l/zP7v2pWaHEO
         dfocS5SF1QPcvAXyAd/v2vXtMjwQNe50qA+EoOFt9UiQb0LoAZmVqQz/T9z9k1Oaa2
         SCp/R5bpxgF9A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 07/11] ARM: mark setup_machine_tags() stub as __init __noreturn
Date:   Fri, 19 Apr 2019 18:47:50 +0900
Message-Id: <20190419094754.24667-8-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for arm, Clang build results in the following modpost
warning:

WARNING: vmlinux.o(.text+0x1124): Section mismatch in reference from the function setup_machine_tags() to the function .init.text:early_print()
The function setup_machine_tags() references
the function __init early_print().
This is often because setup_machine_tags lacks a __init
annotation or the annotation of early_print is wrong.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - new patch

 arch/arm/kernel/atags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index 201100226301..067e12edc341 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
 const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
 	unsigned int machine_nr);
 #else
-static inline const struct machine_desc *
+static inline const struct machine_desc * __init __noreturn
 setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 {
 	early_print("no ATAGS support: can't continue\n");
-- 
2.17.1

