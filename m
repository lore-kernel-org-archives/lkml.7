Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB41C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AFC2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahey5ESf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDKUMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:12:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32889 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKUMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:12:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id h5so3988949pfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lkadqpOzNcf9LB0J7+vgu9aowMST+yhJ4ntbZQm8mK8=;
        b=Ahey5ESf4YTsZMyDj4Z3utUoGjJNU09BAjDZUKQ4heDd8tga8DW6XtxbmwQZSgDwHc
         J9hjI0kmlwcTyPm/5/FvQ89a/vF8GftB0Ti5lip9t1XGRaufWcv/4CBdWYPb/86S//y2
         mbed1DO8XUlcNQraiVKsqIlmInYCXPlzx22bKcgRhATvq0UDceETZbDW66wv8dkjRGgL
         CJq79JBJL4VORZTlKHW336gg+73R8GUkBjB/VJxchr95Cznj0Avnz43Vp23OsNdozTC0
         qfUUFM/7bAuLIBS0gQVR5/8EnoUW06dcoGIrBkhrJqnOcIpki6++OZt72vXsYo4pP0n+
         JomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lkadqpOzNcf9LB0J7+vgu9aowMST+yhJ4ntbZQm8mK8=;
        b=rMvA6jyxIb27pu1tlxOYxjSnJ/O64bWvOW0FBhHNIycQgzj4rc54xycl4MMz9IAVT9
         Q+WQVj0RKpl1kSRDobmCKOINBM2mK/RyNcNJLhV5nLK63bAS+sGTAnb7N9zUntahn5je
         wmaABaYWxQ9pxK2GbjSucFE3FwF41KBg5DAqWshpTXnN2PquQxsH+dIoh7jn912diva0
         LBwv+Jht+9qMjdg59PMN00JirtvpDEKmLhDM4QUOjPWrd530zJ8TuJG/iGrRV7mN/H8s
         KMue2xaT/0KmYx4wh8ELODq4UqutOQoFcO6gbh/w2E33Z6nlpbiJYWfbKojTahvScdM6
         ufSQ==
X-Gm-Message-State: APjAAAXmL+t46rXi30qCYDuGweeY/jCJNWkFwpwgwPvXuxGgTJ1xQUpn
        NJuVTbUDAZo6Mblvkxpbkbs=
X-Google-Smtp-Source: APXvYqzIRelUUPwc7KH6u9QK8MLgTolFA8LYMQjvOP8nVu5UXxiS4QAr9AlV4vpSGS4+3ds2Liudpg==
X-Received: by 2002:a63:fd49:: with SMTP id m9mr49394582pgj.16.1555013521607;
        Thu, 11 Apr 2019 13:12:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r11sm78255231pga.87.2019.04.11.13.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 13:12:01 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:11:58 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_asrc: Unify the supported input and
 output rate
Message-ID: <20190411201158.GB13170@Asurada-Nvidia.nvidia.com>
References: <cover.1554975348.git.shengjiu.wang@nxp.com>
 <b7f4c8dd00743ddd09c33def00c1759757b8e743.1554975348.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f4c8dd00743ddd09c33def00c1759757b8e743.1554975348.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 09:39:09AM +0000, S.j. Wang wrote:
> Unify the supported input and output rate, add the

We previously didn't support 5KHz->5KHz, but now we do? That'd be
great if so.

>  static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> @@ -626,14 +629,18 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
>  		.stream_name = "ASRC-Playback",
>  		.channels_min = 1,
>  		.channels_max = 10,
> -		.rates = FSL_ASRC_RATES,
> +		.rate_min = 5512,
> +		.rate_max = 192000,
> +		.rates = SNDRV_PCM_RATE_KNOT,
>  		.formats = FSL_ASRC_FORMATS,
>  	},
>  	.capture = {
>  		.stream_name = "ASRC-Capture",
>  		.channels_min = 1,
>  		.channels_max = 10,
> -		.rates = FSL_ASRC_RATES,

Probably could remove FSL_ASRC_RATES define since it's not used.

Thanks
