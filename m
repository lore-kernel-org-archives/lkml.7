Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39DDC10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FB920823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="vCzUzB09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d0H/3jOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfCZCTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:19:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52105 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730624AbfCZCTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:19:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 49984221F0;
        Mon, 25 Mar 2019 22:19:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 25 Mar 2019 22:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lLqJTEWFYe1ihXkfJx/7Y0pcTqd
        pHEr/la0m2n94Pgc=; b=vCzUzB09GgpdER7wadr+Hjp6QOI+oJPNxvqMVN5bmoW
        fWyA1T6tTrkapkpY+r2OGlFoERPqitobEB0lyxunNM+TgDhZ5Q/0FK21gV1aWtd9
        MTibFyUxUMWJoRdUxFffokB2k/4H5cEKZ41OobXyehSM1R3PDZX06BReYOp92/KZ
        MlIaOzL6aCGMNWpxgQ3abmMzDZlfprdoXvMDsKkAD7f17PDYcnoPTtRjgQfFY/q7
        IWdvHgXJ8dZ23FqaNhok/gP41k4IrlLq1OrCkmz2m3j8Xxjw8m0jUuIjYrCZtxxO
        mU1TeosPD7WUw/bRozGzXjGrywRw+l8CYrK2W9cmlug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lLqJTE
        WFYe1ihXkfJx/7Y0pcTqdpHEr/la0m2n94Pgc=; b=d0H/3jOIDMPPe0Y9K96fqd
        dufhdzoAWq6vX+/9V3hD6/oQQ8RYOJmgqX5RyJDln01wjvqAM+QvGValqLt8qUCy
        Hgy25kCkgfBiPlXfcIH5OxcSGTVkSIl1N+lkGbEAXb05i5iDEJWLqZorvJLHPt/+
        9TPNh+yv+c4xVg/hWYh8uMrknECm/2yEqqTtiZEwLZQtRpMA6jZjj6VFFxue4lby
        cxBaGWTdo6yqGdL3uZ1W62bGs6wa9Y1+s6j67HyUPMCNKjC15V+0JMyE3jWIubVT
        2qtSVz/t+t9nCH0ah3nWdfOUFKkjg2TgOVE6SIexoYdyYXDNaYRpEqvb7hfvwWuA
        ==
X-ME-Sender: <xms:FIyZXAo1tHkwrpgeHtIU9P-z2Bw4PIHq_LDj1WkaIWTfoOPOl2IY9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrjeelgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepudejvddruddtgedrvdegke
    drgeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:FIyZXK6Gvuu8JgvvaH-e1EAUp4dlYJQ9WOHmoNFavE3Egnve7OdNLg>
    <xmx:FIyZXAOZMltFBax-QogmoTkUoK8D1yHMxkzHWhUIY39YbDvlUeV_AQ>
    <xmx:FIyZXMPhxgEVjHIVjNRsFmxp3BqfJYEZk71uXGfCseXxgf7_G2smvQ>
    <xmx:FoyZXF5fxKv8CA3ZUuH3jiY6O5X1d7QoUdU-82XjDFlv7jRynkJIgA>
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2434510317;
        Mon, 25 Mar 2019 22:18:59 -0400 (EDT)
Date:   Tue, 26 Mar 2019 11:18:54 +0900
From:   Greg KH <greg@kroah.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, dccp@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [BACKPORT 4.4.y 00/25] candidates from spreadtrum 4.4 product
 kernel
Message-ID: <20190326021854.GA19395@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:43:51PM +0100, Arnd Bergmann wrote:
> I took a scripted approach to look at some product kernels for patches
> backported into vendor kernels. This is a set of (mostly) bugfixes I found
> in Spreadtrum's linux-4.4 kernel that are missing in 4.4.176:
> 
> ffedbd2210f2 mmc: pwrseq: constify mmc_pwrseq_ops structures
> c10368897e10 ALSA: compress: add support for 32bit calls in a 64bit kernel
> 64a67d4762ce mmc: pwrseq_simple: Make reset-gpios optional to match doc
> 4ec0ef3a8212 USB: iowarrior: fix oops with malicious USB descriptors
> e5905ff1281f mmc: debugfs: Add a restriction to mmc debugfs clock setting
> 4ec96b4cbde8 mmc: make MAN_BKOPS_EN message a debug
> ed9feec72fc1 mmc: sanitize 'bus width' in debug output
> 10a16a01d8f7 mmc: core: shut up "voltage-ranges unspecified" pr_info()
> 9772b47a4c29 usb: dwc3: gadget: Fix suspend/resume during device mode
> 6afedcd23cfd arm64: mm: Add trace_irqflags annotations to do_debug_exception()
> 437db4c6e798 mmc: mmc: Attempt to flush cache before reset
> e51534c80660 mmc: core: fix using wrong io voltage if mmc_select_hs200 fails
> e4c5800a3991 mm/rmap: replace BUG_ON(anon_vma->degree) with VM_WARN_ON
> 04c080080855 extcon: usb-gpio: Don't miss event during suspend/resume
> 78283edf2c01 kbuild: setlocalversion: print error to STDERR
> c526c62d565e usb: gadget: composite: fix dereference after null check coverify warning
> 511a36d2f357 usb: gadget: Add the gserial port checking in gs_start_tx()
> 1712c9373f98 mmc: core: don't try to switch block size for dual rate mode
> 5ea8ea2cb7f1 tcp/dccp: drop SYN packets if accept queue is full
> e1dc9b08051a serial: sprd: adjust TIMEOUT to a big value
> 81be24d263db Hang/soft lockup in d_invalidate with simultaneous calls
> 6f44a0bacb79 arm64: traps: disable irq in die()
> b7d44c36a6f6 usb: renesas_usbhs: gadget: fix unused-but-set-variable warning
> 4350782570b9 serial: sprd: clear timeout interrupt only rather than all interrupts
> 3f3295709ede lib/int_sqrt: optimize small argument
> 32fd87b3bbf5 USB: core: only clean up what we allocated

All now queued up, except for the exceptions I have responded to.

thanks,

greg k-h
