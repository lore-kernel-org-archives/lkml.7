Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AB9C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF720859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n3Fu5kN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390069AbfFJMxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:53:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40862 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfFJMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:53:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so9065486wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8T69aUvAi+maIZ8yBvTWOJzaeXiOR3Dqg9+a+MoRXDA=;
        b=n3Fu5kN6wdtGKh9YWexo8ZjfsnSBwADVRCC+C4XPOPSXHT5eKEAqT5i79KL9bKa4wd
         c0hqIJpI7gTWCxibbx6XId2oyRuITeCfXqD/vuxY73kQof26ZidBERPABjLwlljWAlZv
         /RaBmnpuINADHE0WgkCb9CXCUgwj4Yxvz2Ql+sdrVda1v3DhaMUlSuiQFVX9hxE2M59c
         2v8lzULQ5grpGHh307iNtaYcW5R1JoPcHlI5ob+LjUqV8Yn8AMYEPWaBB5TBDRQZQhyb
         tXVbYg6wQvy59GmMAsTdVK+sHPTjGUCBNjYtFOVx9d4p2BBvJ5leqMnY4TuY0XvTNUme
         i8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8T69aUvAi+maIZ8yBvTWOJzaeXiOR3Dqg9+a+MoRXDA=;
        b=ULW72hJOkfd433s/WRbb8105P+Hko97CJ5Bji8dksxHhU5mUAc/VrFIZaKR5umfhBr
         xqFT6zZYv3UOruVMfgUmeHT2ISpAYy8DNcx1n956rZ2XVPD7jGJXGSKXzs8YuKWPAbJ+
         NNuQQyr+Ai49mLibQ8RYDdduA2rPsaueq3s82X3SYljk7w6pR9xwy+xI4G1rmPjDK1wN
         fAhh2PFrPpeRzFP4GMRBQ/R18P84uQbWUeYfjibQ9ZBLNfqauyM3kNAT2jVLxmbACn5k
         5nt1ZaWzwJ5NiTd1NhVKRw1Pi4GiyssCWjHz1lbkAk5n1TJ28PWQXb1vGE6mTgeMSRgt
         2YOQ==
X-Gm-Message-State: APjAAAUDV6i0Vf1vkQNXdj93rpT71ZPNeKXaOtD91dgpe7tXuExJjC0k
        FX3nOm5+k4Wxj+H9EmnsKkRj+A==
X-Google-Smtp-Source: APXvYqyF38CXjmJlFWQvmC/4HOPRMLGbV8IW7oGgE73werPfKioCG3d1XJdAyRcyyO0juNIRqqCB+Q==
X-Received: by 2002:adf:9267:: with SMTP id 94mr22877356wrj.338.1560171233499;
        Mon, 10 Jun 2019 05:53:53 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 135sm11871603wmb.28.2019.06.10.05.53.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 05:53:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: meson: axg-card: fix null pointer dereference in clean up
Date:   Mon, 10 Jun 2019 14:53:44 +0200
Message-Id: <20190610125344.18221-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using modern dai_link style, we must first make sure the
struct snd_soc_dai_link_component exists before accessing its members.

In case of early probe deferral, some of the '.cpus' or '.codecs' may not
have been allocated yet. Check this before calling of_node_put() on the
structure member.

Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index fb03258d00ae..70bb0cbad233 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -115,9 +115,11 @@ static void axg_card_clean_references(struct axg_card *priv)
 
 	if (card->dai_link) {
 		for_each_card_prelinks(card, i, link) {
-			of_node_put(link->cpus->of_node);
+			if (link->cpus)
+				of_node_put(link->cpus->of_node);
 			for_each_link_codecs(link, j, codec)
-				of_node_put(codec->of_node);
+				if (codec)
+					of_node_put(codec->of_node);
 		}
 	}
 
-- 
2.20.1

