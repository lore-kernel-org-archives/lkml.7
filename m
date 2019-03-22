Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEC9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB56920693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255437;
	bh=jS6uO/wXEFlYMsnnuobzz6X7+4R5r5eNZmla6JPPjhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y3yjodNHb/uCNjNOmDqy0JNP84TiwHDB7pqv+QdMnlQD84nfL68E3LznyGpcPwBF/
	 W/olAmm3id7WVBcSgNHO0OYWc27R8Dai9fAKTBv8VgofLg8WEJxkeLR12rUO95Ovhv
	 6iVHgYUoZkL+vu2MrJB7TuQlhebHqCYQVjuh4xlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfCVLuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732052AbfCVLua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0726B20850;
        Fri, 22 Mar 2019 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255429;
        bh=jS6uO/wXEFlYMsnnuobzz6X7+4R5r5eNZmla6JPPjhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smdaHZtuv8w8E8v/NNAId7lpO5B8LPOcEBqnGzuEGe3eu7dY7eHyiYDU6s+4ivJo0
         3+oiLdWAEgMOGAxK7RbXBBpVJnrcGZ6LsHec8FGv7hbA61y50WzBSvNzD7TG8srCSe
         6mmwdIJ01Nvg8ccyBHJWc1HMsu88gX0lwtsmFdvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jinyoung Park <jinyoungp@nvidia.com>,
        Mark Zhang <markz@nvidia.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 089/183] regulator: max77620: Initialize values for DT properties
Date:   Fri, 22 Mar 2019 12:15:17 +0100
Message-Id: <20190322111248.180853473@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Zhang <markz@nvidia.com>

commit 0ab66b3c326ef8f77dae9f528118966365757c0c upstream.

If regulator DT node doesn't exist, its of_parse_cb callback
function isn't called. Then all values for DT properties are
filled with zero. This leads to wrong register update for
FPS and POK settings.

Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/max77620-regulator.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -1,7 +1,7 @@
 /*
  * Maxim MAX77620 Regulator driver
  *
- * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * Author: Mallikarjun Kasoju <mkasoju@nvidia.com>
  *	Laxman Dewangan <ldewangan@nvidia.com>
@@ -803,6 +803,14 @@ static int max77620_regulator_probe(stru
 		rdesc = &rinfo[id].desc;
 		pmic->rinfo[id] = &max77620_regs_info[id];
 		pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
+		pmic->reg_pdata[id].active_fps_src = -1;
+		pmic->reg_pdata[id].active_fps_pd_slot = -1;
+		pmic->reg_pdata[id].active_fps_pu_slot = -1;
+		pmic->reg_pdata[id].suspend_fps_src = -1;
+		pmic->reg_pdata[id].suspend_fps_pd_slot = -1;
+		pmic->reg_pdata[id].suspend_fps_pu_slot = -1;
+		pmic->reg_pdata[id].power_ok = -1;
+		pmic->reg_pdata[id].ramp_rate_setting = -1;
 
 		ret = max77620_read_slew_rate(pmic, id);
 		if (ret < 0)


