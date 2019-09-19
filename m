Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E81FC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0533E21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568933189;
	bh=KV4GAsafWdjKZTnkNayZVObWw9Ya4mDpcmbTQx6aqQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M7S0gai29YmdPZj6MI/nVfsAUqeYrBKZyVuIqk53Hf0M6lnoqJJsE+V0DON3SWnVP
	 6GbYppDAmkSbmYnAHFZ3QzN2MrNP4IH02V3caeDC41q8wXd3RVdjUk5KcFYOu8zyH2
	 i/DgKVjEG0Bpl6JBPXPau6tOMx3JAtGSAflGfFlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393549AbfISWq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389023AbfISWq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:46:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342A3206C2;
        Thu, 19 Sep 2019 22:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568933186;
        bh=KV4GAsafWdjKZTnkNayZVObWw9Ya4mDpcmbTQx6aqQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/ojsji3vxAtAA8k57gz4oj7lWE19V19CYjtiGeLH0c8ggXOZtqmRUpKiDaU5W3e3
         628ll+A/AuOwMHPg94KSIIK7tsPHS1330ba2/TkYKP6MbvYPh1yDTlKF4JBs+KfkwB
         0HXbFJGxSE386I/GeIMKGQXpAVMsrL4/LGO2xcM8=
Date:   Fri, 20 Sep 2019 00:46:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mnalajal@codeaurora.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] base: soc: Export soc_device_to_device API
Message-ID: <20190919224624.GB447028@kroah.com>
References: <1568927624-13682-1-git-send-email-mnalajal@codeaurora.org>
 <20190919213203.GA395325@kroah.com>
 <20190919215300.GC1418@minitux>
 <20190919215836.GA426988@kroah.com>
 <0fa861c7210c0e929a9955f48e1486ee@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa861c7210c0e929a9955f48e1486ee@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 03:27:45PM -0700, mnalajal@codeaurora.org wrote:
> On 2019-09-19 14:58, Greg KH wrote:
> > On Thu, Sep 19, 2019 at 02:53:00PM -0700, Bjorn Andersson wrote:
> > > On Thu 19 Sep 14:32 PDT 2019, Greg KH wrote:
> > > 
> > > > On Thu, Sep 19, 2019 at 02:13:44PM -0700, Murali Nalajala wrote:
> > > > > If the soc drivers want to add custom sysfs entries it needs to
> > > > > access "dev" field in "struct soc_device". This can be achieved
> > > > > by "soc_device_to_device" API. Soc drivers which are built as a
> > > > > module they need above API to be exported. Otherwise one can
> > > > > observe compilation issues.
> > > > >
> > > > > Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> > > > > ---
> > > > >  drivers/base/soc.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> > > > > index 7c0c5ca..4ad52f6 100644
> > > > > --- a/drivers/base/soc.c
> > > > > +++ b/drivers/base/soc.c
> > > > > @@ -41,6 +41,7 @@ struct device *soc_device_to_device(struct soc_device *soc_dev)
> > > > >  {
> > > > >  	return &soc_dev->dev;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(soc_device_to_device);
> > > > >
> > > > >  static umode_t soc_attribute_mode(struct kobject *kobj,
> > > > >  				struct attribute *attr,
> > > >
> > > > What in-kernel driver needs this?
> > > >
> > > 
> > > Half of the drivers interacting with the soc driver calls this API,
> > > several of these I see no reason for being builtin (e.g.
> > > ux500 andversatile). So I think this patch makes sense to allow us to
> > > build these as modules.
> > > 
> > > > Is linux-next breaking without this?
> > > >
> > > 
> > > No, we postponed the addition of any sysfs attributes in the Qualcomm
> > > socinfo driver.
> > > 
> > > > We don't export things unless we have a user of the export.
> > > >
> > > > Also, adding "custom" sysfs attributes is almost always not the correct
> > > > thing to do at all.  The driver should be doing it, by setting up the
> > > > attribute group properly so that the driver core can do it automatically
> > > > for it.
> > > >
> > > > No driver should be doing individual add/remove of sysfs files.  If it
> > > > does so, it is almost guaranteed to be doing it incorrectly and racing
> > > > userspace.
> > > >
> > > 
> > > The problem here is that the attributes are expected to be attached to
> > > the soc driver, which is separate from the platform-specific
> > > drivers. So
> > > there's no way to do platform specific attributes the right way.
> > > 
> > > > And yes, there's loads of in-kernel examples of doing this wrong, I've
> > > > been working on fixing that up, look at the patches now in Linus's tree
> > > > for platform and USB drivers that do this as examples of how to do it
> > > > right.
> > > >
> > > 
> > > Agreed, this patch should not be used as an approval for any crazy
> > > attributes; but it's necessary in order to extend the soc device's
> > > attributes, per the current design.
> > 
> > Wait, no, let's not let the "current design" remain if it is broken!
> > 
> > Why can't the soc driver handle the attributes properly so that the
> > individual driver doesn't have to do the create/remove?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Current soc framework is allowing the soc info drivers to create very
> limited
> soc information as sysfs entries like machine name, family, revision and
> soc_id.
> Sometimes it become a limited information for the clients to know more about
> soc
> information. In this scenario soc info drivers are adding their own sysfs
> entries
> on top of what soc framework is doing like hw_platform, hw_platform_subtype
> etc.
> I believe this will be an issue for the other soc vendors as well. It is
> good that
> if we could add these into the soc framework rather than individual clients
> defining
> and adding them as per their requirement.

It's fine to add sysfs files (as long as you document them in
Documentation/ABI/) but don't do so file-by-file in a driver as that is
racy and will not work.  See 6d03c140db2e ("USB: phy: fsl-usb: convert
platform driver to use dev_groups") as an example of how to do this in a
simple way to have the driver core do all of the work for you
automatically.

thanks,

greg k-h
