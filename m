Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C0522CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdxMexFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfE2N60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:58:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40680 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2N6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:58:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id 15so1689191wmg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qk0HGBnrffxH0SszLcEFWuIbH/VkDg7vULoFZ+xx0Kc=;
        b=QdxMexFkAlzFN+PfB1ElJBUUAAqH94q9YgBqRg3iwX2qMor9To0i2ro6IzOHJ5q0bR
         lVQCV4jJJbW2ayh/SGGzAb8zFE8i8fS0Ta/sBgsfayq+7MS8EWeflIjpIGPpCd88J3Lr
         gi74EMKfustUw7SYsrSrlzOB3uXKKlobtbDHfkHpwkuEF7P5NLmj/C18ll4IfqvQrSeU
         5L5O0kvAkgy3IyumQGsb/iCDlL3QgdKoNsuQUgvxSDq/1l+O1LglTe2H/nXRudsjk0JU
         uzBIVVqMRZPR6DxOkGvrJFejCrvJgRMgvPdgQrzGLZLh4gVXQVCxUaklGk1sqZSzHbV1
         gluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qk0HGBnrffxH0SszLcEFWuIbH/VkDg7vULoFZ+xx0Kc=;
        b=tN2z9QfS+x3+t8Azc9+JC27YdhHflVowfasvIRaZ9DKPQ/ZST6TeBKWUTe9TLcANMS
         cU8fzVYmaSy1g9yS3y3+PuuC8jO05Z5Hv86Dcp8ikuMM/3I6h6dha0TPS4o+eID9wiPC
         HZeaS7rEXzbZNwMUml0HcNOXrWeYumJvA/sThvTLiCh0SkDnHMAuZ0A9SQjIXZQkVM1I
         Y/+usHwxZ76vFeRGo51ivX2TXb5vgDdbHygg5/8u++Xcod/Erlafj5TDamzTut37wMj6
         PZIvez59qCkXSEM4mwT3q3adeizgyRUZXtra157lmH7FhaEcxtz8X+9BVEsKRZUAk1My
         EHcw==
X-Gm-Message-State: APjAAAWGjvqt9yXgMSkqJ8L4NrKZ9r0G+xswh6FS/d3KpwbFTBTydG+9
        Nz5AhQULvEKupFmfnhwV0XmK5Q==
X-Google-Smtp-Source: APXvYqze12mMzt5a2klvAWdo6ZVb9KQXiqj6wF4yVUfnsNbjdM8VvzW17UUMXRJjnqARdqK9wvKZcw==
X-Received: by 2002:a7b:ce9a:: with SMTP id q26mr2105006wmj.11.1559138303516;
        Wed, 29 May 2019 06:58:23 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id d11sm17124712wrv.72.2019.05.29.06.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 06:58:22 -0700 (PDT)
Date:   Wed, 29 May 2019 14:58:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4 6/6] leds: lm36274: Introduce the TI LM36274
 LED driver
Message-ID: <20190529135821.GK4574@dell>
References: <20190522192733.13422-1-dmurphy@ti.com>
 <20190522192733.13422-7-dmurphy@ti.com>
 <20190523125012.GB20354@amd>
 <0c2bd6af-92c5-2458-dc41-1ea413545347@ti.com>
 <89a80aa8-66ee-d0ec-fa54-c55ca8de06af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89a80aa8-66ee-d0ec-fa54-c55ca8de06af@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019, Jacek Anaszewski wrote:

> Hi,
> 
> On 5/23/19 9:09 PM, Dan Murphy wrote:
> > Pavel
> > 
> > Thanks for the review
> > 
> > On 5/23/19 7:50 AM, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > +++ b/drivers/leds/leds-lm36274.c
> > > 
> > > > +static int lm36274_parse_dt(struct lm36274 *lm36274_data)
> > > > +{
> > > > +	struct fwnode_handle *child = NULL;
> > > > +	char label[LED_MAX_NAME_SIZE];
> > > > +	struct device *dev = &lm36274_data->pdev->dev;
> > > > +	const char *name;
> > > > +	int child_cnt;
> > > > +	int ret = -EINVAL;
> > > > +
> > > > +	/* There should only be 1 node */
> > > > +	child_cnt = device_get_child_node_count(dev);
> > > > +	if (child_cnt != 1)
> > > > +		return ret;
> > > 
> > > I'd do explicit "return -EINVAL" here.
> > > 
> > 
> > ACK
> > 
> > > > +static int lm36274_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct ti_lmu *lmu = dev_get_drvdata(pdev->dev.parent);
> > > > +	struct lm36274 *lm36274_data;
> > > > +	int ret;
> > > > +
> > > > +	lm36274_data = devm_kzalloc(&pdev->dev, sizeof(*lm36274_data),
> > > > +				    GFP_KERNEL);
> > > > +	if (!lm36274_data) {
> > > > +		ret = -ENOMEM;
> > > > +		return ret;
> > > > +	}
> > > 
> > > And certainly do "return -ENOMEM" explicitly here.
> > > 
> > 
> > ACK
> > 
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> I've done all amendments requested by Pavel and updated branch
> ib-leds-mfd-regulator on linux-leds.git, but in the same time

What do you mean by updated?  You cannot update an 'ib' (immutable
branch).  Immutable means that it cannot change, by definition.

> dropped the merge from the for-next.
> 
> We will proceed further once we clarify the issue of cross-merging
> recently raised again by Linus.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
