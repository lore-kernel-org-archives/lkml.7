Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C59C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D97920823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3qgtyV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfFSIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:16:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44385 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731213AbfFSIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:16:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so9202248pgp.11;
        Wed, 19 Jun 2019 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v129+ZmLYPT0Qs610F/+KFD490TqCFT77Vj5+nBNN28=;
        b=M3qgtyV4AQr65r2pR1XmxMysyqRVsRmXoqrZFpp9C6zTvsQyKmyphn+6AiqPxTOdAH
         GCRRu24W/izWtCCzJFP6u6UQieHtTtp0qqTrZexVYMkd7yTbbrh8vgbSrR4Kn4Vdg9+A
         QWg4sDNEf3lZe8+jA3hazKFgNMOAfdapUL9f3l+tdDT6CC4rd8MbUMPM+ZLX2NeF9rLt
         etQbZ+g8R4qczgqml/JlfBZM4KSiK0a4+k2efumXahIGq6HnPrLUjXEGfg91nT0xgt6l
         URrAu1aqdjXKyeUckE/effvcdPFBchJe7vjkuPnRqTprmS0TxjeCBmt3mAclkLSoXOfi
         jxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v129+ZmLYPT0Qs610F/+KFD490TqCFT77Vj5+nBNN28=;
        b=AmD9B1b7xlMziihkS0WSYzdbAutrJpSGWFHW7Qb9mDPb1V3L407cGQcdzBCkxAeDYJ
         G3r06BIkTigMc9WBkjVQigm83a0wZ3TKGGC1Gua+KT0tQfnQ/oBrOymhCGWLTUPkyryF
         RYlymmgdks/FZV/yXNZQOYeTwy6Wfkf8k60oEb+afdadTgy70KfAfHweKyS5e18fkD0x
         wGOvK7v1R/T4e5l8kgMNZ8mSMuzP9bPO7U9fZg9icWSybuAw7gmW8orHp8rv3pRnzWyY
         BSmqOiEGUec2YuMEKTa7OdTr9GgGcVJiU8D94X2tR5U/lgS12j85l60vC9NrUFJ/F5jd
         AJyw==
X-Gm-Message-State: APjAAAUUdmTB3AbrbciIIa1dOR+JripUyBaNAq3zXafpi2CL60fyJ6pv
        SBGGCz0axizjKYZKWVv2ccg=
X-Google-Smtp-Source: APXvYqy46mmCmfahU0kewqo7z+Wo2ByFUBKVQhnj602dEah1sJEMMpRJq+iwu/9ERzcbE0ZNLHP96A==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr6962738pgd.442.1560932208474;
        Wed, 19 Jun 2019 01:16:48 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.gmail.com with ESMTPSA id u1sm15769414pgr.94.2019.06.19.01.16.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:16:48 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:16:42 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: Implement map_urb_for_dma function for vhci to
 skip dma mapping
Message-ID: <20190619081641.GA2387@localhost.localdomain>
References: <20190618142817.16844-1-suwan.kim027@gmail.com>
 <Pine.LNX.4.44L0.1906181129450.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.1906181129450.1659-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:30:34AM -0400, Alan Stern wrote:
> On Tue, 18 Jun 2019, Suwan Kim wrote:
> 
> > vhci doesn’t do dma for remote device. Actually, the real dma
> > operation is done by network card driver. So, vhci doesn’t use and
> > need dma address of transfer buffer of urb.
> > 
> > But hcd provides dma mapping function by defualt in usb_hcd_submit_urb()
> > and it causes unnecessary dma mapping which will be done again at
> > NIC driver and it wastes CPU cycles. So, implement map_urb_for_dma
> > function for vhci in order to skip the dma mapping procedure.
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> >  drivers/usb/usbip/vhci_hcd.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 667d9c0ec905..9df4d9e36788 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -1287,6 +1287,13 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
> >  	return 0;
> >  }
> >  
> > +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > +			    gfp_t mem_flags)
> > +{
> > +	dev_dbg(hcd->self.controller, "vhci does not map urb for dma\n");
> > +	return 0;
> > +}
> > +
> >  static const struct hc_driver vhci_hc_driver = {
> >  	.description	= driver_name,
> >  	.product_desc	= driver_desc,
> > @@ -1302,6 +1309,7 @@ static const struct hc_driver vhci_hc_driver = {
> >  	.urb_dequeue	= vhci_urb_dequeue,
> >  
> >  	.get_frame_number = vhci_get_frame_number,
> > +	.map_urb_for_dma = vhci_map_urb_for_dma,
> >  
> >  	.hub_status_data = vhci_hub_status,
> >  	.hub_control    = vhci_hub_control,
> 
> If the goal is to avoid wasting CPU cycles, you probably should have a 
> vhci_unmap_urb_for_dma routine as well.

I missed that. Thank you for pointing it out.
I will send v2 including unmap function.

Regards

Suwan Kim
