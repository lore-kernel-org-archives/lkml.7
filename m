Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B51FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B94221872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HUDj5gvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfDEMcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:32:02 -0400
Received: from mout.web.de ([212.227.17.11]:36223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfDEMcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554467461;
        bh=BTQLeyt4owsegpWWhDIxAIo4qZedRh0aTQu2Jr93aZk=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=HUDj5gvOf+OkgY19vROWT3hc1d8V2h0A2P0SNn6AIKrnprRGlVZpyBbLLgHwrYX72
         sKHVG6c67QCFZL7Zcnfe6w86d8ejm7tGYl+G+ymqHled2hh4jNP2KsDJkKL5SJa6Lf
         SOI4eN6C+Y5Y+otXIqOXN3X2ZBTNK5cdMk4YwXOc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.156.119]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8hwt-1gyRkc01z9-00wDRM; Fri, 05
 Apr 2019 14:31:01 +0200
Cc:     linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Yi Wang <wang.yi59@zte.com.cn>
References: <1551169071-11639-2-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH 2/3] ASoC: fsl_utils: fix a leaked reference by adding
 missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <94bbd764-9727-5e17-aab0-66738edec39f@web.de>
Date:   Fri, 5 Apr 2019 14:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1551169071-11639-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:n11wZCPQkiaiHKHonaXxL+zH3VtKnMXVrK+OeNH1Jb0QxQUm2S3
 7hFdeEueFIvIFdwT/fQupbg7gUeUS/o2BZIO43aL9RjU4p8XaTV+8Y8ZHlR+ALogq6GQHg3
 9Vcy22XoL3AfIgDS7gaBZyR0JWyJOSUGjkrJGfVQr/XF67ozjmEnHthtCyc3iJ5enmHVlcA
 dKr80gzoTVc0cy7QhHfYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GwWM8qn3Cs4=:yIJPNM/LaIlTqTn56zoWTw
 NvUc6AlJ+KqelSb7sjrfYpf2WEVYXb6w9VZExwZjis1hITuWh8T7w+OorSDoE1is2yYEn4N4/
 0hZixlo7BR/pGZT6QCjg4bGjJiO2Yp9LHVn4IBMxiKv1rIYwkBMqHUYW878mx+HNHGQ/n7Ao1
 dy84kjM+cvrGrHQ6RKOmhYQ1OPBHQBCVwkrBCCDL22PIZ6MhoKB+mXOHJs/TsESLiUbg+ztn8
 iDflH4JqfPN1Xmul+OVDXH+6mfmVFIMq2YCi4eDkIKVxjsIdsn2VhlXoMKWWA9i+71ybrURU2
 QOqIWSqvSghbeKWKvNKrFUjoxG2iBMnxaNsm05JROBSnx4+YMvWV+82bxJqtvX7VHUZjaGOGN
 Bp1RWW6GjVICCIrb23jqPmupzsxVJiXUKcyxukJHr9i9fKMGl8kUVKK+hkdHEoBHcvkMoKZ8k
 3GFNcH26TTulGRJT6OxRpSaye0kb4Re4T0xp0JwjEEBHOjaHr3M9i6W/BNBKs91Tgk+U0rQlj
 vHBwGCQZjJkI7mgn2F/51pXIOaBWY1DJVTTePC+m4++aEKd+w3k9WJ07hFQP3lGocgO2ZjjR/
 18/oy8YT+mg/ngII0dnt9ky1QWiXHZyMLnwP2qEeEgfOD391QKDNA6mFAKPvmn5jP9OEURaTZ
 zu2I1zeFkYSHwXIhQXRmtxgWqnHXs2TETsivih25eLutwD7WdLmcoPH17fueqqQYX5OcY9O4v
 VzPiiqkMsWJ66g+zYo+i+OwUXsfVOHHyOLcfUVuGZl9ZVp4FEo8m+io50XKiBAMydghGJotFe
 Cv9yUPIoPW5jRHgfd8LktlZnA6CRSXrivhL12sIEPxJMmIqiV+eR1QWDxeKLV2NHrrOtJ50YW
 RjNQe1BwJb32TVi2B/R2zvjtvdNE9eqBodpYrdcDPbvBGjZQYYsI8m7r9p4MPW3WsAdlAkPZl
 fZNHOqWL2nA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -71,6 +71,7 @@  int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
>  	iprop = of_get_property(dma_np, "cell-index", NULL);
>  	if (!iprop) {
>  		of_node_put(dma_np);
> +		of_node_put(dma_channel_np);
>  		return -EINVAL;
>  	}
>  	*dma_id = be32_to_cpup(iprop);

How do you think about to adjust the exception handling in this function
implementation a bit more according to the Linux coding style?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/fsl/fsl_utils.c?id=c705247136a523488eac806bd357c3e5d79a7acd#n16

Regards,
Markus
