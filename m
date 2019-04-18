Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0335CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B761F21871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610353;
	bh=ZObmM1XzK+zWcXPLL2bsqkgrYt+3yMH/6KbpDD5u7Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqeQuNo1p+FCg2hmHdopt0y02KOEYIOZ8DPIuWaIUaSpolTya/P6IiEA3zFXtDZm9
	 k4bxC9w5Fk5I94+jnezslRCeMhDMXuw7oWmw1SF8oXaewjEyz00vzW74bKezEW7f5j
	 OYcKnQAVRYshpbXtLD1vS75rSdHGGNm/wY053GJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390072AbfDRR7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390042AbfDRR7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:59:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8675F218A6;
        Thu, 18 Apr 2019 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610347;
        bh=ZObmM1XzK+zWcXPLL2bsqkgrYt+3yMH/6KbpDD5u7Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjE29EYFItMvhgqE5rfrpW4jEaQSDFDHq0yJR4tIvl+C6feUE7wDQXC9QzYiHMmSK
         Ajeh35DKZ/hZf3BjcVqFXT1fkYse4b0QdyddAz2kGbvXjD/SwwCBiELVeAcjSArLod
         G0fCpR3bqBU9+UcDLKikcdH52/MSdMrbk1Cs7yWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marian Mihailescu <mihailescu2m@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/110] thermal: samsung: Fix incorrect check after code merge
Date:   Thu, 18 Apr 2019 19:56:07 +0200
Message-Id: <20190418160439.168967773@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3b5236cc5d086dd3ddd01113ee9255421aab9fab ]

Merge commit 19785cf93b6c ("Merge branch 'linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal")
broke the code introduced by commit ffe6e16f14fa ("thermal: exynos: Reduce
severity of too early temperature read"). Restore the original code from
the mentioned commit to finally fix the warning message during boot:

thermal thermal_zone0: failed to read out thermal zone (-22)

Reported-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 19785cf93b6c ("Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 48eef552cba4..fc9399d9c082 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -666,7 +666,7 @@ static int exynos_get_temp(void *p, int *temp)
 	struct exynos_tmu_data *data = p;
 	int value, ret = 0;
 
-	if (!data || !data->tmu_read || !data->enabled)
+	if (!data || !data->tmu_read)
 		return -EINVAL;
 	else if (!data->enabled)
 		/*
-- 
2.19.1



