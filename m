Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C95BC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CB42339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567583924;
	bh=eQJoRYxz3mDb8fvKOmbNYK16DrykSDmjb38YODdG02Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YfmTU4OOXdhg9NVt6Dgv49KnykNnDAvPhS2uiQxxf2Xvr+Wr3smTCF1rxknzCsokZ
	 HTC430pMfDQrv45jictHjzt6YnXOdzPCyaixdeAoaKQbV8MoM6oNmfTqUbKE/GaNY3
	 LSn/ZRs9RuwnA6uPaKAv+N6Ijxs2jpVOcn/+Zt5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfIDH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfIDH6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:58:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529FE20820;
        Wed,  4 Sep 2019 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567583921;
        bh=eQJoRYxz3mDb8fvKOmbNYK16DrykSDmjb38YODdG02Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y512PAzUx2FFwBtxUBv//JpU4QLdQSmJY0B8fdz/BM+RaW0rNqa7Ht/w0eZ59mwtA
         EhYgyT+gkuyIyotLPK/rb6C1B2zBFkolrEyTtPTVYTO7YzNkpUVLLx3+Od024C+FKN
         yFgvuwMHUoPhHHG95iW4SBQ4RvT7EyTFB6HDyDzk=
Date:   Wed, 4 Sep 2019 09:58:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Jacky.Cao@sony.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Kento.A.Kobayashi@sony.com
Subject: Re: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Message-ID: <20190904075839.GA28042@kroah.com>
References: <16EA1F625E922C43B00B9D82250220500871C862@APYOKXMS108.ap.sony.com>
 <87sgpcmr7v.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgpcmr7v.fsf@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 10:54:28AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> <Jacky.Cao@sony.com> writes:
> 
> > The power budget for SuperSpeed mode should be 900 mA
> > according to USB3.0 specification, so set the power
> > budget to 900 mA for dummy_start_ss which is only used
> > for SuperSpeed mode.
> >
> > If the max power consumption of SuperSpeed device is
> > larger than 500 mA, insufficient available bus power
> > error happens in usb_choose_configuration function
> > when the device connects to dummy hcd.
> >
> > Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
> > ---
> > drivers/usb/gadget/udc/dummy_hcd.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> > index 8414fac..52f2cf5 100644
> > --- a/drivers/usb/gadget/udc/dummy_hcd.c
> > +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> > @@ -48,6 +48,7 @@
> > #define DRIVER_VERSION "02 May 2005"
> >
> >  #define POWER_BUDGET  500  /* in mA; use 8 for low-power port testing */
> > +#define POWER_BUDGET_3_0  900  /* in mA */
> >
> >  static const char  driver_name[] = "dummy_hcd";
> > static const char  driver_desc[] = "USB Host+Gadget Emulator";
> > @@ -2432,7 +2433,7 @@ static int dummy_start_ss(struct dummy_hcd *dum_hcd)
> >      dum_hcd->rh_state = DUMMY_RH_RUNNING;
> >      dum_hcd->stream_en_ep = 0;
> >      INIT_LIST_HEAD(&dum_hcd->urbp_list);
> > -     dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET;
> > +     dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET_3_0;
> >      dummy_hcd_to_hcd(dum_hcd)->state = HC_STATE_RUNNING;
> >      dummy_hcd_to_hcd(dum_hcd)->uses_new_polling = 1;
> > #ifdef CONFIG_USB_OTG
> 
> Alan, I suppose you're okay with this change?

I'm not ok with the whitespace damage making this patch impossible to
apply :)

