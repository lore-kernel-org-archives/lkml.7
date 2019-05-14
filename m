Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E49FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0629220881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sys806tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfENL6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:58:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46328 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:58:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so9002261pfm.13;
        Tue, 14 May 2019 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PHsvMzJ/ElifXzgRhZsQ2fxqtqxtZnYp1vf5e9YVI5c=;
        b=Sys806txaL2ePBILZweqrTyj/tSS09Jc7nVQUyTA0PGqBx2oRBDq8eHZqKL/+yTC1v
         C9s+uCYhwTxwR5sk+OHjTC/e+o+tJC/N+tu1UhAsj3lzqWBNolurjK0DQUPKpuQjC9uM
         oIkBwFzM3LZYAOsQiP/4dt1XNvgCY5gtbFziuE+91DClizTY9PwevdcI/79MNwZLqooA
         Ng9amy2EtA6lNXNRb9kdm0w6b6mf/FvAzLwSoyS5j1Ak1eSyl8z0HKIVFT7nDuBi7Gyo
         +f/dJyvYvly9BEq3A5Eg2NZLCqCrS0IJQATmuzHdtHvgDMERCauaKB9MunVy7XHDSVFn
         sBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PHsvMzJ/ElifXzgRhZsQ2fxqtqxtZnYp1vf5e9YVI5c=;
        b=TRhbRRygrxDAAj4kyuuIUVpd+3S3mnXVHQTyNie7NxM/1MZPjt/eaTJe71AXX9R5DV
         8JRpeq2wc2VsKmyFL8fby/+BTK9IOBaKAS3UKSl2miUyXwMkwye5mdy9D/j876zwV/Zg
         qD00xFdtwx+0119sEmiHeiHBQ6L4Gw1AXJ7nrvRHnYicXzgueJrCEdau/iFDc7fGFx7X
         Ir8AQBKZBcn83VcZGrFOzXvWWncYZAhtaBxIA6ngRTsESB2DT8AjZggNz24JTSDZFpsr
         QCNrowUqjXPKxhFMPYSsGYd8MHxGlvWrzmhGl5ByykbBejDbsD9X0Xgrg14r9J6htVJp
         U8lw==
X-Gm-Message-State: APjAAAWdcs5/olVCFl87K/zxUY5nHsnlJX2R27jpG1PaQUJn0FZ1Q9xJ
        XpOthCoydMg0WWcmPdTfgVE=
X-Google-Smtp-Source: APXvYqw+eortiWn2aXpMxovjjsbmczbuHxT991wDWHh/wTCrnK6Uilx/i1v/wyKdid5CUZ4C1bC6uA==
X-Received: by 2002:a65:56c3:: with SMTP id w3mr35624527pgs.232.1557835109722;
        Tue, 14 May 2019 04:58:29 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.gmail.com with ESMTPSA id y10sm19588597pff.4.2019.05.14.04.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:58:29 -0700 (PDT)
Date:   Tue, 14 May 2019 20:58:23 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usbip: Remove repeated setting of hcd->state in
 vhci_bus_suspend()
Message-ID: <20190514115822.GA2453@localhost.localdomain>
References: <20190506125550.7826-1-suwan.kim027@gmail.com>
 <440389ab-62c3-7bc2-0e9b-0b302a88c929@kernel.org>
 <20190507154918.GA2427@localhost.localdomain>
 <0ad76300-9b7f-f368-0533-1f88de649d10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad76300-9b7f-f368-0533-1f88de649d10@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 11:28:05AM -0600, shuah wrote:
> On 5/7/19 9:49 AM, Suwan Kim wrote:
> > Hi Shuah,
> > 
> > On Mon, May 06, 2019 at 09:13:02AM -0600, shuah wrote:
> > > On 5/6/19 6:55 AM, Suwan Kim wrote:
> > > > When hcd suspends execution, hcd_bus_suspend() calls vhci_bus_suspend()
> > > > which sets hcd->state as HC_STATE_SUSPENDED. But after calling
> > > > vhci_bus_suspend(), hcd_bus_suspend() also sets hcd->state as
> > > > HC_STATE_SUSPENDED.
> > > > So, setting hcd->state in vhci_hcd_suspend() is unnecessary.
> > > > 
> > > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > > ---
> > > >    drivers/usb/usbip/vhci_hcd.c | 4 ----
> > > >    1 file changed, 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > > > index 667d9c0ec905..e6f378d00fb6 100644
> > > > --- a/drivers/usb/usbip/vhci_hcd.c
> > > > +++ b/drivers/usb/usbip/vhci_hcd.c
> > > > @@ -1238,10 +1238,6 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
> > > >    	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
> > > > -	spin_lock_irqsave(&vhci->lock, flags);
> > > > -	hcd->state = HC_STATE_SUSPENDED;
> > > > -	spin_unlock_irqrestore(&vhci->lock, flags);
> > > > -
> > > >    	return 0;
> > > >    }
> > > > 
> > > 
> > > Tell me more about why you think this change is needed? How did you test
> > > this change?
> > 
> > I think that host controller specific functions, vhci_bus_resume()
> > or vhci_bus_suspend() in the case of vhci, usually process host
> > controller specific data (struct vhci_hcd) not a generic data
> > (struct usb_hcd). The generic data is usually processed by generic HCD
> > layer. But vhci_bus_resume() and vhci_bus_suspend() set generic data
> > (hcd->state) and moreover this variable is set in generic HCD layer
> > once again(hcd_bus_resume() and hcd_bus_suspend()).
> > 
> > So, i think host controller specific functions (vhci_bus_resume()
> > and vhci_bus_suspend()) don't need to set the generic data that is
> > "hcd->state = HC_STATE_RUNNING or HC_STATE_SUSPEND".
> > 
> 
> It depends. In this case, vhci_hcd is virtual driver and maintains
> port status for devices that are remote. It checks hcd->state in
> vhci_hub_status().
> 
> It updates the hcd->state in suspend with vhci->lock hold and checks
> status from vhci_hub_status(). Removing updating hcd->state from
> vhci_bus_suspend()will open a window where vhci_hub_status() might
> find it wrong state.
> 

I didn't know that and I missed. Thank you for pointing out my fault.
I agree that removing updating hcd->state which is protected by vhci
lock is not correct.

But I still have not fully understood the relationship between
vhci_bus_suspend() and vhci_hub_status() yet. I will look at it in
more detail. Again, thank you for reviewing my patch.

Regards

Suwan Kim
