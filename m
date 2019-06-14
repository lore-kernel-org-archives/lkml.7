Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC43C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C5C2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544199;
	bh=ovPM9bDh/BKCt1Lv79G3XLom9qjK3CX4c8Uwl1nvjVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XkGgr/v4Jo+Y3yXIVzLPZQo68jhhXp45ZZIfHGXt+3joQpaDKOCGc7ZdHpnCwYjAN
	 D8k2XuMGLewX5axg1mnwvH6eWcLYQ9FVPVXeDzXoS/lwGib3hLXvsZme3N3SF3lqvG
	 WhuOmoiuOaVzY158tKs7YnS5aZ8b5uOdKtUGfyZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfFNU36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfFNU3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:29:51 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B634921848;
        Fri, 14 Jun 2019 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544190;
        bh=ovPM9bDh/BKCt1Lv79G3XLom9qjK3CX4c8Uwl1nvjVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNrAhCF7c6oh+VFpW9/NWAgaFvDVFuggf5GxeiqTRouXEyIrkqN7jiChfADNk9pMy
         kfm9yaqYIkM2eoTAwDjRS/kE5rw+GPi7KvVnhi9cqdhFQ30uV9E0CQHQsbHJuSCXKi
         SnRqJ3DvqwVNqMVOq/z1PIMFKz+jP1+fE1Hzdfcw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengguang Xu <cgxu519@gmx.com>, Wu Hao <hao.wu@intel.com>,
        Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fpga@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/39] fpga: dfl: expand minor range when registering chrdev region
Date:   Fri, 14 Jun 2019 16:29:13 -0400
Message-Id: <20190614202946.27385-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202946.27385-1-sashal@kernel.org>
References: <20190614202946.27385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@gmx.com>

[ Upstream commit de9a7f6f5f1967d275311cca9163b4a3ffe9b0ae ]

Actually, total amount of available minor number
for a single major is MINORMASK + 1. So expand
minor range when registering chrdev region.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/dfl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index ab361ec78df4..e38a55e84cd3 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -322,7 +322,7 @@ static void dfl_chardev_uinit(void)
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
 		if (MAJOR(dfl_chrdevs[i].devt)) {
 			unregister_chrdev_region(dfl_chrdevs[i].devt,
-						 MINORMASK);
+						 MINORMASK + 1);
 			dfl_chrdevs[i].devt = MKDEV(0, 0);
 		}
 }
@@ -332,8 +332,8 @@ static int dfl_chardev_init(void)
 	int i, ret;
 
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++) {
-		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0, MINORMASK,
-					  dfl_chrdevs[i].name);
+		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0,
+					  MINORMASK + 1, dfl_chrdevs[i].name);
 		if (ret)
 			goto exit;
 	}
-- 
2.20.1

