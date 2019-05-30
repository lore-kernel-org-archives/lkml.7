Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D5C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CC524C11
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187732;
	bh=acZXoBPoKiXvlqIJzBAzO0pMqsa6VZtkUPUMJfKHWvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e2cmOALyvAV9wDQ7mWl315hYlnI8NtjMr9nEouhjMnPG/TsMsuivQKxzZgMF/iuR4
	 1hJsEfcXUrlooa8OirJm+u714/OpUZpNTgXINX6f9UfBztjDWBTG2c7uTI1VIAYpxb
	 Et6a1W4PNQ20mX055/PejmHMCJJalMfAp3asHvyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbfE3DmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732495AbfE3DVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:15 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72776249CE;
        Thu, 30 May 2019 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186474;
        bh=acZXoBPoKiXvlqIJzBAzO0pMqsa6VZtkUPUMJfKHWvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpbNbX1BoDOwBHIrboBVEy+M5Og63KPYnmBR3j9vWxOcdRKRYZb4EIwofWvTCzSPI
         9jU005mOt7vDd3NgcAz076yiluyf1KjOddnv2jmLHKwoVPdpfjCPv1EoMcySX83IUA
         onTIHA2vmz8qPc+zQnHqme0mhwOCkE+s//efmWJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 106/128] ASoC: eukrea-tlv320: fix a leaked reference by adding missing of_node_put
Date:   Wed, 29 May 2019 20:07:18 -0700
Message-Id: <20190530030453.759325192@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b820d52e7eed7b30b2dfef5f4213a2bc3cbea6f3 ]

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./sound/soc/fsl/eukrea-tlv320.c:121:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 102, but without a correspo    nding object release within this function.
./sound/soc/fsl/eukrea-tlv320.c:127:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 102, but without a correspo    nding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/eukrea-tlv320.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 883087f2b092b..38132143b7d5e 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -119,13 +119,13 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"fsl,mux-int-port node missing or invalid.\n");
-			return ret;
+			goto err;
 		}
 		ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"fsl,mux-ext-port node missing or invalid.\n");
-			return ret;
+			goto err;
 		}
 
 		/*
-- 
2.20.1



