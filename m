Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0BEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24922339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567598810;
	bh=bn11dHJhPXsKpa1VYeSNM5XEtDRwjbnn0OTy+qzlgPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KCzy5gXuhxFE8VX6Tals8ckphT2kTBnCGJr67AVSLBrcDKPmFKXVpsnSwlXUOUj70
	 slySAxUZffEggDveCD9njCStsp4qkU8CliSwIqne4aNhH2jF3d6Y0KJ3Jt2gGE4NtI
	 PjGmzroeNnJQoMn1c0s8COnS0N0r54rlVqlxWEkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfIDMGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfIDMGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:06:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E3522CF5;
        Wed,  4 Sep 2019 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567598808;
        bh=bn11dHJhPXsKpa1VYeSNM5XEtDRwjbnn0OTy+qzlgPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zhNhufNMYrSuaAbS4OUT5a2T8aF5rXMvuWrvQQYBu5X1W8xN0dROxAiOpPs6BJi19
         9wjE5rTNzGupvUYjG4ay/6ZWCtNnslKmiVpD08TkLTVWkhM3cRzFrrYAp4UG7pLx39
         449kTkC8Tw7JSc2xzKSqqGqPcu8G5FmrzitL+VRw=
Date:   Wed, 4 Sep 2019 14:06:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] w1: add 1-wire master driver for IP block found
 in SGI ASICs
Message-ID: <20190904120646.GA11400@kroah.com>
References: <20190831082623.15627-1-tbogendoerfer@suse.de>
 <20190831082623.15627-2-tbogendoerfer@suse.de>
 <20190904114837.GA9153@kroah.com>
 <20190904140134.698aaf5f5ec204a5305c1177@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904140134.698aaf5f5ec204a5305c1177@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:01:34PM +0200, Thomas Bogendoerfer wrote:
> On Wed, 4 Sep 2019 13:48:37 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Sat, Aug 31, 2019 at 10:26:21AM +0200, Thomas Bogendoerfer wrote:
> > > Starting with SGI Origin machines nearly every new SGI ASIC contains
> > > an 1-Wire master. They are used for attaching One-Wire prom devices,
> > > which contain information about part numbers, revision numbers,
> > > serial number etc. and MAC addresses for ethernet interfaces.
> > > This patch adds a master driver to support this IP block.
> > > It also adds an extra field dev_id to struct w1_bus_master, which
> > > could be in used in slave drivers for creating unique device names.
> > > 
> > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > ---
> > >  drivers/w1/masters/Kconfig           |   9 +++
> > >  drivers/w1/masters/Makefile          |   1 +
> > >  drivers/w1/masters/sgi_w1.c          | 130 +++++++++++++++++++++++++++++++++++
> > >  include/linux/platform_data/sgi-w1.h |  13 ++++
> > 
> > Why platform data?  I thought that was the "old way", and the "proper
> > way" now is to use device tree?
> 
> this machine is old and doesn't have device tree at all.

Your text says "every new SGI ASIC".  So new devices are being made for
old systems?

confused,

greg k-h
