Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAC6C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916A921736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575037421;
	bh=a6hVaNk8Q5k0+z4Duh/JUZyIYtxLSMk7z1cZzIAf0GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CkXdTJrwr2yGC2HCLsBEeIqs1wRus506Wkhq9EqHLE4IPir0VNRuFyxR0qeBxtrm7
	 B03Le6nS9r/lIpFUBMxST/w5g8k64Lf1KK4Sg7uOUaWomFP4xyiPXYgtXAENRBh6FX
	 9XGkXI4TdqOyzCwc8w+LlhQYleWNPVQ+1Jp0UQfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK2OXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfK2OXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:23:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB56421736;
        Fri, 29 Nov 2019 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575037418;
        bh=a6hVaNk8Q5k0+z4Duh/JUZyIYtxLSMk7z1cZzIAf0GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZHRte+qixw/1DoCnDBWO+aWSSd3zjgZTj98SjElOBexRNGivsUYNeMgSPvur9Rqgs
         ZW2scqiR9OYadHtsbOTHr31KnQxdau2+o8/4Ts7e/Wsri4Mr4HVAP0vJbf4/qOQUck
         RlMHD6ps4grcwbdWua8DcoE96vH/9B9ad7XdIc28=
Date:   Fri, 29 Nov 2019 15:23:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: gigaset: fix crashes on probe
Message-ID: <20191129142336.GB3708476@kroah.com>
References: <20191129101753.9721-1-johan@kernel.org>
 <20191129133239.GA3703941@kroah.com>
 <20191129135145.GJ29518@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129135145.GJ29518@localhost>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 02:51:45PM +0100, Johan Hovold wrote:
> On Fri, Nov 29, 2019 at 02:32:39PM +0100, Greg Kroah-Hartman wrote: > On Fri, Nov 29, 2019 at 11:17:49AM +0100, Johan Hovold wrote:
> > > Syzbot has been reporting a GPF on probe in the gigaset ISDN driver,
> > > which have since been moved to staging.
> > > 
> > > The first patch fixes that issue, and the next one fixes a second crash
> > > found during testing.
> > > 
> > > The third patch addresses a benign warning in USB core which syzbot is
> > > bound to report once the crashes have been fixed.
> > > 
> > > And while I hate playing checkpatch games, the final patch addresses a
> > > checkpatch warning introduced on purpose by the third patch.
> > 
> > I'll take these after 5.5-rc1, but then it is time to just delete all of
> > drivers/staging/isdn/ from my tree, so don't worry about them after that
> > :)
> 
> Sounds good to me. :)
> 
> But we should probably get these backported before dropping
> staging/isdn. Not sure if syzbot is run against older stable trees as
> well, but if so, you may want to consider adding a stable-tag also to
> patch 3/4.

Yes, I will backport them, it's a good idea to do that.

thanks,

greg k-h
