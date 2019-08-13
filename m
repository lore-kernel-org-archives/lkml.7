Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFFDC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D3920578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565676756;
	bh=/kbzKCVdF8E3NqOCCP0htEJ8jCfrIzVHyivdMvBxvmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eu1b9nh7K6t7pySmSfwiJ6jWHsAhn7nD5d60xej2w+mbDv15HmemYF855hUNBubI1
	 OuMVMXML9tXjlr41Go3htZkhLkM/RPW0t+zBt9k+QFPi+ZUUHZ0aDtNG16VCkm618v
	 xNP0wSr2oe7cc3iE3TClIEgPWSc+w9aWAmwHr/Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfHMGMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfHMGMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:12:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC29F20578;
        Tue, 13 Aug 2019 06:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565676751;
        bh=/kbzKCVdF8E3NqOCCP0htEJ8jCfrIzVHyivdMvBxvmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewe0rDIidQfm/k0kUS7CSsSV8o7j4yMDGNjgP2k5B5AeMGbDkaj65jxLRrImt+s7K
         D1j5vhbylkyhVr5gZVr+CgVw01TBjtxrJdJS9w02J8XAbga8uxk5oJyzgkER6uo9pg
         3kbPYKxp1OGOs9TSQXRgeTmQK5G9wdxuK2eF7nm8=
Date:   Tue, 13 Aug 2019 08:12:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Morris Ku <morris_ku@sunix.com>,
        Debbie Liu <debbie_liu@sunix.com>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Add support for Sunix serial
 boards
Message-ID: <20190813061228.GH6670@kroah.com>
References: <20190809190130.30773-1-kai.heng.feng@canonical.com>
 <CAHp75VeGs8K+da+4CaqNjm_ci86KoLcmhY8GaJO7jm__J0TcSQ@mail.gmail.com>
 <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:36:40PM +0800, Kai-Heng Feng wrote:
> Hi Andy,
> 
> at 21:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Fri, Aug 9, 2019 at 10:05 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > > Add support to Sunix serial boards with up to 16 ports.
> > > 
> > > Sunix board need its own setup callback instead of using Timedia's, to
> > > properly support more than 4 ports.
> > 
> > Can you, please, split out the Sunix quirk driver to a separate module
> > (see examples like: 8250_exar, 8250_lpss, 8250_mid)?
> > And then with a fewer LOCs add a new boards.
> 
> Greg asked Sunix to use existing 8250_pci.c instead of its own module.
> It only needs a special setup function, other parts are just 8250_pci.

Agreed.  And this patch is already in my tree :)

If people really worry about size issues, start carving this up by
different configuration options, or yes, split it up into tiny modules
(but note the overhead there when things get too tiny, it's a
diminishing return).

> Why does split them a better idea? I even think of squashing 8250_moxa into
> 8250_pci.

I would agree with you, I bet you save space if you do that.

thanks,

greg k-h
