Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD524C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B5B2082C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GnhBvibv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406459AbfIGCH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 22:07:56 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:63002 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfIGCH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 22:07:56 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x8726mnV030289;
        Sat, 7 Sep 2019 11:06:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x8726mnV030289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567822008;
        bh=d519+5LBWEDmACzdn23VGIIVCmRjE22Y92knNc+yYWU=;
        h=From:To:Cc:Subject:Date:From;
        b=GnhBvibvu9LVsstj+fRbsWe/77NR84vhmxA7gKwdT9JKnX0fG64hhds/RCfO2oZD1
         XTdN3R20HFq5bGkK4UOecyhtJJUth+lUZNGTIPwoWNgxdsPRpv/ctw1RZQyb30sUW0
         91PYnSMiV13lS7nrX/A1rrXKXb0cHWlhXuaTrnBniGDBmFDFLRq2d7KiwIbE7eoLG8
         p5wnAXY6QAb25kQ0AEpeKcLHnXVYvcNnPVNutQYx6RKDogMBdQJjzxX3LPyOVXOKlI
         IaWvYjqyfGciuWzSC/zkqb4uvI+/y2frVgThCtSPwI9ljsArQym3UHu5bSLG+IK3tW
         cDnPAcbcROVBg==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christian Brauner <christian@brauner.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] samples: watch_queue: add HEADERS_INSTALL dependency
Date:   Sat,  7 Sep 2019 11:06:31 +0900
Message-Id: <20190907020631.29359-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

samples/watch_queue/Makefile specifies the header search path
-I$(objtree)/usr/include, which is probaby needed to include
<linux/watch_queue.h> etc.

To make it work properly, add "depends on HEADERS_INSTALL" so that
headers are installed into $(objtree)/usr/include before building
this sample.

Fixes: 7141642ed120 ("Add sample notification program")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Arnd reported a build error:
https://lkml.org/lkml/2019/9/6/665

Missing "depends on HEADERS_INSTALL" is the only reason
I have in my mind.

If it still fails to build, I do not know why.


 samples/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 2c3e07addd38..d0761f29ccb0 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -171,6 +171,7 @@ config SAMPLE_VFS
 
 config SAMPLE_WATCH_QUEUE
 	bool "Build example /dev/watch_queue notification consumer"
+	depends on HEADERS_INSTALL
 	help
 	  Build example userspace program to use the new mount_notify(),
 	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
-- 
2.17.1

