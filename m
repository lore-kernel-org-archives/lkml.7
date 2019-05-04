Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C39C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EA320862
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556984085;
	bh=XB+2ke+O8ycEXrjtGw3aam7SL9GBf1WhXYl7lNP9HoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sWkYFHUhWsYDhr5v+UYuiy3CqNOYc0b251ZHot82dGGDLsQDvRefAojL9pIuVnEOQ
	 S/UEINGJ6MPOXmkM6YlEC3qDG+zJtmdrnScpRU8010MMEokEapvcjmLM8joeiU7BZP
	 zrfrW/+FeqsvPFu2jZvSv1O7r6H7GDIzS6+zv7wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfEDPen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 11:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfEDPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 11:34:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F61120644;
        Sat,  4 May 2019 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556984082;
        bh=XB+2ke+O8ycEXrjtGw3aam7SL9GBf1WhXYl7lNP9HoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEpoWxJnTRmyiQg0gX9C6izeET8Mc5tzrOIXV9bD8L+VNvtoDSozHid9xk/Vtop3x
         GiZfuNzyH8fhFvKAfaWaAI/CBjgDEJ2FIehuU2RHZB7m+j2ap1q+Wuv5Ju0T6YL136
         Fqf2FC8gZ2SGbiDFsGOtHq7wDX7zyAzEa6s95I1k=
Date:   Sat, 4 May 2019 17:34:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     rafael@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhaowuyun@wingtech.com
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue
 directory
Message-ID: <20190504153440.GB19654@kroah.com>
References: <20190423143258.96706-1-smuchun@gmail.com>
 <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
 <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com>
 <a37e7a49c3e7fa6ece2be2b76798fef3e51ade4e.camel@kernel.crashing.org>
 <CAPSr9jHCVCHNK+AmKkUBgs4dPC0UC5KdYKqMinkauyL3OL6qrQ@mail.gmail.com>
 <79fbc203bc9fa09d88ab2c4bff8635be4c293d49.camel@kernel.crashing.org>
 <CAPSr9jHw9hgAZo2TuDAKdSLEG1c6EtJG005MWxsxfnbsk1AXow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSr9jHw9hgAZo2TuDAKdSLEG1c6EtJG005MWxsxfnbsk1AXow@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 10:47:07PM +0800, Muchun Song wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> 于2019年5月2日周四 下午2:25写道：
> 
> > > > The basic idea yes, the whole bool *locked is horrid though.
> > > > Wouldn't it
> > > > work to have a get_device_parent_locked that always returns with
> > > > the mutex held,
> > > > or just move the mutex to the caller or something simpler like this
> > > > ?
> > > >
> > >
> > > Greg and Rafael, do you have any suggestions for this? Or you also
> > > agree with Ben?
> >
> > Ping guys ? This is worth fixing...
> 
> I also agree with you. But Greg and Rafael seem to be high latency right now.

It's in my list of patches to get to, sorry, hopefully will dig out of
that next week with the buffer that the merge window provides me.

thanks,

greg k-h
