Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06995C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31812071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573770416;
	bh=KuxfeqX5EcXUqmt8/Zaj0gqsqVbQFp80jiduBQOv7LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YR+aS1hP3CLJpKxEE642+aAUwaTvwukD/vOMkKidALsq4FQaDdxKmCbH0SoANjJm/
	 dbJTdpeDGqj50qWXLsHSNWrqqZxpFGnFLos05Pv3M5CdN6a2X+T2TLTdP1ElbnkwmO
	 J9nfyKWBUFoYi+KSYN6c/H6gGEkd5qbmQxz2/iAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKNW0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:26:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35610 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNW0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:26:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id n19so2538452otk.2;
        Thu, 14 Nov 2019 14:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i/iNq2b5ltR+9fYOihLUMFxATvvS7Fy9uMXgDlcEfQM=;
        b=NVE+HRebP3baz91eW+CjVuW7RNFTm0rJGKz+FuM6X+QpcaCe7ABOF6PPXsWZy/D7OK
         b8ESzFmGDIm2dlFUsI84ZxO+qAxlJx7hRyCa0cYdr8hBnWgGh18H6YShCMlCyxgr2Dou
         c++/FscfdosaRQlcWqyNRhsHSSjeiZHMO/D+uu3jTv0LwuWZt2IjJK0Rq4jyU29PHKmd
         HeM/RJZOJpLKaM9OmEUGccl5f877n2Tpkq3J8M8KVGK725n2TEOHKxFq/+0Vt3xsJ9Mo
         WwzupHea42+RbjGahNrwV/IXVIOTA+fAvZ7ncyaWCINT2kdjhM477n4y+qHOTMTuv4RS
         NMSw==
X-Gm-Message-State: APjAAAVCEwVA06TPLvQB78A8T9tfzZlTsCYrx+THysdNfKJoEFfNG+bA
        7xwslNgRGFlIS3djD6x1YQ==
X-Google-Smtp-Source: APXvYqxsoZ0hyPff9ybgafyqCaAsP+RfF8L2i8yn9ePNs1IgLIi7Gjm2T8DnmYbHet+4hyZrOQyCVQ==
X-Received: by 2002:a05:6830:215a:: with SMTP id r26mr8512506otd.136.1573770413826;
        Thu, 14 Nov 2019 14:26:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y4sm2257755oie.42.2019.11.14.14.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 14:26:52 -0800 (PST)
Date:   Thu, 14 Nov 2019 16:26:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Message-ID: <20191114222652.GA7517@bogus>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
 <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112193653.GB13374@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:36:53AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 12, 2019 at 07:15:47PM +0000, Mark Brown wrote:
> > On Tue, Nov 12, 2019 at 11:03:28AM -0800, Dmitry Torokhov wrote:
> > > On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> > > > On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:
> > 
> > > > > +      interrupts:
> > > > > +        items:
> > > > > +          - description: main interrupt (attention) line.
> > > > > +          - description: dedicated wakeup interrupt.
> > > > > +        minItems: 1 # The wakeup interrupt is optional.
> > 
> > > > > +      interrupt-names:
> > > > > +        items:
> > > > > +          - const: irq
> > > > > +          - const: wakeup
> > > > > +        minItems: 1
> > 
> > > > How will this interact with a SPI device that defines interrupts at the
> > > > device level, possibly more than one of them?  Especially if the device
> > > > has its own idea what the interrupts should be called.
> > 
> > > My understanding that individual drivers should be able to override
> > > whatever the default behavior core has configured, and the device can
> > > establish their own mapping. We have this in I2C and I believe this
> > > works well.
> > 
> > > Is the concern about the device tree scheme or SPI core handling?
> > 
> > Both really.
> 
> So as I mentioned, the driver is not forced to use the interrupt
> supplied by the SPI core, and the worst thing is that the core
> configures the main IRQ as wakeirq and driver would need to call
> dev_pm_clear_wake_irq() before switching to correct one. I expect there
> will be just a few drivers needing that and many more would benefit from
> the default behavior and not needing to repeat the same boilerplate
> code.
> 
> As far as scheme goes - I hope that Rob could confirm that we can
> override number of interrupts and names in consumers of the binding, as
> needed.

This won't work. A device schema doesn't override what's defined here, 
but just further constrains this schema.

You could define a "spi irq" schema which devices can include if they 
want to, but I don't think this pattern is that common to SPI devices. 
There's not any spec behind compared to say alert irq for SMBus. 

The 'wakeup' irq name is standardized (for DT), but that's not SPI 
specific. About all we could define there is 'wakeup-source' is boolean 
and if there is more than one interrupt, one should be named 'wakeup'.

Rob

