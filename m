Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01559C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C547B2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256742;
	bh=lFmiHzMxA9irccZlgSBqnfmYinVia1Agczz5mLITE+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=og2yC92iX4NCEK/NORaljTUo1YPcS9N6V26s7Ae7x0sJ7QxJihsRBXFktSaOWnjkP
	 Sv5A/zNd3IZ9wj5aVm8lY7Jqn4l0+FvXBEuyAZE4tuRBjDb5vRN7mxwtlybLFN9ybI
	 +weze7BcBUy30YYh4shqq4oYmYM4i5OqVjtjTC4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbfCVMMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389608AbfCVMMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E56C21929;
        Fri, 22 Mar 2019 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256736;
        bh=lFmiHzMxA9irccZlgSBqnfmYinVia1Agczz5mLITE+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxlxMTKJLVWYdOp82m/ae0NTjoPqrm6dV9aZRV4wWHzTb5NaZ/O/Un6ECt8PlQV2I
         fPgHUs/vu8yhTLGrhJGyeDlS8IsxA4TsS0pq+LT7qSefnVv0FKYdRy9TLKZcskLj3c
         LJxFIszM2aXkn433WXq/L2nFnMZnnBPBmw2IM9PI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.0 005/238] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Date:   Fri, 22 Mar 2019 12:13:44 +0100
Message-Id: <20190322111258.642516886@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

commit 05bd7fcdd06b19a10f069af1bea3ad9abac038d7 upstream.

The ADCs are sleeping when the SLEEP bit is set and running when it's
cleared, so the bit should be inverted.
Tested on pcm1863.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/pcm186x.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -158,7 +158,7 @@ static const struct snd_soc_dapm_widget
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  1),
 };
 
 static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
@@ -184,8 +184,8 @@ static const struct snd_soc_dapm_widget
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
-	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
+	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
 };
 
 static const struct snd_soc_dapm_route pcm1863_dapm_routes[] = {


