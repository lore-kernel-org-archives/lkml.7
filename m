Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17518C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2B02186A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368734;
	bh=g5k0Ig8enZu5U3movZssnThUqTMqKazRszEEAOqmx5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IZnWYQqEm/wU731eslP+NQvcoBapK8z64Ze1YoWQC6LL2Xgzeatv5msy0gNBEMnrt
	 TeuevixEv6J7srHv+XJPGNzYIM2MWVvm8rJ8AATuYZjWgS3/Wbu8fPxUMSwG+kDVB2
	 FMNbZYFFNji/i6l6eXQ92sl0uB1HJIK3s9YpwWK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfDDJFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbfDDJF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70942147C;
        Thu,  4 Apr 2019 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368727;
        bh=g5k0Ig8enZu5U3movZssnThUqTMqKazRszEEAOqmx5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVfY3cDaCcwRu8H6isnKdG/xBCjUuBBWCTnC3EgTkBnYBnYRSdzBSRHxSggwkLhWP
         /m7rYrKIQzQnl8+cd+9wYUG8ZFijqIheRAKXUjQV6VnFD9Z2Dhr7m2YTWHYg8TG4v9
         ftXkszie+3RJiTmexb417rcB2mQyez6v6QTcAEcg=
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
Subject: [PATCH 4.19 131/187] ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe
Date:   Thu,  4 Apr 2019 10:47:48 +0200
Message-Id: <20190404084609.376986169@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 44433b20435c..600d9be9706e 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -689,6 +689,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 asrc_fail:
 	of_node_put(asrc_np);
 	of_node_put(codec_np);
+	put_device(&cpu_pdev->dev);
 fail:
 	of_node_put(cpu_np);
 
-- 
2.19.1



