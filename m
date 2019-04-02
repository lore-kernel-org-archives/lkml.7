Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDAEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6205120830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0IxdWsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfDBPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:20:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cxEjSqGOPRarKa1D2qo1b1UER3b4LpnSfVFv6d3Y7UE=; b=m0IxdWsM3bI1uVspBrRKGEop1
        U22L+Yrf4Kr7AljJ70iQhWYVoRYMoSaCs2PjrbD2g+VMKq7C+BGcuTx0LRkgBm4PUcRnJCQE5rUbm
        STPkavDaBK4kBOoA7eBB+v+bfhsEKcLsxHH/dJMznFDAXi7YbwspBQSQEjwHs7M1uKWDadKwIhfgg
        TTGdGmDy1u+JFKTQ0+axdfqepnH2MAiY4myF6lwHGnQAwXnoNrndvCDpMa++QZNUtbAQ/HfHp6NNa
        OY5y4VwCbNjsMfIhGvrTsqRmoOKfgwYHPJBzPdzh1tQ3/8QHhrB015ELFasnPVl0bWJgwqBe2sO6o
        0G6q70D1A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBLCs-0008N1-0H; Tue, 02 Apr 2019 15:20:10 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] reset: fix linux/reset.h errors
Message-ID: <099f1078-104d-c434-ad6c-f28c6479c614@infradead.org>
Date:   Tue, 2 Apr 2019 08:20:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

The header file <linux/reset.h> uses errno constant(s) and the
ERR_PTR() macro but does not #include the appropriate header files
that provide those facilities, so add 2 header files to fix
build errors.

  CC [M]  drivers/gpu/drm/lima/lima_device.o
In file included from ../drivers/gpu/drm/lima/lima_device.c:5:0:
../include/linux/reset.h: In function ‘__device_reset’:
../include/linux/reset.h:77:25: error: ‘ENOTSUPP’ undeclared (first use in this function)
  return optional ? 0 : -ENOTSUPP;
../include/linux/reset.h:77:25: note: each undeclared identifier is reported only once for each function it appears in
../include/linux/reset.h: In function ‘__of_reset_control_get’:
../include/linux/reset.h:85:36: error: ‘ENOTSUPP’ undeclared (first use in this function)
  return optional ? NULL : ERR_PTR(-ENOTSUPP);
../include/linux/reset.h: In function ‘__reset_control_get’:
../include/linux/reset.h:93:36: error: ‘ENOTSUPP’ undeclared (first use in this function)
  return optional ? NULL : ERR_PTR(-ENOTSUPP);
../include/linux/reset.h: In function ‘__devm_reset_control_get’:
../include/linux/reset.h:101:36: error: ‘ENOTSUPP’ undeclared (first use in this function)
  return optional ? NULL : ERR_PTR(-ENOTSUPP);
../include/linux/reset.h: In function ‘devm_reset_control_array_get’:
../include/linux/reset.h:107:36: error: ‘ENOTSUPP’ undeclared (first use in this function)
  return optional ? NULL : ERR_PTR(-ENOTSUPP);
../include/linux/reset.h: In function ‘of_reset_control_array_get’:
../include/linux/reset.h:114:36: error: ‘ENOTSUPP’ undeclared (first use in this function)
  return optional ? NULL : ERR_PTR(-ENOTSUPP);
In file included from ../drivers/gpu/drm/lima/lima_device.c:5:0:
../include/linux/reset.h: In function ‘__devm_reset_control_get’:
../include/linux/reset.h:102:1: warning: control reaches end of non-void function [-Wreturn-type]
 }


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/reset.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20190402.orig/include/linux/reset.h
+++ linux-next-20190402/include/linux/reset.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_RESET_H_
 #define _LINUX_RESET_H_
 
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 
 struct device;


