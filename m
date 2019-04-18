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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B32C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BD7217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nALspakr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfDRA64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:58:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43527 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRA64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:58:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id t81so280408oig.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zJVtqbFtGMW3px95wLhMRMCyD52FxUuXyeDzZfmutmk=;
        b=nALspakrfo5dYHk9SgxepMvTOzrGDgggctxaqxLuuewezMNMrDTUttpKEiOV8BsCEN
         diCfXhXweO9a4INQUtyxwjf82wB8rJM37NXv1nxG5zQQ9Zm/Io/J6RMEAA7n0zzy5JvP
         3blR/gwGZjU1WZ0ekgQuQ26robsahmcHva4cpP1aj064A9l5DFavsve9iJq96A2Mzl0/
         Pyw+w8nUXgNvM0miUGPV0SIhhwh0G3mFNqCwAFh/M5UM1MVNb/uZ9w6cDKGo2mgZckht
         Bzm7dodVvGMPdrXMetfV0Tyrr9lwFET6JVBwl4xZXCc0NEkmx83quBE10vQnslDIPkDu
         gFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zJVtqbFtGMW3px95wLhMRMCyD52FxUuXyeDzZfmutmk=;
        b=TuysM0C4o7O1WbveGVoqK4yo8lFgjaRyu2uNuVcJM7u715iJMfAb5tuzFoo5MGa+rp
         VoZ/+xn/zEB/Lu9R0MmBuX2EjJHqmLfrvMY6LTlS2h6GH1Xu1LAuA9iX8EjI0L5udRyN
         K9ob5I9xgsvdllPSeKzvlaSjV26XK8vV3mVoGmJeg5ELAA9a2JtM9yd9XczKmdnvBrxZ
         xRFAcT3Q0dosnfV7/QOXr1BrtGbV+MM3jsGkCC+du78tELVbQzjc7uMSRs23Dk00tI/Y
         cJF1Ze8WDSp5fvU1b6j1QxMKq1jjWYFY+glpjzrf1Z7n9kKknORwV7e6O+BAeNNTZb9g
         7DzQ==
X-Gm-Message-State: APjAAAVDntdq8fbxxjVQ/2pjBMRUzxrOJcqTpjfwc87+a75gF3zlExHY
        4AHKHCtsA76xcE+dwBuiugo=
X-Google-Smtp-Source: APXvYqwC+rknuySfFufao5xdGd7D3ihIbgS80uc1npWckFhLUCiNi92sem/V1fMLBBJ8IRdsjLrGUQ==
X-Received: by 2002:aca:5986:: with SMTP id n128mr264301oib.2.1555549135430;
        Wed, 17 Apr 2019 17:58:55 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:9d55:3ae5:fad7:6d16])
        by smtp.gmail.com with ESMTPSA id f3sm309925oih.38.2019.04.17.17.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:58:54 -0700 (PDT)
Date:   Wed, 17 Apr 2019 19:58:52 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     Alex Elder <elder@linaro.org>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH v2] Staging: greybus: Cleanup in greybus
 driver
Message-ID: <20190418005851.GB3421@madhuleo>
References: <20190416221318.21161-1-madhumithabiw@gmail.com>
 <b7ed0505-0ebf-98af-7beb-08b0709cc5fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ed0505-0ebf-98af-7beb-08b0709cc5fd@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17  :41, Alex Elder wrote:
> On 4/16/19 5:13 PM, Madhumitha Prabakaran wrote:
> > Fix a blank line after structure declarations. Also, convert
> > macros into inline functions in order to maintain Linux kernel
> > coding style based on which the inline function is
> > preferable over the macro.
> 
> Madhumitha, here is my explanation for why *not* to convert these
> container_of() macros to inline functions.  It's not just because
> "we do this all over the kernel."  The reason is that it actually
> does not improve the code.
> 
> Inline functions are often better than macros because they are
> explicit about types, allowing the compiler to tell you if you
> are passing parameters of the right type, and possibly assigning
> results to objects of the right type.


This makes more sense now.

> 
> Here is the definition of the container_of() macro in <linux/kernel.h>:
> 
> #define container_of(ptr, type, member) ({                      \
>         const typeof(((type *)0)->member) * __mptr = (ptr);     \
>         (type *)((char *)__mptr - offsetof(type, member)); })
> 
> You see that ptr is explicitly assigned to a local variable
> of the type of the member field, so the compiler is able to
> check that assignment.  And the return value is similarly
> cast to the type of the containing structure, so the type
> compatibility of the assignment can also be checked.  It is
> assumed that where this macro is used, the caller knows it
> is passing an appropriate address.
> 
> There is another thing about this particular definition make
> it just as good as an inline function.  A macro expansion can
> result in one of its parameters being used more than once, and
> that allows those parameters to be *evaluated* more than once
> in a single statement, which can produce incorrect code.
> 
> This macro is defined using the "statement expression"
> extension to C--where a compound statement is enclosed in
> parentheses--({ ... }).  This allows a local variable to be
> used in the macro expansion, which avoids any reuse of the
> macro parameters which might cause side-effects.
> 
> So anyway, I don't think there is any benefit to replacing
> macros like this that do container_of() with inline functions.
> 
> 					-Alex

Thanks for taking time to explain it in detailed way.

