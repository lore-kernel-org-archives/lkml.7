Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F39CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE7B214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiPaNGgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbfJVP4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:56:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36219 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388930AbfJVP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:56:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so14622264oih.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nT+qu+mK4nExh9asL6QEuobL9f44sXZzjJ8OGH3zTLs=;
        b=jiPaNGgo/CgQHcG9hfGwIIOkxf9tMHIdDesTkpbw5BbUzbEqEV6xfyrtz4XCd9lRzQ
         mmIzdQDOE1drZYsdxFVBmGEVPkM8Kcr0cWpt8ptN3i9XLbDJ1i+xYPJXhNdNQ/wGAByX
         lS1ah5yqFODjchjAYkMNETyQQ/h4dT73uNZKi4TDjGcZcPPqQuE2g7Hpy+nj8svXQvK/
         rajQmCMj3kS5Dpw6BSbWmSaT53Ik0aealOGhGh9fX5zX7LEDLS/B9UtECrLH9lvlYeMa
         GvJ1TDuHHY869jclQ3MrlN+4qVb7IFKHupanLxHUhvL/tk/GK/DxSvX9z1hOevFxRcgh
         y1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=nT+qu+mK4nExh9asL6QEuobL9f44sXZzjJ8OGH3zTLs=;
        b=V1wswbbzpm9MbvQ60w8/xN9jJUgdc1DPYTCaaCsfzjWs/jVhni7/P5Tky1AEtP3pM5
         dWISXJTong8MYJJloScXSgajeViCIwDGdEQjRDE5kTK6uO8ROpuvGO7dQYPSC4OTr2q2
         18EiaKG4gnWrtAU425nujuOln+k5IDtWLFN+tmuWQZgfR100ICMl942fG1y1NGoP7mgX
         JrvOPWbg2vaj+m3HDgWagqncVA51rxx7CxgcYqaIiwe7wiFPvTpC7kxsPGzPVW6U/LEg
         f+1ku4CFh6pLWCol7EjxvJRHhZmHtWPE3JYR1gIFvXtQc/XnSduRIHP663+MPABcHX1Z
         EOew==
X-Gm-Message-State: APjAAAUAO4KkQtYJhXHdOpivcrmERyKFtjDMqOjlAvksflW4ssw+h3AY
        OfzkVIYb6SjfnPTNnhSdPA==
X-Google-Smtp-Source: APXvYqwJDxk9uqBohdV+ivzlr/WbmtCIalYQxKWJETxEQIq1RB3qGjj65Atk8+KrHJnT4L/0970+nQ==
X-Received: by 2002:aca:f1d7:: with SMTP id p206mr3671009oih.97.1571759792068;
        Tue, 22 Oct 2019 08:56:32 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id s1sm5145646otd.49.2019.10.22.08.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:56:31 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id EAB7B180044;
        Tue, 22 Oct 2019 15:56:30 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:56:29 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tony Camuso <tcamuso@redhat.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] ipmi: Don't allow device module unload when in use
Message-ID: <20191022155629.GU14232@t560>
Reply-To: minyard@acm.org
References: <20191014134141.GA25427@t560>
 <20191014154632.11103-1-minyard@acm.org>
 <28065598-c638-07eb-d966-0e85ce62c37f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28065598-c638-07eb-d966-0e85ce62c37f@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:29:12AM -0400, Tony Camuso wrote:
> Corey,
> 
> Testing shows that this patch works as expected.

Thanks, I'll add a Tested-by for you.  It's queued for the next merge
window.

-corey

