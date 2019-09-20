Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBCBC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32AE20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568959474;
	bh=FMHYLNhnUIWX/Ad7Hx9zHh7rSIMaDyP2houL0wEpfnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yrXNZs2i8cXMXRx3QWE1Fg3wJGX7kmlmjYHqGyi9SqLWDLcfhUrMQyWAZlhH+0Qeh
	 /fAhqOfZUERCz6z6I7V1OYU7q3R+vB8gXmFDxYCbbZtqASMTgEWALdBY8XIqJP/8YL
	 Yz6ZmFWFaOaqMtxjpC7DlpmxkFyMsJVBwSe+P4/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408208AbfITGEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408197AbfITGEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:04:32 -0400
Received: from localhost (unknown [145.15.244.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14812086A;
        Fri, 20 Sep 2019 06:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568959471;
        bh=FMHYLNhnUIWX/Ad7Hx9zHh7rSIMaDyP2houL0wEpfnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4EWCyGCf0Pe4SOOTvruW2VA7hJDuNTJQvwqSPAm8TeTTyPgb3NzE2UD/Vxx7hhH8
         5EvAoib85g/KwuzD4n4t55sirjnnO++lnuM/bVmIL9LJJ1O91OHOmwZxErmI1YOWFR
         DUfktYSjkx6Ez0rYZ583u/BoyYnuLjiqAS6Dauy0=
Date:   Fri, 20 Sep 2019 08:04:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, penberg@cs.helsinki.fi,
        jslaby@suse.com, textshell@uchuujin.de, sam@ravnborg.org,
        daniel.vetter@ffwll.ch, mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        yuehaibing@huawei.com, zengweilin@huawei.com
Subject: Re: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
Message-ID: <20190920060426.GA473496@kroah.com>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com>
 <20190919092933.GA2684163@kroah.com>
 <nycvar.YSQ.7.76.1909192251210.24536@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1909192251210.24536@knanqh.ubzr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:56:15PM -0400, Nicolas Pitre wrote:
> On Thu, 19 Sep 2019, Greg KH wrote:
> 
> > On Thu, Sep 19, 2019 at 05:18:15PM +0800, Xiaoming Ni wrote:
> > > Using kzalloc() to allocate memory in function con_init(), but not
> > > checking the return value, there is a risk of null pointer references
> > > oops.
> > > 
> > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > We keep having this be "reported" :(
> 
> Something probably needs to be "communicated" about that.

I know, but it's also kind of fun to see what these "automated" checkers
find, sometimes the resulting patches almost work properly :)

This one is really close, I think if the likely/unlikely gets cleaned
up, it is viable.

> > >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > > +		if (unlikely(!vc)) {
> > > +			pr_warn("%s:failed to allocate memory for the %u vc\n",
> > > +					__func__, currcons);
> > > +			break;
> > > +		}
> > 
> > At init, this really can not happen.  Have you see it ever happen?
> 
> This is maybe too subtle a fact. The "communication" could be done with 
> some GFP_WONTFAIL flag, and have the allocator simply pannic() if it 
> ever fails.

That's a good idea to do as well.

thanks,

greg k-h
