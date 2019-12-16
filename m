Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD9C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037212146E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ku4jjLQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfLPUOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:14:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40222 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfLPUOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:14:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so5202514lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SBA8qsH74joROaQ7qUDtcV487nsBL4T4WgclmBa0Frc=;
        b=ku4jjLQyhZhXcIGu4nZIjg8rbK20un3MtB+TCOZXShMDtjr2HGOaRu9he7uOTF7Cih
         T3brX3yh+ceFv1ntlhNGLP08m0V9P/WctQ31kCqVPwTi11yHvWDB5zIM2L5gdtJU0t6C
         toL5piqJBqXKVfkIh8mA39aWi5VXl3mGdfXtivjFonFdjVGqYWA8jh0Vc6d9QCyAkARu
         JsEfg1+SXICLbj/4yY8AtlA1Ik7ZG/HN0JzGkdvM1S4w9ncr2eYD6CVNrpouMnS8Sv2w
         5TLiAlvSGrxO3NlzrooXpjw9JCEb10909JKvwfctiyJBYaKdJw18ww6wndKPu+6NMY0+
         zznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SBA8qsH74joROaQ7qUDtcV487nsBL4T4WgclmBa0Frc=;
        b=LBg8IDbFuT+PZbzsLKFUKCBL5kQMeXnhroiMvKGWTN/sx6dYHf07iM3JsCpEgUNxAH
         vH3M2x5Q96byWFlg9zyps/4TEqRyfgtT8akP7yY8ANQOfJLMlPjDnaEDUR6b5BiCXwVh
         G/52JvmjST5nHesw3SINVj7ZXoTNAlIS1wj0/p+J2pLIH3dw+sBCGmy5n0yP8GDFd1uo
         qTjm6zdC0L8y7SvMcKS3THPBhywgAGvSdY9u5KY993xfKF+YuhTI4UGtEzxfBpgn9/U0
         QP/vJK7uvz4UC5KzcMA1f8NGkJ+2bvqkBgk1qtJHny6FEqcEMLNOA0seci25kcTYi00G
         JlbQ==
X-Gm-Message-State: APjAAAWWUtjskSVYVIIq2RmYpYj+QQ6/y5iKuAcgWKw1KEH2L5Wfrtrn
        bzdlyp+dOAWVHhki/71L414apg==
X-Google-Smtp-Source: APXvYqxKjc/fsBTpIng96/mIdsynKS0oePdJPNDLm9lKBC2UNlCq0QkEhG6AghBZJ/xPXJHMxWvS4w==
X-Received: by 2002:ac2:5635:: with SMTP id b21mr512845lff.127.1576527257085;
        Mon, 16 Dec 2019 12:14:17 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 192sm9615625lfh.28.2019.12.16.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 12:14:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:14:04 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/4] net: stmmac: Let TX and RX interrupts be
 independently enabled/disabled
Message-ID: <20191216121404.43966b89@cakuba.netronome.com>
In-Reply-To: <BN8PR12MB3266288303A6CA6C3CAA5E6CD3510@BN8PR12MB3266.namprd12.prod.outlook.com>
References: <cover.1576007149.git.Jose.Abreu@synopsys.com>
        <04c000a3e0356e8bfb63e07490d8de8e081a2afe.1576007149.git.Jose.Abreu@synopsys.com>
        <20191214123623.1aeb4966@cakuba.netronome.com>
        <BN8PR12MB3266288303A6CA6C3CAA5E6CD3510@BN8PR12MB3266.namprd12.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 09:18:50 +0000, Jose Abreu wrote:
> > > @@ -3759,24 +3777,18 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
> > >  	struct stmmac_channel *ch =
> > >  		container_of(napi, struct stmmac_channel, tx_napi);
> > >  	struct stmmac_priv *priv = ch->priv_data;
> > > -	struct stmmac_tx_queue *tx_q;
> > >  	u32 chan = ch->index;
> > >  	int work_done;
> > >  
> > >  	priv->xstats.napi_poll++;
> > >  
> > > -	work_done = stmmac_tx_clean(priv, DMA_TX_SIZE, chan);
> > > -	work_done = min(work_done, budget);
> > > -
> > > -	if (work_done < budget)
> > > -		napi_complete_done(napi, work_done);
> > > +	work_done = stmmac_tx_clean(priv, budget, chan);
> > > +	if (work_done < budget && napi_complete_done(napi, work_done)) {  
> > 
> > Not really related to this patch, but this looks a little suspicious. 
> > I think the TX completions should all be processed regardless of the
> > budget. The budget is for RX.  
> 
> Well but this is a TX NAPI ... Shouldn't it be limited to prevent CPU 
> starvation ?

It is a bit confusing, but at least netpoll expects the TX completions
to be processed with zero budget. Check out poll_one_napi().
