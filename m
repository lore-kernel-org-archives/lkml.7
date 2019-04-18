Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B4DC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A42D2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG3VtRXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfDRAzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:55:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46099 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRAzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:55:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id x188so263811oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AV64GvdS0YzPBsOlzyDEAVi9ue4MjVTIDqGNkDwC9Io=;
        b=FG3VtRXXvVmeoCr8SriXFcdTfidzpRciVS+Fgb2ZffXESpMWl65i57FK1Ua7x9JhGv
         wI9DO85Haax7WSJUAPP6uI/ZhMZhr3iZm4eyu7MTpged/PuPGgDHebfhCdZOX9b91kB3
         rvKLQSN944b5eJyHyIUfj+HqVwZ4ojl9yNxxzqElSUYtdv+ZxYIyCdB1vxmR2wpzxGAJ
         4S31IunJogi+1Jt7DvDpRypEek2awsnRHsEfi9HYjp2aCSAOkZwsT6t4EPcXsgmjXYwX
         qMUeC9bT7sApRnEuEMeS0GCoQ6vkVH7sKkhjCorpDn6wZDGFtR3728+mMQudRg2KyvAr
         Q+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AV64GvdS0YzPBsOlzyDEAVi9ue4MjVTIDqGNkDwC9Io=;
        b=iTUHmyWFW/4k5vZoK+rwIQXRDLbQNvUyFACJpkKlvUwFIqh7HV7AEeBk2P69FBQW0A
         pbSEk7zCh4zGuul33DvCUEcC/eb4kv3QBDYhkRPGcQ8R07aNn3hIn7Bn0iE3/ouSPyvq
         LmWk0+fTNggEXkMgYaI3wtuRMbe4/jf9+bwLgZw3TM58PjZjzoEfeNdYm8USE4gK8eSk
         Rl4KovBXSazvmxhvX1RtEX9KSezCBnOVh3A8RpAaCqlHM+On+Ez8f7fGznz8FtxYjc09
         agPGyE2vWk6ZBJBcMbsNsiJ6wvDId1Oi1L5J6XNykSM4QjV94HpvkCwRourV8KE+csW8
         9+gw==
X-Gm-Message-State: APjAAAV8gQt/BdH2eEHce1eD/Qo7K2oTPS/Ah0m55Ku2yNd2ih5C/XH5
        l97ha4wb3TSaRsbwWQlwiI73uDpju9ZAFg==
X-Google-Smtp-Source: APXvYqxfBIJiWSYCGdTzElnBv4SwJaGwvkb9RLLlVtVf6lubRjCTt7rHrEseIa24zlUTF5t3LF6PNw==
X-Received: by 2002:aca:3b43:: with SMTP id i64mr249945oia.121.1555548937062;
        Wed, 17 Apr 2019 17:55:37 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:9d55:3ae5:fad7:6d16])
        by smtp.gmail.com with ESMTPSA id h8sm201864oti.64.2019.04.17.17.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:55:36 -0700 (PDT)
Date:   Wed, 17 Apr 2019 19:55:33 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: greybus: Cleanup in greybus driver
Message-ID: <20190418005532.GA3421@madhuleo>
References: <20190416221318.21161-1-madhumithabiw@gmail.com>
 <20190417062518.GA23076@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417062518.GA23076@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17  :25, Greg KH wrote:
> On Tue, Apr 16, 2019 at 05:13:18PM -0500, Madhumitha Prabakaran wrote:
> > Fix a blank line after structure declarations. Also, convert
> > macros into inline functions in order to maintain Linux kernel
> > coding style based on which the inline function is
> > preferable over the macro.
> > 
> > Blank line fixes are suggested by checkpatch.pl
> > 
> > Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> > 
> > Changes in v2:
> > - To maintain consistency in driver greybus, all the instances of macro
> > with container_of are fixed in a single patch.
> > ---
> >  drivers/staging/greybus/bundle.h    |  6 +++++-
> >  drivers/staging/greybus/control.h   |  6 +++++-
> >  drivers/staging/greybus/gbphy.h     | 12 ++++++++++--
> >  drivers/staging/greybus/greybus.h   |  6 +++++-
> >  drivers/staging/greybus/hd.h        |  6 +++++-
> >  drivers/staging/greybus/interface.h |  6 +++++-
> >  drivers/staging/greybus/module.h    |  6 +++++-
> >  drivers/staging/greybus/svc.h       |  6 +++++-
> >  8 files changed, 45 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/bundle.h b/drivers/staging/greybus/bundle.h
> > index 8734d2055657..84956eedb1c4 100644
> > --- a/drivers/staging/greybus/bundle.h
> > +++ b/drivers/staging/greybus/bundle.h
> > @@ -31,7 +31,11 @@ struct gb_bundle {
> >  
> >  	struct list_head	links;	/* interface->bundles */
> >  };
> > -#define to_gb_bundle(d) container_of(d, struct gb_bundle, dev)
> > +
> > +static inline struct gb_bundle *to_gb_bundle(struct device *d)
> > +{
> > +	return container_of(d, struct gb_bundle, dev);
> > +}
> 
> Why are we changing this to an inline function?  The #define is fine,
> and how we "normally" do this type of container_of conversion.
> 
> I understand the objection of the "no blank line", but this was the
> "original" style that we used to create these #defines from the very
> beginning of the driver model work a decade ago.  Changing that
> muscle-memory is going to be hard for some of us.  Look at
> drivers/base/base.h for other examples of this.

Thanks for explaining it.

> 
> thanks,
> 
> greg k-h
