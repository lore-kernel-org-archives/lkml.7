Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C088D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iO8XCTbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfCYH4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:56:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40825 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbfCYH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:56:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so4591172wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=943/7EoKTX9sXFDlxc5BfKmi1xG6lYHKX+P4ihoJG5o=;
        b=iO8XCTbuWx7RXR3iSwAiT0NnOEBH0pYoFGfmQX+0kwMnCJnm13ce6n1EzBe9hg3dGK
         dt3QV49gGJilCjuwdXQSPw0oVoQJd7MF/kyQhHCpkWMyBv9tx1GPJaLDIj4xviNcKYXM
         QPhArbBPZ5g/jnMXLk00+SHdpUkslFVsaR1pUXs7JT7WQ6mWUTyLaAhrO/200lyMsrrl
         7h1TNbkhArZPcvxrGdhKSGKjOXQKlr6yOlY32VSlP+2AugkK06XwORnQPDQ7w3QJipQF
         w6eL6GgmQJsheaXKVKpUFlWVYc8FAKQ5cELzkEu8BlknVQFSA/g/TbIPTKzevKotgCQo
         B+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=943/7EoKTX9sXFDlxc5BfKmi1xG6lYHKX+P4ihoJG5o=;
        b=qiS6Ex1VFq/jw1rt+Efbxb0+5kd3xFGsXitNEqjk2Ntd1Ew7I3zwjAuQbd3FKggdvN
         zPMaJD+zN9UTdrLIZMbZZ3Ns2456wL6hCB/PuqvI9J0X6yQwvEdgHlcmasf/Hvl2IerT
         RJ4gzqyccB4OgiMUzof4mcdZWJIAin5mxKo0qNcSFzaZiIFULUuN3wc3ryiPallCr1Cn
         Tbgid0qK5nGeDTsrrs783xlqRI0teTLaLFwwyYHVg62v+w75FfSXW7kmAFL9VK08GYsh
         Vrz1CNdmuAvjdRq5UVGSjrGWv3Por4CZzbXfNPr/V9DMdR45YHmvFUh+knxD29dU6xbE
         7a/g==
X-Gm-Message-State: APjAAAXgI5nIVmbGSOGzojJXLibr+UuEyLaaoMgWlmLWCEFcPV1Edt91
        UH389l2C8+g12zw9lJS2mRTMlF+vqNw=
X-Google-Smtp-Source: APXvYqzuoJorHIxCTlxc9ewsCpAeuRMT+9Z1EYvjpPd0Pb0WuhLqbogx0LV0Y+4MSKqK2rUKC6UEzQ==
X-Received: by 2002:a1c:1c5:: with SMTP id 188mr4278401wmb.52.1553500571524;
        Mon, 25 Mar 2019 00:56:11 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id d9sm12519549wmb.8.2019.03.25.00.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 00:56:10 -0700 (PDT)
Date:   Mon, 25 Mar 2019 07:56:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: fix a potential NULL pointer dereference
Message-ID: <20190325075608.GY4731@dell>
References: <20190309080456.8579-1-kjlu@umn.edu>
 <C71F9E7E-5EF8-4AE5-92D4-4596D25B1D9B@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C71F9E7E-5EF8-4AE5-92D4-4596D25B1D9B@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019, Kangjie Lu wrote:

> Hi Lee Jones,
> 
> Can you review this patch?

Don't poke.

I have a very long list of reviews on my TODO.  Poking only surfaces
your patch to the top of my Inbox, and since I review patches in
reverse chronological order, it puts the review to the back of the
queue.

> > On Mar 9, 2019, at 2:04 AM, Kangjie Lu <kjlu@umn.edu> wrote:
> > 
> > In case devm_kzalloc fails, the fix does NULL check and returns
> > -ENOMEM upon failure so as to avoid NULL pointer dereference.
> > 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> > drivers/mfd/sm501.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> > index a530972c5a7e..e0173bf4b0dc 100644
> > --- a/drivers/mfd/sm501.c
> > +++ b/drivers/mfd/sm501.c
> > @@ -1145,6 +1145,9 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
> > 	lookup = devm_kzalloc(&pdev->dev,
> > 			      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
> > 			      GFP_KERNEL);
> > +	if (!lookup)
> > +		return -ENOMEM;
> > +
> > 	lookup->dev_id = "i2c-gpio";
> > 	if (iic->pin_sda < 32)
> > 		lookup->table[0].chip_label = "SM501-LOW";
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
