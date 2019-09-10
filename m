Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6095D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404672AbfIJGuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:50:37 -0400
Received: from mx1.emlix.com ([188.40.240.192]:33030 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbfIJGuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:50:37 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 02:50:36 EDT
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id B189A5F8BE;
        Tue, 10 Sep 2019 08:41:01 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Subject: [PATCH v3][RESEND] scripts: use pkg-config to locate libcrypto
Date:   Tue, 10 Sep 2019 08:41:01 +0200
Message-ID: <2010898.sAvVGPNi7W@devpool35>
Organization: emlix GmbH
In-Reply-To: <20538915.Wj2CyUsUYa@devpool35>
References: <20538915.Wj2CyUsUYa@devpool35>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise build fails if the headers are not in the default location. While at
it also ask pkg-config for the libs, with fallback to the existing value.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Cc: stable@vger.kernel.org
---
 scripts/Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index 16bcb8087899..1715adcd8f81 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -8,7 +8,11 @@
 # conmakehash:   Create chartable
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
+PKG_CONFIG?= pkg-config
+
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
+CRYPTO_LIBS = $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+CRYPTO_CFLAGS = $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null)
 
 hostprogs-$(CONFIG_BUILD_BIN2C)  += bin2c
 hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
@@ -23,8 +27,9 @@ hostprogs-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE) += insert-sys-cert
 
 HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
-HOSTLDLIBS_sign-file = -lcrypto
-HOSTLDLIBS_extract-cert = -lcrypto
+HOSTLDLIBS_sign-file = $(CRYPTO_LIBS)
+HOSTCFLAGS_extract-cert.o = $(CRYPTO_CFLAGS)
+HOSTLDLIBS_extract-cert = $(CRYPTO_LIBS)
 
 always		:= $(hostprogs-y) $(hostprogs-m)
 
-- 
2.23.0




