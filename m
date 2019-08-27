Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C983C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8622186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893646;
	bh=e0i8aty4Q48RrwIHAxieP7JGX/0Vv85/V1gmUaeajNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lE5r5sC1klmP7khorYLq5QMqMc0IGpPEmsXbQ/e4tc4PwRGtuF8d3qfYHJ/eZA+hM
	 PjEF1UDWxxBYD34yk3Io88Znkn/ABOvX9dZAa2k+EM5tqLVZbHocIAMBaOvn9DcbwX
	 81/rlbC7IgnNlXNGpvNVIw9g6UZAXRYfot/I3LR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfH0H5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729897AbfH0H44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:56:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BAB0206BA;
        Tue, 27 Aug 2019 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892616;
        bh=e0i8aty4Q48RrwIHAxieP7JGX/0Vv85/V1gmUaeajNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8ha5FubTeXWCFKn5bGU+KkRJhG6eWywnSu+2H5u6oVJ6NOorqxbbHKyc19SJGoNE
         fZwSve3K+Dyti8o+LY9IrEBancUHM9kayGA/LLDkVVkIQC7bHPcCUN7xTt2HcdBY2h
         1MGwZh83otIByoKu55EcBnq9GovGqphzmCqxmlF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ricard Wanderlof <ricardw@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 14/98] ASoC: Fail card instantiation if DAI format setup fails
Date:   Tue, 27 Aug 2019 09:49:53 +0200
Message-Id: <20190827072719.081684877@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 40aa5383e393d72f6aa3943a4e7b1aae25a1e43b ]

If the DAI format setup fails, there is no valid communication format
between CPU and CODEC, so fail card instantiation, rather than continue
with a card that will most likely not function properly.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
Link: https://lore.kernel.org/r/alpine.DEB.2.20.1907241132350.6338@lnxricardw1.se.axis.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 62aa320c20708..dafc3b7f8d723 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1513,8 +1513,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		}
 	}
 
-	if (dai_link->dai_fmt)
-		snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
+	if (dai_link->dai_fmt) {
+		ret = snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
+		if (ret)
+			return ret;
+	}
 
 	ret = soc_post_component_init(rtd, dai_link->name);
 	if (ret)
-- 
2.20.1



