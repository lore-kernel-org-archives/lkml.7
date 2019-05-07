Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295BF20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goKQZpJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfEGPt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:49:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42496 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:49:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so8561344pfw.9;
        Tue, 07 May 2019 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5krD9NT9alu9gIlh41d2nn1JTyOAXbicmzmxHqAAuQA=;
        b=goKQZpJSIKypj13QnqEWH9HgJQax9v6Gs6+70tHtU6E8DKMapxtS7dQXdXf1qIBqk5
         uWQdOcIzS9mKnSX6lsPbQVdeaP4MeIgsOOn1n/CqU9jGx3M54L6rBinbruoeIV0vl0VG
         mGDOp5NIsMXaHBai2PfkQBO2HsNk6iWGpbPweu0pMTiaTr8meLSseKxv2sB4N2QsiZZ1
         C5hToGw7DBh/GUroYq6v0RhkSWbiuZGMErZGuG6YglxpLf3R6HEtr7An+CdpwkAYm4c5
         Khs06DnrXudOQvESv6uKKS2dkD+G6zXX8qJoZmKIk3EEw7sLcS5S8v8xjrWmzf74rjVo
         v9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5krD9NT9alu9gIlh41d2nn1JTyOAXbicmzmxHqAAuQA=;
        b=qb4/hEm+dRwOxmsa/4IiKccDCVla7HvFPjljaOl9b/J0g0vlbKLFfFzXejuW4Ffist
         bIJrqV/hazrxOj/efkEPgo34oJFvxFmWDrLEs4eRRxGVCOb/O0rnPZH/Y3xWpg7+c652
         aA+J5Qzl6e2W86dRy9jC2HjCteJ7jpti3s2Z58wkxOTGVq7T5kgj8WZaw4Axpv/rkBhZ
         I2ueYm8vzxHVGeH8fDtxtQNRRp3y1WRp5PcTWozn6scnJiyFhsbHu8RSPMDwMRmlIe7u
         fWR3hk6oIOFT2g0Pt9bI5Ic89DrRodXpQP/JwvXTyPOPJo1JOSF9fc88wPR4TSkT+/kC
         hMHg==
X-Gm-Message-State: APjAAAUUUTy7+TzzpuJRzpOwqsJ3riS+LSarbhXhT8Wforx9/86ZtFrh
        f9uOUlwBQLad6RQo66cdVAE=
X-Google-Smtp-Source: APXvYqy3Dvzt/y3qs8YVxFJobky73JZyW1ri5VzLovQ0uYZ55Wm/lH6FQatB4BSnwqVNgBEO29sMQQ==
X-Received: by 2002:a62:2a97:: with SMTP id q145mr42788093pfq.22.1557244164945;
        Tue, 07 May 2019 08:49:24 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id i3sm21127516pfa.90.2019.05.07.08.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 08:49:24 -0700 (PDT)
Date:   Wed, 8 May 2019 00:49:19 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usbip: Remove repeated setting of hcd->state in
 vhci_bus_suspend()
Message-ID: <20190507154918.GA2427@localhost.localdomain>
References: <20190506125550.7826-1-suwan.kim027@gmail.com>
 <440389ab-62c3-7bc2-0e9b-0b302a88c929@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440389ab-62c3-7bc2-0e9b-0b302a88c929@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Mon, May 06, 2019 at 09:13:02AM -0600, shuah wrote:
> On 5/6/19 6:55 AM, Suwan Kim wrote:
> > When hcd suspends execution, hcd_bus_suspend() calls vhci_bus_suspend()
> > which sets hcd->state as HC_STATE_SUSPENDED. But after calling
> > vhci_bus_suspend(), hcd_bus_suspend() also sets hcd->state as
> > HC_STATE_SUSPENDED.
> > So, setting hcd->state in vhci_hcd_suspend() is unnecessary.
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> >   drivers/usb/usbip/vhci_hcd.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 667d9c0ec905..e6f378d00fb6 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -1238,10 +1238,6 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
> >   	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
> > -	spin_lock_irqsave(&vhci->lock, flags);
> > -	hcd->state = HC_STATE_SUSPENDED;
> > -	spin_unlock_irqrestore(&vhci->lock, flags);
> > -
> >   	return 0;
> >   }
> > 
> 
> Tell me more about why you think this change is needed? How did you test
> this change?

I think that host controller specific functions, vhci_bus_resume()
or vhci_bus_suspend() in the case of vhci, usually process host
controller specific data (struct vhci_hcd) not a generic data
(struct usb_hcd). The generic data is usually processed by generic HCD
layer. But vhci_bus_resume() and vhci_bus_suspend() set generic data
(hcd->state) and moreover this variable is set in generic HCD layer
once again(hcd_bus_resume() and hcd_bus_suspend()).

So, i think host controller specific functions (vhci_bus_resume()
and vhci_bus_suspend()) don't need to set the generic data that is
"hcd->state = HC_STATE_RUNNING or HC_STATE_SUSPEND".

For test, I loaded vhci-hcd module, suspended and resumed my computer
and checked hcd->state variable. There is no difference compared with
not modified version because my patch just removes repeated and
unnecessary part.

Regards

Suwan Kim
