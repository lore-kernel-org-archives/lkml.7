Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A8FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A9B2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552156486;
	bh=flmMOEoEdSmSBfc7ltQFCjwpzDC1bz5Oi6wc1NnW0i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=18oQfSskJCQKB6c+XMqEGiqD/N5mc3pDC+4lQHWaU2JZsYyu9YKylafg9zIWYdP3q
	 nKAIII06eaIct4z+A62YJ+EaefpCbEJ2e0EJgUtOLZxfdCqplWSsoaWKp3fE8VyVb+
	 txYrv0cYFJXZn5jRU9/g9M70IQFD0egOA4SX6oJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfCISeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfCISeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:34:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8F3207E0;
        Sat,  9 Mar 2019 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552156483;
        bh=flmMOEoEdSmSBfc7ltQFCjwpzDC1bz5Oi6wc1NnW0i8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ef8CqWZNrYs7uxoff89lnsMQrpfurEyteZqYsCqPUIpjH2kjzfc1wwG7ndZtGKToh
         23p+alM7FZZKvXuXOYNPWTuu8/P5kRRvp4D8kXxhHOZOhjRDyT/gDVLq9YZuJIMRjy
         9LInmNB74ivy96meOC2lhl2u9SB6cEdpoIJEhNI0=
Date:   Sat, 9 Mar 2019 18:34:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stefan Agner <stefan@agner.ch>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: max9611: fix a NULL pointer dereference
Message-ID: <20190309183437.479f90a1@archlinux>
In-Reply-To: <20190309151916.GB7820@arch>
References: <20190309045141.8015-1-kjlu@umn.edu>
        <20190309151916.GB7820@arch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2019 16:19:17 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Fri, Mar 08, 2019 at 10:51:40PM -0600, Kangjie Lu wrote:
> > of_match_device may return NULL when it fails, and in this case,
> > there will be a NULL pointer dereference. The fix returns
> > EINVAL when of_match_device returns NULL.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> >  drivers/iio/adc/max9611.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > index 917223d5ff5b..531b6614ea29 100644
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -524,13 +524,16 @@ static int max9611_probe(struct i2c_client *client,
> >  {
> >  	const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
> >  	const struct device_node *of_node = client->dev.of_node;
> > -	const struct of_device_id *of_id =
> > -		of_match_device(max9611_of_table, &client->dev);  
> 
> Given we got to this point how this can go wrong?

If this is to squash a warning then there may be some argument
even though it can't actually fail.  If there is such a warning
please put it in the patch description.

Thanks,

Jonathan

> 
> > +	const struct of_device_id *of_id;
> >  	struct max9611_dev *max9611;
> >  	struct iio_dev *indio_dev;
> >  	unsigned int of_shunt;
> >  	int ret;
> >
> > +	of_id = of_match_device(max9611_of_table, &client->dev);
> > +	if (!of_id)
> > +		return -EINVAL;
> > +
> >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max9611));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > --
> > 2.17.1
> >  

