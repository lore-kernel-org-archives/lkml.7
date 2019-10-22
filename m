Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4CA2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="smgeuRIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbfJVHNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:13:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47952 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfJVHNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:13:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9M7DEsd063127;
        Tue, 22 Oct 2019 02:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571728394;
        bh=U91+Wq5szJ4SPTYWfkBe0dU0xl7L3riATq2QqoUXpBs=;
        h=From:To:CC:Subject:Date;
        b=smgeuRIM7SBm6m966SNKfCMQhCm3dbGDRd9bBc9PmU3oCuHGa1j2L2QdvwRSQLMP1
         eOUHhluhSRYXG3f6L6kyO1l8i301ykmqkRu1/BAN4JztxTCYuewaV/Xq2nNn6+jEfc
         Rg6jArXwDrY9cz23oKLp0NIyWQwWno69EMxQ+ydc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9M7DDIa072313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 02:13:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 02:13:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 02:13:03 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9M7CP6H022795;
        Tue, 22 Oct 2019 02:12:26 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] clk: Fix memory leak in clk_unregister()
Date:   Tue, 22 Oct 2019 12:41:53 +0530
Message-ID: <20191022071153.21118-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocated in alloc_clk() for 'struct clk' and
'const char *con_id' while invoking clk_register() is never freed
in clk_unregister(), resulting in kmemleak showing the following
backtrace.

  backtrace:
    [<00000000546f5dd0>] kmem_cache_alloc+0x18c/0x270
    [<0000000073a32862>] alloc_clk+0x30/0x70
    [<0000000082942480>] __clk_register+0xc8/0x760
    [<000000005c859fca>] devm_clk_register+0x54/0xb0
    [<00000000868834a8>] 0xffff800008c60950
    [<00000000d5a80534>] platform_drv_probe+0x50/0xa0
    [<000000001b3889fc>] really_probe+0x108/0x348
    [<00000000953fa60a>] driver_probe_device+0x58/0x100
    [<0000000008acc17c>] device_driver_attach+0x6c/0x90
    [<0000000022813df3>] __driver_attach+0x84/0xc8
    [<00000000448d5443>] bus_for_each_dev+0x74/0xc8
    [<00000000294aa93f>] driver_attach+0x20/0x28
    [<00000000e5e52626>] bus_add_driver+0x148/0x1f0
    [<000000001de21efc>] driver_register+0x60/0x110
    [<00000000af07c068>] __platform_driver_register+0x40/0x48
    [<0000000060fa80ee>] 0xffff800008c66020

Fix it here.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1c677d7f7f53..2f2eea26c375 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3879,6 +3879,7 @@ void clk_unregister(struct clk *clk)
 					__func__, clk->core->name);
 
 	kref_put(&clk->core->ref, __clk_release);
+	free_clk(clk);
 unlock:
 	clk_prepare_unlock();
 }
-- 
2.17.1

