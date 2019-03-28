Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA73C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E63A2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfC1OLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:11:35 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51518 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725779AbfC1OLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:11:34 -0400
Received: (qmail 5642 invoked by uid 2102); 28 Mar 2019 10:11:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Mar 2019 10:11:33 -0400
Date:   Thu, 28 Mar 2019 10:11:33 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Sekhar Nori <nsekhar@ti.com>
cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 0/3] ARM: davinci: ohci-da8xx: model the vbus GPIO as a
 fixed regulator
In-Reply-To: <3d7f7814-6184-96c6-8087-6373a489ebc0@ti.com>
Message-ID: <Pine.LNX.4.44L0.1903281009430.1448-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019, Sekhar Nori wrote:

> >> Can you document why the current solution is not optimal? Is it to make
> >> future device-tree conversion for these boards easier? Or?
> >>
> > 
> > It's sub-optimal from the HW modeling in SW PoV - it is in fact a
> > regulator enabled/disabled by a GPIO. Also: it's code duplication as
> > currently we check if the vbus GPIO exists and then use it or check if
> > the regulator exists and use this as the second choice. The third
> > patch actually shrinks the driver.
> 
> I see now that the driver supports controlling the VBUS gpio as
> regulator already. Something I should have caught in review last time
> around.
> 
> I agree this patch is an improvement. Lets see what Alan feels.

I'm not an expert on this stuff, but the patch looks reasonable.  
However, I do wish that in the devm_request_threaded_irq() call, the 
indentation of the continuation lines was left unchanged.

Alan Stern

> Also, reg_enabled member of da8xx_ohci_hcd structure seems to be pretty
> useless considering regulator API already has use counting. Can you take
> a look and remove that too as an added bonus.
> 
> Thanks,
> Sekhar


