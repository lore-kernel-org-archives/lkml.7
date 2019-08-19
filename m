Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C4BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B4122CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242734;
	bh=8vRsvS2UGGwvEnAdIxjo2i3ETJRhz5Wf5lCbKvVguOs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jX1sX4q0TA+qYjpl2z6CmgVm2F8NAQ0nFk0rAmYPchmeWedqVi2RmpAx0j9V6+h0t
	 TcbAkSWx2atX7A2Pjuz1ztA5teXkcn72Zbz1KjBeISuDwctqAc0ctNZicA6k+SlBJ1
	 INNtSWs4IRG1A5Rxa8Y1H5opI0vb4t0E1gB8sbL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfHSTZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfHSTZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:25:32 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E72206C1;
        Mon, 19 Aug 2019 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242732;
        bh=8vRsvS2UGGwvEnAdIxjo2i3ETJRhz5Wf5lCbKvVguOs=;
        h=From:To:Cc:Subject:Date:From;
        b=l8OJWcmughWZuDP3/XDpGNVsTiZDTfTDaJoWhgDX7iEKwDp3iUkFyIwxIpEObvfDB
         Dxtbxko+4GaOBxk8wZiQ13pSL+1HsW8evfVGhzlbp8+WJPdkAHfJonqwQRp8KVAmtK
         v71cIdSd3diqeCyi3v7A/LtO6rFr8tZgxPKslgh0=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] ASoC: sun4i-i2s: Number of fixes and TDM Support
Date:   Mon, 19 Aug 2019 21:25:07 +0200
Message-Id: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

Hi,

This series aims at fixing a number of issues in the current i2s driver,
mostly related to the i2s master support and the A83t support. It also uses
that occasion to cleanup a few things and simplify the driver. Finally, it
builds on those fixes and cleanups to introduce TDM and DSP formats support.

Let me know what you think,
Maxime

Marcus Cooper (1):
  ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs

Maxime Ripard (20):
  ASoC: sun4i-i2s: Register regmap and PCM before our component
  ASoC: sun4i-i2s: Switch to devm for PCM register
  ASoC: sun4i-i2s: Replace call to params_channels by local variable
  ASoC: sun4i-i2s: Move the channel configuration to a callback
  ASoC: sun4i-i2s: Move the format configuration to a callback
  ASoC: sun4i-i2s: Rework MCLK divider calculation
  ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK
  ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs
  ASoC: sun4i-i2s: RX and TX counter registers are swapped
  ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
  ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs
  ASoC: sun4i-i2s: Fix the LRCK polarity
  ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t
  ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t
  ASoC: sun4i-i2s: Fix the LRCK period on A83t
  ASoC: sun4i-i2s: Remove duplicated quirks structure
  ASoC: sun4i-i2s: Pass the channels number as an argument
  ASoC: sun4i-i2s: Support more channels
  ASoC: sun4i-i2s: Add support for TDM slots
  ASoC: sun4i-i2s: Add support for DSP formats

 sound/soc/sunxi/sun4i-i2s.c | 660 ++++++++++++++++++++-----------------
 1 file changed, 372 insertions(+), 288 deletions(-)

base-commit: d45331b00ddb179e291766617259261c112db872
-- 
git-series 0.9.1
