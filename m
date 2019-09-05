Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46453C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1906220820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfkV95Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfIEJ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:28:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44738 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731084AbfIEJ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:28:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id 30so1834595wrk.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZSFUJO3Cl5xfTH0Oz2n3wB3n0rI8IaAXjOBMneGW988=;
        b=pfkV95Bv0UZfPijf04Lw+S5gWyPrZBf6nMW16xOvbNgBkOqbuTXKqhjFYAv9E+FprC
         642QNfMlNoxFq2F0pUWRVLDLWtQL7aLFtrD6IJKWfeyGn3AkKPJwPOFVJ8qunlmtFhMp
         GKKYEIOvFTsJKHXCODaxCEyFcLgMBLlDjFYCqomKC9NKxAyn9Q72U1ovQrgfqEmTUG8o
         cYVriYNXSKLlGpnAn4pKQiheoN5zetXQ5lk4piehoTmcslfppIi5ZIQJdodEIIMRMZTE
         uvjWfyt0nD1xjB3h3EBMWIFAJvJyWlLFfsoGRS4tTUQzwhypCN4lrWEl8Ms7o4ipyBNB
         Yn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZSFUJO3Cl5xfTH0Oz2n3wB3n0rI8IaAXjOBMneGW988=;
        b=J8bK799fChH2nWZuc0AqpZY0eFzZL7zEVpmgrAKh5j5Hs18JPtjCg/cEoFZsIwNPiC
         6dRsGlGUMfmoCKzmv+2mjluUn1lXzYaW3Pws/c4IFRp4AsOnYEYOns6nR6+J3f4S1747
         nDGcaLuIc0RtyM74MbMowU9VQuIleuT3zKInxX6jNDaWBt8G2IlTkFZ8qoxgONhI+hLd
         0lJPAhGRYlKcMPnTkYXp7zR1rYj72gjLw9FUxdMF6kL/aIFCEgDr4xtG5wZPlZXTbdGI
         mZYEUNSrYIYl2ZOTyXdaoV0HC9tp2aTKuoEvTTo33NFFT2oOexk8JNgUDNgvaLD4qTLP
         kEjw==
X-Gm-Message-State: APjAAAX5fmSIZ13xdOrwi17GL8JCqM9ZBMQ+xa5lWZTv6BhgHvbIE0oS
        dS6PVtM9tRTV0pzDC7z9CxDa6w==
X-Google-Smtp-Source: APXvYqzXqv86R+TXN5EBeFSzsw4TbvqcdMpFUJoJuOdwhoetcsejRn2RxvT5UuPS+bGgwEyO0gPGzw==
X-Received: by 2002:adf:e7cc:: with SMTP id e12mr1706018wrn.299.1567675698218;
        Thu, 05 Sep 2019 02:28:18 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id t7sm1796620wrr.37.2019.09.05.02.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 02:28:17 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:28:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: qcom-geni: Provide an option to disable DMA
 processing
Message-ID: <20190905092816.GD26880@dell>
References: <20190905075213.13260-1-lee.jones@linaro.org>
 <20190905075213.13260-2-lee.jones@linaro.org>
 <20190905091800.GD1157@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190905091800.GD1157@kunai>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Sep 2019, Wolfram Sang wrote:

> 
> > Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")
> 
> Are you sure? From visual inspection, I don't see a correlation between
> this commit and the fix here.

This patch should have been part of the commit, or at the very least,
part of the set, alluded to above.  Unfortunately, I was carrying
Bjorn's hack which simply returned early from geni_se_rx_dma_prep()
with an error, so it masked the issue.

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/i2c/busses/i2c-qcom-geni.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > index a89bfce5388e..8822dea82980 100644
> > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > @@ -353,13 +353,16 @@ static void geni_i2c_tx_fsm_rst(struct geni_i2c_dev *gi2c)
> >  static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
> >  				u32 m_param)
> >  {
> > +	struct device_node *np = gi2c->se.dev->of_node;
> >  	dma_addr_t rx_dma;
> >  	unsigned long time_left;
> > -	void *dma_buf;
> > +	void *dma_buf = NULL;
> >  	struct geni_se *se = &gi2c->se;
> >  	size_t len = msg->len;
> >  
> > -	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> > +	if (!of_property_read_bool(np, "qcom,geni-se-no-dma"))
> > +		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> > +
> >  	if (dma_buf)
> >  		geni_se_select_mode(se, GENI_SE_DMA);
> >  	else
> > @@ -392,13 +395,16 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
> >  static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
> >  				u32 m_param)
> >  {
> > +	struct device_node *np = gi2c->se.dev->of_node;
> >  	dma_addr_t tx_dma;
> >  	unsigned long time_left;
> > -	void *dma_buf;
> > +	void *dma_buf = NULL;
> >  	struct geni_se *se = &gi2c->se;
> >  	size_t len = msg->len;
> >  
> > -	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> > +	if (!of_property_read_bool(np, "qcom,geni-se-no-dma"))
> > +		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> > +
> >  	if (dma_buf)
> >  		geni_se_select_mode(se, GENI_SE_DMA);
> >  	else



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
