Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B875C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C215920880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2ioMrvxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDHHzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:55:51 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:33135 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:55:51 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x387sSoo029620;
        Mon, 8 Apr 2019 16:54:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x387sSoo029620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554710069;
        bh=2mZMfdiHyWUddajl/MAR4lGHyfV3TtjPDk5s5iFxLc8=;
        h=From:To:Cc:Subject:Date:From;
        b=2ioMrvxv0qwfshvxv0VMy0EZAkgMjxTfThy3Vkn1Ur6+x6P1fRPccAtkTu0EiCS5J
         t5bIGY7TTgRwVMrKWuBlgzOxX9/N1fX07s84CSS83iAbwv8L9dR8cINdLZFO/TgZB3
         +xkTgUanG6PoT5UixHA7fwLCxvc3qvXLvUj5SlGE6IFBPHQaINAlh+pU55h3CrSIUI
         8/bco5Pk0/Sz1ULADeeqdcGYIdbYvuNSHliT6ZTjgYBK5VrcKFKzQmHDyMyAecaAET
         dVJTpD+Z5JgYVB6HqFogSIaw4nDJbC0T203w1kTOmYbmtmD7qP5B/KzBD2tAHLF66D
         JDbSA1ZwelG/g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: visit mach-* and plat-* directories when cleaning
Date:   Mon,  8 Apr 2019 16:54:25 +0900
Message-Id: <20190408075427.6052-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you run "make clean" for arm, it never visits mach-* or plat-*
directories because machine-y and plat-y are just empty.

When cleaning, all machine, plat directories are accumulated to
machine-, plat-, respectively. So, let's pass them to core- to
clean up those directories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 807a7d06c2a0..b6693a3ddcca 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -293,6 +293,10 @@ core-y				+= arch/arm/crypto/
 core-y				+= arch/arm/firmware/
 core-y				+= $(machdirs) $(platdirs)
 
+# For cleaning
+core-				+= $(patsubst %,arch/arm/mach-%/, $(machine-))
+core-				+= $(patsubst %,arch/arm/plat-%/, $(plat-))
+
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 
 libs-y				:= arch/arm/lib/ $(libs-y)
-- 
2.17.1

