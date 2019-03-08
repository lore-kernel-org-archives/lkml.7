Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65271C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC4F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cru93ztw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCHU6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:58:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37574 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCHU6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:58:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so15061326pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 12:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SQfJPUdfepXhbeNiGtUR3W2GGFP/9RdPwPI2MEEDGFA=;
        b=cru93ztwEgkxVLzHjrKP8V+BhOu2Gy1joL49CJw/B9fck6vZLDNIVa9mEeEN23WJN1
         Q0VIyCJmGe5dX1kw9RimenLL3+bZ81fiWpQ31lvxx0kj1m6wtOOdYLWxpQi/lUJmSQnZ
         0SdqaWAscz4SuOjWrS0eLbd3kg8QdubaV7lpsg8+PGkNFC21gExYg6zuUhjkDeRKndYQ
         xdMqPSxvMn36GKRtuJTjlPRWsBrxxChM4DSTtliy096Ey5sWEBNMyKjj5B+9iXpONkp1
         gPH5Uuwx1PaNexyMtRQkjKoUWcflJkCMXyQU6+IAounerIHQrFw9tnpYRnlXW0d0jDel
         09+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SQfJPUdfepXhbeNiGtUR3W2GGFP/9RdPwPI2MEEDGFA=;
        b=hwrX/yzvVpdMItvtDXy9sL+zoN/JCLqcKzBtX7ZJgVr++I9HA3J7YQ3v3bgptYDt4J
         hqNPR7VH4Z6TbXkJcBp/Kmy2wKZO6ft2s/a31Z6Ma+RycKTO+kAlqp0prcZZXt+YlGWb
         viH3wxaHo+aRB3Yx+UMXqT7jxh1bsfitHsQsoz5WsTwngXb5ycruNjTO9+aYHIawFAmp
         r2cS7Dy4qpWcB9/enSo+/k3C6EE3X8nz15V/XWJ4gpVP61PtuSOMr0QoKJBhfCMkQvFu
         AbcRn1565BPd3NarjncNd/zTXfewYvZKK+g70UHMZImc/k6tVPBLv7va41CZA6EcA0WE
         dflQ==
X-Gm-Message-State: APjAAAVrzH28A8VS6M7o9LfurwZjbqQFX7/aAi2eo0UEoBEMp82kopiZ
        pNaabSTcwzgyo5QJm4LIRP0=
X-Google-Smtp-Source: APXvYqz8mKT/gHGN0V8knuC2EYJqzZnbA8bsDGX3SDb+sDKu0uQKb5DrP0bTWUa9Yg3UmFvRvHDSUw==
X-Received: by 2002:a63:591f:: with SMTP id n31mr18314064pgb.304.1552078691055;
        Fri, 08 Mar 2019 12:58:11 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a7sm11797010pff.54.2019.03.08.12.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 12:58:10 -0800 (PST)
Date:   Fri, 8 Mar 2019 12:58:06 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl: sai: Fix underrrun for playback stream
 start
Message-ID: <20190308205805.GA8912@Asurada-Nvidia.nvidia.com>
References: <20190308173904.27298-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308173904.27298-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 05:39:30PM +0000, Daniel Baluta wrote:

> @@ -542,6 +544,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		for (i = 0; tx && i < channels; i++)
> +			regmap_write(sai->regmap, FSL_SAI_TDR, 0x0);

Though it could reduce underrrun for sure, I don't feel it's a
thorough fix, especially when dealing with a duplex case where
RX is the first stream while the driver enables both TE and RE
at the same time. So the transmitter might have started before
TX DMA request gets enabled.

We actually have something similar in the ESAI driver as that
one is well documented. But SAI is apparently more tricky at
the trigger() function. And the paragraph you pasted from the
RM doesn't explicitly sound like we should do this.

Btw, Instead of writing dummy data, have you tried polling the
WFP pointer of the TFR0 register to make sure data is copied
by the DMA?

> +		if (tx)
> +			udelay(10);

Any justification for the delay? Missing a line of comments? I
guess it's to address the 3-bit clocks timing. However, putting
it before enabling DMA request doesn't make much sense to me.

> +
>  		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
>  				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
>  
> -- 
> 2.17.1
> 
