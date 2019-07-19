Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A84C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF9021850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508630;
	bh=0x+K6BU4fDjllyEo+Yimd2GVCgLa5ENbGONnnLzPI4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q9uFj6jag5rGuDQcIjikXjLki1Uzp3GS0MXAg1s9KI6l0ymHaLF6SNzuwf2xbApzj
	 bPme0Nq6I5NLdyH51dT6HwyvAkYy8UkrDovYlb24ZRTFrxR36juGSmYXIl+aPKk0x2
	 HE4dN3ZQ/hCB2TvnB1KgEGFpA2nf7PSJdN+XB0kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfGSD5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfGSD5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:57:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900062184E;
        Fri, 19 Jul 2019 03:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508622;
        bh=0x+K6BU4fDjllyEo+Yimd2GVCgLa5ENbGONnnLzPI4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2D9VwyOWl47q1u0Kjv4dSRZ7izeV395Vq55rBFY2YMN9zIWytlDa+5BVrfutuH8yO
         Gp/t1ffXQ4D3SYkmRty1Z1dETF4fRaVWdGhnPRgMylOp+mzT/Krt18ar1JST30khHP
         ekFbaVf8gM9eJd7AUWDZ2a/OzCtr7h058ehvjeec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 007/171] ipmi_si: fix unexpected driver unregister warning
Date:   Thu, 18 Jul 2019 23:53:58 -0400
Message-Id: <20190719035643.14300-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 2f66353963043e1d8dfacfbdf509acc5d3be7698 ]

If ipmi_si_platform_init()->platform_driver_register() fails,
platform_driver_unregister() called unconditionally will trigger
following warning,

ipmi_platform: Unable to register driver: -12
------------[ cut here ]------------
Unexpected driver unregister!
WARNING: CPU: 1 PID: 7210 at drivers/base/driver.c:193 driver_unregister+0x60/0x70 drivers/base/driver.c:193

Fix it by adding platform_registered variable, only unregister platform
driver when it is already successfully registered.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Message-Id: <20190517101245.4341-1-wangkefeng.wang@huawei.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_si_platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index f2a91c4d8cab..0cd849675d99 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -19,6 +19,7 @@
 #include "ipmi_si.h"
 #include "ipmi_dmi.h"
 
+static bool platform_registered;
 static bool si_tryplatform = true;
 #ifdef CONFIG_ACPI
 static bool          si_tryacpi = true;
@@ -469,9 +470,12 @@ void ipmi_si_platform_init(void)
 	int rv = platform_driver_register(&ipmi_platform_driver);
 	if (rv)
 		pr_err("Unable to register driver: %d\n", rv);
+	else
+		platform_registered = true;
 }
 
 void ipmi_si_platform_shutdown(void)
 {
-	platform_driver_unregister(&ipmi_platform_driver);
+	if (platform_registered)
+		platform_driver_unregister(&ipmi_platform_driver);
 }
-- 
2.20.1

