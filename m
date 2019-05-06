Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7D3C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF91720C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Pck2O9ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEFJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:58:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33386 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:58:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id s18so4824010wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9jEvZjc2+umi5MvYcNLZKb83bYswxMWT40Sgskk8a0=;
        b=Pck2O9ceC4Nncwi5pyCGV9hFb8Bp38Ivr0tb4n4clKpvOCdhipVZqz6sfOMHgMIIt+
         CaSg7FiXYx8KXsbEOpBJhHo+qFlGyy0XC9TvLD2XxgUszj3wGI+lhWO0vbg9EGfFlSCq
         e7d4GkFiHDB++qk4/g9ypeiXgyaraNi+jNYFU9pli/VJMEb96gkLBEZobauv9okX8h38
         cYpFKtxDv9S1umpDjAE6LxVaeEvyIl365uo3PbG4jq7z2X62Khc3jSE0ajixSrTx9GVC
         aWPAtWITMz5i0fDzcjULjoOzdn27FF66Jw4Xg5BCDkWJXfmJD9Ji/rJBCOF6q2pxHt7y
         L7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9jEvZjc2+umi5MvYcNLZKb83bYswxMWT40Sgskk8a0=;
        b=C+6cK3pwCaoQqOETBTO6pd09qc15ibVPFq2xvk0HkD6cfoh7yKsTVKZ8AEwBaSTNZJ
         TOAgnwoa487VZjF8eJIAiXtuyl+PyFGKD2Y537cKMaEhWvP00EITwuGm0hREqEMfbASe
         OcjCzjAP9H0HneYneuprdloGXmQlZal7pVHj62T1vlUwIkVGRuXThA8sOKtillMezh5Z
         4xmOahtRCvoO5BQEZzlO+74IKb4UjWTm7g8nHu6nId5nVILf7xtLtnoJypnb5lTC/7+d
         c9ZibQP+HhMxKsKWUyHs4A2x7IH5cWbxHW887bACyq0QGvXY6HD1ZsiuhcydgXYSWbby
         zwwA==
X-Gm-Message-State: APjAAAVJqQy1n2SGBVx40MR+NoqL5PbMQoY5oJjK6YwUb7duWRxp5Y5U
        k5qYiBISQtQfQiHJjK5UKtkQkw==
X-Google-Smtp-Source: APXvYqwibJMkjX4WpvOLZ+fmynsQiAFeWPLepic+Pu+LFXREzkXRg8kZCwEWJPVPmKqzBQGB3S3i+w==
X-Received: by 2002:a1c:eb03:: with SMTP id j3mr16172394wmh.15.1557136702640;
        Mon, 06 May 2019 02:58:22 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c10sm23409791wrd.69.2019.05.06.02.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:58:21 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 0/4] ASoC: hdmi-codec: fixes and improvements
Date:   Mon,  6 May 2019 11:58:11 +0200
Message-Id: <20190506095815.24578-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a collection of fixes and improvement on the hdmi
codec driver. It should be completely transparent for the current users
of the codec.

The most important change is removal the current_substream pointer which
allows the codec to be used on codec-to-codec links. I plan to use this
for the HDMI sound support of the Amlogic g12a SoC family.

Changes since v1:
* Drop already applied patches
* Rebase patchset on sound/for-next

Jerome Brunet (4):
  ASoC: hdmi-codec: remove function name debug traces
  ASoC: hdmi-codec: remove reference to the current substream
  ASoC: hdmi-codec: remove reference to the dai drivers in the private
    data
  ASoC: hdmi-codec: remove ops dependency on the dai id

 sound/soc/codecs/hdmi-codec.c | 188 ++++++++++++++++------------------
 1 file changed, 91 insertions(+), 97 deletions(-)

-- 
2.20.1

