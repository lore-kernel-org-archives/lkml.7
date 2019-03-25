Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F51FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CCB20883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfCYDFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:05:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbfCYDFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:05:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3867DD64E3C96AEFB07A;
        Mon, 25 Mar 2019 11:05:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Mon, 25 Mar 2019 11:05:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH v2 -next] ASoC: simple-card-utils: remove set but not used variable 'dai_name'
Date:   Mon, 25 Mar 2019 03:17:40 +0000
Message-ID: <20190325031740.164364-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323020838.107533-1-yuehaibing@huawei.com>
References: <20190323020838.107533-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
sound/soc/generic/simple-card-utils.c:164:18: warning:
 parameter 'dai_name' set but not used [-Wunused-but-set-parameter]

It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add
asoc_simple_debug_info()"), so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2: fix patch title
---
 sound/soc/generic/simple-card-utils.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 4ed68348f939..db1458a19985 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -173,10 +173,8 @@ int asoc_simple_parse_clk(struct device *dev,
 	 * see
 	 *	soc-core.c :: snd_soc_init_multicodec()
 	 */
-	if (dlc) {
+	if (dlc)
 		dai_of_node	= dlc->of_node;
-		dai_name	= dlc->dai_name;
-	}
 
 	/*
 	 * Parse dai->sysclk come from "clocks = <&xxx>"



