Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AC8C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C0922DCB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TEAP3bpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfHTIxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:53:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43934 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHTIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:53:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id h13so5421857edq.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rFIJ9CTcB3zRGvI8JWfGMI7wV/Ot4grZu8ZTczPSunk=;
        b=TEAP3bpzzRE8sLuo6bjthjn4uBQj17oZOmXs9NUKZDzQmDPysXh9j1Sc7lAwe+WBm1
         iz2asO2EefZ8HNbs7NP3PUjo29tnfB6SGl0RQsE9aypaHsu2BDLeZRHHpCrQc5W8r6ku
         AYgxr5zTTqajJ0NunF6ZRP2PB9VMhsdfiQyio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rFIJ9CTcB3zRGvI8JWfGMI7wV/Ot4grZu8ZTczPSunk=;
        b=Oh6RnIwqR7e+NADIGOU9F/O+a+9mwzhXVitEoMtEcZsZ8PDr7KfTWA8PeRiZIqOaZN
         W3+AmuRzXEkegHhTQPJC25jt4S4Dow65dOWsyBJ307E7aqTKTOs47514ITPVWMXxLn2F
         bPoVeGG6NNTdri7aHDKaTyIMsk+tkrMfRLfodEcsLtIKSeY8u0Bm6yCvKjrj4f8B2H8T
         NLTm96caDzGblcbUhrecEcCVkh1wHTPoGSJbCa2W4h/lVQZ+pdhjFQ5r0KCMqrtB2VUM
         BR84Jca46i5jrZ4sRcuRygu7A1OWjks/OLUa+AnY3zywIlnswRxMAhiGfEQxMJHoBL9a
         kc4g==
X-Gm-Message-State: APjAAAWAHLbEnd/AuDxTbhFiAeeMKKeXNO+mgwXR6oMj17D/OM8ojsfj
        iffntPK5vT3VbWbXBNtXt9Zq0g==
X-Google-Smtp-Source: APXvYqxaCnyav32Ke+uW+TN66XMsXgz8+9CXwxRl1NuQkfHVVRBs3AbB+FY2yTv6GNv7ug1zoaKxlw==
X-Received: by 2002:aa7:db12:: with SMTP id t18mr24139903eds.266.1566291212120;
        Tue, 20 Aug 2019 01:53:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id va28sm2482422ejb.36.2019.08.20.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:53:31 -0700 (PDT)
Date:   Tue, 20 Aug 2019 10:53:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "Togorean, Bogdan" <Bogdan.Togorean@analog.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "matt.redfearn@thinci.com" <matt.redfearn@thinci.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] drm: bridge: adv7511: Add support for ADV7535
Message-ID: <20190820085329.GC11147@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        "Togorean, Bogdan" <Bogdan.Togorean@analog.com>,
        "Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "matt.redfearn@thinci.com" <matt.redfearn@thinci.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20190809141611.9927-1-bogdan.togorean@analog.com>
 <20190809141611.9927-3-bogdan.togorean@analog.com>
 <20190809152510.GA23265@ravnborg.org>
 <c99cfbd3dc45bb02618e7653c33022f3553e1cce.camel@analog.com>
 <20190819104616.GA15890@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819104616.GA15890@ravnborg.org>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:46:16PM +0200, Sam Ravnborg wrote:
> Hi Bogdan.
> 
> > > >  		adv7533_detach_dsi(adv7511);
> > > >  	i2c_unregister_device(adv7511->i2c_cec);
> > > >  	if (adv7511->cec_clk)
> > > > @@ -1266,8 +1278,9 @@ static const struct i2c_device_id
> > > > adv7511_i2c_ids[] = {
> > > >  	{ "adv7511", ADV7511 },
> > > >  	{ "adv7511w", ADV7511 },
> > > >  	{ "adv7513", ADV7511 },
> > > > -#ifdef CONFIG_DRM_I2C_ADV7533
> > > > +#ifdef CONFIG_DRM_I2C_ADV753x
> > > >  	{ "adv7533", ADV7533 },
> > > > +	{ "adv7535", ADV7535 },
> > > >  #endif
> > > 
> > > This ifdef may not be needed??
> > > If we did not get this type we will not look it up.
> > But if we have defined in DT adv7533/5 device but
> > CONFIG_DRM_I2C_ADV753x not selected probe will fail with ENODEV. That
> > would be ok?
> 
> What do we gain from this complexity in the end.
> Why not let the driver always support all variants.
> 
> If this result in a simpler driver, and less choices in Kconfig
> then it is a win-win.

Yeah in general we don't Kconfig within drivers in drm to disable specific
code-paths. It's not worth the pain.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
