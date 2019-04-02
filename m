Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CB1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0D120645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="dWcltubN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDBP40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:56:26 -0400
Received: from mail.nic.cz ([217.31.204.67]:51089 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbfDBP4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:56:25 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id 6346E63514;
        Tue,  2 Apr 2019 17:56:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1554220583; bh=aUEUCP2MTTHJR3FgOiheCDZb3bPb2opksewxTsTlF7M=;
        h=Date:From:To;
        b=dWcltubNkJEh8kYgnB0aMZU7jOiswZAwtpCZ9gUteG8ih+ABhdbct+JhjciLLDrnd
         Hy1OFdB8FvcGDypJeVMJpBgihzEyGmgGooJmlg75EJ3YXjdBQ8aCYypmAa4VpH+Dpa
         eVDPBxwzQzBAS7iOPfJgX9sLsYCxnQnQDPfMoSlY=
Date:   Tue, 2 Apr 2019 17:56:23 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <jacek.anaszewski@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
Subject: Re: [RFC PATCH 3/5] documention: leds: Add multicolor class
 documentation
Message-ID: <20190402175623.0d85ad7d@nic.cz>
In-Reply-To: <e2621a54-4c5c-4235-9aba-39a856cfbe88@ti.com>
References: <20190401173400.14238-1-dmurphy@ti.com>
        <20190401173400.14238-4-dmurphy@ti.com>
        <20190401212709.GA14681@amd>
        <e2621a54-4c5c-4235-9aba-39a856cfbe88@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 2 Apr 2019 06:53:30 -0500
Dan Murphy <dmurphy@ti.com> wrote:

> I agree there are other solutions.  Better not so sure.
> We keep kicking a solution down the road we have been talking about adding something to the kernel
> for almost 5 months now, but no one can decide what to do.
> 
> How do we move a solution forward?
> Should we just forget the whole idea and keep developing against the current framework?
> 
> > One was discussed before -- have single file which contains
> > coefficients for r/g/b channels.
> >   
> 
> That has been presented as well and the concept was not well received either.
> 
> > Or at least... you should not really need separate sync and
> > sync_enable files. One should do.
> >   
> 
> The idea here was to be able to set the LED brightness immediately on a single LED
> with a single brightness write or setup the color brightness on all the LEDs and then
> sync the LED brightnesses.
> 
> If you wanted to control a single LED for notifications the user space may have to do
> 
> echo 0 > blue/brightness
> echo 0 > green/brightness
> echo 255 > red/brightness
> echo 1 > sync
> 
> As opposed to just
> echo 255 > red/brightness
> 

Maybe other kernel developers, or sysfs maintainers like Greg, schould
also have a word about this.

Another solution, although not usable from shell, could be this:
  if a process opens all brightness files of a singled multicolor LED
  and then does a special SYNC_ON_THIS ioctl on one of them, then the
  sync is done when this color is written.
But that would also require ioctl for sysfs files, and I don't think
Greg would like that.

Dan's sync_enable API looks right to me from the one file/one value
sysfs rule as well - you can enable this setting (sync_enable) via one
file.

What is the main reason you guys are concerned about this?
That users will complain that they are writing to red/brightness and
the LED does not change color (because they did not disable
sync_enable)?

Marek
