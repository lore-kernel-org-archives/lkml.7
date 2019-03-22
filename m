Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D192082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256900;
	bh=QDs6iBFx1f8uSVYrX9TDbLZvZ8sbz4mi1c3O3bFtZt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SejCQ7Z52svVlXi4756cGXbISzZisO4ozV4kj+fo+LeeWVIyGQi8adM04TshYTfRQ
	 vnCJsd9bIto/VFsPSuqlqxEQt+Wf0SWMHKi7xvNW9sh0fqecoRvihKSbj9WMOExP16
	 SNzwxot4/DVH+n48iQTusExh2UJu8kRVJWnz/Xf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbfCVMO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389465AbfCVMO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7226218A1;
        Fri, 22 Mar 2019 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256896;
        bh=QDs6iBFx1f8uSVYrX9TDbLZvZ8sbz4mi1c3O3bFtZt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRNHxSLrOmbvS4EfGzjB3ZDF8Nv7PGy6CfQ4O4dqhoK41GfNK/H0pJf4NK04LQSEV
         6iiTWLTwVt2TqU7qIzHGWTjOqB5nj9F3ebmBoUPOdBYCnfRsy1fMKssonMy5ZjghWE
         xAwlTlpy38NvW8QT4Fj6m6t9jQiNGFi7CEM0kiK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jinyoung Park <jinyoungp@nvidia.com>,
        Mark Zhang <markz@nvidia.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.0 070/238] regulator: max77620: Initialize values for DT properties
Date:   Fri, 22 Mar 2019 12:14:49 +0100
Message-Id: <20190322111302.744232817@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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


