Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31762C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0405225607
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYfDxhjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfE3Hib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:38:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfE3Hia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:38:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so3414278wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7nvQSt9u8hnEYp0RlBDRlIGBODePoq9QbKJNU2Z6R6I=;
        b=tYfDxhjHwopW10j/LxPwT+r0xzailTUFARfEDHBcC2xcwtT5AONzXsv/P+4QFLJDxQ
         extfmqu0pOByaM1XGJssrrcyVS0NsezxhOF+qaSlvoEtV/8rXBMoVlWtpYDGpRMVcrfQ
         6ljwDf4tDjC5ALOcHnrNFMK4O5yRdq3OfkxOSG/Hvl4A5W4QgXo9Teo8v1L6h81ThGZQ
         x34p3Ls/t5EQbukEgfFyaaS85GIqnPDEh7qyS4kcgBsl1d8yOi5Rd1osThsexsDcaMNT
         SumZ64jZ0dXTlozznClUyrp/hPGXPo2CvP1xyCCBIEpNnRnaUxJ0RvqhtcBv60pPBDu4
         e2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7nvQSt9u8hnEYp0RlBDRlIGBODePoq9QbKJNU2Z6R6I=;
        b=Mf3Wa0BYX8A29YjzBVZxZJAL+yy23DOjawI/7WA1ghX35+d4bSW8tELG8DR/Xa9CRJ
         3tVogXqgelnwtgs+KNTJsFR3G6GzH6jNHDkjbAp+zXcFy442hH0R8HTFg56bibY4kjCB
         yeIq93iPnmTkn7MDsRO53iEz/LbROt1idPIzBsHxDeFRNTI0mZIKigmJkiuIDUtZbvKF
         Asbp4dUYqFqo2uzpINi45r2+cnDsOap/sG+5zUOWqAV+vAUBiAqWRpuujxo+gtaqP1KW
         1eRkzRsrufPn4lJEp6bvKMmmPfo7HHYuohTut4o5p4Ex67Q8urt4k5oPQ+VEYO5Vsl/y
         OLBA==
X-Gm-Message-State: APjAAAWnIGlyEVIMz25Ook2sbxxO6fAayuadDDc0Mos0HQrwzVbj5+OJ
        oZF4Jbl42WSjRULrADIyTUvW1a+9MCA=
X-Google-Smtp-Source: APXvYqxhYpfaz8l4WfpxnWUASoy2MMApP6r2fgfNYHBXRruCpq9yut686jx+JIorQaP5E7LHF2WUrw==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr1589045wrw.214.1559201909288;
        Thu, 30 May 2019 00:38:29 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 32sm4553425wra.35.2019.05.30.00.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 00:38:28 -0700 (PDT)
Date:   Thu, 30 May 2019 08:38:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4 6/6] leds: lm36274: Introduce the TI LM36274
 LED driver
Message-ID: <20190530073827.GL4574@dell>
References: <20190522192733.13422-1-dmurphy@ti.com>
 <20190522192733.13422-7-dmurphy@ti.com>
 <20190523125012.GB20354@amd>
 <0c2bd6af-92c5-2458-dc41-1ea413545347@ti.com>
 <89a80aa8-66ee-d0ec-fa54-c55ca8de06af@gmail.com>
 <20190529135821.GK4574@dell>
 <afff7c24-bb68-e9dc-295e-4449f9729cc9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afff7c24-bb68-e9dc-295e-4449f9729cc9@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, Jacek Anaszewski wrote:

> On 5/29/19 3:58 PM, Lee Jones wrote:
> > On Fri, 24 May 2019, Jacek Anaszewski wrote:
> > 
> > > Hi,
> > > 
> > > On 5/23/19 9:09 PM, Dan Murphy wrote:
> > > > Pavel
> > > > 
> > > > Thanks for the review
> > > > 
> > > > On 5/23/19 7:50 AM, Pavel Machek wrote:
> > > > > Hi!
> > > > > 
> > > > > > +++ b/drivers/leds/leds-lm36274.c
> > > > > 
> > > > > > +static int lm36274_parse_dt(struct lm36274 *lm36274_data)
> > > > > > +{
> > > > > > +	struct fwnode_handle *child = NULL;
> > > > > > +	char label[LED_MAX_NAME_SIZE];
> > > > > > +	struct device *dev = &lm36274_data->pdev->dev;
> > > > > > +	const char *name;
> > > > > > +	int child_cnt;
> > > > > > +	int ret = -EINVAL;
> > > > > > +
> > > > > > +	/* There should only be 1 node */
> > > > > > +	child_cnt = device_get_child_node_count(dev);
> > > > > > +	if (child_cnt != 1)
> > > > > > +		return ret;
> > > > > 
> > > > > I'd do explicit "return -EINVAL" here.
> > > > > 
> > > > 
> > > > ACK
> > > > 
> > > > > > +static int lm36274_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct ti_lmu *lmu = dev_get_drvdata(pdev->dev.parent);
> > > > > > +	struct lm36274 *lm36274_data;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	lm36274_data = devm_kzalloc(&pdev->dev, sizeof(*lm36274_data),
> > > > > > +				    GFP_KERNEL);
> > > > > > +	if (!lm36274_data) {
> > > > > > +		ret = -ENOMEM;
> > > > > > +		return ret;
> > > > > > +	}
> > > > > 
> > > > > And certainly do "return -ENOMEM" explicitly here.
> > > > > 
> > > > 
> > > > ACK
> > > > 
> > > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > I've done all amendments requested by Pavel and updated branch
> > > ib-leds-mfd-regulator on linux-leds.git, but in the same time
> > 
> > What do you mean by updated?  You cannot update an 'ib' (immutable
> > branch).  Immutable means that it cannot change, by definition.
> 
> We have already talked about that. Nobody has pulled so the branch
> could have been safely updated.

You have no sure way to know that.  And since I have no way to know,
or faith that you won't update it again, pulling it now/at all would
seem like a foolish thing to do.

Until you can provide me with an assurance that you will not keep
updating/changing the supposedly immutable pull-requests you send out,
I won't be pulling any more in.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
