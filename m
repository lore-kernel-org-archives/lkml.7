Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D37C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3147920859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfDVS1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:27:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48274 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVS1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:27:38 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E58DA263BB8;
        Mon, 22 Apr 2019 19:27:35 +0100 (BST)
Date:   Mon, 22 Apr 2019 20:27:32 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "joao.pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] i3c: fix i2c and i3c scl rate by bus mode
Message-ID: <20190422202732.0d539af3@collabora.com>
In-Reply-To: <13D59CF9CEBAF94592A12E8AE55501350A61C415@DE02WEMBXB.internal.synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
        <05fdeea79db83970e9ecb0d7045b4dd98f206f06.1555350118.git.vitor.soares@synopsys.com>
        <20190416075041.22f8e849@collabora.com>
        <13D59CF9CEBAF94592A12E8AE55501350A61596D@DE02WEMBXB.internal.synopsys.com>
        <20190416165250.0606e5a2@collabora.com>
        <13D59CF9CEBAF94592A12E8AE55501350A61B3B4@DE02WEMBXB.internal.synopsys.com>
        <20190422180715.40abe1b9@collabora.com>
        <13D59CF9CEBAF94592A12E8AE55501350A61C415@DE02WEMBXB.internal.synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 17:54:29 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> > > > > >       
> > > > > > >  {
> > > > > > >  	i3cbus->mode = mode;
> > > > > > >  
> > > > > > > -	if (!i3cbus->scl_rate.i3c)
> > > > > > > -		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> > > > > > > -
> > > > > > > -	if (!i3cbus->scl_rate.i2c) {
> > > > > > > -		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
> > > > > > > -			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
> > > > > > > -		else
> > > > > > > -			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> > > > > > > +	switch (i3cbus->mode) {
> > > > > > > +	case I3C_BUS_MODE_PURE:
> > > > > > > +		if (!i3cbus->scl_rate.i3c)
> > > > > > > +			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> > > > > > > +		break;
> > > > > > > +	case I3C_BUS_MODE_MIXED_FAST:
> > > > > > > +		if (!i3cbus->scl_rate.i3c)
> > > > > > > +			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> > > > > > > +		if (!i3cbus->scl_rate.i2c)
> > > > > > > +			i3cbus->scl_rate.i2c = i2c_scl_rate;
> > > > > > > +		break;
> > > > > > > +	case I3C_BUS_MODE_MIXED_SLOW:
> > > > > > > +		if (!i3cbus->scl_rate.i2c)
> > > > > > > +			i3cbus->scl_rate.i2c = i2c_scl_rate;
> > > > > > > +		i3cbus->scl_rate.i3c = i3cbus->scl_rate.i2c;      
> > > > > > 
> > > > > > Maybe we should do
> > > > > > 
> > > > > > 		if (!i3cbus->scl_rate.i3c ||
> > > > > > 		    i3cbus->scl_rate.i3c > i3cbus->scl_rate.i2c)
> > > > > > 			i3cbus->scl_rate.i3c = i3cbus->scl_rate.i2c;
> > > > > > 					   
> > > > > > Just in case the I3C rate forced by the user is lower than the max I2C
> > > > > > rate.      
> > > > > 
> > > > > That was something that I considered but TBH it isn't a real use case.    
> > > > 
> > > > Add a WARN_ON() to at least catch such inconsistencies. And maybe we
> > > > should add a dev_warn() when the user-defined rates do not match
> > > > the mode/LVR constraints. It's easy to do a mistake when writing a dts.    
> > > 
> > > I think the WARN_ON() is too evasive on the screen and won't provide the 
> > > information we want.
> > > The dev_warn() should work perfectly here.
> > > 
> > > 		if (i3cbus->scl_rate.i3c < i3cbus->scl_rate.i2c)
> > > 			dev_warn(&i3cbus->cur_master->dev->dev,
> > > 				     "%s: i3c-scl-hz lower then i2c-scl-hz\n",  __func__);  
> > 
> > Using dev_warn() sounds good, though I don't think you need the
> > __func__ here. Also, please print the i2c/i3c rates in the message, and
> > align the second line on the open parens.
> >   
> > > 		if (i3cbus->scl_rate.i2c != I3C_BUS_I2C_FM_SCL_RATE ||
> > > 		    i3cbus->scl_rate.i2c != I3C_BUS_I2C_FM_PLUS_SCL_RATE)
> > > 			dev_warn(&i3cbus->cur_master->dev->dev,
> > > 				     "%s: i2c-scl-hz not defined according MIPI I3C spec\n", 
> > > 				     __func__);  
> > 
> > Is that really a problem? Having an i2c rate that is less than FM speed
> > sounds like a valid case to me.  
> 
> I'm addressing the spec constrains.

"Table 57 I3C Timing Requirements When Communicating With I2C Legacy
Devices" says that freq can be between 0 and 400KHz when operating in
slow(FM) mode. Yes, maximum rate when not specified otherwise is
400Khz, but the point of overloading the max I2C/I3C spec is to allow
custom rates when the default/spec ones are not achievable, so I'm not
sure complaining in that case is legitimate.

We should definitely complain when one tries to set a maximum rate that
is higher than what devices can do (i3cbus->scl_rate.i2c >
max_i2c_scl_rate).

Same goes for I3C communications, we shouldn't care when the forced rate
is lower than what the bus is capable of, what's important is to
complain when it's higher than what's supported.
