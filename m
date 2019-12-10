Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE5BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C624687
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576011910;
	bh=whSdxiCC2omyQoZMIjUst8o/j7AtFqK3OnwN6X1Shys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cr4jQUnL1TWDaTd4CX1CZeuyxJraX42ghJWcVcZJic22cBWttRFwKPeGr1FdnLZQH
	 gb3EwgYpAZ8u0DR1OA3hiCbZtHHi9+M8mwAtpegX17FHVr13JUQUCbpyV04O6w8saa
	 FNxjh1vddrc0SfyGl6Ua65GDPLFPYGbk80Byrq4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLJVFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfLJVEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:04:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 240292468E;
        Tue, 10 Dec 2019 21:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576011888;
        bh=whSdxiCC2omyQoZMIjUst8o/j7AtFqK3OnwN6X1Shys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDOOzQGHVwo6QR5/IBtEZVGLbk2uqQjVWSWblb3RnZca92dT3k4y3RrxhZtLBkp9W
         J+X3ZpPfpcgN8MYIezvNrUhepFf6sobXlwbIhU6OCe6aaRPJGESzwrRTuy9bjIR8mT
         scOAOLeL8+XOkhawhtoiwcmp9NgZ5c0L18kOE/bE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 038/350] media: vim2m: Fix BUG_ON in vim2m_device_release()
Date:   Tue, 10 Dec 2019 15:58:50 -0500
Message-Id: <20191210210402.8367-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210402.8367-1-sashal@kernel.org>
References: <20191210210402.8367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 2455d417c03aa0cbafed04c46cbb354643238318 ]

If v4l2_m2m_init() fails, m2m_dev pointer will be set ERR_PTR(-ENOMEM),
then kfree m2m_dev will trigger BUG_ON, see below, fix it by setting m2m_dev
to NULL.

  vim2m vim2m.0: Failed to init mem2mem device
  ------------[ cut here ]------------
  kernel BUG at mm/slub.c:3944!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 11 PID: 9061 Comm: insmod Tainted: G            E     5.2.0-rc2 #81
  Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
  RIP: 0010:kfree+0x11a/0x160

  Call Trace:
   vim2m_device_release+0x3f/0x50 [vim2m]
   device_release+0x27/0x80
   kobject_release+0x68/0x190
   vim2m_probe+0x20f/0x280 [vim2m]
   platform_drv_probe+0x37/0x90
   really_probe+0xef/0x3d0
   driver_probe_device+0x110/0x120
   device_driver_attach+0x4f/0x60
   __driver_attach+0x9a/0x140
   ? device_driver_attach+0x60/0x60
   bus_for_each_dev+0x76/0xc0
   ? klist_add_tail+0x57/0x70
   bus_add_driver+0x141/0x210
   driver_register+0x5b/0xe0
   vim2m_init+0x29/0x1000 [vim2m]
   do_one_initcall+0x46/0x1f4
   ? __slab_alloc+0x1c/0x30
   ? kmem_cache_alloc_trace+0x167/0x1b0
   do_init_module+0x5b/0x21f
   load_module+0x1add/0x1fb0
   ? __do_sys_finit_module+0xe9/0x110
   __do_sys_finit_module+0xe9/0x110
   do_syscall_64+0x5b/0x1c0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: ea6c7e34f3b2 ("media: vim2m: replace devm_kzalloc by kzalloc")
Reported-by: Hulk Robot <hulkci@huawei.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vim2m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2m.c
index 2d79cdc130c58..e17792f837f82 100644
--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -1346,6 +1346,7 @@ static int vim2m_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->m2m_dev)) {
 		v4l2_err(&dev->v4l2_dev, "Failed to init mem2mem device\n");
 		ret = PTR_ERR(dev->m2m_dev);
+		dev->m2m_dev = NULL;
 		goto error_dev;
 	}
 
-- 
2.20.1

