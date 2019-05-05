Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2017FC46460
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F3621479
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557062219;
	bh=b2YRcqnJU6y/jF4bNhb+eUd5PiyaaCBmAS4DtsxsrxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gvzy5XfXgYAn3tRTih8byBJtbZs+pGevRRUb/FYxdDlX27cdChEYBTBzZ+cUjqX91
	 BbcmI57qhmXlQ0ZCjo3PIzE/V6tHuV5t7D7/sWnpAyWWS66HEHy5+gCckIdBIKJVmF
	 7n01zCPjIeWcm+aTssUjl4ZeXWN2+Mmr103aXzxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfEENQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfEENQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:16:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A47A206DF;
        Sun,  5 May 2019 13:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557062216;
        bh=b2YRcqnJU6y/jF4bNhb+eUd5PiyaaCBmAS4DtsxsrxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2dp4jlTQASh7UohCLOUTYbp6RW37Du9KCBfi/HxHZCrmqaLiF7BhlnH3gmflcULw
         Nf58TQvOn/pwUSlQms+foQzxwgmS1sXIwQRqGnlkotTkCSdbJiMdHhVtDTfxJrrlnH
         xpdmvlBhdPpI8Sr2lX1qUqvqDq2krIzarut+Hpy0=
Date:   Sun, 5 May 2019 15:16:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH pstore-next v2 2/4] pstore: Allocate compression during
 late_initcall()
Message-ID: <20190505131654.GC25640@kroah.com>
References: <20181018185616.14768-1-keescook@chromium.org>
 <20181018185616.14768-3-keescook@chromium.org>
 <CAM0oz-91yjPQKnxGDjwFThs19U=+iziuUr=9z13NSibr_uRxZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0oz-91yjPQKnxGDjwFThs19U=+iziuUr=9z13NSibr_uRxZQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 11:37:51AM -0700, Douglas Anderson wrote:
> Hi,
> 
> On Thu, Oct 18, 2018 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> >
> > ramoops's call of pstore_register() was recently moved to run during
> > late_initcall() because the crypto backend may not have been ready during
> > postcore_initcall(). This meant early-boot crash dumps were not getting
> > caught by pstore any more.
> >
> > Instead, lets allow calls to pstore_register() earlier, and once crypto
> > is ready we can initialize the compression.
> >
> > Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > Fixes: cb3bee0369bc ("pstore: Use crypto compress API")
> > [kees: trivial rebase]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/pstore/platform.c | 10 +++++++++-
> >  fs/pstore/ram.c      |  2 +-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> I'd propose that these three patches:
> 
> 95047b0519c1 pstore: Refactor compression initialization
> 416031653eb5 pstore: Allocate compression during late_initcall()
> cb095afd4476 pstore: Centralize init/exit routines
> 
> Get sent to linux-stable.  Specifically I'll mention that 4.19 needs
> it.  IMO the regression of pstore not catching early boot crashes is
> pretty serious IMO.

So just those 3 commits and not this specific patch from Joel?

thanks,

greg k-h
