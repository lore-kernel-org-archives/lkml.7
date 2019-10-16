Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB414ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83B72064B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkOUvUOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389254AbfJPTdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:33:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45583 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfJPTdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:33:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so21203101oti.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0EwAgpEWd7EO1EKdG0MkkOzuiwYznfYN6gWUck6FlNk=;
        b=gkOUvUOBud2L6/5P2AOAIv5TGQ0M9JfReVPHkNifHedEPpf9C2ArYQmO9HSzD8LMFz
         5kZW2qK3mfrnTNNDASJT3tiwWUaCdBW+paalxTil5WxBO+isf1bXvGFBjiccrbZ+IMZw
         xpkxJF4W3BaFs+gtd+cko4whgrvQaqUsm9p3chQkEIOcqrWbv9xFDQGVoZy0DkBcre+i
         WppiCvJHLWQEzU3c9vz4G9Nx/mBBet2u21zrLZE5nfyoDraAWgzP0P6xBg3p5K+HUTW+
         b3+0gJZg4x2GCKSVAwvQjR7PZLZfyvkzIsOL79Rm1Dcq1Fbu56lr12jXuuNAb/HsuTP0
         BjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=0EwAgpEWd7EO1EKdG0MkkOzuiwYznfYN6gWUck6FlNk=;
        b=pXLRWayapl5u6yagblRmGGLpZC2d146gK18BNFVrHeZtxJBeAuECESM9fEInVO/XVE
         GeG0jiSxa4Hvfx0TqIF94ik2C+JZRsGO5KrmxT266Y0mmGdtej44cQ5XwQzVsJiBI3cR
         IKHXnG8dAQF45xL8pGXvclDIQzeHKFc4wSrL2/Bbwg9DH7B2yKRLwvN/38ecBtEBIw7/
         W8dFHrHYR/D/vrsXcnNONiRLSATIYwp9pXHXiHcpmQ8mMw3EGzXkd1Ye6JDYXDkyi8+4
         5qN9oaTfkqjhpgjQgB/htIj4I8GULXUDZOBR6aSoIvbX8f5jQfuPHUNPH7NBiC0Ho5yF
         E/vA==
X-Gm-Message-State: APjAAAVgiV7Xfh7ONKic4Z1iLu6wW6a9aEVPx4w644j6BLyC70A+wLhm
        /RTNThn6llXAhg8fE3ZIrg==
X-Google-Smtp-Source: APXvYqwuzd58Mq7UxADftNjaqqu6nt/Ts9ibHkjdwTJDrfxCdB4x58a3NYpRkQ/s1wJSpZ4JCs72iQ==
X-Received: by 2002:a9d:19a9:: with SMTP id k38mr6040876otk.366.1571254431889;
        Wed, 16 Oct 2019 12:33:51 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 8sm7704769oti.41.2019.10.16.12.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 12:33:51 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 821FF180046;
        Wed, 16 Oct 2019 19:33:50 +0000 (UTC)
Date:   Wed, 16 Oct 2019 14:33:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tony Camuso <tcamuso@redhat.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] ipmi: Don't allow device module unload when in use
Message-ID: <20191016193349.GP14232@t560>
Reply-To: minyard@acm.org
References: <20191014134141.GA25427@t560>
 <20191014154632.11103-1-minyard@acm.org>
 <f73aa2ef-e173-db85-e426-3bf380626f66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73aa2ef-e173-db85-e426-3bf380626f66@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:25:56PM -0400, Tony Camuso wrote:
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
> 
> Hi Corey.
> 
> You changed ipmi_register_ipmi to ipmi_add_ipmi in ipmi_msghandler, but you
> did not change it where it is actually called.
> 
> # grep ipmi_register_smi drivers/char/ipmi/*.c
> drivers/char/ipmi/ipmi_powernv.c:	rc = ipmi_register_smi(&ipmi_powernv_smi_handlers, ipmi, dev, 0);
> drivers/char/ipmi/ipmi_si_intf.c:	rv = ipmi_register_smi(&handlers,
> drivers/char/ipmi/ipmi_ssif.c:	rv = ipmi_register_smi(&ssif_info->handlers,
> 
> Is there a reason for changing the interface name? Is this something
> that I could do instead of troubling you with it?

I don't understand.  You don't say that anything went wrong, you just
referenced something I changed.

I changed the name so I could create a macro with that name to pass in
the module name.  Pretty standard to do in the kernel.  Is there a
compile or runtime issue?

-corey

> 
> Regards,
> Tony
> 
> 
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
