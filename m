Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048B620B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CHPtc9jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfDWDXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:23:09 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:58056 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbfDWDW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:22:58 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3N3L8LH031384;
        Tue, 23 Apr 2019 12:21:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3N3L8LH031384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555989676;
        bh=6a2lxZ60QvbOnt17TfgaQyw8mxjsKyu0piFkGUEaJaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHPtc9jSL+9ebuZO/skz7KvegyF3HYZD/nb6/DUdMdujdL8RxU/elng/gx9lj7zmN
         3LS//0ivw+/Lk89IGnZjJkOdZyR47Hr8cuKKAf9OB2cw7QwCfosqxN7q9/NSvjLQcu
         gswk62JqD1xBPGrZr5R5e7bwFyb8X9fRto9UW4pYcvEXoyrV1Qj9H5ghciINvvuaOZ
         LOES2rW0cy4ghzpgTXNZgj2B7dO7gvFk1/HK8GGyehvEr5qGYAXvqhC4ffi6lQOJ43
         Q6j9nhdCfBQNAj49iioj3TEtmPutjuAz9A6aQXI2YIiNFK8b5AQoiP+KVg1lECf/fc
         HUrKflwhtfxWQ==
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
        Mathieu Malaterre <malat@debian.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 06/10] ARM: mark setup_machine_tags() stub as __init __noreturn
Date:   Tue, 23 Apr 2019 12:21:02 +0900
Message-Id: <20190423032106.11960-7-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
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

Changes in v3: None
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

