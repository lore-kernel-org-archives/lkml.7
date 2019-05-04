Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C4C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B020862
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556980893;
	bh=gSjzNXwzVADkhUG1J+XQmSWvUA18jz5VVOMIPF/+1Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o+Dq9Wd93ch4pv0bA92QdH6zdgyTzKGxdopS1GGKc2e1Ldwf1lUZgbiFw8+S7tNhh
	 ZTE5OQEiT0Lm1ruWCckunOQCgwG0pWyDorcCv+3F0pQF45a5zxASDpFVU+VSZ9gJzT
	 1j3rQnwYsBgxMM5NGeOfomXnvIsgU8cO7xKsP0ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfEDOlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfEDOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:41:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9C720859;
        Sat,  4 May 2019 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556980890;
        bh=gSjzNXwzVADkhUG1J+XQmSWvUA18jz5VVOMIPF/+1Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThCm6UKrH6zyS8oz0Qw5T0dAyoGWPWxAFtryrhciPkXkkctI/EgK8butFvzCy9Hyu
         RxqXKbYhZxGYfCNElmz9Q6ap8/AIANtSZHt7V2oAuWjLBRlgyXzVdYYLpGdJaRvbrO
         tpoVgZrage+I+yowLYnvLnctJR+7XYiJHtWMEhRg=
Date:   Sat, 4 May 2019 16:41:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Message-ID: <20190504144128.GA13454@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172345.GC1874@kroah.com>
 <CAK8P3a2EKXrg4amHDi5zVvOQ8AM+u6EAhBc=T8Hk_tU20xSV4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2EKXrg4amHDi5zVvOQ8AM+u6EAhBc=T8Hk_tU20xSV4w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 10:35:02AM -0400, Arnd Bergmann wrote:
> On Thu, May 2, 2019 at 1:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Apr 27, 2019 at 11:04:58PM +0100, Dragan Cvetic wrote:
> > > Add char device interface per DT node present and support
> > > file operations:
> > > - open(),
> > > - close(),
> > > - unlocked_ioctl(),
> > > - compat_ioctl().
> >
> > Why do you need compat_ioctl() at all?  Any "new" driver should never
> > need it.  Just create your structures properly.
> 
> The function he added was the version that is needed when the structures
> are compatible. I submitted a series to add a generic 'compat_ptr_ioctl'
> implementation that would save a few lines here doing the same thing,
> but it's not merged yet.
> 
> Generally speaking, every driver that has a .ioctl() function should also
> have a .compat_ioctl(), and ideally it should be exactly this trivial
> version.

Ok, for some reason I thought if there was no need for a compat ioctl
(i.e. no pointer mess), then no need for a callback at all.

thanks,

greg k-h
