Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BD7218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366826;
	bh=byAg77FHN3WI5S1frV8IHsE1cuzxw/EeGiVs4Ma0yCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ConloeoRKWrfvNmlyrS/tThOa2o/tJquXnsnJJVJu21Gypoc878+TrPJ/Qs/edsG5
	 sTwYR+eQjBgzEKJZOS/JYBe+giWfEiISrC7r/iuiLQSDQbkzcfiySEx12M23IfyNSN
	 5m480VTrfrbmjZEgEb9NKoBOhfpTFW0V6At98/vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbfB1PNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388470AbfB1PNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571C0218FC;
        Thu, 28 Feb 2019 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366812;
        bh=byAg77FHN3WI5S1frV8IHsE1cuzxw/EeGiVs4Ma0yCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPsDmY2tjjxJvBQhNDa7rFUeSrlSVV0123nVIbojMmrb2xKfaL5B/gTZEeCd91L16
         0/Gh6aJlJd8zHMytPC2Mql8KA0W0aGudXGMVeQcrJ/8IJPJypzemn+TNXSlysayW4H
         uJc0gh0vd5TVpQS02BwX/8fc2cE3FbvKr8hPGIY8=
Date:   Thu, 28 Feb 2019 16:13:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] dt-bindings: usb: add non-removable device property
Message-ID: <20190228151330.GA1360@kroah.com>
References: <20190228143344.16312-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228143344.16312-1-mans@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:33:44PM +0000, Mans Rullgard wrote:
> Add a boolean property indicating that a device is hardwired to the
> upstream port.  Although hubs can provide this information, they are not
> always configured correctly.  An alternate means of indicating this for
> built-in USB devices is thus useful.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> I have a situation where userspace would like to know which USB devices
> are built-in, but the on-board hub doesn't have the right setting.
> Also, the hub itself can't be indicated as fixed in any other way that
> I'm aware of.

Then that's a firmware bug, right?  We have a way for firmware to export
this to the USB core, why not use that?  Your on-board hub should get a
firmware update with this information, let's not try to create
yet-another-way to define this type of information please.

> In a way, adding this property seems a bit silly since dt can only
> sensibly be used for hardwired devices in the first place.  Thus the
> mere presence of a dt node could be taken to indicate the same thing.
> On the other hand, it's conceivable that someone might dynamically
> generate a devicetree based on what happens to be connected on boot or
> something.  For that reason, and explicit property seems safer.
> ---
>  Documentation/devicetree/bindings/usb/usb-device.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Can you show some code actually using this?  Again, this should "just
work" for USB today unless your platform is really broken (and if it is,
go complain to the vendor...)

thanks,

greg k-h
