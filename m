Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BACC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAB620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfDQKD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:03:56 -0400
Received: from foss.arm.com ([217.140.101.70]:42266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfDQKD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:03:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13106374;
        Wed, 17 Apr 2019 03:03:56 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23D433F68F;
        Wed, 17 Apr 2019 03:03:53 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:03:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] arm: mm: Export __sync_icache_dcache() for
 xen-privcmd
Message-ID: <20190417100351.oix3df7hwwivgf7k@mbp>
References: <20190413163052.11407-1-xypron.glpk@gmx.de>
 <20190415055109.GB9279@infradead.org>
 <20190417094137.2gkbtinldiwbkvwy@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417094137.2gkbtinldiwbkvwy@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:41:37AM +0100, Russell King wrote:
> On Sun, Apr 14, 2019 at 10:51:09PM -0700, Christoph Hellwig wrote:
> > On Sat, Apr 13, 2019 at 06:30:52PM +0200, Heinrich Schuchardt wrote:
> > > This patch avoids
> > > ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> > > observed when compiling v4.19.34.
> > > 
> > > The xen-privcmd driver, which can be modular, calls set_pte_at()
> > > which in turn may call __sync_icache_dcache().
> > 
> > Maybe that really is a sign that it should not be modular..
> 
> This issue has been discussed several times, and this URL gives a list
> of all messages on linux-arm-kernel that mention __sync_icache_dcache:
> 
> https://archive.armlinux.org.uk/lurker/search/20380101.000000.00000000@ml:linux-arm-kernel,sb:__sync_icache_dcache.en.html
> 
> At the beginning of March, Boris Ostrovsky pointed that another solution
> is available that does not need architecture private symbols to be
> exported.
> 
> Since I've already said in a previous thread that I don't want this
> function exported, it seems the way forward is pretty obvious.

Arnd submitted a patch, not sure what happened to it:

https://lore.kernel.org/lkml/20190304204826.2414365-1-arnd@arndb.de/

I think this boils down to whether set_pte_at() is allowed to be called
from loadable modules. If yes, __sync_icache_dcache() needs exporting,
otherwise Arnd's patch makes the relevant code built-in (and, if merged,
I'm happy to revert the similar export on arm64).

-- 
Catalin
