Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DA8222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852640;
	bh=uJ43pXqqAExfV9HJ8vcn7lUngjtVJIsx/CnHYFlyYGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IUtnY29NV9Ra7fq48lLrgTIowc2sLIgwhCqjCNDVv9VHE0MBZOYnbA6mhx1l4py/5
	 yNWNKumydirnM88kI/xYowAO/aWyY2dLcI2gUoYhxt9TPgq71dE+1pQCh3y9IwZHDB
	 r8DmTayvKFFxEVNe2ttpjgGjb0iBAhxdW6zWb0q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfLTOaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbfLTOaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9549624682;
        Fri, 20 Dec 2019 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852218;
        bh=uJ43pXqqAExfV9HJ8vcn7lUngjtVJIsx/CnHYFlyYGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/DXAXvs9ii87PJ+hLOABkxoBfxH5LoWGMyVgeU9+TpPgba4Za/reZ5cNHE3Z1zi5
         yRiKzMf0/xM79e5JW062lzEt1aWBpXiw7PsuXp9YoC80rXjkXpxNqQb4AtsnW7AvPu
         zTqXV0epDfRnCiO6t1lDviR4M2kgbhuNi1dR01aY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 17/52] PM / devfreq: Set scaling_max_freq to max on OPP notifier error
Date:   Fri, 20 Dec 2019 09:29:19 -0500
Message-Id: <20191220142954.9500-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit e7cc792d00049c874010b398a27c3cc7bc8fef34 ]

The devfreq_notifier_call functions will update scaling_min_freq and
scaling_max_freq when the OPP table is updated.

If fetching the maximum frequency fails then scaling_max_freq remains
set to zero which is confusing. Set to ULONG_MAX instead so we don't
need special handling for this case in other places.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e5c2afdc7b7f0..e185c8846916d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -560,8 +560,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 		goto out;
 
 	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->scaling_max_freq)
+	if (!devfreq->scaling_max_freq) {
+		devfreq->scaling_max_freq = ULONG_MAX;
 		goto out;
+	}
 
 	err = update_devfreq(devfreq);
 
-- 
2.20.1

