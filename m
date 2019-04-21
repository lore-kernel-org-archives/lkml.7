Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52560C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D90620869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 06:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAaOxD+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDUFyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 01:54:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfDUFyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 01:54:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so4272655pgj.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LxIFaDAjG3Mf4CKCOKCnEJN+OeV4ScqkIERFngckI4A=;
        b=LAaOxD+ZJIu2q9HJbL0xcuvhgWihpdORRIC21ARI/HGLnJetPMuLI6ZxTpxnHrS/VR
         c0Iki61GRuw3bpWHygxkXOyqF1bWI7cfXSfAtAGAw/w/iinqw9MCzKAhAJ+LIv9STLAG
         KRNccylvtUNwDoVMN8aKn1sQF/DH0UW2u/JHVQgIqrenfR21YaZLgU8fCnSvtiSfahL+
         TbEstC5k5OUrbT3aUcTwbAYUsr11xseqDGOXZOqO4dsbWQ1bBCHatPZmc5xoAaWsMI/n
         3zHT/rIWtqd1kYedbtCmpYHzlXxvpLxP7qxjQG9pdtHQrxaYKBV4tvBlF3XMDNeTt+9G
         +4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LxIFaDAjG3Mf4CKCOKCnEJN+OeV4ScqkIERFngckI4A=;
        b=X2WdDIInZKYnpCCdbLanhKyzRwPnQxptXc9Rj5jyNpYs3nlRsAQqXCIqrlezlm0T1t
         ruzAUCOeUk0PVxfAjRWdDBl73C/7PwhvBLiN5C4MzgXm/lANO8L/O447aDwzf6qD3ZWT
         pfgdWoLUqpzwed/bTfiF1PzZUrgBrkKTrzKI7fF/w7S9ZDjE2KZaIGrkyCGo5G0Ot7rS
         eICFXCJAHVcZDMDTpU/CqzY1yIkUdSQ2YOqCIfnCsbQSM4hRcmL03WgVis2edZJwMTfj
         xPnr44uPWHTKLyLJmZpUbzDnasnBIInCHJF4YI7dSWXt61oKeLYaHxM58/yRvs8d1m59
         T5RQ==
X-Gm-Message-State: APjAAAXky377cy5BN3iXnC3gP9dilonATzm9ngunHr/EpFdTpQ22dlrP
        c2dLvHMHsa3tFO3Hy8cm+DQ=
X-Google-Smtp-Source: APXvYqzvbB4cv40Daen5ODJbcKQMVnlU8GPhyobIcmISAHn5oXEuPiQyIM89BWQ1yX5ByHEY7Cna7w==
X-Received: by 2002:a62:1647:: with SMTP id 68mr13561107pfw.113.1555826050829;
        Sat, 20 Apr 2019 22:54:10 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v15sm12187074pff.105.2019.04.20.22.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 22:54:10 -0700 (PDT)
Date:   Sat, 20 Apr 2019 22:54:07 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Message-ID: <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420155846.10027-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 03:59:05PM +0000, Daniel Baluta wrote:
> Turn off/on clocks when device enters suspend/resume. This
> helps saving power.

> @@ -934,6 +933,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  static int fsl_sai_runtime_resume(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(sai->bus_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable bus clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> +		if (ret)
> +			goto disable_bus_clk;
> +	}
> +
> +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> +		if (ret)
> +			goto disable_tx_clk;
> +	}

The driver only enables mclk_clks for I2S master mode. But this
change enables them for I2S slave mode also. It doesn't sound a
right thing to me since we are supposed to save power?
