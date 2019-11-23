Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D46C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E359D2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JxW6GxU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKWQhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:37:08 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:64651 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKWQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:37:07 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xANGaggc001459;
        Sun, 24 Nov 2019 01:36:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xANGaggc001459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574527003;
        bh=b2XnY177SuO8gk06SbcWRoYrsHQQpflhu5zyta4ZfZY=;
        h=From:To:Cc:Subject:Date:From;
        b=JxW6GxU8YEMUD+vsN/b/GH4gC1gIX6GzqB/QXDCzJfamqA7fRWHPiPBEd80DJ3CW5
         tt5onb3HX9yT0+gfM/E7xDyf8Gh4WDDgsp5sP5maiziCuwJ2hS+40uy2MtvYdwGOz1
         kKfu9weh2DpAuef6J0P/N5WkmZQsJwvJA/sEgsa9ZDKkZreHVgvT5GTFeKVcD3B7qi
         VxIKdgHdVXJmi7ofTsZRYm34XDa2HcpHya8L1rhVUiLdhBxLmPMVCdf0DDIudet4Op
         4PmBqndX20kKhQynYWYhm+2Q4J4JotK0IcfZ3lLAan80+sDq6fS628fAuTjgVvG15O
         WRfrBuIawSJug==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers/component: remove modular code
Date:   Sun, 24 Nov 2019 01:36:32 +0900
Message-Id: <20191123163633.27227-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

component.o is added to obj-y. Hence this is never compiled as
a module.

Remove meaningless modular code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/base/component.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 532a3a5d8f63..3a09036e772a 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -11,7 +11,6 @@
 #include <linux/device.h>
 #include <linux/kref.h>
 #include <linux/list.h>
-#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
@@ -775,5 +774,3 @@ void component_del(struct device *dev, const struct component_ops *ops)
 	kfree(component);
 }
 EXPORT_SYMBOL_GPL(component_del);
-
-MODULE_LICENSE("GPL v2");
-- 
2.17.1

