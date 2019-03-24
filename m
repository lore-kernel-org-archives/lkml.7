Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBACC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37DE20989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfCXRXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:23:01 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38974 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:23:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8708E9E7723;
        Sun, 24 Mar 2019 17:22:58 +0000 (GMT)
Date:   Sun, 24 Mar 2019 17:22:56 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: light: vcnl4000 add devicetree hooks
Message-ID: <20190324172256.79742403@archlinux>
In-Reply-To: <20190324171930.7580e6bb@archlinux>
References: <20190321154047.23236-1-angus@akkea.ca>
        <20190321154047.23236-3-angus@akkea.ca>
        <20190324171930.7580e6bb@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 17:19:30 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 21 Mar 2019 08:40:44 -0700
> "Angus Ainslie (Purism)" <angus@akkea.ca> wrote:
> 
> > Add an of_match table for devicetree probing.
> > 
> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>  
> 
> I made a small tweak (see inline) for an issue I'd missed
> previously (which is pretty obscure!)
> 
> Jonathan
> > ---
> >  drivers/iio/light/vcnl4000.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 5e0a8eb83ebc..308cb2d2b641 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -363,9 +363,31 @@ static int vcnl4000_probe(struct i2c_client *client,
> >  	return devm_iio_device_register(&client->dev, indio_dev);
> >  }
> >  
> > +static const struct of_device_id vcnl_4000_of_match[] = {
> > +	{
> > +		.compatible = "vishay,vcnl4000",
> > +		.data = "VCNL4000",
> > +	},
> > +	{
> > +		.compatible = "vishay,vcnl4010",
> > +		.data = "VCNL4010",
> > +	},
> > +	{
> > +		.compatible = "vishay,vcnl4010",
> > +		.data = "VCNL4020",
> > +	},
> > +	{
> > +		.compatible = "vishay,vcnl4200",
> > +		.data = "VCNL4200",
> > +	},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, vcnl4000_of_match);
vcnl_4000_of_match.

Fixed up.
> > +
> >  static struct i2c_driver vcnl4000_driver = {
> >  	.driver = {
> >  		.name   = VCNL4000_DRV_NAME,
> > +		.of_match_table = of_match_ptr(vcnl_4000_of_match),  
> Ah. I'd missed this previously.  Don't use the of_match_ptr
> magic anymore. It prevents ACPI probing via the weird
> DSDT entry that basically says "here be devicetree".
> >  	},
> >  	.probe  = vcnl4000_probe,
> >  	.id_table = vcnl4000_id,  
> 

