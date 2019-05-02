Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2E6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B8A204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4niFnqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBSmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:42:52 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45235 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:42:51 -0400
Received: by mail-vk1-f195.google.com with SMTP id h127so769608vkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rep+RFn3BdJQf0oo+RGjYfMB+zeAYnLgZKuY9nUKCQA=;
        b=k4niFnqgC6uT+WkOQ6wgsJcYaNgMLnTL7lVhPfpNfF/fWu3Z/FxIjhBpaj3wtHigDP
         oknx0uZtfuzo6ralUpJB0Vr5FJRCJ1w1O59dD+RG6do4ZDLCDZyWqsCtlvlAScWcCJFJ
         NlsBZybNdO639hEBLlKY4YqWfytlkksQKfBpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rep+RFn3BdJQf0oo+RGjYfMB+zeAYnLgZKuY9nUKCQA=;
        b=a+3Gx+hN/pIRmVpeW7vesVAQNA+Y3q+tsRLnAfCicq1rcM73OJ0fTHj1F6ZKiLqN7E
         1rxruI55HsziDTiv0Yh1wcSKbnjVPOvPvczeJzDqRKafTESBnbGhpnM+31m1I+ZAPyif
         WCRnCv6jFwFdohn/ujwjHMs9w7YfjmK86RP+BHeP6aaBrYMEqGD2CG1RhIpLlsbp3BJT
         v3ik2Jo3+R+sLgWQDtwJrNks+7ZdnY7IEwztReCzEeBNsFEWxm0mH+sLLH5lA36zXcGO
         xm6tpP0iK0lns5O0ecixibWKY2bh5KWu7tMBuQkIoF6uctS/IMrXwrs6uXxU9s99WVLi
         3oGg==
X-Gm-Message-State: APjAAAVQhK0F5j40Tx9x9fU3hWaXxqIoH+eYmw2YZKPsfRgkjnLKNBp6
        U4lrXBIVHI918vX2yN0sTAZOOM9FHpA=
X-Google-Smtp-Source: APXvYqzL5tVCENHyIoP6ciB6etI0JDtSIPKmvj0GuQCkq6Ygw4g7PrFa7sZ1a3I2cFmoMOh/cR8IvA==
X-Received: by 2002:a1f:e185:: with SMTP id y127mr2924235vkg.20.1556822570638;
        Thu, 02 May 2019 11:42:50 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id n202sm12259717vke.5.2019.05.02.11.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:42:50 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id j184so1988550vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:42:50 -0700 (PDT)
X-Received: by 2002:a67:7cd1:: with SMTP id x200mr3103185vsc.144.1556822175074;
 Thu, 02 May 2019 11:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-4-dianders@chromium.org> <87pnpas1fx.fsf@linux.intel.com>
In-Reply-To: <87pnpas1fx.fsf@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 May 2019 11:36:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTBgKnnswhfoQH3qWjpbp831e1L1+j+QCjxx2h=aQoog@mail.gmail.com>
Message-ID: <CAD=FV=XTBgKnnswhfoQH3qWjpbp831e1L1+j+QCjxx2h=aQoog@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Documentation: dt-bindings: Add
 snps,need-phy-for-wake for dwc2 USB
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Julius Werner <jwerner@chromium.org>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 25, 2019 at 5:40 AM Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
>
> Douglas Anderson <dianders@chromium.org> writes:
>
> > Some SoCs with a dwc2 USB controller may need to keep the PHY on to
> > support remote wakeup.  Allow specifying this as a device tree
> > property.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > For relevant prior discussion on this patch, see:
> >
> > https://lkml.kernel.org/r/1435017144-2971-3-git-send-email-dianders@chromium.org
> >
> > I didn't make any changes from the prior version since I never found
> > out what Rob thought of my previous arguments.  If folks want a
> > change, perhaps they could choose from these options:
> >
> > 1. Assume that all dwc2 hosts would like to keep their PHY on for
> >    suspend if there's a USB wakeup enabled, thus we totally drop this
> >    binding.  This doesn't seem super great to me since I'd bet that
> >    many devices that use dwc2 weren't designed for USB wakeup (they
> >    may not keep enough clocks or rails on) so we might be wasting
> >    power for nothing.
> > 2. Rename this property to "snps,wakeup-from-suspend-with-phy" to make
> >    it more obvious that this property is intended both to document
> >    that wakeup from suspend is possible and that we need the PHY for
> >    said wakeup.
> > 3. Rename this property to "snps,can-wakeup-from-suspend" and assume
> >    it's implicit that if we can wakeup from suspend that we need to
> >    keep the PHY on.  If/when someone shows that a device exists using
> >    dwc2 where we can wakeup from suspend without the PHY they can add
> >    a new property.
> >
> > Changes in v2: None
> >
> >  Documentation/devicetree/bindings/usb/dwc2.txt | 3 +++
> >  1 file changed, 3 insertions(+)
>
> checking file Documentation/devicetree/bindings/usb/dwc2.txt
> Hunk #1 FAILED at 37.
> Hunk #2 succeeded at 52 (offset -1 lines).
> 1 out of 2 hunks FAILED

Can you try applying this and the next two patches again?  ...or let
me know that you'd like me to repost?

Thanks!

-Doug
