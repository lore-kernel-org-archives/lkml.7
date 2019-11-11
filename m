Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A882C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9B92084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573454445;
	bh=cktYl62Ynev3YcbNhpece5Z14fVDGbQyuOjqOeQf4Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bc9kR42OwemJe+15uyXEJNYwnBh8R+wphqA07fJfs5jEKme9GlfPoL02EBo+EPGSa
	 KqNfvh8Y0gUjcaZ4xRi/HIJdor1lA5IoTwGuBZpZrXBiMXW/LhWPrrKJsOBQpB8SAG
	 ZWFnPjWzLTrBERjBFx7CVX5AySoxbkM55HbaMnHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKKGko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfKKGkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:40:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C61420818;
        Mon, 11 Nov 2019 06:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573454442;
        bh=cktYl62Ynev3YcbNhpece5Z14fVDGbQyuOjqOeQf4Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9AYN0qRT9g+HjcozyPSfAxeXGwrD/p62xk0fGvNIEwwbe+jeCiTdU8Z02UVy8mBU
         6EhCkCncoqGPQRkmPCtjtIcB0iFmEimLIfokLW8QumwPcVen8DJd5ozAHFuDbPRuWF
         ps+wnu+3R+bj461e+l6N90ZizCpBxyUGAqcNdeRQ=
Date:   Mon, 11 Nov 2019 07:40:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] base: soc: Export soc_device_to_device() helper
Message-ID: <20191111064040.GA3502217@kroah.com>
References: <20191103013645.9856-3-afaerber@suse.de>
 <20191111045609.7026-1-afaerber@suse.de>
 <20191111052741.GB3176397@kroah.com>
 <586fa37c-6292-aca4-fa7c-73064858afaf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <586fa37c-6292-aca4-fa7c-73064858afaf@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 06:42:05AM +0100, Andreas Färber wrote:
> Hi Greg,
> 
> Am 11.11.19 um 06:27 schrieb Greg Kroah-Hartman:
> > On Mon, Nov 11, 2019 at 05:56:09AM +0100, Andreas Färber wrote:
> >> Use of soc_device_to_device() in driver modules causes a build failure.
> >> Given that the helper is nicely documented in include/linux/sys_soc.h,
> >> let's export it as GPL symbol.
> > 
> > I thought we were fixing the soc drivers to not need this.  What
> > happened to that effort?  I thought I had patches in my tree (or
> > someone's tree) that did some of this work already, such that this
> > symbol isn't needed anymore.
> 
> I do still see this function used in next-20191108 in drivers/soc/.
> 
> I'll be happy to adjust my RFC driver if someone points me to how!

Look at c31e73121f4c ("base: soc: Handle custom soc information sysfs
entries") for how you can just use the default attributes for the soc to
create the needed sysfs files, instead of having to do it "by hand"
which is racy and incorrect.

> Given the current struct layout, a type cast might work (but ugly).
> Or if we stay with my current RFC driver design, we could use the
> platform_device instead of the soc_device (which would clutter the
> screen more than "soc soc0:") or resort to pr_info() w/o device.

Ick, no, don't cast blindly.  What do you need the pointer for?  Is this
for in-tree code?

thanks,

greg k-h
