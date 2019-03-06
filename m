Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06FBC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFBB20657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="oZi8soNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfCFVaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:30:05 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41071 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:30:04 -0500
Received: by mail-yw1-f67.google.com with SMTP id q128so11393517ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 13:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NGlf0gBKF+Q5ixlrYcrI4I5PHHPIvPCv8Cp9LR7yJBY=;
        b=oZi8soNmHYdaQ4vaMURDGrB+8OGgbjwg21His3g8aZTt23WOvVcKuCm9XpgsPShMOr
         EF8G7L4ZdmBS78e9Kjao6pdudjQUyfLg5f7kZZhT7roXi0uN4Ide032PWfbN6n2vkZh1
         KzGUosoJdsF5htcKWXwog+Gf4c+ebWX/qgPvWZdWSuNyMoF1l9kXEdGMUM+QCT6kXFqi
         /HCPjVSH1umfbSykMZu58mY9RbbymQd9/vuuTRSTt2bVWI582x/++6ozKTC4DvwLtKWX
         5BcLr9kjZ2aCH5mPL5uO8aTRV8/xaivHYwDAuXD2V4J63paBuxIaB1xNpVCXLqwNrDAC
         zFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGlf0gBKF+Q5ixlrYcrI4I5PHHPIvPCv8Cp9LR7yJBY=;
        b=YhM0ppLF7DVKUo6VG9jItNbdloaG3WBGIPPnKr6mDdRN43UZrPVw6kHGKX2vMrlwa6
         Jtz/+1sz6CFILF0xZJ5p4SRp3w+jKD/hbcFjL7q7CA5eKb1SDOyCqSvrja78x6pG7KxS
         IwYFoYnsVPkG6fkCa3wIqudHMLC25XZw2hbZ5LK1FjhZBO8MonUNkjjKUm1NkFYXpz8w
         xbCNvfNsOxjiYIyeaCMkFIhGGdF52IYzG+yUYrvp5ds5w/ynDPMZm+VmYPMNtzSbE0O6
         OLNjY3Pr+YKKQr4r/RGn5L/HQXsjccKgYzDudEB9uAPcvoybhMaKxSnmwUWeYirTMxAh
         NSkA==
X-Gm-Message-State: APjAAAUnHFQkBEnzfltXUwGqPQInjJuvnK5QNuL+V/OJatKI1JbZj6AH
        0rEmdL/lScjFlloLQh3gaColIg==
X-Google-Smtp-Source: APXvYqxH8/M4rLtzq+ngu8In/B87Onz29ncRKaK83jmmY1cqrWAxVyEldLH2L4iuIZ9vz+Xav0GtUA==
X-Received: by 2002:a81:615:: with SMTP id 21mr7523360ywg.295.1551907803104;
        Wed, 06 Mar 2019 13:30:03 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id m65sm885035ywb.46.2019.03.06.13.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:30:02 -0800 (PST)
Date:   Wed, 6 Mar 2019 14:30:00 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
Message-ID: <20190306213000.GI7413@cisco>
References: <20190306201413.14153-1-tycho@tycho.ws>
 <20190306201413.14153-2-tycho@tycho.ws>
 <20190306203932.im7lkblvmd227td3@gmail.com>
 <20190306204611.GH7413@cisco>
 <CAPP7u0Wp6q=LwtnbNk3YNaKKHXAfDqXd0Dx6xXXesvKpR-p+Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPP7u0Wp6q=LwtnbNk3YNaKKHXAfDqXd0Dx6xXXesvKpR-p+Gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:02:25PM +0100, Christian Brauner wrote:
> On Wed, Mar 6, 2019 at 9:46 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Wed, Mar 06, 2019 at 09:39:35PM +0100, Christian Brauner wrote:
> > > > +
> > > >     /* Prepare the new filter before holding any locks. */
> > > >     prepared = seccomp_prepare_user_filter(filter);
> > > >     if (IS_ERR(prepared))
> > > > @@ -1302,7 +1315,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
> > > >             mutex_unlock(&current->signal->cred_guard_mutex);
> > > >  out_put_fd:
> > > >     if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> > > > -           if (ret < 0) {
> > > > +           if (ret) {
> > >
> > > Why that change but keep checking if (ret < 0) further up?
> >
> > Not sure what you mean here. The only other place I see that we check
> > something is < 0 in that function is the return value of
> > get_unused_fd_flags(), which looks right to me?
> 
> The change just seemed it had nothing to do with the rest of the patch.
> Just making sure this didn't happen on accident and would cause regressions.

No, not on accident :). See the second half of the patch notes.

I can split it out into two separate patches if that makes more sense.
In fact this hunk alone fixes the UAF, but you still get non-sensical
return results even if it doesn't do anything terrible, hence the
first hunk.

Cheers,

Tycho
