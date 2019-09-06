Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817F7207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxDF8NaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404373AbfIFVeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:34:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37748 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbfIFVeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:34:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id b10so3806288plr.4;
        Fri, 06 Sep 2019 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/RyWa89NW2CDbmflnwIpgsMIqDN+1KFBG0Q30EjlOnc=;
        b=AxDF8NaMGcmYQw5D4ipAwssIfm08RvYyYk/14DHiB6AUe2zyxJoyBvNOxMzxgOgKsZ
         zqbiW9BZjc5vAP6Q3JBzuihYo+ZHrp5NFkq6I7Hph40sfolO+AUnWuPS3kop0qJAkFd/
         Sw8Q9FuFCSz4znMB1tRww41XtW54Z1iDf5vfHKHymz0HFSdg7DGAOFQYvqpAavZWX23L
         Jrp+TagrPwSRUBKRzgR8EJqH1TDh1atHds/j8WbF2cux8fpaUmKLG4AI8EAfi59kNBno
         qrNPSyjPF0Wcr8hE/5CILmsF9NBMRa5/KdLddxmja0qEnpwTTqn8Ha+IYOjpjRIhspMn
         Nd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/RyWa89NW2CDbmflnwIpgsMIqDN+1KFBG0Q30EjlOnc=;
        b=bJ3m0GWNqdvkPedyGPBMp7hLgNnJkaLKSV7DyE6tys7NY0xyucnBSrfyRLmFQMokL/
         H43SCvoUlgl5WprJ2goeBLZcWrOJNjMt9VJdAvq/pkdMor1O88nwts2cXvQGrUqdGAuz
         Z+Y8RLe3qC8oj5XCPmVOoa55g6AfwROnXa8+UOhWtr8UTVdP9dLyj0KodxznP7GsJhEG
         vPQ9/7SrZEmODOIsmZ8mOrlUnDOG8CsgTtcOyr2NOe5GEk/0RkLZAgth3Beon859BqZ2
         dHNm4DcSMgohEXqGhF+763c8Z+dP5YkKNoBAKnKjxnkT0Zmu3NJPc3GVVQdTuHuOJmzY
         zBdw==
X-Gm-Message-State: APjAAAX82TsvsB6UcuDtXm41g80stNuWiYTWAoEwXuI4fWAdEoZ3B+pe
        MutJEVt0nW3VJf3o4luwXXU=
X-Google-Smtp-Source: APXvYqyeYAOWNBxwXf8u0zHDpw8+eAGTebm69GRrvObCOy2+nktKHhwJkGEjB1E4T4pbmDEIufZ+3g==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr479860plk.132.1567805644741;
        Fri, 06 Sep 2019 14:34:04 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v12sm6778693pff.40.2019.09.06.14.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 14:34:03 -0700 (PDT)
Date:   Fri, 6 Sep 2019 14:34:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] platform/x86: intel_cht_int33fe: use inline
 reference properties
Message-ID: <20190906213401.GS187474@dtor-ws>
References: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
 <20190906043809.18990-2-dmitry.torokhov@gmail.com>
 <20190906112243.GB30048@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906112243.GB30048@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 02:22:43PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Thu, Sep 05, 2019 at 09:38:08PM -0700, Dmitry Torokhov wrote:
> > Now that static device properties allow defining reference properties
> > together with all other types of properties, instead of managing them
> > separately, let's adjust the driver.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > Heikki, I do not have this hardware, so if you could try this out
> > it would be really great.
> > 
> >  drivers/platform/x86/intel_cht_int33fe.c | 46 ++++++++++++------------
> >  1 file changed, 22 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> > index 4fbdff48a4b5..91f3c8840fd8 100644
> > --- a/drivers/platform/x86/intel_cht_int33fe.c
> > +++ b/drivers/platform/x86/intel_cht_int33fe.c
> > @@ -50,28 +50,8 @@ struct cht_int33fe_data {
> >  
> >  static const struct software_node nodes[];
> 
> I think you can remove that.

Not really, as there is still circular dependency between nodes and
properties. I moved it down closer to properties though.

> 
> > -static const struct software_node_ref_args pi3usb30532_ref = {
> > -	&nodes[INT33FE_NODE_PI3USB30532]
> > -};
> > -
> > -static const struct software_node_ref_args dp_ref = {
> > -	&nodes[INT33FE_NODE_DISPLAYPORT]
> > -};
> > -
> >  static struct software_node_ref_args mux_ref;
> 
> I'm pretty sure you should now drop that one.

I ended up reworking things a bit and still using a form of this to
reach in and change data, as properties ended up being constants.

> 
> > -static const struct software_node_reference usb_connector_refs[] = {
> > -	{ "orientation-switch", 1, &pi3usb30532_ref},
> > -	{ "mode-switch", 1, &pi3usb30532_ref},
> > -	{ "displayport", 1, &dp_ref},
> > -	{ }
> > -};
> > -
> > -static const struct software_node_reference fusb302_refs[] = {
> > -	{ "usb-role-switch", 1, &mux_ref},
> > -	{ }
> > -};
> > -
> >  /*
> >   * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
> >   * the max17047 both through the INT33FE ACPI device (it is right there
> > @@ -107,7 +87,13 @@ static const struct property_entry max17047_props[] = {
> >  	{ }
> >  };
> >  
> > -static const struct property_entry fusb302_props[] = {
> > +/* Not const because we need to update "usb-role-switch" property. */
> > +static struct property_entry fusb302_props[] = {
> > +	/*
> > +	 * usb-role-switch property must be first as we rely on fixed
> > +	 * position to adjust it once we know the real node.
> > +	 */
> > +	PROPERTY_ENTRY_REF("usb-role-switch", NULL),
> >  	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
> >  	{ }
> >  };
> > @@ -131,16 +117,22 @@ static const struct property_entry usb_connector_props[] = {
> >  	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
> >  	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
> >  	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
> > +	PROPERTY_ENTRY_REF("orientation-switch",
> > +			   &nodes[INT33FE_NODE_PI3USB30532]),
> > +	PROPERTY_ENTRY_REF("mode-switch",
> > +			   &nodes[INT33FE_NODE_PI3USB30532]),
> > +	PROPERTY_ENTRY_REF("displayport",
> > +			   &nodes[INT33FE_NODE_DISPLAYPORT]),
> >  	{ }
> >  };
> >  
> >  static const struct software_node nodes[] = {
> > -	{ "fusb302", NULL, fusb302_props, fusb302_refs },
> > +	{ "fusb302", NULL, fusb302_props },
> >  	{ "max17047", NULL, max17047_props },
> >  	{ "pi3usb30532" },
> >  	{ "displayport" },
> >  	{ "usb-role-switch" },
> > -	{ "connector", &nodes[0], usb_connector_props, usb_connector_refs },
> > +	{ "connector", &nodes[0], usb_connector_props },
> >  	{ }
> >  };
> >  
> > @@ -174,7 +166,13 @@ static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
> >  
> >  	data->mux = fwnode_handle_get(dev->fwnode);
> >  	put_device(dev);
> > -	mux_ref.node = to_software_node(data->mux);
> > +
> > +	/*
> > +	 * Update "usb-role-switch" property with real node. Note that we
> > +	 * rely on software_node_register_nodes() to use the original
> > +	 * instance of properties instead of copying them.
> > +	 */
> > +	fusb302_props[0].value.ref.node = to_software_node(data->mux);
> 
> There are other changes to this driver and to swnode.c in Rafael's
> tree, so if you send v2 soon, then please rebase on top of his devprop
> branch, or alternatively linux-next.

Yep, did that, will re-post series shortly.

-- 
Dmitry
