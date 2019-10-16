Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29361C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F392021848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do+e/YaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389559AbfJPHHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:07:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41208 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389242AbfJPHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id f5so22818178ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZhTgNjpKNQusZyPVoOQIc1FXI/m0QRLJulVFef76XX8=;
        b=Do+e/YaGZ/1kWMOZw1D1T1VnuBALKM+/iodChqull8q+46Lag2kJ3nIo7vEhP38y5z
         Yx/BSyBkRCVuh2n96BV0wQa7eiQhZ5cUKWivQV2hY6S4HKkKx/H/d/PUMMWgG3ijMTkd
         FYzGq1f2k8UALpZUFtbNZnLTwxCcUN7lHYIXoZNUxbO8KeQaEDMPbhl+j0zXHFiR6+rE
         7uH3DeWFbEeiHiVkSfzGwUCsOhj4OVpiJIsw+y6VTfTeBUUl9E3FK8ZI3X8d0ynXfjnA
         3ieluyI+90fOxZE3q2V+qrlN/M0gdWB2+7TCVXM8WXSwLy8VbfZTLXMEAVgGe7ZaYvii
         SU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZhTgNjpKNQusZyPVoOQIc1FXI/m0QRLJulVFef76XX8=;
        b=FyWBOTBqA04Xda52TnVQT5J0arjRBzZ2VQ4PeECDSlSg57ex3ihIn81bJRZWlbDJK2
         oX2xsUXvgf4TRBXiVlA+tNQ8hp5xyS0mjWFq7NMmt5N/8tHC/XKsmy2nx3OgFEqD0QMJ
         3V4QNBjc6LhRjnREwDFdOAbn6HW5uzw+E38o179yc8NdoCN8H0lM/U2gLD2y2StCOsuO
         arWFZcx1XX1/k3FAXpllkf3FiPFUXVeDawqJ0VDPgqO677H0rfYM44iW1jpCfuEc8teJ
         WzJJwt5A3C4uxfuPId7p7ayXaY6Q10I/zW16P/aO/j7/mydWBp1FGLtYurUhFNTQEtpQ
         84Jw==
X-Gm-Message-State: APjAAAXam4fancr1E9pgIEFHJCsEtZBrp/wgBTXEFs0OEF2Lo6Sfy8oi
        7/8g97HgUpir8T/IQt+4Dso=
X-Google-Smtp-Source: APXvYqwClC2cQSENX+/5tnSvwIw58bgtoluNV+WC1Z1QqCdducKDlTv9sD/34p2DOfggOz109aI5SQ==
X-Received: by 2002:a2e:957:: with SMTP id 84mr25058609ljj.23.1571209662571;
        Wed, 16 Oct 2019 00:07:42 -0700 (PDT)
Received: from localhost.localdomain (c213-102-65-51.bredband.comhem.se. [213.102.65.51])
        by smtp.gmail.com with ESMTPSA id j191sm1361493lfj.49.2019.10.16.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:07:41 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 0/7] ASoC: sun4i-i2s: Updates to the driver
Date:   Wed, 16 Oct 2019 09:07:33 +0200
Message-Id: <20191016070740.121435-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,
To be able to add support for the Allwinner H6 I've changed some of the
original reg fields into function calls as this made it easier to setup
for multi-channel audio especially across different SoCs. I've also
stripped out all the other patches unrelated to this which I will deliver
after support for the H6 has gone in.

These other patches are required for HDMI audio which is driving this
patchset and they can be found here
https://github.com/codekipper/linux-sunxi/commits/upstream-i2s
BR,
CK

---
v6 changes compared to v5 are:
- rebased onto the recent tdm delivery
- stripped out patches not required for the H6 delivery

v5 changes compared to v4 are:
- removed delivered patches.
- Added more details to commit messages.
- replaced some reg fields with function calls.
- Added DSP_A and DSP_B support for H3 and later SoCs.
- Added support for the Allwinner H6.

v4 changes compared to v3 are:
- Moved patches around so that the more controversial of patches are
  at the top of the stack.
- Added more details to commit messages.
- Fixed 20bit audio PCM format to use 4 bytes.
- Reduced number of flags used to indicate a new SoC.

v3 changes compared to v2 are:
 - added back slave mode changes
 - added back the use of tdm properties
 - changes to regmap and caching
 - removed loopback functionality
 - fixes to the channel offset mask

v2 changes compared to v1 are:
 - removed slave mode changes which didn't set mclk and bclk div.
 - removed use of tdm and now use a dedicated property.
 - fix commit message to better explain reason for sign extending
 - add divider calculations for newer SoCs.
 - add support for multi-lane i2s data output.
 - add support for 20, 24 and 32 bit samples.
 - add loopback property so blocks can be tested without a codec.

---
Jernej Skrabec (2):
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  ASoC: sun4i-i2s: Add support for H6 I2S

Marcus Cooper (5):
  ASoC: sun4i-i2s: Move channel select offset
  ASoC: sun4i-i2s: Add functions for RX and TX channel offsets
  ASoC: sun4i-i2s: Add functions for RX and TX channel enables
  ASoC: sun4i-i2s: Add functions for RX and TX channel selects
  ASoC: sun4i-i2s: Add functions for RX and TX channel mapping

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   2 +
 sound/soc/sunxi/sun4i-i2s.c                   | 337 ++++++++++++++++--
 2 files changed, 305 insertions(+), 34 deletions(-)

-- 
2.23.0

