Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D71C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4FB2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555437831;
	bh=f5PLDSzQ0k6DZLuQf0lW+jMtus9QGMxToRDvwzpxAvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wQcVpOW/pBiTpBcjlPd9A1XfIXn7JsOyEh6RwjH4jHH2uBs6JwU1g6exiEpgi2Os5
	 gY6U198yhuTgl2pO9z97zcHnZi/IM0oMoY1094sfIjb7Qonp0OXWZzPdwQaWIhPiy+
	 rNkrkp9YZAdLmBrY9RjY+tQowZA3xdcJqgEDfOR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfDPSDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbfDPSDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BF6206B6;
        Tue, 16 Apr 2019 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555437829;
        bh=f5PLDSzQ0k6DZLuQf0lW+jMtus9QGMxToRDvwzpxAvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=109YCLU5QG/mM1s0nJ4klZVC/m80YujbGzcityg2mE2QGOuIYcTjCmU3ncAn1Z2XH
         LRMEWoHJnBTWEVOyslvfQbzdvXvsCSVPvluRwnLXjolb6m5YG5ZuLz3hie3oQ3552z
         XM5Rz+Hi3pspCV7CC6fICK0fQW2R6OWACAx62ba8=
Date:   Tue, 16 Apr 2019 20:03:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Development <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 64/76] parisc: Detect QEMU earlier in boot process
Message-ID: <20190416180346.GA26096@kroah.com>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183726.478117691@linuxfoundation.org>
 <e99d8712-6352-a94c-74c7-395b66293b9f@gmx.de>
 <20190416142350.GB31920@kroah.com>
 <b73a9caf-2461-3361-a6ed-b36a5d0a06c9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73a9caf-2461-3361-a6ed-b36a5d0a06c9@gmx.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 05:00:15PM +0200, Helge Deller wrote:
> On 16.04.19 16:23, Greg Kroah-Hartman wrote:
> > On Tue, Apr 16, 2019 at 03:50:16PM +0200, Helge Deller wrote:
> >> Hi Greg,
> >>
> >> please do NOT apply this patch to the 4.9 tree.
> >> See below, it was tagged for v4.14+ only.
> >
> > Yes, but I added it to 4.9 because:
> 
> Ah, ok.
> 
> >>> commit d006e95b5561f708d0385e9677ffe2c46f2ae345 upstream.
> >>>
> >>> While adding LASI support to QEMU, I noticed that the QEMU detection in
> >>> the kernel happens much too late. For example, when a LASI chip is found
> >>> by the kernel, it registers the LASI LED driver as well.  But when we
> >>> run on QEMU it makes sense to avoid spending unnecessary CPU cycles, so
> >>> we need to access the running_on_QEMU flag earlier than before.
> >>>
> >>> This patch now makes the QEMU detection the fist task of the Linux
> >>> kernel by moving it to where the kernel enters the C-coding.
> >>>
> >>> Fixes: 310d82784fb4 ("parisc: qemu idle sleep support")
> >
> > This commit is in 4.9.76.  So why wouldn't it be valid in 4.9.y (with
> > the exception of the fact that it doesn't build...)?
> 
> In my opinion it was not a critical-enough patch to ask for backporting this
> and the other depend patch.
> Idle-sleep does work without this patch, it's just upcoming qemu-support
> wich will not run optimal (but does work).
> 
> That said, of course it would be nice to get that backported in 4.9.
> I *think* if you pull in 5ffa8518851f1401817c15d2a7eecc0373c26ff9 too,
> it should be ok and fix the build issue.

Ok, I've pulled that patch in now as well, let me regenerate the tree
and see if that solves the issue or not.

thanks,

greg k-h
