Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CCFC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 13:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CF520838
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 13:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2M9092B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfGMNux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 09:50:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39242 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 09:50:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so1531389pfn.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SJUeu1gN7/mspxsTa9EOncf4StCjWZ5cgxwVtZifj3A=;
        b=q2M9092BrLcdUt5eYWDzQ+aCrFKTpwzF0n0qmbHJ3eXbDuRK9+aoKd1YPZWKzOzhQR
         U5nsaMEOWJi470JXtoCvLB1l7lfDugZdeMbEg9qbL+AKGPLdxjqYKKvpUi/AqIO8aSn5
         VbByuVEycdkVv/oazW5sIvaydMKxKaoJKZ/m9dqAp+aiynsf3kglFptTAHo7v6+hcMXm
         6ojRuygk8qRbgngucJjsaIDuREbfMNtKVyKfMagXQTmzN1AQjN69ATFpOxCIHQo+CGuq
         iTD/2kS4Ehp5UdnpWsXNfOJF3Tkas1QBCjRUSlotHPJZByP9lLLjsEZBve3IZm4mwRc+
         f+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SJUeu1gN7/mspxsTa9EOncf4StCjWZ5cgxwVtZifj3A=;
        b=BJL+ESkzL0WW3SgWANPVkBrp64R3bKJZhzv3APkMyEE/YgGkd76KmOZz2C6C9Whi5n
         gmyRTbPDNlp1FLizErPbMRmJt4XPpu9jH7dhOtRGqFYPW3sFeidEOMbd+uqe37dEKPnW
         e7G2P+Zu6zZb7eLciM8q2j9d4Pspn6kuRJRQOKnks8E/ox5bfuIVnBK4TizesE/nGIdo
         fC1jPM9W4q/AYRv97N1iFFQvu2vmUG+Xg7IaSB2l03/V5l+MkUtM8D9lx3A+yuoKpjg9
         9FyWuEXfKH5M3Gl8dVDbODngr6jrrX1Kjsrr/yIyOt7H8XWCjHaHveqjSwCylnGmDcGV
         hVmw==
X-Gm-Message-State: APjAAAXsKiYXmlC8peS4uBBrJZvd0hHPzkkMu9XkNa6Y2brq+vAIKELd
        s/GWBHMll9IOqDVqFklEqrg=
X-Google-Smtp-Source: APXvYqyIM6CVUjQDdabYvb7cg+9KblNmVYXrAnlO9WvKLuI6RbbFepWnviqkQKUYNBMzmGYkjb5Yhg==
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr18892921pjg.116.1563025852464;
        Sat, 13 Jul 2019 06:50:52 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id l124sm12080395pgl.54.2019.07.13.06.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 06:50:51 -0700 (PDT)
Date:   Sat, 13 Jul 2019 19:20:46 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Joe Perches <joe@perches.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Gen Zhang <blackgod016574@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: codecs: wcd9335: fix "conversion to bool not
 needed here"
Message-ID: <20190713135045.GA15087@hari-Inspiron-1545>
References: <20190711174906.GA10867@hari-Inspiron-1545>
 <eeeb09518c8967ffd48606c3d1222553752e895d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeeb09518c8967ffd48606c3d1222553752e895d.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 03:00:00PM -0700, Joe Perches wrote:
> On Thu, 2019-07-11 at 23:19 +0530, Hariprasad Kelam wrote:
> > Fix below issue reported by coccicheck
> > sound/soc/codecs/wcd9335.c:3991:25-30: WARNING: conversion to bool not
> > needed here
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  sound/soc/codecs/wcd9335.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> > index 1bbbe42..85a8d10 100644
> > --- a/sound/soc/codecs/wcd9335.c
> > +++ b/sound/soc/codecs/wcd9335.c
> > @@ -3988,12 +3988,7 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
> >  		regmap_read(wcd->if_regmap,
> >  				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
> >  		if (val) {
> > -			if (!tx)
> > -				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
> > -					(port_id / 8);
> > -			else
> > -				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
> > -					(port_id / 8);
> > +			reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 + (port_id / 8);
> >  			regmap_read(
> >  				wcd->if_regmap, reg, &int_val);
> >  			/*
> 
> This change makes no sense and doesn't match the commit message.
> 
>Please ignore this patch. Both the statments in if/else look similar to
>me but they are not.
