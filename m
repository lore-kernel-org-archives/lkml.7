Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030FF214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtUVNGWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfDVSPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:15:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39691 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfDVSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:15:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so6078450pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rCa/9yPbubYEgQtxdxweEsDxXAxrOMXLbp7pFOiMKJQ=;
        b=XtUVNGWBjgKORtdbQmjprX3pnJLCAy6L+jDj4Q6qttCPmE+YEgCWN9jVtM1OW/r3yD
         1oDNw39CZ/BqWeq9V29jHHJURCk9kAc1LYLZulgJwaJefyyGQbHfmCl5ZVUmg8/6VLFU
         B7YcbsaexSui+nD+5mQupDJEKB6w3htTcyjCgBZrpILiv4HWNjfo106VZVHUfZTbi06F
         x6huHRpMijaPkZeIsu5nfAsKJS9Yi2ajJlMc6f0NfW3R8XKTesLp2JkSRCkLR9BWMLPH
         hUoGjcl1Cc15XfXCd9Rju0d9cwbgMGFf1QU9bp+z8jsel9eAr1r4937Ii4baV8t5XreV
         5OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rCa/9yPbubYEgQtxdxweEsDxXAxrOMXLbp7pFOiMKJQ=;
        b=JSUIL6Q+67AfO28XaXw1pMTVa/bpWJbS7Bdqdp1AAXLWH5f850Rpc81N04FOSaDdqr
         r6ujwufQKtfUkEpnZMC903c6VIO/b9/M1/D0ZcOsvBcfgz7Uuie17lo//XQal/XRfWtj
         d+Ydl62oA2Dr7wofcaqipVE2Ho8cRn9JvI3Vjt+hONDia+Jrs9EnXty55V0a0H7S2uU9
         fRn49oLyVjpY3dke3was4GKS/6booZ0QGB7kxXlNLb+6wjKu+ZKefhcbswvhxoiGot8w
         eF/UkS9e4J1O2m3uN+f9wVgY2iC5dSfNCkat1aDQ1wgqQ5dRBbaSQCLIiewog0bK+Rk+
         hOOw==
X-Gm-Message-State: APjAAAUtbr2PFBimoKQyxdRhH6+XcZGILecLEYJcYmmjwJbk/vwGPjff
        iGa1R4yIOti51XZG4KX75bk=
X-Google-Smtp-Source: APXvYqy4i1a9gd2vMvwuBw/wREp8ceq+ck+H5HAXZwW37YzcNaQFJ5Fawooa4zZHDJ/6zPF+oWWWJg==
X-Received: by 2002:a65:6105:: with SMTP id z5mr20426581pgu.378.1555956945915;
        Mon, 22 Apr 2019 11:15:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u5sm19690143pfm.121.2019.04.22.11.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 11:15:45 -0700 (PDT)
Date:   Mon, 22 Apr 2019 11:15:40 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Message-ID: <20190422181539.GA30867@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-3-daniel.baluta@nxp.com>
 <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
 <1555930942.31656.4.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555930942.31656.4.camel@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:02:22AM +0000, Viorel Suman wrote:
> Hi Nicolin,
> 
> On Sb, 2019-04-20 at 22:54 -0700, Nicolin Chen wrote:
> > On Sat, Apr 20, 2019 at 03:59:05PM +0000, Daniel Baluta wrote:
> > > 
> > > Turn off/on clocks when device enters suspend/resume. This
> > > helps saving power.
> > > 
> > > @@ -934,6 +933,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
> > >  static int fsl_sai_runtime_resume(struct device *dev)
> > >  {
> > >  	struct fsl_sai *sai = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret = clk_prepare_enable(sai->bus_clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable bus clock: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> > > +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> > > +		if (ret)
> > > +			goto disable_bus_clk;
> > > +	}
> > > +
> > > +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> > > +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> > > +		if (ret)
> > > +			goto disable_tx_clk;
> > > +	}
> > The driver only enables mclk_clks for I2S master mode. But this
> > change enables them for I2S slave mode also. It doesn't sound a
> > right thing to me since we are supposed to save power?
> 
> This change does not enable them for I2S slave mode, please check "fsl_sai_hw_params"
> and "fsl_sai_hw_free" functions: the field "sai->mclk_streams" is modified only for
> the case when "if (!sai->is_slave_mode)";

Thanks for the input. This should be fine then.

Nicolin
