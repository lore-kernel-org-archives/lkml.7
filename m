Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59477C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFCB2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfDPOwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:52:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50954 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDPOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:52:55 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 848F3281040;
        Tue, 16 Apr 2019 15:52:53 +0100 (BST)
Date:   Tue, 16 Apr 2019 16:52:50 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] i3c: fix i2c and i3c scl rate by bus mode
Message-ID: <20190416165250.0606e5a2@collabora.com>
In-Reply-To: <13D59CF9CEBAF94592A12E8AE55501350A61596D@DE02WEMBXB.internal.synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
        <05fdeea79db83970e9ecb0d7045b4dd98f206f06.1555350118.git.vitor.soares@synopsys.com>
        <20190416075041.22f8e849@collabora.com>
        <13D59CF9CEBAF94592A12E8AE55501350A61596D@DE02WEMBXB.internal.synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 14:24:57 +0000
Vitor Soares <vitor.soares@synopsys.com> wrote:

> Hi Boris,
> 
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Date: Tue, Apr 16, 2019 at 06:50:41
> 
> > On Mon, 15 Apr 2019 20:46:41 +0200
> > Vitor Soares <vitor.soares@synopsys.com> wrote:
> >   
> > > Currently in case of mixed slow bus topologie and all i2c devices
> > > support FM+ speed, the i3c subsystem limite the SCL to FM speed.  
> >   
> 
> I will it replace with your message below.
> 
> > "
> > Currently the I3C framework limits SCL frequency to FM speed when
> > dealing with a mixed slow bus, even if all I2C devices are FM+ capable.
> > "
> >   
> > > Also in case on mixed slow bus mode the max speed for both
> > > i2c or i3c transfers is FM or FM+.  
> > 
> > Looks like you're basically repeating what you said above.  
> 
> What I meant was that I3C framework isn't limiting the I3C speed in case 
> of mixed slow bus.

Oh, okay, then maybe something like

"
The core was also not accounting for I3C speed limitations when
operating in mixed slow mode and was erroneously using FM+ speed as the
max I2C speed when operating in mixed fast mode.
"

> 
> >   
> > > 
> > > This patch fix the definition of i2c and i3c scl rate based on bus  
> > 
> > 	     ^fixes					      on the bus
> >   
> > > topologie and LVR[4] if no user input.  
> > 
> >   ^topology		^if the rate is not already specified by the user.
> >   
> > > In case of mixed slow mode the i3c scl rate is overridden.  
> > 
> > 							   ^ with the max
> > I2C rate.
> >   
> > > 
> > > Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > Cc: Boris Brezillon <bbrezillon@kernel.org>
> > > Cc: <stable@vger.kernel.org>
> > > Cc: <linux-kernel@vger.kernel.org>
> > > ---
> > >  drivers/i3c/master.c | 39 +++++++++++++++++++++++++--------------
> > >  1 file changed, 25 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > index 909c2ad..1c4a86a 100644
> > > --- a/drivers/i3c/master.c
> > > +++ b/drivers/i3c/master.c
> > > @@ -564,20 +564,30 @@ static const struct device_type i3c_masterdev_type = {
> > >  	.groups	= i3c_masterdev_groups,
> > >  };
> > >  
> > > -int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode)
> > > +int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
> > > +		     unsigned long i2c_scl_rate)  
> > 
> > 
> > Can we rename the last arg into max_i2c_scl_rate?  
> 
> The i2c_scl_rate is base on LVR[4] bit and the user can set a higher scl 
> rate, this is reason I didn't named it to max_i2c_scl_rate.
> But if you think that make more sense I'm ok with that.

In this context it does encode the maximum rate allowed by the spec
(based on LVR parsing), so max_i2c_rate sounds like a correct name to
me.

> 
> >   
> > >  {
> > >  	i3cbus->mode = mode;
> > >  
> > > -	if (!i3cbus->scl_rate.i3c)
> > > -		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> > > -
> > > -	if (!i3cbus->scl_rate.i2c) {
> > > -		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
> > > -			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
> > > -		else
> > > -			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> > > +	switch (i3cbus->mode) {
> > > +	case I3C_BUS_MODE_PURE:
> > > +		if (!i3cbus->scl_rate.i3c)
> > > +			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> > > +		break;
> > > +	case I3C_BUS_MODE_MIXED_FAST:
> > > +		if (!i3cbus->scl_rate.i3c)
> > > +			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> > > +		if (!i3cbus->scl_rate.i2c)
> > > +			i3cbus->scl_rate.i2c = i2c_scl_rate;
> > > +		break;
> > > +	case I3C_BUS_MODE_MIXED_SLOW:
> > > +		if (!i3cbus->scl_rate.i2c)
> > > +			i3cbus->scl_rate.i2c = i2c_scl_rate;
> > > +		i3cbus->scl_rate.i3c = i3cbus->scl_rate.i2c;  
> > 
> > Maybe we should do
> > 
> > 		if (!i3cbus->scl_rate.i3c ||
> > 		    i3cbus->scl_rate.i3c > i3cbus->scl_rate.i2c)
> > 			i3cbus->scl_rate.i3c = i3cbus->scl_rate.i2c;
> > 					   
> > Just in case the I3C rate forced by the user is lower than the max I2C
> > rate.  
> 
> That was something that I considered but TBH it isn't a real use case.

Add a WARN_ON() to at least catch such inconsistencies. And maybe we
should add a dev_warn() when the user-defined rates do not match
the mode/LVR constraints. It's easy to do a mistake when writing a dts.
