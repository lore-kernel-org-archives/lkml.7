Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7168C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FD6206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lJXYtboy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfD0Dd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:33:57 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:17155 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfD0Ddv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:33:51 -0400
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x3R3XieA029345;
        Sat, 27 Apr 2019 12:33:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x3R3XieA029345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556336026;
        bh=ZIKJFBEyh/OSHngEXiMX/2USDQxITyIVb8NQIStI1H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJXYtboyPRaPsTlVouC3YTCaJW9WIZn/OvfH4o7hFPhCqMfDfA3ZEEXSJX3fnfWKv
         8FnM0fKlSfNeGLsZJ64qd9Vq+vqxFCznxvshXEeXN2zBQ2ytw8VC7JNVqh54V37tLm
         9CSjd5goq6so+qOS8/Mu+qdMYT1Jmg0lRyanaCMc0qiDvmNSdGZIK6nWM/ORZrwplk
         gu7mwJTAiKOgVVC+vlxjqI1S0dBy1D1AgbwzmtQ6JsSz7GgjOvWoFs0k3Rqy552PiJ
         rq9p1RWLcBDrTM5Dn0i6VwUDCfbQDhha2KCmf1Z2bdWMJY92IersWs4mntoHKRDrwM
         IpYZJWX8DX20Q==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] samples: seccomp: turn CONFIG_SAMPLE_SECCOMP into a bool option
Date:   Sat, 27 Apr 2019 12:33:39 +0900
Message-Id: <1556336020-15634-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
References: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prompt of CONFIG_SAMPLE_SECCOMP claims this is "loadable module
only", which is invalid.

samples/seccomp/ only contains host programs, so having it tristate
is pointless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 samples/Kconfig          | 4 ++--
 samples/seccomp/Makefile | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index d19754c..b98a763 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -103,8 +103,8 @@ config SAMPLE_CONNECTOR
 	  See also Documentation/connector/connector.txt
 
 config SAMPLE_SECCOMP
-	tristate "Build seccomp sample code -- loadable modules only"
-	depends on SECCOMP_FILTER && m
+	bool "Build seccomp sample code"
+	depends on SECCOMP_FILTER
 	help
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index fb43a81..00e0b5e 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -40,5 +40,5 @@ HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
 HOSTLDLIBS_user-trap += $(MFLAG)
 endif
-always := $(hostprogs-m)
+always := $(hostprogs-y)
 endif
-- 
2.7.4

