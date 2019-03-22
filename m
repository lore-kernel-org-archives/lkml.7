Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA4EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C88921900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfCVQr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:47:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49402 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCVQr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:47:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6763AA78;
        Fri, 22 Mar 2019 09:47:57 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A158D3F59C;
        Fri, 22 Mar 2019 09:47:55 -0700 (PDT)
Subject: Re: [PATCH] ASoC: codecs: Fix to avoid potential NULL pointer
 dereferences
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org
References: <20190319005805.13823-1-pakki001@umn.edu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <23781985-7747-730c-764d-1565a511cb67@arm.com>
Date:   Fri, 22 Mar 2019 16:47:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319005805.13823-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 00:58, Aditya Pakki wrote:
> In sirf_audio_codec_driver_probe, of_match_node may fail and return a
> NULL pointer. The patch avoids a potential NULL pointer dereference.

Actually 'match' isn't used in this function...  So there's no chance of
a NULL dereference. You might as well remove the call.

Steve

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  sound/soc/codecs/sirf-audio-codec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
> index e424499a8450..fd2bbd6a3c58 100644
> --- a/sound/soc/codecs/sirf-audio-codec.c
> +++ b/sound/soc/codecs/sirf-audio-codec.c
> @@ -464,6 +464,8 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  
>  	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>  
>  	sirf_audio_codec = devm_kzalloc(&pdev->dev,
>  		sizeof(struct sirf_audio_codec), GFP_KERNEL);
> 

