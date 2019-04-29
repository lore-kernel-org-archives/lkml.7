Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F1C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F3020673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfD2K5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:57:39 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.129]:44908 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727710AbfD2K5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:57:38 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.eu-west-1.aws.symcld.net id BB/06-25548-F98D6CC5; Mon, 29 Apr 2019 10:57:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRWlGSWpSXmKPExsVy8IPnUd15N47
  FGKx/rWNxqmUPu8WVi4eYLKY+fMJm8e1KB5PF5V1z2Cw6d/WzWmz4vpbRgd1jw+cmNo/WS3/Z
  PHbOusvusWlVJ5vHvrfL2DzWb7nK4vF5k1wAexRrZl5SfkUCa8b5069YCu6LVUw4s4qlgfG6U
  BcjB4eQwHpGie+xXYycQGaFRPPMeYwgNpuAhcTkEw/YQGwWAVWJg69ms4PYwgJhEqs+7GAGsU
  UEuhglzh/17mLk4mAWmM8osW3hVVaQBK+Ag8TM7pfsELagxMmZT1hAbGYBCYmDL14wQywzkDi
  9oBEsLiFgLzH9/VVmkHskBPQlGo/FQoQNJb7P+sYCETaXeNKaP4GRfxaSobOQDF3AyLSK0SKp
  KDM9oyQ3MTNH19DAQNfQ0EjXyMBI19DIRC+xSjdZL7VUtzy1uETXUC+xvFivuDI3OSdFLy+1Z
  BMjMPxTCk7V7GCc3p1+iFGSg0lJlHfptqMxQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4n18/Fi
  MkWJSanlqRlpkDjESYtAQHj5IIbw1Imre4IDG3ODMdInWKUZfjYevnucxCLHn5ealS4rx914C
  KBECKMkrz4EbAksIlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK86SBTeDLzSuA2vQI6ggno
  iPh5YEeUJCKkpBoY1837wRSkmxY+6YTdxNemCyUmcJhLRAU/7s9ft6ih5JGcxq7dJfMdDky6V
  MC01TvI2L77zL/jfKzBpyL27rpjvvavtuHT6zu+lczvtzac/9+vwChZZ0tRdNm0DjfTxzXBF1
  Y1n3uQoXDV/98K3WORCwrLJcL8A1cXfFcxmKeRdHX+XieOyEuRSizFGYmGWsxFxYkAe8BvVQU
  DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-302.messagelabs.com!1556535454!7351215!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12516 invoked from network); 29 Apr 2019 10:57:34 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-16.tower-302.messagelabs.com with AES128-SHA256 encrypted SMTP; 29 Apr 2019 10:57:34 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Mon, 29 Apr 2019 11:57:33 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 71FB83FBCC; Mon, 29 Apr 2019 11:57:33 +0100 (BST)
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 29 Apr 2019 11:57:33 +0100
Subject: [PATCH v2] ASoC: da7219: Use clk_round_rate to handle enabled bclk/wclk
 case
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20190429105733.71FB83FBCC@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 29/04/2019 08:13:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some platforms where DA7219 is the DAI clock master, BCLK/WCLK
will be set and enabled prior to the codec's hw_params() function
being called. It is possible the platform requires a different
BCLK configuration than would be chosen by hw_params(), for
example S16_LE format needed with a 64-bit frame to satisfy certain
devices using the clocks.

To handle those kinds of scenarios, the use of clk_round_rate() is
now employed as part of hw_params(). If BCLK is already enabled
then this function will just return the currently set rate, if it
is valid for the desired frame size, so the subsequent call to
clk_set_rate() will succeed and nothing changes with regards to
clocking. In addition the specific BCLK & WCLK recalc_rate()
implementations needed updating to always give back a real value,
as those functions are called as part of the clk init code and a
real value is needed for the clk_round_rate() call to work as
expected.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
Changes in v2:
 - Removed clk_round_rate() call for WCLK/SR as this is not sensible.
 - Added checking after clk_round_rate() call for BCLK to verify returne rate is
   suitable for the hw_params() desired frame size.

 sound/soc/codecs/da7219.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5f5fa34..206d01c 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1621,6 +1621,21 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 
 		if (bclk) {
 			bclk_rate = frame_size * sr;
+			/*
+			 * Rounding the rate here avoids failure trying to set a
+			 * new rate on an already enabled bclk. In that
+			 * instance this will just set the same rate as is
+			 * currently in use, and so should continue without
+			 * problem, as long as the BCLK rate is suitable for the
+			 * desired frame size.
+			 */
+			bclk_rate = clk_round_rate(bclk, bclk_rate);
+			if ((bclk_rate / sr) < frame_size) {
+				dev_err(component->dev,
+					"BCLK rate mismatch against frame size");
+				return -EINVAL;
+			}
+
 			ret = clk_set_rate(bclk, bclk_rate);
 			if (ret) {
 				dev_err(component->dev,
@@ -1927,9 +1942,6 @@ static unsigned long da7219_wclk_recalc_rate(struct clk_hw *hw,
 	struct snd_soc_component *component = da7219->component;
 	u8 fs = snd_soc_component_read32(component, DA7219_SR);
 
-	if (!da7219->master)
-		return 0;
-
 	switch (fs & DA7219_SR_MASK) {
 	case DA7219_SR_8000:
 		return 8000;
@@ -2016,9 +2028,6 @@ static unsigned long da7219_bclk_recalc_rate(struct clk_hw *hw,
 	u8 bclks_per_wclk = snd_soc_component_read32(component,
 						     DA7219_DAI_CLK_MODE);
 
-	if (!da7219->master)
-		return 0;
-
 	switch (bclks_per_wclk & DA7219_DAI_BCLKS_PER_WCLK_MASK) {
 	case DA7219_DAI_BCLKS_PER_WCLK_32:
 		return parent_rate * 32;
-- 
1.9.1

