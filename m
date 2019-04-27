Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21122C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E664A206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329912;
	bh=EXGjGJeSu29yqXPI6hz9MnRcY3gvpS4p2pKEiRlIOFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CbS1r/Kif8xyNZJXqasDO8cfMgDt6ySUocRaZBG7f9VbCqObsakCIdk5+xn7Gl3Yo
	 0BXbQ46AxeVEeAojNrQplsuCQ9Qgwd/dgOiYbXZfpZdB1nKoRJgd8x2H2vhr+VV0Ih
	 SFLLJdCnjki3L+Vcsj/pp9XgsEhhzG7KeHd7vYXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfD0BlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfD0Bk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2687208CB;
        Sat, 27 Apr 2019 01:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329257;
        bh=EXGjGJeSu29yqXPI6hz9MnRcY3gvpS4p2pKEiRlIOFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTBggKgZ0FNvomtVw7L5ghHholkkNJ+4Rj3jDKVImmV8WHs0XuRDJ/y/Wo9H9nmd3
         zn8JvKBhCbLBhVEmjLC0/uIBbCQ0h32J2kowGoLQDFD9L7VEBlVkGXOzAixxfNwB/p
         Sgqwfa8OvYvrEV6cTp9umFgyTI9ZIMxKVerJqqhA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 03/53] ASoC: ab8500: Mark expected switch fall-through
Date:   Fri, 26 Apr 2019 21:40:00 -0400
Message-Id: <20190427014051.7522-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
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
index 03bbbcd3b6c1..87616b126018 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2129,6 +2129,7 @@ static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		dev_err(dai->component->dev,
 			"%s: ERROR: The device is either a master or a slave.\n",
 			__func__);
+		/* fall through */
 	default:
 		dev_err(dai->component->dev,
 			"%s: ERROR: Unsupporter master mask 0x%x\n",
-- 
2.19.1

