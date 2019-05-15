Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C03C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7801F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557938390;
	bh=MTEha5fRGojdwXOS8OjWxkdxwE+qp3d58CzLpCynDXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L0PLplk0ivhDO6gG9ysl9Nh0N77j/HGq/7CjtSl44w8VAv24QnMQ3ZDhct7/p/Aee
	 V/nTcjBgjwgAhYg4/CKHrPkvUPzcvxpWXgs5LDFpvUWjL/1f7l6YrS3JsKmG12ltTt
	 ZR7bwRvisqdDwjp9YDaUb9BpXA1OZeKwRixwC6Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfEOQjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfEOQjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:39:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D5720873;
        Wed, 15 May 2019 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557938387;
        bh=MTEha5fRGojdwXOS8OjWxkdxwE+qp3d58CzLpCynDXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rReZiZSVA5nqbhubOHlCX1qMleMf6VBef4sHEY6UEYHvvZtETCvPZJTFqsUnofHpz
         Rg8UFnlDbjMBwfWoMmXjH3VhnxaIUWcsu6v7P9dRwR+ryXuGkBC2WJLGUARdMRINHK
         3uRO+g4pwtwWNLDCd/JhDi3bmWqj+alrVEMuygqs=
Date:   Wed, 15 May 2019 18:39:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
Message-ID: <20190515163945.GA5719@kroah.com>
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
 <20190515114022.GA18824@kroah.com>
 <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
 <20190515123319.GA435@kroah.com>
 <63833AA2-AC8B-4EEA-AF36-EF2A9BFD4F9F@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63833AA2-AC8B-4EEA-AF36-EF2A9BFD4F9F@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 09:06:44PM +0800, Kai-Heng Feng wrote:
> at 20:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, May 15, 2019 at 07:54:58PM +0800, Kai-Heng Feng wrote:
> > > at 19:40, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Wed, May 15, 2019 at 07:24:01PM +0800, Kai-Heng Feng wrote:
> > > > > The rtl8821ce can be found on many HP and Lenovo laptops.
> > > > > Users have been using out-of-tree module for a while,
> > > > > 
> > > > > The new Realtek WiFi driver, rtw88, will support rtl8821ce in 2020 or
> > > > > later.
> > > > 
> > > > Where is that driver, and why is it going to take so long to get merged?
> > > 
> > > rtw88 is in 5.2 now, but it doesn’t support 8821ce yet.
> > > 
> > > They plan to add the support in 2020.
> > 
> > Who is "they" and what is needed to support this device and why wait a
> > full year?
> 
> “They” refers to Realtek.
> It’s their plan so I can’t really answer that on behalf of Realtek.

Where did they say that?  Any reason their developers are not on this
patch?

> > > > > 296 files changed, 206166 insertions(+)
> > > > 
> > > > Ugh, why do we keep having to add the whole mess for every single one of
> > > > these devices?
> > > 
> > > Because Realtek devices are unfortunately ubiquitous so the support is
> > > better come from kernel.
> > 
> > That's not the issue here.  The issue is that we keep adding the same
> > huge driver files to the kernel tree, over and over, with no real change
> > at all.  We have seen almost all of these files in other realtek
> > drivers, right?
> 
> Yes. They use one single driver to support different SoCs, different
> architectures and even different OSes.

Well, they try to, it doesn't always work :(

> That’s why it’s a mess.

Oh we all know why this is a mess.  But they have been saying for
_years_ they would clean up this mess.  So push back, I'm not going to
take another 200k lines for a simple wifi driver, again.

Along those lines, we should probably just delete the other old realtek
drivers that don't seem to be going anywhere from staging as well,
because those are just confusing people.

> > Why not use the ones we already have?
> 
> It’s virtually impossible because Realtek’s mega wifi driver uses tons of
> #ifdefs, only one chip can be selected to be supported at compile time.

That's not what I asked.

I want to know why they can't just add support for their new devices to
one of the many existing realtek drivers we already have.  That is the
simpler way, and the correct way to do this.  We don't do this by adding
200k lines, again.

> > But better yet, why not add proper support for this hardware and not use
> > a staging driver?
> 
> Realtek plans to add the support in 2020, if everything goes well.

Device "goes well" please.  And when in 2020?  And why 2020?  Why not
2022?  2024?

> Meanwhile, many users of HP and Lenovo laptops are using out-of-tree driver,
> some of them are stuck to older kernels because they don’t know how to fix
> the driver. So I strongly think having this in kernel is beneficial to many
> users, even it’s only for a year.

So who is going to be responsible for "fixing the driver" for all new
kernel api updates?  I'm tired of seeing new developers get lost in the
maze of yet-another realtek wifi driver.  We've been putting up with
this crud for years, and it has not gotten any better if you want to add
another 200k lines for some unknown amount of time with the hope that a
driver might magically show up one day.

thanks,

greg k-h
