Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA444C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45E3216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329458;
	bh=gOhfH6gZJps6lIYgX0fq++OQpZggfMVl2D2sefhZzsY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DQVwXbtBRR2ebW4i10D+udjmhP1hngd/betreB253PkVyxi3ar3+IHt3povt7kLKF
	 g7ko2Ofuzmr/RqnOgGz1TFf376HMNM/XZtWn9/7v7nPlHYWwmJfSYhCzWn4JIJmmwc
	 tXgEC4ePlJIKYi+HS5hSvDzrSsM0nCBNlHMsTpdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfD0BoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbfD0BoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:44:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 698C7208CB;
        Sat, 27 Apr 2019 01:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329454;
        bh=gOhfH6gZJps6lIYgX0fq++OQpZggfMVl2D2sefhZzsY=;
        h=From:To:Cc:Subject:Date:From;
        b=x6Ot59hZ/RYgNKsJ6sp0qLNEnlEXKTRjbP9wY67mfSi1AzufgcxuIAlybZITCmVHK
         n97sEMKeZxKYFCPsrCfHPISdi8/HA00d1iKfzrfdiIsogKKmQq6eFZ22GLPBF14vS4
         EJLETDl3EwjVtajrLA4pOt2p7teNn+bmZUjzH2wc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 1/8] ASoC: ab8500: Mark expected switch fall-through
Date:   Fri, 26 Apr 2019 21:44:04 -0400
Message-Id: <20190427014412.9091-1-sashal@kernel.org>
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
index fd43827bb856..daa92a5f8410 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2131,6 +2131,7 @@ static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		dev_err(dai->codec->dev,
 			"%s: ERROR: The device is either a master or a slave.\n",
 			__func__);
+		/* fall through */
 	default:
 		dev_err(dai->codec->dev,
 			"%s: ERROR: Unsupporter master mask 0x%x\n",
-- 
2.19.1

