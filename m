Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE018C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D21D20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yz+3dqmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCICRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 21:17:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36394 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfCICRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 21:17:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so15440533pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 18:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LWU1MdRnb2VUKD0yC9of3vgG/47n3sRrwmND8NfGd4s=;
        b=Yz+3dqmK+1R/fURhktJmOoxzwAUcrBhy7kMqISUG5NtCqpr4VSgzvLPf4v7jZIYikG
         Wqrvp1KDkrkVoqB3smHhNazFSKQClohchIo7dLj+gmuUB1itb0YaD6KVU/9VqTZBsgIy
         x9+pYq72aLQHBQ4jEnR8IZXzyZaKJ0ZNoYqnTWirjvxBUR3NRIoD/bXouNOYrvzv5FGC
         klHmOnfwNf68iKTMPo9XcVVjXotobrZnGEadi2soiOL3+GsTzT+upTlp8dMo7974b4R6
         i53tdSPNtChpi3eOU1I95usMMWWp9E7gFN7C0oK6O31ZdQ4icN300uTg/f3GbkSjg7+Q
         sKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LWU1MdRnb2VUKD0yC9of3vgG/47n3sRrwmND8NfGd4s=;
        b=Rk5Ic8gh+xXF5L/bPaY6/HioseIMk7bJbGRR1hmD46P9bAdVlX9KEKEEKsg5rvKDWV
         mGjWJjf8o3+GeWSrhtkuxPonRa9vJAdgaf1EHokvyNxj++S8PwTfISkh4e9UDSQ422gl
         N1G3hMwQV3UQFCtN38CseEfLA/xoCSQ4QhBKEfR0NIJFi0pxxtaMr9tnLGq5Wyuzlt58
         iIEGGXcpCDEGq0swZELJecmYFt9QWuJo6/qV5M6RIQ2GzxVFf3p0b6pWAb9A8tcVv9R+
         PsxK9dMAtLj2iZ33DWWxIUuc3KKHuwCpStrcuckOvBtPxe7SbJyPfbop1QaIeEKh6P9B
         GAjQ==
X-Gm-Message-State: APjAAAUdBEd2tiZgH4q96yb86uDVCvtG1sk8AKTlwaQB8GDxD2PlMDgR
        cRhE9C6JbVDLhP1J1sjhb3Du
X-Google-Smtp-Source: APXvYqya9UDjiu9GHaX8oUU1TI6Q1dLRENXsEsRyjnjD1vW2yH9mOdY/a1jn9HH1gjvGsmvAh7yvrg==
X-Received: by 2002:aa7:81d7:: with SMTP id c23mr22326689pfn.146.1552097869215;
        Fri, 08 Mar 2019 18:17:49 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:730b:185a:e100:cbb9:245b:912c])
        by smtp.gmail.com with ESMTPSA id p11sm30212941pfi.10.2019.03.08.18.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 18:17:48 -0800 (PST)
Date:   Sat, 9 Mar 2019 07:47:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/15] ARM: actions: fix a leaked reference by adding
 missing of_node_put
Message-ID: <20190309021742.GA5664@Mani-XPS-13-9360>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <20190305114048.egpbeddy4pqbwl5b@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305114048.egpbeddy4pqbwl5b@shell.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

On Tue, Mar 05, 2019 at 11:40:48AM +0000, Russell King - ARM Linux admin wrote:
> On Tue, Mar 05, 2019 at 07:33:52PM +0800, Wen Yang wrote:
> > The call to of_get_next_child returns a node pointer with refcount
> > incremented thus it must be explicitly decremented after the last
> > usage.
> > 
> > Detected by coccinelle with the following warnings:
> > ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
> > ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
> > ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.
> 
> I question this.  Your reasoning is that the node is no longer used
> so the reference count needs to be put.
> 
> However, in all these cases, data is read from the nodes properties
> and the device remains in-use for the life of the kernel.  There is
> a big difference here.
> 
> With normal drivers, each device is bound to their associated device
> node associated with the device.  When the device node goes away, then
> the corresponding device goes away too, which causes the driver to be
> unbound from the device.
> 
> However, there is another class of "driver" which are the ones below,
> where they are "permanent" devices.  These can never go away, even if
> the device node refcount hits zero and the device node is freed - the
> device is still present and in-use in the system.  So, having the
> device node refcount hit zero is actually a bug: what that's saying
> is the system device (eg, SCU) has gone away.  If you somehow were to
> remove the SCU from the system, you'd end up severing the connection
> between the CPU cores and the rest of the system - obviously resulting
> in a dead system!
> 
> So, what is the point of dropping these refcounts for devices that can
> never go away - and thus their associated device_node should also never
> go away?
> 

Yes, practically we would never hit this case but theoretically we should
decrement the refcount for nodes/properties whenever we are done with it.
As you know, there are 'n' number of places in kernel where we can see the
refcount not being put after use. So I would welcome these kind of patches
to set an example for someone who tries to use the of_* calls in future.

IMO, DT should've handled the refcount internally without exposing the
pointers to external world.

Thanks,
Mani

> > 
> > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: "Andreas Färber" <afaerber@suse.de>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > v2->v1: add a missing space between "adding" and "missing"
> > 
> >  arch/arm/mach-actions/platsmp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
> > index 4fd479c..1a8e078 100644
> > --- a/arch/arm/mach-actions/platsmp.c
> > +++ b/arch/arm/mach-actions/platsmp.c
> > @@ -107,6 +107,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
> >  	}
> >  
> >  	timer_base_addr = of_iomap(node, 0);
> > +	of_node_put(node);
> >  	if (!timer_base_addr) {
> >  		pr_err("%s: could not map timer registers\n", __func__);
> >  		return;
> > @@ -119,6 +120,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
> >  	}
> >  
> >  	sps_base_addr = of_iomap(node, 0);
> > +	of_node_put(node);
> >  	if (!sps_base_addr) {
> >  		pr_err("%s: could not map sps registers\n", __func__);
> >  		return;
> > @@ -132,6 +134,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
> >  		}
> >  
> >  		scu_base_addr = of_iomap(node, 0);
> > +		of_node_put(node);
> >  		if (!scu_base_addr) {
> >  			pr_err("%s: could not map scu registers\n", __func__);
> >  			return;
> > -- 
> > 2.9.5
> > 
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
