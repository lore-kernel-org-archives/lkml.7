Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A11C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD7421927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xODCt9c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405276AbfISWPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:15:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43644 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393842AbfISWPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:15:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so3166778pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fB4zQQtxD6RQxzuoXRwLfGvFn/ooCdWNGohHK66LQ08=;
        b=xODCt9c4PPzf7ZJP+bySIqn30TXjt1heT30OW1TE2tgQtVhEZ7PHRfvCGWTlZvgjNV
         apIa133AHQl1MXOGINvY5iFkudp6kx2frahxdJAcNMzV4Y4J64OAEOnRdDYg8+HNB/99
         nqJBshr9YGEOTxr7GHCPTuHdo1o0hTVg/jt0hakbqbYZt2h/5166qpMQW5S6VqM1V+Xw
         etWTjs94jRmnO7JqoXz7dZN92pFkE5YflNvMSyPlBjqvNtq64WMXpUqtQB5kuK8Sbwo9
         fx1+RAgTe8xE+mAHEuDd8+bLlYv0yz3sQOkn8B4Fkqa6lUkA15fs422p51e3RUn/AkKS
         vMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fB4zQQtxD6RQxzuoXRwLfGvFn/ooCdWNGohHK66LQ08=;
        b=mDG1zuoM5vg9U2RmOm1IxQJDen9jjQrXDfcbk0fzN6ToncNdPq80Wj1POtqNFIkaIw
         xEM8mAyNbfc4RVz4+pJgsO+KkORTGjYD1mkffFyGdvRFA+JnhfhEXxus92Bpl0V/btdp
         aMpicFyJDqscuaZ+qQ68R9HBrW2zRrPeeWbUqYV7s/prd8yvOOHrYzHkn9mw28fLG2Mp
         FVTAXoW7rc1/5zxa4aiieDo1mQ4eiE9+O2+pp0Gm6dJ9unuDgIxbNd1Hdxt2hPqWaixt
         dIGp7G6Y7IlJzSty9JZDz+rJJKNWS6wr/T+159iEpxXSNU1REXtJSxcJRf72c9AQ/0/f
         gZdg==
X-Gm-Message-State: APjAAAX84CuWtdG7q5a+Z+DSC2bpDDqa/VerNOjoyJ++CitT8Smolc54
        /6v4yo4OVM3Fk+yd5mTbMETstA==
X-Google-Smtp-Source: APXvYqwHnPaYhBk4Lt3yi1dUPz66jlOkeds9a5M1ZpocrTHis+sK2zkXHck+Dypk2L3DX5oswWkkiQ==
X-Received: by 2002:a17:90a:8991:: with SMTP id v17mr145915pjn.127.1568931299611;
        Thu, 19 Sep 2019 15:14:59 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c62sm7071pfa.92.2019.09.19.15.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 15:14:59 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:14:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Murali Nalajala <mnalajal@codeaurora.org>, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] base: soc: Export soc_device_to_device API
Message-ID: <20190919221456.GA63675@minitux>
References: <1568927624-13682-1-git-send-email-mnalajal@codeaurora.org>
 <20190919213203.GA395325@kroah.com>
 <20190919215300.GC1418@minitux>
 <20190919215836.GA426988@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919215836.GA426988@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Sep 14:58 PDT 2019, Greg KH wrote:

> On Thu, Sep 19, 2019 at 02:53:00PM -0700, Bjorn Andersson wrote:
> > On Thu 19 Sep 14:32 PDT 2019, Greg KH wrote:
> > 
> > > On Thu, Sep 19, 2019 at 02:13:44PM -0700, Murali Nalajala wrote:
> > > > If the soc drivers want to add custom sysfs entries it needs to
> > > > access "dev" field in "struct soc_device". This can be achieved
> > > > by "soc_device_to_device" API. Soc drivers which are built as a
> > > > module they need above API to be exported. Otherwise one can
> > > > observe compilation issues.
> > > > 
> > > > Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> > > > ---
> > > >  drivers/base/soc.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> > > > index 7c0c5ca..4ad52f6 100644
> > > > --- a/drivers/base/soc.c
> > > > +++ b/drivers/base/soc.c
> > > > @@ -41,6 +41,7 @@ struct device *soc_device_to_device(struct soc_device *soc_dev)
> > > >  {
> > > >  	return &soc_dev->dev;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(soc_device_to_device);
> > > >  
> > > >  static umode_t soc_attribute_mode(struct kobject *kobj,
> > > >  				struct attribute *attr,
> > > 
> > > What in-kernel driver needs this?
> > > 
> > 
> > Half of the drivers interacting with the soc driver calls this API,
> > several of these I see no reason for being builtin (e.g.
> > ux500 andversatile). So I think this patch makes sense to allow us to
> > build these as modules.
> > 
> > > Is linux-next breaking without this?
> > > 
> > 
> > No, we postponed the addition of any sysfs attributes in the Qualcomm
> > socinfo driver.
> > 
> > > We don't export things unless we have a user of the export.
> > > 
> > > Also, adding "custom" sysfs attributes is almost always not the correct
> > > thing to do at all.  The driver should be doing it, by setting up the
> > > attribute group properly so that the driver core can do it automatically
> > > for it.
> > > 
> > > No driver should be doing individual add/remove of sysfs files.  If it
> > > does so, it is almost guaranteed to be doing it incorrectly and racing
> > > userspace.
> > > 
> > 
> > The problem here is that the attributes are expected to be attached to
> > the soc driver, which is separate from the platform-specific drivers. So
> > there's no way to do platform specific attributes the right way.
> > 
> > > And yes, there's loads of in-kernel examples of doing this wrong, I've
> > > been working on fixing that up, look at the patches now in Linus's tree
> > > for platform and USB drivers that do this as examples of how to do it
> > > right.
> > > 
> > 
> > Agreed, this patch should not be used as an approval for any crazy
> > attributes; but it's necessary in order to extend the soc device's
> > attributes, per the current design.
> 
> Wait, no, let's not let the "current design" remain if it is broken!
> 
> Why can't the soc driver handle the attributes properly so that the
> individual driver doesn't have to do the create/remove?
> 

The custom attributes that these drivers want to add to the common ones
are known in advance, so I presume we could have them passed into
soc_device_register() and registered together with the common
attributes...

It sounds like it's worth a prototype.

Regards,
Bjorn
