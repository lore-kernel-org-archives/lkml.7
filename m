Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F991C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A74F20830
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="n1CZpt3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbfCAMHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:07:07 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1931 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCAMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:07:06 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7920730000>; Fri, 01 Mar 2019 04:07:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 04:07:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 01 Mar 2019 04:07:06 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 1 Mar
 2019 12:07:03 +0000
To:     Mark Brown <broonie@kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Regression: ASoC: soc-core: clear platform pointers on error
Message-ID: <bbc0d37a-5a08-9ce0-58b6-c89d28c558ce@nvidia.com>
Date:   Fri, 1 Mar 2019 12:07:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551442035; bh=7wKq9d+Skb4EVsQ2Ggh7jucL0Vmi8f4T1ANYNVgzSnE=;
        h=X-PGP-Universal:To:From:Subject:Message-ID:Date:User-Agent:
         MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Language:Content-Transfer-Encoding;
        b=n1CZpt3KmqG6pA+7VH8fjtFOxGwwdUHGbOSzfUIji2s6GpAq69eLMU+H8qWVYwN0d
         U13zxqh1OEWU3D2rnJNK0S68rM232dt8c9zMlIeqN08RTMCrDecIzY090LCbr+akPm
         TNXJQDbt4hFivirTs87E9clhgw4oCCVA7Noy8nOsmR2/8uBQBWI0BCslubMg8JSj2u
         LeWdmqYQ/a1be6+4P2Bruyza0lRCBLroyjmOS8hf0avcfDHFDp5nYKyfgUL49dr8jp
         O5Y5cA8YcTB5QfHTwcmbYtnkmamm2FweXo9KY8vUy28t5UCweQgSnkA5t7a2yMaR7U
         DbPptX24RYqag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Curtis,

I am seeing a regression on -next where the soundcard on one of our
Tegra boards fails to initialise following a probe deferral. The bisect
points to the commit 78a24e10cd94420f1b4e2dc5923ae7109e2aaba1 ('ASoC: 
soc-core: clear platform pointers on error') and reverting this on top
of -next fixes the problem.

Looking at the bootlog from the failure I see ...

 tegra-snd-wm8903 sound: ASoC: failed to init link WM8903

 tegra-snd-wm8903 sound: snd_soc_register_card failed (-517)

 tegra30-i2s 70080400.i2s: DMA channels sourced from device 70080000.ahub

 tegra-snd-wm8903 sound: ASoC: Both platform name/of_node are set for WM8903

 tegra-snd-wm8903 sound: ASoC: failed to init link WM8903

 tegra-snd-wm8903 sound: snd_soc_register_card failed (-22)

 tegra-snd-wm8903: probe of sound failed with error -22


With the above change I see soc_cleanup_platform() is ever being called
when the probe is deferred and hence leads to the failure. Note that the
initial failure, "ASoC: failed to init link WM8903" occurs very early
in snd_soc_register_card() when initialising the prelinks. 

The following fixes it, but I have not scrutinised the code to see if
there are other exit points that we need to handle.

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 93d316d5bf8e..6f66beb0c3ae 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2797,6 +2797,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
                ret = soc_init_dai_link(card, link);
                if (ret) {
+                       soc_cleanup_platform(card);
                        dev_err(card->dev, "ASoC: failed to init link %s\n",
                                link->name);
                        mutex_unlock(&client_mutex);

Cheers
Jon

-- 
nvpublic