> 
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
> >  
> >  /* Greybus "private" definitions" */
> >  struct gb_bundle *gb_bundle_create(struct gb_interface *intf, u8 bundle_id,
> > diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
> > index 3a29ec05f631..a681ef74e7fe 100644
> > --- a/drivers/staging/greybus/control.h
> > +++ b/drivers/staging/greybus/control.h
> > @@ -24,7 +24,11 @@ struct gb_control {
> >  	char *vendor_string;
> >  	char *product_string;
> >  };
> > -#define to_gb_control(d) container_of(d, struct gb_control, dev)
> > +
> > +static inline struct gb_control *to_gb_control(struct device *d)
> > +{
> > +	return container_of(d, struct gb_control, dev);
> > +}
> >  
> >  struct gb_control *gb_control_create(struct gb_interface *intf);
> >  int gb_control_enable(struct gb_control *control);
> > diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
> > index 99463489d7d6..20307f6dfcb9 100644
> > --- a/drivers/staging/greybus/gbphy.h
> > +++ b/drivers/staging/greybus/gbphy.h
> > @@ -15,7 +15,11 @@ struct gbphy_device {
> >  	struct list_head list;
> >  	struct device dev;
> >  };
> > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > +
> > +static inline struct gbphy_device *to_gbphy_dev(struct device *d)
> > +{
> > +	return container_of(d, struct gbphy_device, dev);
> > +}
> >  
> >  static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
> >  {
> > @@ -43,7 +47,11 @@ struct gbphy_driver {
> >  
> >  	struct device_driver driver;
> >  };
> > -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> > +
> > +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
> > +{
> > +	return container_of(d, struct gbphy_driver, driver);
> > +}
> >  
> >  int gb_gbphy_register_driver(struct gbphy_driver *driver,
> >  			     struct module *owner, const char *mod_name);
> > diff --git a/drivers/staging/greybus/greybus.h b/drivers/staging/greybus/greybus.h
> > index d03ddb7c9df0..a82d5002b4d5 100644
> > --- a/drivers/staging/greybus/greybus.h
> > +++ b/drivers/staging/greybus/greybus.h
> > @@ -64,7 +64,11 @@ struct greybus_driver {
> >  
> >  	struct device_driver driver;
> >  };
> > -#define to_greybus_driver(d) container_of(d, struct greybus_driver, driver)
> > +
> > +static inline struct greybus_driver *to_greybus_driver(struct device_driver *d)
> > +{
> > +	return container_of(d, struct greybus_driver, driver);
> > +}
> >  
> >  static inline void greybus_set_drvdata(struct gb_bundle *bundle, void *data)
> >  {
> > diff --git a/drivers/staging/greybus/hd.h b/drivers/staging/greybus/hd.h
> > index 6cf024a20a58..de7c49d05266 100644
> > --- a/drivers/staging/greybus/hd.h
> > +++ b/drivers/staging/greybus/hd.h
> > @@ -57,7 +57,11 @@ struct gb_host_device {
> >  	/* Private data for the host driver */
> >  	unsigned long hd_priv[0] __aligned(sizeof(s64));
> >  };
> > -#define to_gb_host_device(d) container_of(d, struct gb_host_device, dev)
> > +
> > +static inline struct gb_host_device *to_gb_host_device(struct device *d)
> > +{
> > +	return container_of(d, struct gb_host_device, dev);
> > +}
> >  
> >  int gb_hd_cport_reserve(struct gb_host_device *hd, u16 cport_id);
> >  void gb_hd_cport_release_reserved(struct gb_host_device *hd, u16 cport_id);
> > diff --git a/drivers/staging/greybus/interface.h b/drivers/staging/greybus/interface.h
> > index 1c00c5bb3ec9..f86c0d596dbe 100644
> > --- a/drivers/staging/greybus/interface.h
> > +++ b/drivers/staging/greybus/interface.h
> > @@ -63,7 +63,11 @@ struct gb_interface {
> >  	struct work_struct mode_switch_work;
> >  	struct completion mode_switch_completion;
> >  };
> > -#define to_gb_interface(d) container_of(d, struct gb_interface, dev)
> > +
> > +static inline struct gb_interface *to_gb_interface(struct device *d)
> > +{
> > +	return container_of(d, struct gb_interface, dev);
> > +}
> >  
> >  struct gb_interface *gb_interface_create(struct gb_module *module,
> >  					 u8 interface_id);
> > diff --git a/drivers/staging/greybus/module.h b/drivers/staging/greybus/module.h
> > index b1ebcc6636db..c427b788b677 100644
> > --- a/drivers/staging/greybus/module.h
> > +++ b/drivers/staging/greybus/module.h
> > @@ -22,7 +22,11 @@ struct gb_module {
> >  
> >  	struct gb_interface *interfaces[0];
> >  };
> > -#define to_gb_module(d) container_of(d, struct gb_module, dev)
> > +
> > +static inline struct gb_module *to_gb_module(struct device *d)
> > +{
> > +	return container_of(d, struct gb_module, dev);
> > +}
> >  
> >  struct gb_module *gb_module_create(struct gb_host_device *hd, u8 module_id,
> >  				   size_t num_interfaces);
> > diff --git a/drivers/staging/greybus/svc.h b/drivers/staging/greybus/svc.h
> > index ad01783bac9c..4e35ac9ed0ff 100644
> > --- a/drivers/staging/greybus/svc.h
> > +++ b/drivers/staging/greybus/svc.h
> > @@ -52,7 +52,11 @@ struct gb_svc {
> >  	struct dentry *debugfs_dentry;
> >  	struct svc_debugfs_pwrmon_rail *pwrmon_rails;
> >  };
> > -#define to_gb_svc(d) container_of(d, struct gb_svc, dev)
> > +
> > +static inline struct gb_svc *to_gb_svc(struct device *d)
> > +{
> > +	return container_of(d, struct gb_svc, dev);
> > +}
> >  
> >  struct gb_svc *gb_svc_create(struct gb_host_device *hd);
> >  int gb_svc_add(struct gb_svc *svc);
> > 
> 
