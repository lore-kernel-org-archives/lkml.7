Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8717C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B106E208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329581;
	bh=sOLPf7XZLHFsv7XC+6i24Egye9EIsCe+Q+mx2trXnnA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eaKUGq6yFrjAJfu68e5gbOvpCH6A1th2k8Cv8+Pytm9pvkab6/mcGmEFsJeXAzQAi
	 IRLYXZsWor70vryuHR71KQqfKU+RieKu6YR/Jqg0s2ZPH7rUcn9S0N/NE3VRcLWWkV
	 r0q4seacoU++BPVZ210QoihnyFFD7om78dOI4p4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfD0Bnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbfD0Bn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A7EF215EA;
        Sat, 27 Apr 2019 01:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329407;
        bh=sOLPf7XZLHFsv7XC+6i24Egye9EIsCe+Q+mx2trXnnA=;
        h=From:To:Cc:Subject:Date:From;
        b=LXCOCy0YBR+GzPEunMqdv6n+sDA/jPJnhFgUZaAyTEa5wovR1TbeP4CxL5VssF8RJ
         iclUR7X9nA59ASTZS9CdSahIzVjke9AROldnj+dA8GTq1jSGzAv4Tzyyjv5R2hNlvt
         vdGiSIfFoHfezt/rmgBkHI84l7PO+XVGaHP3dWgE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 01/16] ASoC: ab8500: Mark expected switch fall-through
Date:   Fri, 26 Apr 2019 21:43:09 -0400
Message-Id: <20190427014325.8704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 102cefc8e879b707be0024fdc7bce1deeb359a5f ]

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

In file included from sound/soc/codecs/ab8500-codec.c:24:
sound/soc/codecs/ab8500-codec.c: In function ‘ab8500_codec_set_dai_fmt’:
./include/linux/device.h:1485:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/ab8500-codec.c:2129:3: note: in expansion of macro ‘dev_err’
   dev_err(dai->component->dev,
   ^~~~~~~
sound/soc/codecs/ab8500-codec.c:2132:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 935ff7cb71c5..755007d7727e 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2129,6 +2129,7 @@ static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		dev_err(dai->codec->dev,
 			"%s: ERROR: The device is either a master or a slave.\n",
 			__func__);
+		/* fall through */
 	default:
 		dev_err(dai->codec->dev,
 			"%s: ERROR: Unsupporter master mask 0x%x\n",
-- 
2.19.1

