Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC7FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2CC22CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149351;
	bh=bkXd6B9Dqu+zP7vWK3oLVDih/8Ru2rswszj6L1ELQCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VvUejybUNvjkRJ++kd9VaC9edcql64BMf+s8nkBW5zf2kcayMsRLdCunqco7ehwfz
	 FKkp0u5XwW+WQ+4lGfwIuZO1l73g0Myckz/u9GqUkWJOhLNv5UBEIFsmfmmXsVemmq
	 cEbxa197qxbpzZsxhpjDDA+7qJdB4/heUQCROL1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfGZNmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387844AbfGZNmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:42:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB30C22CD6;
        Fri, 26 Jul 2019 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148526;
        bh=bkXd6B9Dqu+zP7vWK3oLVDih/8Ru2rswszj6L1ELQCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bwYcYbTzitPeem9Fw4s/Cful/V+/+Uqr5x8vrW97hnQaF1Y38HJpKI+c9OQpUijm
         DIFD1syjNnXVz/zc/fC4kYCvl8IKjbN9JhCsd6wLJDfg3KC2xTl92vfsarhCrNOPOc
         Wh2ZgpMm607FNxmod5XRzZcAXuzCDJBTo8Iq9r7k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yongxin Liu <yongxin.liu@windriver.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 83/85] drm/nouveau: fix memory leak in nouveau_conn_reset()
Date:   Fri, 26 Jul 2019 09:39:33 -0400
Message-Id: <20190726133936.11177-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongxin Liu <yongxin.liu@windriver.com>

[ Upstream commit 09b90e2fe35faeace2488234e2a7728f2ea8ba26 ]

In nouveau_conn_reset(), if connector->state is true,
__drm_atomic_helper_connector_destroy_state() will be called,
but the memory pointed by asyc isn't freed. Memory leak happens
in the following function __drm_atomic_helper_connector_reset(),
where newly allocated asyc->state will be assigned to connector->state.

So using nouveau_conn_atomic_destroy_state() instead of
__drm_atomic_helper_connector_destroy_state to free the "old" asyc.

Here the is the log showing memory leak.

unreferenced object 0xffff8c5480483c80 (size 192):
  comm "kworker/0:2", pid 188, jiffies 4294695279 (age 53.179s)
  hex dump (first 32 bytes):
    00 f0 ba 7b 54 8c ff ff 00 00 00 00 00 00 00 00  ...{T...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000005005c0d0>] kmem_cache_alloc_trace+0x195/0x2c0
    [<00000000a122baed>] nouveau_conn_reset+0x25/0xc0 [nouveau]
    [<000000004fd189a2>] nouveau_connector_create+0x3a7/0x610 [nouveau]
    [<00000000c73343a8>] nv50_display_create+0x343/0x980 [nouveau]
    [<000000002e2b03c3>] nouveau_display_create+0x51f/0x660 [nouveau]
    [<00000000c924699b>] nouveau_drm_device_init+0x182/0x7f0 [nouveau]
    [<00000000cc029436>] nouveau_drm_probe+0x20c/0x2c0 [nouveau]
    [<000000007e961c3e>] local_pci_probe+0x47/0xa0
    [<00000000da14d569>] work_for_cpu_fn+0x1a/0x30
    [<0000000028da4805>] process_one_work+0x27c/0x660
    [<000000001d415b04>] worker_thread+0x22b/0x3f0
    [<0000000003b69f1f>] kthread+0x12f/0x150
    [<00000000c94c29b7>] ret_from_fork+0x3a/0x50

Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 4116ee62adaf..f69ff22beee0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -252,7 +252,7 @@ nouveau_conn_reset(struct drm_connector *connector)
 		return;
 
 	if (connector->state)
-		__drm_atomic_helper_connector_destroy_state(connector->state);
+		nouveau_conn_atomic_destroy_state(connector, connector->state);
 	__drm_atomic_helper_connector_reset(connector, &asyc->state);
 	asyc->dither.mode = DITHERING_MODE_AUTO;
 	asyc->dither.depth = DITHERING_DEPTH_AUTO;
-- 
2.20.1

