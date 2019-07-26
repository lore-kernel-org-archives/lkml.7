Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C55C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F4F22C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wbo3cxpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfGZCLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:11:48 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:63665 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfGZCLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:11:45 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6Q2B03l020523;
        Fri, 26 Jul 2019 11:11:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6Q2B03l020523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564107064;
        bh=d0XIimaYVsZuor/Vqvat3vZ1jPTCJjSdyV2UnY7OLcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wbo3cxpRfJwWVXDE26VHPcZJzvkvNPmdtSZzhaCH/OleeiJo9oSsmQa4nM+LrBxZg
         jKlgx8BYKcXVSFGrXxyFiG54oKueKUWsFi738OIOmdKo9xua1720j1j7tGlCzXs1hn
         es9RTXA6gHvxt8YcxXZKtrWV9eEkZuDloj5BsGn5lhFm+kbi0X6kPuj4/9WBIp/S1e
         Vxe5njb7eGHy+fY+Dg3j0Q0hZILr5jBVah8cU3o4QgRnNhBinAii83DCHbsdEK3+XH
         Esj0rHgLwTKeY5QU8xV/ltusQxMn6dDjYstdEVeNlljsWUh/O0I7a2+hUuGyWVhGM2
         ANCgN1FC3r1lQ==
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
Subject: [PATCH 3/5] integrity: use obj-y for non-modular objects
Date:   Fri, 26 Jul 2019 11:10:56 +0900
Message-Id: <20190726021058.4212-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726021058.4212-1-yamada.masahiro@socionext.com>
References: <20190726021058.4212-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_INTEGRITY is a boolean option, so none of these objects is
linked into a module.

All of the other CONFIG options here depend on CONFIG_INTEGRITY,
so there is no point in creating the composite object, integirity.o

Flatten the code into the obj-$(CONFIG_...) form.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 security/integrity/Makefile | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 35e6ca773734..53bb1d70e631 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -3,16 +3,14 @@
 # Makefile for caching inode integrity data (iint)
 #
 
-obj-$(CONFIG_INTEGRITY) += integrity.o
-
-integrity-y := iint.o
-integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
-integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
-integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
-integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
-integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
+obj-$(CONFIG_INTEGRITY) += iint.o
+obj-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
+obj-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
+obj-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
+obj-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+obj-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 					platform_certs/load_uefi.o
-integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
+obj-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
 
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
-- 
2.17.1

