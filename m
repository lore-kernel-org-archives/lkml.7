Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333BEC31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025F120859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560188919;
	bh=JCYtr578JZHDpZDNNeR6oaJuu0zaAN8vx7GBh/2uwDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SitiiSeTtdCLs15q5DqKaLGtomjlDVDf9/B33HfzUXsNTvj9iz3iKwMAN+HqLKbo8
	 coC3D7aYP7g6R1iXv8k93JU9gBhF1oQViRjNokOHPF0ZGErlAZYK+tDovx8fspzqgS
	 knCm2zurTQ6wgXAKMni7pAh0m0yAxvQ1fQN2VxBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbfFJRsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388137AbfFJRsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:48:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F382082E;
        Mon, 10 Jun 2019 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560188917;
        bh=JCYtr578JZHDpZDNNeR6oaJuu0zaAN8vx7GBh/2uwDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCtSbOGJJdsJVtrRQic15syeuz/CIQssKTnv1lIGTU+xmmTbiBHry4ebqKYPZhsTD
         fTiDmvJAimgk6+vtSXUmyQqn4MGqYJ5Xti6wN4yb/f0jrcONCQ77ig5Ki7vOg+jvEv
         skCS43g9oOaIilC9DIV05MC7Tb7Y7kWLUXJwfizY=
Date:   Mon, 10 Jun 2019 19:48:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firmware: Add support for loading compressed files
Message-ID: <20190610174835.GA11472@kroah.com>
References: <20190520092647.8622-1-tiwai@suse.de>
 <20190610172130.GA28902@kroah.com>
 <s5h1s01ic08.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1s01ic08.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 07:30:31PM +0200, Takashi Iwai wrote:
> On Mon, 10 Jun 2019 19:21:30 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Mon, May 20, 2019 at 11:26:42AM +0200, Takashi Iwai wrote:
> > > Hi,
> > > 
> > > this is a patch set to add the support for loading compressed firmware
> > > files.
> > > 
> > > The primary motivation is to reduce the storage size; e.g. currently
> > > the amount of /lib/firmware on my machine counts up to 419MB, and this
> > > can be reduced to 130MB file compression.  No bad deal.
> > > 
> > > The feature adds only fallback to the compressed file, so it should
> > > work as it was as long as the normal firmware file is present.  The
> > > f/w loader decompresses the content, so that there is no change needed
> > > in the caller side.
> > > 
> > > Currently only XZ format is supported.  A caveat is that the kernel XZ
> > > helper code supports only CRC32 (or none) integrity check type, so
> > > you'll have to compress the files via xz -C crc32 option.
> > > 
> > > The patch set begins with a few other improvements and refactoring,
> > > followed by the compression support.
> > > 
> > > In addition to this, dracut needs a small fix to deal with the *.xz
> > > files.
> > > 
> > > Also, the latest patchset is found in topic/fw-decompress branch of my
> > > sound.git tree:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> > 
> > I've applied the first 3 patches to my tree, as they were sane and good
> > cleanups.
> 
> Great, thanks!
> 
> > I'll wait for a test-case and a resend of the second two before taking
> > them {hint} :)
> 
> The patch for test_firmware was already sent, and it includes the test
> of the compressed firmware file.  In anyway, I'm going to resubmit the
> rest tomorrow.

Ah, sorry, I seem to have missed that.  A new series would be best,
thanks!

greg k-h
