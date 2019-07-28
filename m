Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A3AC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99242070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TvRaYBwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfG1QsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 12:48:21 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:42834 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1QsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 12:48:21 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6SGl8D5014222;
        Mon, 29 Jul 2019 01:47:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6SGl8D5014222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564332429;
        bh=mpYHa7s6QzNrys/LyWTOOn2taSGGO863b5EDmcRvPjs=;
        h=From:To:Cc:Subject:Date:From;
        b=TvRaYBwCMHeP0TwOcouBqcrCv7LVMt57qIX3aCICxRQJalnxM5a5UEeFY53Z45THH
         Q3Z1+zXUlosMC8SscI0dw6v+PGOONeko9pouiH1WJ0KWUPJIIeaXdqU4i8xbPOAOH+
         wUOk3CXpX4ujLsOiSE1I8LvuX+FqrrOz1B87oI1rhiZh0timbgV9YU45u6WfHU5PDr
         Reg4SoUbRk4cmLQ+2rQSaDmzPPTpauPGgX53ve5n40Y9D0kIAjqmxUXrum9PqDvmAQ
         OC8hGHkVEnqUiBg8QDiY8bc8FFzhSvuaULlMsLpdQJFJpxw7KCdWTGq+eh6GGc9T8B
         lB/QH4h9C3GJQ==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: raid_class: add include guard to raid_class.h
Date:   Mon, 29 Jul 2019 01:47:06 +0900
Message-Id: <20190728164706.16558-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/raid_class.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index 5cdfcb873a8f..b62e42d8bb17 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -4,6 +4,10 @@
  *
  * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
  */
+
+#ifndef _LINUX_RAID_CLASS_H
+#define _LINUX_RAID_CLASS_H
+
 #include <linux/transport_class.h>
 
 struct raid_template {
@@ -81,3 +85,4 @@ void raid_class_release(struct raid_template *);
 int __must_check raid_component_add(struct raid_template *, struct device *,
 				    struct device *);
 
+#endif /* _LINUX_RAID_CLASS_H */
-- 
2.17.1

