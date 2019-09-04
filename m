Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511A3C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CEB22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567600436;
	bh=NPSijeGSxbzXyxdkAUWe73NhTGQn1UKpLjx/1aIO0DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D5PpeJh7b2krnsOyHhw4RWsK5BHNPWQuBK89HX3IWvVQiJumsnKAKKL2i/pNCHleV
	 4e7whxpdz/EfIbEOreUaZjMUO4PTcKxOreu8/WjAeCxGYBYc6/LaOCQ66ekimBPMZu
	 ru3RG7dYvsRX7MSR3BA5P1b6ukSl1Kuo/LKl08oE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfIDMdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbfIDMdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:33:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C1321670;
        Wed,  4 Sep 2019 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567600434;
        bh=NPSijeGSxbzXyxdkAUWe73NhTGQn1UKpLjx/1aIO0DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2gbqjHerKowGZqJshDle9lbqVBpyHgPtd8XU4TlH2306OOdt0KSyWuEhR7+t9+l2h
         youTFg9rT5xQXAa5RMoFWy/xkD0z+bBM+olMVqX6R1q5WRH4TqVIvCqW8GPBRGvdWs
         FHcmZz3WSxrRNhbyyXWG/OwcEutQTN0HIqZBdvK8=
Date:   Wed, 4 Sep 2019 14:33:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] w1: add 1-wire master driver for IP block found
 in SGI ASICs
Message-ID: <20190904123351.GA15401@kroah.com>
References: <20190831082623.15627-1-tbogendoerfer@suse.de>
 <20190831082623.15627-2-tbogendoerfer@suse.de>
 <20190904114837.GA9153@kroah.com>
 <20190904140134.698aaf5f5ec204a5305c1177@suse.de>
 <20190904120646.GA11400@kroah.com>
 <20190904141434.7d05c6bcd2852d2060ba91ce@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904141434.7d05c6bcd2852d2060ba91ce@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:14:34PM +0200, Thomas Bogendoerfer wrote:
> On Wed, 4 Sep 2019 14:06:46 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Sep 04, 2019 at 02:01:34PM +0200, Thomas Bogendoerfer wrote:
> > > On Wed, 4 Sep 2019 13:48:37 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Sat, Aug 31, 2019 at 10:26:21AM +0200, Thomas Bogendoerfer wrote:
> > > > > Starting with SGI Origin machines nearly every new SGI ASIC contains
> > > > > an 1-Wire master. They are used for attaching One-Wire prom devices,
> > > > > which contain information about part numbers, revision numbers,
> > > > > serial number etc. and MAC addresses for ethernet interfaces.
> > > > > This patch adds a master driver to support this IP block.
> > > > > It also adds an extra field dev_id to struct w1_bus_master, which
> > > > > could be in used in slave drivers for creating unique device names.
> > > > > 
> > > > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > > > ---
> > > > >  drivers/w1/masters/Kconfig           |   9 +++
> > > > >  drivers/w1/masters/Makefile          |   1 +
> > > > >  drivers/w1/masters/sgi_w1.c          | 130 +++++++++++++++++++++++++++++++++++
> > > > >  include/linux/platform_data/sgi-w1.h |  13 ++++
> > > > 
> > > > Why platform data?  I thought that was the "old way", and the "proper
> > > > way" now is to use device tree?
> > > 
> > > this machine is old and doesn't have device tree at all.
> > 
> > Your text says "every new SGI ASIC".  So new devices are being made for
> > old systems?
> > 
> > confused,
> 
> ok, now I see where the confusion comes from. New in the meaning of latest
> produced SGI MIPS system.
> 
> Is it better, if I rephrase this to latest line of MIPS system ASICs ?

Nah, I'll take this now, it's ok, thanks for the explanation.

greg k-h
