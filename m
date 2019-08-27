Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB9AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5B12173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892326;
	bh=RWeVlLznSXW9B8GqqqtugqSzpRKZ1E5XKsjMxzuPPhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V0qZzyL2+zKRG+ZMCzTaROVKKD6hnP44R94dz/9vx+3xhihudMkmG9lntwuL8oa6E
	 3Nn035OVIb8ZAcHPupOTzuILVpA1C+LPigkERysKblklyCbKQzU2kFnz43qSSfBT8e
	 X1zeel2+NzqvGKbAzwi5idAestT0rm2tHymtZamw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfH0HwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbfH0HwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:52:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF18217F5;
        Tue, 27 Aug 2019 07:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892321;
        bh=RWeVlLznSXW9B8GqqqtugqSzpRKZ1E5XKsjMxzuPPhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qj3BI/Wb88visIvsYmv3irlYZXhNmkaTtTb7u0bgp6lkDEOWod+bzUeyvGCqK2i9d
         F0/8yNpkUwooCC0e/KpVlrlRF5mdX8EhEqaW2VNTjqHDWbzXApiN2aIepVmpmg+OsK
         r0rrjX7tysLwPDXkaQSDa34CXfBDxa027w/tjvi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ricard Wanderlof <ricardw@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/62] ASoC: Fail card instantiation if DAI format setup fails
Date:   Tue, 27 Aug 2019 09:50:13 +0200
Message-Id: <20190827072700.729176600@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
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
index 42c2a3065b779..ff5206f5455d9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1757,8 +1757,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
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



