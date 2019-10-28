Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4798CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 00:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892F32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 00:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="O77cxxp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfJ1A64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 20:58:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36032 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfJ1A6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 20:58:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id u16so6481864lfq.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aMsAP2PxExyB/E1NoTV0dqnnfdxMUwdxPX5EmrFyzA=;
        b=O77cxxp0TiDbHCipSNxBDPQs6T3YuiXf2d6J838uRz/Yz+afk4zkR4cPIm4g3CsmLU
         +BQIeATLcLKQ3CnG6y/WT1V6Wder0rgPEQQOcvJLBXyqGsXF44D7R/iyUcHJZdJUnlQ5
         +FKKNxPCswaqseS4VUyoitrkxGU/Xg/Mg6Nu6OYsvG4oOjj7V/sH3Aa+VajjKaSI5flC
         5RfLygrqux7RvLJcNKY0PfyXkS0784Dgxwvw6BQAJQJgqUJGj4NUukHElgcB73eiWejp
         Ch8wzrgFhJkDlErFtU7bxaYsLF/DhvBa20f/1dphxEnP9jFGkBzHzVzXqvtA+jPR4iLu
         jC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aMsAP2PxExyB/E1NoTV0dqnnfdxMUwdxPX5EmrFyzA=;
        b=Vk4wYUrKuCPsZEzrDGjuAF8iVGZqYKhDD9XGk+xO35UBr6NRiLm/Pgp99nzTEd+PfF
         7DjydrwCeWq7TyW5hUgInQs0UlE3UxDzdvKXGEFBrABQ4xPdTZ/85/+elxxjv5a0GRef
         enPgNVzDU3BdTF6T++7Al1/HpVt2RjBi/zYmvDOfw4MoJro17heMb3gewNgBgrvDP1pB
         nbfDJiFwlbQ8ynGnJLZiL3ro1cXZZ1nOLAuAzFcvcgco3oiumwIGpG4WY74vIulSKNvR
         HpDJHQk+y3eqt6fFKUHmSffOztCJ9dCnBHdR4cEVvvZD63p0HKQcfVHSaCs2KMVpgCBr
         gEWg==
X-Gm-Message-State: APjAAAV7ETNEPtfNysv61C2duIIowSX8ge+pHyVdtzGwvjJnqS8fIGRS
        Oke+RcWaxvVd3Mv6ehNDzdkMkHbG962usNcG3Wj09Q==
X-Google-Smtp-Source: APXvYqxuFefFQRfxYLkJfVt6hHBd6Eyt1FmfLGZfeU+h+svNEOHgMHfQEyL/zqhvT47BmrFDaTpQdCnU0C81rSHyBto=
X-Received: by 2002:a05:6512:146:: with SMTP id m6mr47893lfo.98.1572224332997;
 Sun, 27 Oct 2019 17:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191009060516.3577-1-r@hev.cc> <0911c1130bb79fd8c8e266bc7701b251@suse.de>
In-Reply-To: <0911c1130bb79fd8c8e266bc7701b251@suse.de>
From:   Heiher <r@hev.cc>
Date:   Mon, 28 Oct 2019 08:58:35 +0800
Message-ID: <CAHirt9iJhPA2BbHYFU81M3bcCwd9uk8T_Cvx9_3MRauwz-2+hg@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] fs/epoll: Remove unnecessary wakeups of nested epoll
To:     stable@vger.kernel.org
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 9, 2019 at 5:21 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> On 2019-10-09 08:05, hev wrote:
> > From: Heiher <r@hev.cc>
> >
> > Take the case where we have:
> >
> >         t0
> >          | (ew)
> >         e0
> >          | (et)
> >         e1
> >          | (lt)
> >         s0
> >
> > t0: thread 0
> > e0: epoll fd 0
> > e1: epoll fd 1
> > s0: socket fd 0
> > ew: epoll_wait
> > et: edge-trigger
> > lt: level-trigger
> >
> > We remove unnecessary wakeups to prevent the nested epoll that working
> > in edge-
> > triggered mode to waking up continuously.
> >
> > Test code:
> >  #include <unistd.h>
> >  #include <sys/epoll.h>
> >  #include <sys/socket.h>
> >
> >  int main(int argc, char *argv[])
> >  {
> >       int sfd[2];
> >       int efd[2];
> >       struct epoll_event e;
> >
> >       if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
> >               goto out;
> >
> >       efd[0] = epoll_create(1);
> >       if (efd[0] < 0)
> >               goto out;
> >
> >       efd[1] = epoll_create(1);
> >       if (efd[1] < 0)
> >               goto out;
> >
> >       e.events = EPOLLIN;
> >       if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
> >               goto out;
> >
> >       e.events = EPOLLIN | EPOLLET;
> >       if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
> >               goto out;
> >
> >       if (write(sfd[1], "w", 1) != 1)
> >               goto out;
> >
> >       if (epoll_wait(efd[0], &e, 1, 0) != 1)
> >               goto out;
> >
> >       if (epoll_wait(efd[0], &e, 1, 0) != 0)
> >               goto out;
> >
> >       close(efd[0]);
> >       close(efd[1]);
> >       close(sfd[0]);
> >       close(sfd[1]);
> >
> >       return 0;
> >
> >  out:
> >       return -1;
> >  }
> >
> > More tests:
> >  https://github.com/heiher/epoll-wakeup
> >
> > Cc: Al Viro <viro@ZenIV.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Davide Libenzi <davidel@xmailserver.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: Eric Wong <e@80x24.org>
> > Cc: Jason Baron <jbaron@akamai.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Roman Penyaev <rpenyaev@suse.de>
> > Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: hev <r@hev.cc>
> > ---
> >  fs/eventpoll.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index c4159bcc05d9..75fccae100b5 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -671,7 +671,6 @@ static __poll_t ep_scan_ready_list(struct eventpoll
> > *ep,
> >                             void *priv, int depth, bool ep_locked)
> >  {
> >       __poll_t res;
> > -     int pwake = 0;
> >       struct epitem *epi, *nepi;
> >       LIST_HEAD(txlist);
> >
> > @@ -738,26 +737,11 @@ static __poll_t ep_scan_ready_list(struct
> > eventpoll *ep,
> >        */
> >       list_splice(&txlist, &ep->rdllist);
> >       __pm_relax(ep->ws);
> > -
> > -     if (!list_empty(&ep->rdllist)) {
> > -             /*
> > -              * Wake up (if active) both the eventpoll wait list and
> > -              * the ->poll() wait list (delayed after we release the lock).
> > -              */
> > -             if (waitqueue_active(&ep->wq))
> > -                     wake_up(&ep->wq);
> > -             if (waitqueue_active(&ep->poll_wait))
> > -                     pwake++;
> > -     }
> >       write_unlock_irq(&ep->lock);
> >
> >       if (!ep_locked)
> >               mutex_unlock(&ep->mtx);
> >
> > -     /* We have to call this outside the lock */
> > -     if (pwake)
> > -             ep_poll_safewake(&ep->poll_wait);
> > -
> >       return res;
> >  }
>
> This looks good to me.  Heiher, mind to make kselftest out of your test
> suite?
>
> Reviewed-by: Roman Penyaev <rpenyaev@suse.de>
>
> --
> Roman
>
>
>

Need to back port this patch to stable branches?

-- 
Best regards!
Hev
https://hev.cc
