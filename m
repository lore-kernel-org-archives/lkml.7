Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76447C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EF52089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806496;
	bh=kl4VkFn/kIn6Kaes2768yCdGWHalmqI56eqE0eTfxfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j3WOO9b/6rCM86FFKTzKVwkMH1E0WH4yiMavEazw4K745AyhgZAJwD3rqsc2CM5Wd
	 QTSxpRpnmwTgkrJaGgrD6jrasB3YTstxTjL06ZRBppN7daRVhlhhoAWx8XYnuBeMgl
	 VepC3IZl5VfD7JQecRWUPDsLYyEod1cT3RkCoTxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfFQVVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbfFQVVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:21:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBA620861;
        Mon, 17 Jun 2019 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806490;
        bh=kl4VkFn/kIn6Kaes2768yCdGWHalmqI56eqE0eTfxfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1sxc+4GFIG1smomkpezkSTbgGL6vlLW7JRHivTiNTacBhdTTciS+tqJw1KsnL/hx5
         TxR51ZxhbCU5OFkuydZYryIcPJLTNocH1VpnsD1bCG3KHLME1emlCTIwI//qPU07gi
         fkJCeTUUDFNQvSs9Fg9WS4WOymliFOTe+AXUnnyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        David Milburn <dmilburn@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 070/115] nvme: fix memory leak for power latency tolerance
Date:   Mon, 17 Jun 2019 23:09:30 +0200
Message-Id: <20190617210803.656145049@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 510a405d945bc985abc513fafe45890cac34fafa ]

Unconditionally hide device pm latency tolerance when uninitializing
the controller to ensure all qos resources are released so that we're
not leaking this memory. This is safe to call if none were allocated in
the first place, or were previously freed.

Fixes: c5552fde102fc("nvme: Enable autonomous power state transitions")
Suggested-by: Keith Busch <keith.busch@intel.com>
Tested-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
[changelog]
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 23c90382a515..35d2202ee2fd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3699,6 +3699,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
-- 
2.20.1