> 
> Regards,
> Tony
> 
> 
> On 10/14/19 11:46 AM, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > If something has the IPMI driver open, don't allow the device
> > module to be unloaded.  Before it would unload and the user would
> > get errors on use.
> > 
> > This change is made on user request, and it makes it consistent
> > with the I2C driver, which has the same behavior.
> > 
> > It does change things a little bit with respect to kernel users.
> > If the ACPI or IPMI watchdog (or any other kernel user) has
> > created a user, then the device module cannot be unloaded.  Before
> > it could be unloaded,
> > 
> > This does not affect hot-plug.  If the device goes away (it's on
> > something removable that is removed or is hot-removed via sysfs)
> > then it still behaves as it did before.
> > 
> > Reported-by: tony camuso <tcamuso@redhat.com>
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > ---
> > Tony, here is a suggested change for this.  Can you look it over and
> > see if it looks ok?
> > 
> > Thanks,
> > 
> > -corey
> > 
> >   drivers/char/ipmi/ipmi_msghandler.c | 23 ++++++++++++++++-------
> >   include/linux/ipmi_smi.h            | 12 ++++++++----
> >   2 files changed, 24 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > index 2aab80e19ae0..15680de18625 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -448,6 +448,8 @@ enum ipmi_stat_indexes {
> >   #define IPMI_IPMB_NUM_SEQ	64
> >   struct ipmi_smi {
> > +	struct module *owner;
> > +
> >   	/* What interface number are we? */
> >   	int intf_num;
> > @@ -1220,6 +1222,11 @@ int ipmi_create_user(unsigned int          if_num,
> >   	if (rv)
> >   		goto out_kfree;
> > +	if (!try_module_get(intf->owner)) {
> > +		rv = -ENODEV;
> > +		goto out_kfree;
> > +	}
> > +	
> >   	/* Note that each existing user holds a refcount to the interface. */
> >   	kref_get(&intf->refcount);
> > @@ -1349,6 +1356,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
> >   	}
> >   	kref_put(&intf->refcount, intf_free);
> > +	module_put(intf->owner);
> >   }
> >   int ipmi_destroy_user(struct ipmi_user *user)
> > @@ -2459,7 +2467,7 @@ static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
> >    * been recently fetched, this will just use the cached data.  Otherwise
> >    * it will run a new fetch.
> >    *
> > - * Except for the first time this is called (in ipmi_register_smi()),
> > + * Except for the first time this is called (in ipmi_add_smi()),
> >    * this will always return good data;
> >    */
> >   static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
> > @@ -3377,10 +3385,11 @@ static void redo_bmc_reg(struct work_struct *work)
> >   	kref_put(&intf->refcount, intf_free);
> >   }
> > -int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
> > -		      void		       *send_info,
> > -		      struct device            *si_dev,
> > -		      unsigned char            slave_addr)
> > +int ipmi_add_smi(struct module         *owner,
> > +		 const struct ipmi_smi_handlers *handlers,
> > +		 void		       *send_info,
> > +		 struct device         *si_dev,
> > +		 unsigned char         slave_addr)
> >   {
> >   	int              i, j;
> >   	int              rv;
> > @@ -3406,7 +3415,7 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
> >   		return rv;
> >   	}
> > -
> > +	intf->owner = owner;
> >   	intf->bmc = &intf->tmp_bmc;
> >   	INIT_LIST_HEAD(&intf->bmc->intfs);
> >   	mutex_init(&intf->bmc->dyn_mutex);
> > @@ -3514,7 +3523,7 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
> >   	return rv;
> >   }
> > -EXPORT_SYMBOL(ipmi_register_smi);
> > +EXPORT_SYMBOL(ipmi_add_smi);
> >   static void deliver_smi_err_response(struct ipmi_smi *intf,
> >   				     struct ipmi_smi_msg *msg,
> > diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
> > index 4dc66157d872..deec18b8944a 100644
> > --- a/include/linux/ipmi_smi.h
> > +++ b/include/linux/ipmi_smi.h
> > @@ -224,10 +224,14 @@ static inline int ipmi_demangle_device_id(uint8_t netfn, uint8_t cmd,
> >    * is called, and the lower layer must get the interface from that
> >    * call.
> >    */
> > -int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
> > -		      void                     *send_info,
> > -		      struct device            *dev,
> > -		      unsigned char            slave_addr);
> > +int ipmi_add_smi(struct module            *owner,
> > +		 const struct ipmi_smi_handlers *handlers,
> > +		 void                     *send_info,
> > +		 struct device            *dev,
> > +		 unsigned char            slave_addr);
> > +
> > +#define ipmi_register_smi(handlers, send_info, dev, slave_addr) \
> > +	ipmi_add_smi(THIS_MODULE, handlers, send_info, dev, slave_addr)
> >   /*
> >    * Remove a low-level interface from the IPMI driver.  This will
> > 
> 
