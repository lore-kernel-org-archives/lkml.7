Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE6C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B11722C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HHlRhbNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGZCMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:12:00 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:63670 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGZCLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:11:45 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6Q2B03k020523;
        Fri, 26 Jul 2019 11:11:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6Q2B03k020523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564107063;
        bh=nOKtkgXfIVcWv2vTVE3jpIpHqbVnmkI/DmNIReebTe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHlRhbNo1ln2bJlCtBH2WZ40lxEa9J4wi+PaKV3i8SSd0c35WyDiSS6wXPknju9om
         8B8KdYixmjkrlC5Y6Ki7VXcaWnIylTAeNDz8PKh2SR6P64FwOoCUdtcsSDZKBzN/kU
         MrVLStkWF9L0N0+rdsKhfrwFXXrc152JFzW5S+j0usjaQtNNxiUJ32BF/K7V7/dMt+
         EjjbSFxnpIM47qP/GFmAuyG5F2ZjWyRO2ZwyhxRmUKIcy36bpYd8Ujzq7PCMG4EZmI
         t1vn5ogE8MceqLOboNsb9S82127dFNyWK3QFji0MklniUOJlSBaH7HCRWy6sMZd0dZ
         5UOYvSEDoRPxw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dave Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/5] integrity: remove pointless subdir-$(CONFIG_...)
Date:   Fri, 26 Jul 2019 11:10:55 +0900
Message-Id: <20190726021058.4212-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726021058.4212-1-yamada.masahiro@socionext.com>
References: <20190726021058.4212-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ima/ and evm/ sub-directories contain built-in objects, so
obj-$(CONFIG_...) is the correct way to descend into them.

subdir-$(CONFIG_...) is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 security/integrity/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index b6d6273a4176..35e6ca773734 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -14,7 +14,5 @@ integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 					platform_certs/load_uefi.o
 integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
 
-subdir-$(CONFIG_IMA)			+= ima
 obj-$(CONFIG_IMA)			+= ima/
-subdir-$(CONFIG_EVM)			+= evm
 obj-$(CONFIG_EVM)			+= evm/
-- 
2.17.1

