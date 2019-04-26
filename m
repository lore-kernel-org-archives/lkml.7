Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9831BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9622067D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfDZM7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:59:30 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:32416 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbfDZM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:59:30 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id 65/D7-19007-EA003CC5; Fri, 26 Apr 2019 12:59:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRWlGSWpSXmKPExsVy8IPnUd11DId
  jDH5cFLQ41bKH3eLKxUNMFlMfPmGz+Halg8ni8q45bBadu/pZLTZ8X8vowO6x4XMTm0frpb9s
  Hjtn3WX32LSqk81j39tlbB7rt1xl8fi8SS6APYo1My8pvyKBNePL1S+MBV/FKnq7j7M1ML4R6
  mLk4hASWM8o8eLwRNYuRk4gp0Kid+4BFhCbTcBCYvKJB2wgNouAqsSOPecZQWxhgWCJue1dYD
  UiAl2MEuePeoMMYhaYzyixbeFVsEG8Ag4Sa64dZYawBSVOznwC1sAsICFx8MULZohlBhKnFzS
  CxSUE7CWmv78KFOcAsvUlGo/FQoQNJb7P+gZVYi6xb38T2wRG/llIps5CMnUBI9MqRoukosz0
  jJLcxMwcXUMDA11DQ2NdE10LS73EKt0kvdRS3eTUvJKiRKCkXmJ5sV5xZW5yTopeXmrJJkZgF
  KQUskTuYLy0NP0QoyQHk5Iob/2nQzFCfEn5KZUZicUZ8UWlOanFhxhlODiUJHhL/gPlBItS01
  Mr0jJzgPEIk5bg4FES4X0CkuYtLkjMLc5Mh0idYtTleNj6eS6zEEtefl6qlDjvApAiAZCijNI
  8uBGw1HCJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvBpApPJl5JXCbXgEdwQR0RMpKsCNK
  EhFSUg2MXi/0mU44fV2WvjD4bvPvyQ8+BYQn5Yevesv9sqW34cNODTVRnY6tszx/GdnU+2WzN
  a4tkNm9vrzo0/2UB/urcrdOO/AjTCPaZ0nuTL50+x77n71fDjFnzOsMEd+5s0495eRNhdXytx
  xDox1CVkb8vfzFo7C2rf23elR3YL6WEN/+lzZPF/1QYinOSDTUYi4qTgQA3S+hnAgDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-14.tower-239.messagelabs.com!1556283565!4816085!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3143 invoked from network); 26 Apr 2019 12:59:26 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-14.tower-239.messagelabs.com with AES128-SHA256 encrypted SMTP; 26 Apr 2019 12:59:26 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Fri, 26 Apr 2019 13:59:25 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 04F3F3FB4A; Fri, 26 Apr 2019 13:59:25 +0100 (BST)
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 26 Apr 2019 13:59:24 +0100
Subject: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled bclk/wclk
 case
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 26/04/2019 09:14:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some platforms where DA7219 is the DAI clock master, BCLK/WCLK
will be set and enabled prior to the codec's hw_params() function
being called. It is possible the platform requires a different
BCLK/WCLK configuration than would be chosen by hw_params(), for
example S16_LE format needed with a 64-bit frame to satisfy certain
devices using the clocks.

To handle those kinds of scenarios, the use of clk_round_rate() is
now employed as part of hw_params(). If BCLK/WCLk are already
enabled then this function will just return the currently set
rates, so the subsequent calls to clk_set_rate() will succeed and
nothing changes with regards to clocking. In addition the specific
recalc_rate() implementations needed updating to always give back
a real value, as those functions are called as part of the clk
init code and a real value is needed for the clk_round_rate() calls
to work as expected.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5f5fa34..72268f5 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1593,6 +1593,13 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 
 	sr = params_rate(params);
 	if (da7219->master && wclk) {
+		/*
+		 * Rounding the rate here avoids failure trying to set a new
+		 * rate on an already enabled wclk. In that instance this will
+		 * just set the same rate as is currently in use, and so should
+		 * continue without problem.
+		 */
+		sr = clk_round_rate(wclk, sr);
 		ret = clk_set_rate(wclk, sr);
 		if (ret) {
 			dev_err(component->dev,
@@ -1621,6 +1628,14 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 
 		if (bclk) {
 			bclk_rate = frame_size * sr;
+			/*
+			 * Rounding the rate here avoids failure trying to set a
+			 * new rate on an already enabled bclk. In that
+			 * instance this will just set the same rate as is
+			 * currently in use, and so should continue without
+			 * problem.
+			 */
+			bclk_rate = clk_round_rate(bclk, bclk_rate);
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

