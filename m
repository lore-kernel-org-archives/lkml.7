Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D195CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A970A21907
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCPQOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:14:25 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45088 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfCPQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:14:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 0296A9E7589;
        Sat, 16 Mar 2019 16:14:22 +0000 (GMT)
Date:   Sat, 9 Mar 2019 18:48:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Anderson Reis <andersonreisrosa@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <anderson.reis.rosa@usp.com>,
        Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [PATCH v2 3/4] iio:potentiostat:lmp91000: invert if statement
Message-ID: <20190309184809.3bbe694a@archlinux>
In-Reply-To: <20190309184615.54feca1d@archlinux>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
        <20190308194655.5983-4-anderson.reis.rosa@usp.com>
        <20190309184615.54feca1d@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2019 18:46:15 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri,  8 Mar 2019 16:46:54 -0300
> Anderson Reis <andersonreisrosa@gmail.com> wrote:
> 
> > Invert if statement arms in line 214, in order to make the code cleaner,
> > solve these checkpatch.pl CHECKs:
> > 
> > - lmp9100.c:214: CHECK: braces {} should be used on all arms of this statement
> > - lmp9100.c:216: CHECK: Unbalanced braces around else statement
> > 
> > Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> > Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>  
> Applied.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/potentiostat/lmp91000.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> > index c45cfb632649..1de17924e154 100644
> > --- a/drivers/iio/potentiostat/lmp91000.c
> > +++ b/drivers/iio/potentiostat/lmp91000.c
> > @@ -211,12 +211,11 @@ static int lmp91000_read_config(struct lmp91000_data *data)
> >  
> >  	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
> >  	if (ret) {
> > -		if (of_property_read_bool(np, "ti,external-tia-resistor"))
> > -			val = 0;
> > -		else {
> > +		if (!of_property_read_bool(np, "ti,external-tia-resistor"))
Spoke too soon. You didn't build test this.  Missing {

Fixed up.

Jonathan

> >  			dev_err(dev, "no ti,tia-gain-ohm defined");
> >  			return ret;
> >  		}
> > +		val = 0;
> >  	}
> >  
> >  	ret = -EINVAL;  
> 

