Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF89C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235521909
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126396;
	bh=IHMwj5rKt9brmS6dnPEV2ODMwzpN+DjUy1Uzsi3XqYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z1p3ORh/myypq3VMjVLIUG2Xw2feXucZ0PL6QHQ7Ph238u8sdhngGRNvwW3i93fn6
	 eDcc1PXxd4KAMGoM5LrgBGOeWL5tgZYgI36VntuVuFEuu7DDQQRn5OExgDELEIVeos
	 6ZfI7m/Tf7jE5WjwH5pv+K8DsoxT6DSmamNkNFUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfDXRTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388699AbfDXRTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:51 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AA120675;
        Wed, 24 Apr 2019 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126390;
        bh=IHMwj5rKt9brmS6dnPEV2ODMwzpN+DjUy1Uzsi3XqYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvq28zq3KrwzChEWrUHHmZnQogIxM1NA8dAyhE0n+l6eB1mz/J5+SPeE7veqvH3D+
         X8ynbp3PDMRaQe00D8OUjlkzyEDd0WmpBs5k33wR1NUVlfBqcXYXemdaxqy+sI0LLk
         T8l1GfUZLWyKfq4U/YfwjdMF8ByRkSegjdh3Z8mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <yellowriver2010@hotmil.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 052/168] ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe
Date:   Wed, 24 Apr 2019 19:08:16 +0200
Message-Id: <20190424170926.869709054@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 11907e9d3533648615db08140e3045b829d2c141 ]

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Signed-off-by: Wen Yang <yellowriver2010@hotmil.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 1b05d1c5d9fd..a32fe14b4687 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -659,6 +659,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 asrc_fail:
 	of_node_put(asrc_np);
 	of_node_put(codec_np);
+	put_device(&cpu_pdev->dev);
 fail:
 	of_node_put(cpu_np);
 
-- 
2.19.1



