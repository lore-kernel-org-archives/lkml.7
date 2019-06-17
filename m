Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED760C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27992084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jlmJDnmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfFQQVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:21:46 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:45807 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfFQQVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:21:46 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x5HGLP0a021960;
        Tue, 18 Jun 2019 01:21:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x5HGLP0a021960
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560788485;
        bh=9Vm4Ynh/kWZgI3KQqSGTAag3aRK8FA3tSa76sSISXdg=;
        h=From:To:Cc:Subject:Date:From;
        b=jlmJDnmTI2akcO5J5J7XjrMV/pUBRF9GNH/gFAbyIFLtAgoE54PZSNIudD6klV6po
         rnTCSBjGYlM33MilC4g/ejVOspJx9Cc4ArKA355ftACfIhH5W/9UVFfgahxbFsTApk
         /FNz+ovCbmWvhVNviUlHRSdi+3w4aUBT3SKr12RmdSM9a3ufyBiO00YZP9Q0AxBpAk
         X1rvtGKkXjnJvwdUM0kc/41GV5OXoCkbldysAMk+ga1VdX0RTgt7KBz7LX3Xy2eVM2
         4ZPf1Pl+cPCEHZ7w/VQVE9IdcVRJaZDSoEeDzU+qLniBcD+gVfxxuP26FxsYM2oWLY
         W2jXJYRBR8c4w==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH] libfdt: reduce the number of headers included from libfdt_env.h
Date:   Tue, 18 Jun 2019 01:21:23 +0900
Message-Id: <20190617162123.24920-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, libfdt_env.h includes <linux/kernel.h> just for INT_MAX.

<linux/kernel.h> pulls in a lots of broat.

Thanks to commit 54d50897d544 ("linux/kernel.h: split *_MAX and *_MIN
macros into <linux/limits.h>"), <linux/kernel.h> can be replaced with
<linux/limits.h>.

This saves including dozens of headers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/libfdt_env.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index edb0f0c30904..2231eb855e8f 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -2,7 +2,7 @@
 #ifndef LIBFDT_ENV_H
 #define LIBFDT_ENV_H
 
-#include <linux/kernel.h>	/* For INT_MAX */
+#include <linux/limits.h>	/* For INT_MAX */
 #include <linux/string.h>
 
 #include <asm/byteorder.h>
-- 
2.17.1

