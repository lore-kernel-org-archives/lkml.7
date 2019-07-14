Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BEC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB91D2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MP1w8rQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfGNOXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 10:23:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52202 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfGNOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:23:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so12730689wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLgOaF7uPGQWrrQHZdojIJiFq3af4TIBkSiSnmLSrtg=;
        b=MP1w8rQwxe9+5R/g8DEo8ENY3HpEfAz0NHOaHcUUnIa2eov6i57pjCtwdRxfDaw76v
         bH3I54+2Qo4E7o9yzGZJT5zN4oS+/r1dtDSjSgT8gWEH4NsHF26JM8LnyY9VXZkmx5U6
         NMNOLIhR2E47J0XqdW+qYuWe1t92S+P97grWoEy5DDtHzAcT74uQOA2wiitlpZbVqD7d
         fs/DB7yy5y+wKpHAbpBGa/yt6oROuEg1Ytx+GgO7KM1H6H6frwkTNyPMoJj02EkKEZfI
         RsuAHlxo5VE6Q7Umou+jNaD1kU1SJ+1yO7gem+k57wdxcYMogXClAfbsmrKTG5WOIoDT
         A45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLgOaF7uPGQWrrQHZdojIJiFq3af4TIBkSiSnmLSrtg=;
        b=nAryr6Kj52IqKJktsudG06zbDXtDnKIzEDseP4vBJQZlb818iMDI1PL+EU2MDnDy44
         5vCk+tynZAwFECbIlAmuIKJlhLU/I83rvFPRrRvPXvccYun0mF/M/fssANXGbDtAJFV/
         8aZdCIWXoBFKPZguyH8HH8l0n2/j5pXvnBQ6V5DdTYhhQDzbleQbgAWlOc11XXJOut3O
         pNZ8sawuIKpv4zhGTxEe7USR4XNn6C1gJnA8SBJDmvCKdYIN/nSiwnc/lR8jZ3fBDvkE
         6z/CXlsbA0EvztQbRe7w0vlgNh95kK1zKxgE0mtWAhIXBCFdlTpVgnF78w3flI0+ywam
         fEEw==
X-Gm-Message-State: APjAAAU3NrStXju39EGIQNkD3+rKgUHK4Vps8kLCox2SDdikqEdCfYjp
        P9fXLVo5OS4n7MNicV4MIWM=
X-Google-Smtp-Source: APXvYqxIiOUzWPQ2ZsQy1ArLprbF5ukhUmGsJAVQy7tOdinhuZ1BSQTgMdCH5M2O3fcSfD9D5AJO5w==
X-Received: by 2002:a05:600c:1007:: with SMTP id c7mr18725037wmc.161.1563114186994;
        Sun, 14 Jul 2019 07:23:06 -0700 (PDT)
Received: from brauner.io (p4FC0A2B8.dip0.t-ipconnect.de. [79.192.162.184])
        by smtp.gmail.com with ESMTPSA id b203sm16388198wmd.41.2019.07.14.07.23.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 07:23:06 -0700 (PDT)
Date:   Sun, 14 Jul 2019 16:23:05 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Anatoly Pugachev <matorola@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clone: fix CLONE_PIDFD support
Message-ID: <20190714142304.3uihy4vepmxgdqha@brauner.io>
References: <20190714120206.GC6773@altlinux.org>
 <20190714121724.mwg2t3di6goha7yq@brauner.io>
 <20190714141007.GA9131@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190714141007.GA9131@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 05:10:08PM +0300, Dmitry V. Levin wrote:
> On Sun, Jul 14, 2019 at 02:17:25PM +0200, Christian Brauner wrote:
> > On Sun, Jul 14, 2019 at 03:02:06PM +0300, Dmitry V. Levin wrote:
> > > The introduction of clone3 syscall accidentally broke CLONE_PIDFD
> > > support in traditional clone syscall on compat x86 and those
> > > architectures that use do_fork to implement clone syscall.
> > > 
> > > This bug was found by strace test suite.
> > > 
> > > Link: https://strace.io/logs/strace/2019-07-12
> > > Fixes: 7f192e3cd316 ("fork: add clone3")
> > > Bisected-and-tested-by: Anatoly Pugachev <matorola@gmail.com>
> > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > 
> > Good catch! Thank you Dmitry.
> > 
> > One change request below.
> > 
> > > ---
> > >  arch/x86/ia32/sys_ia32.c | 1 +
> > >  kernel/fork.c            | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
> > > index 64a6c952091e..98754baf411a 100644
> > > --- a/arch/x86/ia32/sys_ia32.c
> > > +++ b/arch/x86/ia32/sys_ia32.c
> > > @@ -239,6 +239,7 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
> > >  {
> > >  	struct kernel_clone_args args = {
> > >  		.flags		= (clone_flags & ~CSIGNAL),
> > > +		.pidfd		= parent_tidptr,
> > >  		.child_tid	= child_tidptr,
> > >  		.parent_tid	= parent_tidptr,
> > >  		.exit_signal	= (clone_flags & CSIGNAL),
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 8f3e2d97d771..2c3cbad807b6 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -2417,6 +2417,7 @@ long do_fork(unsigned long clone_flags,
> > >  {
> > >  	struct kernel_clone_args args = {
> > >  		.flags		= (clone_flags & ~CSIGNAL),
> > > +		.pidfd		= parent_tidptr,
> > >  		.child_tid	= child_tidptr,
> > >  		.parent_tid	= parent_tidptr,
> > >  		.exit_signal	= (clone_flags & CSIGNAL),
> > > -- 
> > 
> > Both of these legacy clone helpers need to make CLONE_PIDFD and
> > CLONE_PARENT_SETTID incompatible, i.e. could you please add a helper to
> > kernel/fork.c:
> > 
> > bool legacy_clone_args_valid(const struct kernel_clone_args *kargs)
> > {
> > 	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
> > 	if ((kargs->flags & CLONE_PIDFD) && (kargs->flags & CLONE_PARENT_SETTID))
> > 		return false;
> > }
> > 
> > and export it and use it in ia32 too?
> 
> copy_process already performs the check, isn't this enough?

No it doesn't anymore. clone3() allows CLONE_PIDFD + CLONE_PARENT_SETTID
since struct clone_args has a dedicated pidfd return argument.

> Also, the check in sys_clone looks redundant and I was going to suggest
> its removal.

See above.
