Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D50C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 05:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECF7208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 05:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561266024;
	bh=zFQ1/H48FzWgTv6CLGVT5WbQRHwPzkIBssyelN4JGBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=or3db7SbdnkBGo5E4ujsaxxTGCqL+qr0qFXZOdXupOYLNYz9OqJswYsRvv0TtLzSt
	 3zLpf1w4YmX3zbmDNdeKMIHXtkt8Qi8Bph+UxGCvgXi+tfezpOO3iynRjhrFSCUAKm
	 YlYM4ipYmrCn3O6lgO9heFouPcfwocrTzpmT0yWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFWFAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 01:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfFWFAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 01:00:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C008C20657;
        Sun, 23 Jun 2019 05:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561266022;
        bh=zFQ1/H48FzWgTv6CLGVT5WbQRHwPzkIBssyelN4JGBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5hyGDBuXrnwZleT/6R5LpQJYM6i/9R6ETbO+AdEk5oAh+tCHHUkD2oiw5eVBE3n+
         4aiBaQlw37diejkKDBzBvlQVMBxO9c2WrOAFvZ5Ta2aiB+6US7DxVP//ffBMFgXpAD
         0f8og+WjVZsf45ij5BdZJ80+Yfx/SsWA6Op24WfY=
Date:   Sun, 23 Jun 2019 07:00:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lkdtm: remove redundant initialization of ret
Message-ID: <20190623050019.GC4812@kroah.com>
References: <20190614094311.24024-1-colin.king@canonical.com>
 <20190621140347.GA7011@kroah.com>
 <20190621140509.GB7011@kroah.com>
 <201906210920.E133B26C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906210920.E133B26C@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:26:05AM -0700, Kees Cook wrote:
> On Fri, Jun 21, 2019 at 04:05:09PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 21, 2019 at 04:03:47PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jun 14, 2019 at 10:43:11AM +0100, Colin King wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > The variable ret is being initialized with the value -EINVAL however
> > > > this value is never read and ret is being re-assigned later on. Hence
> > > > the initialization is redundant and can be removed.
> > > > 
> > > > Addresses-Coverity: ("Unused value")
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > Acked-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  drivers/misc/lkdtm/core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> > > > index bba093224813..92df35fdeab0 100644
> > > > --- a/drivers/misc/lkdtm/core.c
> > > > +++ b/drivers/misc/lkdtm/core.c
> > > > @@ -390,7 +390,7 @@ static int __init lkdtm_module_init(void)
> > > >  {
> > > >  	struct crashpoint *crashpoint = NULL;
> > > >  	const struct crashtype *crashtype = NULL;
> > > > -	int ret = -EINVAL;
> > > > +	int ret;
> > > >  	int i;
> > > >  
> > > >  	/* Neither or both of these need to be set */
> > > > -- 
> > > > 2.20.1
> > > > 
> > > 
> > > With this patch now applied, I get this build warning:
> > > drivers/misc/lkdtm/core.c: In function lkdtm_module_init:
> > > drivers/misc/lkdtm/core.c:467:9: warning: ret may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   return ret;
> > >          ^~~
> > > 
> > > So are you _sure_ it shouldn't be initialized?
> > 
> > In looking at the code in my tree, ret is used uninitialized with this
> > patch, so maybe coverity is wrong, or I don't have all of the needed
> > patches?
> 
> The path went away when the check for debugfs_create_file() was removed.
> I thought that patch was in your tree already?

Ah, other tree, sorry, my fault.  I'll go queue this up to the place
that patch is...

thanks,

greg k-h
