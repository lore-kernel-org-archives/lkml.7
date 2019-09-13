Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E5AC4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7C12089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568387455;
	bh=mlOuDQQnvN+0T53mUIADRJSv6FqN9GNg5U8ukgfoLYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tyLxGT9mK1NcfdEYtPWLjc4UcZJJTa3SiybP31R7qIzS7g6wuzI207QjEiC1K46r0
	 XcurU7XJUqY0eZSTaBK6tUPq7z5EL1IfWXYGKctEXmtKrUy354cInPZbMaT7kh2szh
	 XAbW0zv2FrbMNp0RCdkw9XTtZWAjUfV+6u2evRH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391187AbfIMPKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390046AbfIMPKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:10:54 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D4620640;
        Fri, 13 Sep 2019 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568387454;
        bh=mlOuDQQnvN+0T53mUIADRJSv6FqN9GNg5U8ukgfoLYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onxugGw0+FvpKFku4WKZrbIlbGYrWkXA+zSq8pMPrkT4Zms2Ird03beT05J2Mnwyd
         ulhJV2LK1wFf7IPUqO6TL3N6lYuvtTORYx6hC+4Bx2bnaSh+Qf6bIfCeRnDXUfBoM0
         s+FSQWC4H793K2MM7LDjPgnhJJUccucswMqVYxrQ=
Date:   Fri, 13 Sep 2019 16:10:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        "# 3.9+" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 092/190] drm/nouveau: Dont WARN_ON VCPI allocation
 failures
Message-ID: <20190913151051.GB458191@kroah.com>
References: <20190913130559.669563815@linuxfoundation.org>
 <20190913130606.981926197@linuxfoundation.org>
 <CAKb7UviY0sjFUc6QqjU4eKxm2b-osKoJNO2CSP9HmQ5AdORgkw@mail.gmail.com>
 <20190913144627.GH1546@sasha-vm>
 <20190913145456.GA456842@kroah.com>
 <20190913150111.GI1546@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913150111.GI1546@sasha-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:01:11AM -0400, Sasha Levin wrote:
> On Fri, Sep 13, 2019 at 03:54:56PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Sep 13, 2019 at 10:46:27AM -0400, Sasha Levin wrote:
> > > On Fri, Sep 13, 2019 at 09:33:36AM -0400, Ilia Mirkin wrote:
> > > > Hi Greg,
> > > >
> > > > This feels like it's missing a From: line.
> > > >
> > > > commit b513a18cf1d705bd04efd91c417e79e4938be093
> > > > Author: Lyude Paul <lyude@redhat.com>
> > > > Date:   Mon Jan 28 16:03:50 2019 -0500
> > > >
> > > >    drm/nouveau: Don't WARN_ON VCPI allocation failures
> > > >
> > > > Is this an artifact of your notification-of-patches process and I
> > > > never noticed before, or was the patch ingested incorrectly?
> > > 
> > > It was always like this for patches that came through me. Greg's script
> > > generates an explicit "From:" line in the patch, but I never saw the
> > > value in that since git does the right thing by looking at the "From:"
> > > line in the mail header.
> > > 
> > > The right thing is being done in stable-rc and for the releases. For
> > > your example here, this is how it looks like in the stable-rc tree:
> > > 
> > > commit bdcc885be68289a37d0d063cd94390da81fd8178
> > > Author:     Lyude Paul <lyude@redhat.com>
> > > AuthorDate: Mon Jan 28 16:03:50 2019 -0500
> > > Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > CommitDate: Fri Sep 13 14:05:29 2019 +0100
> > > 
> > >    drm/nouveau: Don't WARN_ON VCPI allocation failures
> > 
> > Yeah, we should fix your scripts to put the explicit From: line in here
> > as we are dealing with patches in this format and it causes confusion at
> > times (like now.)  It's not the first time and that's why I added those
> > lines to the patches.
> 
> Heh, didn't think anyone cared about this scenario for the stable-rc
> patches.
> 
> I'll go add it.
> 
> But... why do you actually care?

On the emails we send out, it has inproper author information which can
cause confusion that the sender of the email (i.e. me) is somehow saying
that they are the author of the patch.

thanks,

greg k-h
