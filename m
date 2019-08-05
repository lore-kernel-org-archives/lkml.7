Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D97DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA1C2087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VKzwCZsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfHENlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:41:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50475 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHENlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:41:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so74807634wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3FggyWEk7iag/gjHOv9EP41vPE6V1cAArTG8uYr8XE=;
        b=VKzwCZsY5ujaTHwBT2AdabMwz/1j90BaDaa/VIhk7cwlJO/n264xa2vUQOchFf6hn1
         iu24xUGNF3exhSvC8sOfcU/WP7MHEpYz/JQi5vY4N0rpFRQ82yUIc7fT6QjSg4sLApfW
         AFtp86CS+jmu0DbCb5QFeDCGFqmNTB0si0PY8C4SC39LwW5U15uabg5vrEjne46KEZIn
         L0vhnpzT/HAVWyLSZ88RB448nF5GfiMbcwdmRxymXqDL7tAB/BT8Bp2NaS+NI1QbEYFg
         5zNSN1uU0r3p79VVyvXzjFIKCtqRQOHtpk4qkXtx1dPs1l1ks7l5kqR4qlp9VVFwooHF
         yjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3FggyWEk7iag/gjHOv9EP41vPE6V1cAArTG8uYr8XE=;
        b=t8dNvWYGL6KlECeV+cE0hcfP7+bMeGbA9wqogxThZcHDwhw6kDMDQvtZeGYtgWjTyr
         cp9kf5zUZBxk4c4uHpjHHehyXiozTwn1Km28vKqYi0TjDfkNpgWSKoaHqL8fQSiOmM/A
         yot4JbjFOAhcRf+dfC7Hspu+4y04qU4W3lqQetNhbbG86v2kii6pmGpdfjF7DMwWgJZ7
         lyn+jt4ZEI8ezopEYcnt0TWAGKRLwFf27FhvN9yysrVAbvA/+nganvsBPUols9QyRAX9
         ii7l3ErTjC/AhhXo445guWUkwvADOGCZelH7iMKjH1HlqjlTCq/LW1TC+opFubhyRN8H
         ZLmg==
X-Gm-Message-State: APjAAAWayERu7cuFxsVV+bzYZ0jTRYmpyNCmfQ5l16oBSs32IgIS/Jtk
        IdNj8YEA5jAIKRBePmfKyktxptoPuC4=
X-Google-Smtp-Source: APXvYqwF6PGarFPBjk3nNJY6M7XmmSODW9OY5CMXn6Qo4jDotnjtLtsU/m8nGsyE18j0hM+jq4UcTA==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr19859634wmb.112.1565012466102;
        Mon, 05 Aug 2019 06:41:06 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm99040534wrn.11.2019.08.05.06.41.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:41:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/8] drm/bridge: dw-hdmi: improve i2s support
Date:   Mon,  5 Aug 2019 15:40:54 +0200
Message-Id: <20190805134102.24173-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to improve the support of the i2s
interface of the synopsys hdmi controller.

Once applied, the interface should support all the usual i2s bus formats,
8 channels playback and properly setup the channel number and allocation
in the infoframes.

Also, the dw-hdmi i2s interface will now provide the eld to the generic
hdmi-codec so it can expose the related controls to user space.

This work was inspired by Jonas Karlman's work, available here [0].

This was tested the Amlogic meson-g12a-sei510 platform.
For this specific platform, which uses codec2codec links, there is a
runtime dependency for patch 8 on this ASoC series [1].

[0]: https://github.com/Kwiboo/linux-rockchip/commits/rockchip-5.2-for-libreelec-v5.2.3
[1]: https://lkml.kernel.org/r/20190725165949.29699-1-jbrunet@baylibre.com

Jerome Brunet (8):
  drm/bridge: dw-hdmi-i2s: support more i2s format
  drm/bridge: dw-hdmi: move audio channel setup out of ahb
  drm/bridge: dw-hdmi: set channel count in the infoframes
  drm/bridge: dw-hdmi-i2s: enable lpcm multi channels
  drm/bridge: dw-hdmi-i2s: set the channel allocation
  drm/bridge: dw-hdmi-i2s: reset audio fifo before applying new params
  drm/bridge: dw-hdmi-i2s: enable only the required i2s lanes
  drm/bridge: dw-hdmi-i2s: add .get_eld support

 .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   | 20 ++-----
 .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |  1 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 59 +++++++++++++++++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 37 ++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     | 13 +++-
 include/drm/bridge/dw_hdmi.h                  |  2 +
 6 files changed, 107 insertions(+), 25 deletions(-)

-- 
2.21.0

