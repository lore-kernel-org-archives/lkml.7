Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6BFC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFA62082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t8gsBpvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfFMP0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52260 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfFMLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:42:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so9857487wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ct4dk4GNCZZpVBLlWG9IpyH3sVkXJaOUvUrsuvrJN7k=;
        b=t8gsBpvVYiQYc5Cn+QwlQpiY7tEcHBk2PiEx7Mm99YPiqUHhaR1qhC0wYPkrGD4SHH
         AeMv6d+++LORjfxG0hocO0hAVvVWjfgFXU7DUebAhDowZP5pxIZyokfKWuCJzU8ptVhs
         QTgFlBriQSaGZrLhOrDLhAUzOUWa2IZ20zuUZUL7kLXsMMqv8CincQItL92lCi5QYDLp
         yO8rK8tCPUVh0fCCcPIWZsvG5XWSoviGFdcRgDhPtSwdgQT738Uv3cgVBbCBZVsW2SCz
         ENsPDyh/zm4wAkf0I4yvwFPYHgBcqLTLWSYk/hhtUFHz1WUfsbUpGdYYMdpUXFx89UY4
         6JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ct4dk4GNCZZpVBLlWG9IpyH3sVkXJaOUvUrsuvrJN7k=;
        b=bpYycQxj4yCuexdmzOKvSgwW74KHoQakFeJBJKu/SHwSg0yM86sA110+KwtJF0lgB+
         Yj1sWVkeZa/3ZZ3zepJVaG7n/Ku1CgPex9NPdsrQjG3NMWz66s8VImsSd3Ka+kn5R0Ir
         4aZ/gFgr2rBA03OAYjfROpTPVNvz8xrLMff8DTMYRwsrPa7OvoFsLn6lJvkQAhC9lzrS
         t/SPIwISkh7VMvXgewoTSWIgMGM1g+y3Mimvxcq1JbunvO7ChspbzX0Yg/fVSTkUktVW
         fVsGMl5aVo8r/Obt5HIwsXipF6sqVhdfcmrGu0pb6qhgmijpvYaDtDJgM2bCBb6Y5qdc
         DcAg==
X-Gm-Message-State: APjAAAXiFh2KIoWOgbUb+PHkywoQcVlUWdIBIg1Cfu29T+RH/MR8nHYr
        WS5yaVKUYXtG/2p7dM4pRgzk7Q==
X-Google-Smtp-Source: APXvYqwqh3apCFq8wjX/n7GQ82ee2GciU3Q+2n5x2zCfXMbElFvgw/Kli69Hg3m7WsELb0p2+ZsBpA==
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr3135082wma.171.1560426159921;
        Thu, 13 Jun 2019 04:42:39 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b5sm2598490wru.69.2019.06.13.04.42.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:42:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/4] ASoC: meson: axg-tdmin: right_j is not supported
Date:   Thu, 13 Jun 2019 13:42:30 +0200
Message-Id: <20190613114233.21130-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613114233.21130-1-jbrunet@baylibre.com>
References: <20190613114233.21130-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right justified format is actually not supported by the amlogic tdm input
decoder.

Fixes: 13a22e6a98f8 ("ASoC: meson: add tdm input driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdmin.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index a790f925a4ef..cb87f17f3e95 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -121,7 +121,6 @@ static int axg_tdmin_prepare(struct regmap *map,
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
-	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_DSP_B:
 		break;
 
-- 
2.20.1

