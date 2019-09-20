Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146682080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxpsH7YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406732AbfITWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:51:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37177 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406570AbfITWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:51:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id b10so3860265plr.4;
        Fri, 20 Sep 2019 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0P3XLXQhDOk6yT8L9UZqipY6hQ6gvzDoPp4owKec9vk=;
        b=XxpsH7YCa/PUyweMsFxZ83TPOyD0WUZjPit3c8pITmQgtwko6irwDaxc9pADFQztvC
         4U90FTq1tsr90gbU3BH0dXMjgwrxN9irMCPTc5p97PU3oec9/cqWzdg6C2yhY/HsfNln
         aScdV6JxcUYSWR5y5Hv9upvbjhCmXfYVsD9tu4NY5ITzk7+s1hqedARflggKmV1Dur7v
         fiOu8/6RUGHJEhmjdorBPStTRSD4Ln8RO9iV39xPXYgVi3HpcU5c3nwZPcYP/tfnsq7x
         oh49U2WdVkdA819mAvnTSbQQg3Gu+tax53st1QAbHmpdvq4sxTse2UtHV/IylCvTkm9n
         Q3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0P3XLXQhDOk6yT8L9UZqipY6hQ6gvzDoPp4owKec9vk=;
        b=mNivWr3hPxn9ZEYMye0BafcMw2KmUWGF1X96XFjbhNe0BuTh5TXOpwtq2VYivcGSb8
         LbneMsikX5qjRU5QdJMl+boupADVgKqG6zezefGs9VDUDSQh74obVVoQU3YX/tf26qOu
         DxNhnBN7XcSt2RC4a2/PqjqOJKYgYywSDbDfJCcDWdE3yBPXDcRi9ZZBwJe5Jcc3xHZf
         ccFogUhmUYTkKQwWkdJCQtPuL8J/cGfnQqMbSZ0W57TO7Rb8VYxpc5I8B4AUX9v0b7wJ
         xsFhJ/UqimlNal1dUMH4s8GjpjmXRERYtXKNotVoA1cJW46DeHoUq3HT19fl1GkvivyP
         Dcrw==
X-Gm-Message-State: APjAAAW4yH/iOttwx3D/bzpxTvuCPmuIMghK/4fyBxc6lYj5beCbO2ZX
        zvW3bgzBvrNK2Qn4Jv9cTHc=
X-Google-Smtp-Source: APXvYqxuXYaN7Iqu31wZ7eEfynHGlkievoHDsqLPDXtQ855SljuXpLCmyBe3bDgUiLJ0h23ehjlQAQ==
X-Received: by 2002:a17:902:fe91:: with SMTP id x17mr19665279plm.106.1569019907795;
        Fri, 20 Sep 2019 15:51:47 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g24sm2039646pfi.81.2019.09.20.15.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 15:51:47 -0700 (PDT)
Date:   Fri, 20 Sep 2019 15:50:58 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH V3 3/4] ASoC: pcm_dmaengine: Extract
 snd_dmaengine_pcm_refine_runtime_hwparams
Message-ID: <20190920225055.GB21389@Asurada-Nvidia.nvidia.com>
References: <cover.1568861098.git.shengjiu.wang@nxp.com>
 <57e3bda7b94fecf94d17f2eacf1c6beebcac74ff.1568861098.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e3bda7b94fecf94d17f2eacf1c6beebcac74ff.1568861098.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 08:11:41PM +0800, Shengjiu Wang wrote:
> When set the runtime hardware parameters, we may need to query
> the capability of DMA to complete the parameters.
> 
> This patch is to Extract this operation from
> dmaengine_pcm_set_runtime_hwparams function to a separate function
> snd_dmaengine_pcm_refine_runtime_hwparams, that other components
> which need this feature can call this function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

> @@ -145,58 +140,15 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea

> +	ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
> +							dma_data,
> +							&hw,
> +							chan);
> +	if (ret)
> +		return ret;
>  
>  	return snd_soc_set_runtime_hwparams(substream, &hw);
> +
> }

Just a nit, why add a line here? :)

The rest looks good to me, not sure whether the name "refine"
would be the best one though, would like to wait for opinions
from others.

Thanks
