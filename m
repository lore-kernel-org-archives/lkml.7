Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B1F2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of6jkP71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfHNGI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:08:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36839 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfHNGI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:08:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so24448230lfp.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSksoEM6AOP7H4nx5slyJOwVx6G+Lfd4yTDhKXFI4kw=;
        b=Of6jkP71r4l9hIWGhjXEn6k3ZQXEbpaIaO3H210UOh4VYtJCUbtF5QhSlMuKHIEWiF
         PPxk4tArZlRxJ4MWvamV/A6gUDEmTLgaMLTAeX+/oeNbUnGIeHxfJcr8CZg2y3Kjad0q
         t9VO5xOqidl9/XWlGmNmmLWvK2UO+1wDsI6BK4jRzJdgbDMFGaGkqmXNF8Ah0De7S8Hk
         tCujzldHtTcr4Se4O1SKV61TCZG7M71GzDoXhDMgIej8v5mywFfBi+LTACNiVPh+3bQh
         OEBwfx0fzGE6wsRVJlcTUy1/fBTbe/L53aY/QPzWikBip14hwF3Eugg4Ng7LW+kA6OCm
         Ebig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSksoEM6AOP7H4nx5slyJOwVx6G+Lfd4yTDhKXFI4kw=;
        b=J+ZgcQZXtj8Ipqv/VGaZVUrjywxPkogHzhMmRk9hD5KPTZkBaMRHd8b0Ws8tp/geg0
         Qr+I0oavBlvtSMaNHEd1GSfiS08VfMAKkZkpgwx6pyHNMSiPIj4xh30CTi6q7l0jb//2
         KRtqKjVew9xNqomxboxtpyZ1Xl4lsiCPxxUVzLRZqKjEJCP3oWs9dwXIJTcyDDmDZTY8
         hAGqUqch9MOWFTU06/+xEZNL31e35tGHRJX+acM71ZCVo/PaPeuQ545hl/hDXRlUACDK
         2mm2HEhBMMsAU1vmeoCM+uKaj+6/DCVd4j6okEtAKgkc0qXawKfN6aDHlB3l/s4ytDed
         JcAA==
X-Gm-Message-State: APjAAAWcAtpoJQ/sUXb8HUDCdmCKxURMFnlW8g30mBDPoOQ2NVZPdwH9
        OLzLlIcx+VSzOIY7nUlfzUY=
X-Google-Smtp-Source: APXvYqzDEhoiObAivBRlNhvLf+Jr5rb2KVMNEytoFIqeDJzvNkvCX+VS8HpTMDqFXbrqfHV7pZRBgg==
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr24200422lff.95.1565762936954;
        Tue, 13 Aug 2019 23:08:56 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.08.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:08:55 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 00/15] ASoC: sun4i-i2s: Updates to the driver
Date:   Wed, 14 Aug 2019 08:08:39 +0200
Message-Id: <20190814060854.26345-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
found whilst getting slave clocking and hdmi audio working on the newer
SoCs. As the LibreELEC project is progressing extremely well then there
has been some activity getting H6 SoC support with surround sound
working and these changes are also included.

The functionality included with the new patch set has been extended to
cover more sample resolutions, multi-lane data output for HDMI audio
and some bug fixes that have been discovered along the way. I have
changed some of the original reg fields into function calls as this made
it easier to setup for multi-channel audio especially across different
SoCs.

I can see more usage of the tdm property since I last attempted to push
these patches and the examples currently in mainline sort of the opposite
to what I'm trying to achieve. When we first started looking at the i2s
driver, the codecs that we were using allowed for the frame width to be
determined based on the sampling resolution but in most use cases it
seems that a fixed width is required(my highest priority should be to get
HDMI audio support in). We're using the tdm property to override the old
way to calculate the frame width. What I've seen in what has already been
mainlined is that the i2s driver has a frame width that is fixed to 32
bits and this can be overridden using the tdm property.

My test branch for this can be found at
https://github.com/codekipper/linux-sunxi/commits/upstream-i2s , I've been
using a Pine64 to test with; validating the new SoC block with HDMI audio
and ensuring that I've not broken the old block by making sure that the audio
codec still works. If we able to get the first three patches delivered then
that is enough for HDMI audio support on the newer SoCs(H3, A64 etc).

I still need to investigate the FIFO syncing issues which i've not had a
chance to change or address the concerns that broonie and wens brought up.
This change has been moved to the top of the patch stack. I would also like
to make the multi-channel audio and audio mapping more configurable via the
device tree. Currently what is implemented suites our current needs.

BR,
CK

---
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
Jernej Skrabec (3):
  clk: sunxi-ng: h6: Allow I2S to change parent rate
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  ASoC: sun4i-i2s: Add support for H6 I2S

Marcus Cooper (12):
  ASoC: sun4i-i2s: Add regmap field to sign extend sample
  ASoC: sun4i-i2s: Add set_tdm_slot functionality
  ASoC: sun4i-i2s: Correct divider calculations
  ASoC: sun4i-i2s: Support more formats on newer SoCs
  ASoC: sun4i-i2s: Add functions for RX and TX channel offsets
  ASoC: sun4i-i2s: Add functions for RX and TX channel enables
  ASoC: sun4i-i2s: Add functions for RX and TX channel selects
  ASoC: sun4i-i2s: Add functions for channel mapping
  ASoC: sun4i-i2s: Add multi-lane functionality
  ASoC: sun4i-i2s: Add multichannel functionality
  ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
  ASoC: sun4i-i2s: Adjust regmap settings

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   2 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   8 +-
 sound/soc/sunxi/sun4i-i2s.c                   | 690 ++++++++++++++----
 3 files changed, 542 insertions(+), 158 deletions(-)

-- 
2.22.0

