Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61BCC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9CA2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="y1KrOO2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfD2N3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:29:50 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33213 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2N3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:29:50 -0400
Received: by mail-wr1-f45.google.com with SMTP id s18so16140451wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMPo0rd7ZXjpiRM4+zIpn+YrRKSVz4ZqI2UlGQZefLc=;
        b=y1KrOO2XKwzw0QbhbT87K2BeeNvx+RN+tOkxY34bnGC0fEhMdcoMNQq/g3j/fai1Ip
         yIwDX6ptAcPntfpkqh5kxruD1yOHc4SNF8VAYYTPkyWjXQfsPvolKCtiMht1gqB77OMr
         kDpXTxPrzS3pgtk6NsFjJNqluthsqfFROO32TJYUQ/VFQzpWOWQaxg/mQvXRodbFn6XH
         XIibnKsCO9J8G+gtRJBA8Iz9UlXM++UYgizAERYQR7s+E+6MIUm9C9xwOiNQ8v7DUokV
         ogyT1HfO3CTcDBDSx73EpUcnoFpB3Hv/SioigduQSTzx6udoOU5kBZwLOnBGtarlHQUv
         HQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMPo0rd7ZXjpiRM4+zIpn+YrRKSVz4ZqI2UlGQZefLc=;
        b=k1BfpLZyAUFKnbYVFYM+RMPPWMd5pe4MWsS1yelU9IYHtoL2Je9Eo7tfq9bCrM9jD8
         mqkbPKE630W2y2nhL5VrbIDBfhoRtU2JUn7JWHGh9JnavZOkWN7YfOgQjUL/yjtZAZHj
         rpKVjRbT21jjOQWy8fINzfyPxj5L6i6zErGyVm31Pm60l/mrsDKPLSr7pGYIutZgKgYM
         5a6pyQWcMR3pvIKRQdlfPIME0vGOhMVw0r7Y2/FpDIr63Gn1kIQTDCplproOTSuq3l1m
         S6uDzs441r5kc7SABNKW4loMROCahsGKlRb43BIMVhAZ8jWuD3fhgiDQJ1ceCBrwfo98
         MN+Q==
X-Gm-Message-State: APjAAAXOOstirwZk6IbH34EaYcUDEpDqZGfsMcs0nQB3i9HqYQxc0MO+
        1/HEEG8ZQl24FEy10sCoVLRCfw==
X-Google-Smtp-Source: APXvYqxgLutCwa5iw2MV+S09Q8TgGm4NR377EBLqs43h9sjcaCUGdnwG5LVkz1dmERLKeUqev1U6FQ==
X-Received: by 2002:adf:e288:: with SMTP id v8mr5162412wri.7.1556544588440;
        Mon, 29 Apr 2019 06:29:48 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s17sm2857593wra.94.2019.04.29.06.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 06:29:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 0/6] ASoC: hdmi-codec: fixes and improvements
Date:   Mon, 29 Apr 2019 15:29:37 +0200
Message-Id: <20190429132943.16269-1-jbrunet@baylibre.com>
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

Jerome Brunet (6):
  ASoC: hdmi-codec: remove function name debug traces
  ASoC: hdmi-codec: unlock the device on startup errors
  ASoC: hdmi-codec: stream is already locked in hw_params
  ASoC: hdmi-codec: remove reference to the current substream
  ASoC: hdmi-codec: remove reference to the dai drivers in the private
    data
  ASoC: hdmi-codec: remove ops dependency on the dai id

 sound/soc/codecs/hdmi-codec.c | 259 ++++++++++++++++------------------
 1 file changed, 125 insertions(+), 134 deletions(-)

-- 
2.20.1

