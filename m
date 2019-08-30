Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC31CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F1820659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567146555;
	bh=w5gHXGlwtkw2+r0MPL+BJkXamsnvdtNRlH2XT0EHQjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R0zZvtaDVAsCTloW/8kFbaKiRZTbYCdubjOHIcrLn4td9v/ikWx84i4ZlahEvdvRf
	 nbcSARZhIBweFcwQJ7V47uwpfNmTW493rtBCf1a9lFqQhLaDpnWvIjNJh7+huwscgM
	 5FJvDIeryCiUvfgd/AiaMcUmxkJUNmscRNyK8X64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfH3G3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfH3G3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:29:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A88F120659;
        Fri, 30 Aug 2019 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567146553;
        bh=w5gHXGlwtkw2+r0MPL+BJkXamsnvdtNRlH2XT0EHQjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zl/htVkwO8o8kRP/crnxSsKBzqX5r1VOcAf2+9z2mTsgV1h127OaVZ+P5pSJgFC4a
         1EjiRvpMeXynfXXQUneSP3UVBl4zFlWzbWlH9RFnc57ehE5WHYYhlyetYUGVNDCw0+
         vAqlhZHwR9xUo18lZSBQuCV8+NA2wh4UTgYe7Dyw=
Date:   Fri, 30 Aug 2019 08:29:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Todd Kjos <tkjos@android.com>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH AUTOSEL 4.19 11/29] binder: take read mode of mmap_sem in
 binder_alloc_free_page()
Message-ID: <20190830062910.GC15257@kroah.com>
References: <20190829105009.2265-1-sashal@kernel.org>
 <20190829105009.2265-11-sashal@kernel.org>
 <20190829151320.GC27650@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829151320.GC27650@elm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:13:20AM -0500, Tyler Hicks wrote:
> Hello, Sasha!
> 
> On 2019-08-29 06:49:51, Sasha Levin wrote:
> > From: Tyler Hicks <tyhicks@canonical.com>
> > 
> > [ Upstream commit 60d4885710836595192c42d3e04b27551d30ec91 ]
> > 
> > Restore the behavior of locking mmap_sem for reading in
> > binder_alloc_free_page(), as was first done in commit 3013bf62b67a
> > ("binder: reduce mmap_sem write-side lock"). That change was
> > inadvertently reverted by commit 5cec2d2e5839 ("binder: fix race between
> > munmap() and direct reclaim").
> > 
> > In addition, change the name of the label for the error path to
> > accurately reflect that we're taking the lock for reading.
> > 
> > Backporting note: This fix is only needed when *both* of the commits
> > mentioned above are applied. That's an unlikely situation since they
> > both landed during the development of v5.1 but only one of them is
> > targeted for stable.
> 
> This patch isn't meant to be applied to 4.19 since commit 3013bf62b67a
> ("binder: reduce mmap_sem write-side lock") was never brought back to
> 4.19.
> 
> Tyler
> 
> > 
> > Fixes: 5cec2d2e5839 ("binder: fix race between munmap() and direct reclaim")

But this commit is in 4.19.49

thanks,

greg k-h
