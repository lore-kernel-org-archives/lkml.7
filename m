Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80853C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4878D217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557436133;
	bh=Wy8moiJ/cxkmnT7sGOzk7oIpYpwQsbJLuL5U19+Hoy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QE4Fv3agkMjwAmpRJP7SdssGJ6BpvqpcoGT1hBN0inwqND4txYsAJudoZc5sta6BA
	 nPELyObccBKcz4RM2OQM3G85elQ64x8FcvsGKCalkBcKwwrKZEBr7CzsW+nTWBqoAm
	 UHyFkmvFOPqd1gZEQfPE1OimViFKcU2VTxHo+1kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfEIVIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfEIVIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:08:39 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191772182B;
        Thu,  9 May 2019 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436118;
        bh=Wy8moiJ/cxkmnT7sGOzk7oIpYpwQsbJLuL5U19+Hoy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7DS+tnpGwvB8LZXcLlEyE65norosYX0q9XnIZvckAyAy327wuNuF2YHZ8AY85XvG
         j5VQ7ZZT6R9++eM9o/xj/xDSd7HK18iX9GRzImQ9vVaNpcCU+Sq26RfwfYE0S00HjH
         VHTJt25dZmFL81UjQ/4xVzpZv4T3/Gfv3XZdncVI=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH 4/4] fpga: dfl: expand minor range when registering chrdev region
Date:   Thu,  9 May 2019 16:08:29 -0500
Message-Id: <20190509210829.31815-5-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509210829.31815-1-atull@kernel.org>
References: <20190509210829.31815-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@gmx.com>

Actually, total amount of available minor number
for a single major is MINORMASK + 1. So expand
minor range when registering chrdev region.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c25217cde5ca..4b66aaa32b5a 100644
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
2.21.0

