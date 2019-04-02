Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15FBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C6C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAUZ2sHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfDBHIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:08:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35092 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBHIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:08:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so5888837pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qXdOng57Us4aguv2Yx9/59Kkgyz35IfaRWj2lo9R3fY=;
        b=OAUZ2sHSqOlXZcLPmLB5Iz9GTxV0MCB6PDgyQDA6N/05wjgw69xmenfteKNsFQ26L2
         xFIPv4gZJ1bdXiHO8dGGmRFkE57WwzvzJm+HRF5vYsxy3dGJyRlhNX0gJP5XquCs4/Ea
         ULsUvkNd8skOiwmWXRGjwPYvnvBW7ZrXp5B39Bl8L6pLaUmvsv5RJXOJN00tddejs/lN
         nWoM5nRbtNSEp6GCAGUV6gY90OY34EdfI8A4+ShjTKujjT1qyP0+I46xlv8L+kZ+hSsp
         hGrOsNfIbk8nup78V4ZuJorS3WgSn3XnM+r/ImBBray5nlKeQM7GDmTmTOnkX/063mIX
         pH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qXdOng57Us4aguv2Yx9/59Kkgyz35IfaRWj2lo9R3fY=;
        b=T1CGaBSbfkYcmslUeCpqCMeB11hud29E0ORa2ZbFTq0bKdsAuMNHOMRHLm212DfnXL
         a7ikMsxmg18YFoh0/v401UIlZs/FsIZwAj8iLmFdGIXKtfjwxCd5J72ErRwVUSihNEmZ
         ckOnZnkVX8V+f0a8pw9x5rineadclzx3ApSePgunPsiXBnVBfP9ZRGmY2mQxE506R2Ta
         Oz8D7O+aNwnWMEATs7/y3CO0y8ERkU11SfMwFIaQ9eQflb/zoVUWwfaPrlwddMIe/CKn
         Tmf/G0OfOJD9ha986RUo1szLmfaFgo0UVq1r7Ttv89hqLA6hqPTg9IqB1CyFxzODG4U9
         GEBQ==
X-Gm-Message-State: APjAAAVicRFuEEErYH2cq8OuWXUYPNSY9r0sgv6myXBIMWUUKTuhWjwo
        fTWmGHjDsTBv7E/0wStglq56pg==
X-Google-Smtp-Source: APXvYqwtRYh0OVVPOtc0VmTgvJGHCrqKJLSticiLu3G1yyLuK+xLr7OvlyYhMbh+T6IZWZgSHNiBKQ==
X-Received: by 2002:a62:1ac3:: with SMTP id a186mr66172780pfa.48.1554188894723;
        Tue, 02 Apr 2019 00:08:14 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id l184sm21786938pfc.98.2019.04.02.00.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:08:13 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:08:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: fix a potential NULL pointer dereference
Message-ID: <20190402070809.GE4187@dell>
References: <20190309080456.8579-1-kjlu@umn.edu>
 <C71F9E7E-5EF8-4AE5-92D4-4596D25B1D9B@umn.edu>
 <20190325075608.GY4731@dell>
 <be967424-090f-d388-4530-47a9a817db1f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be967424-090f-d388-4530-47a9a817db1f@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Mukesh Ojha wrote:

> On 3/25/2019 1:26 PM, Lee Jones wrote:
> > On Fri, 22 Mar 2019, Kangjie Lu wrote:
> > 
> > > Hi Lee Jones,
> > > 
> > > Can you review this patch?
> > Don't poke.
> > 
> > I have a very long list of reviews on my TODO.  Poking only surfaces
> > your patch to the top of my Inbox, and since I review patches in
> > reverse chronological order, it puts the review to the back of the
> > queue.
> > 
> > > > On Mar 9, 2019, at 2:04 AM, Kangjie Lu <kjlu@umn.edu> wrote:
> > > > 
> > > > In case devm_kzalloc fails, the fix does NULL check and returns
> > > > -ENOMEM upon failure so as to avoid NULL pointer dereference.
> > > > 
> > > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > > ---
> > > > drivers/mfd/sm501.c | 3 +++
> > > > 1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> > > > index a530972c5a7e..e0173bf4b0dc 100644
> > > > --- a/drivers/mfd/sm501.c
> > > > +++ b/drivers/mfd/sm501.c
> > > > @@ -1145,6 +1145,9 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
> > > > 	lookup = devm_kzalloc(&pdev->dev,
> > > > 			      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
> > > > 			      GFP_KERNEL);
> > > > +	if (!lookup)
> > > > +		return -ENOMEM;
> 
> Seems you are using quite old codebase.
> This patch is already there ..
> 
> https://elixir.bootlin.com/linux/v5.1-rc2/source/drivers/mfd/sm501.c#L1147
> 
> commit ae7b8eda27b3( mfd: sm501: Fix potential NULL pointer dereference )

Confirmed.  Dropping this one.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
