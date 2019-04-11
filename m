Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F5C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1382082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jz89wF/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDKRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:48:03 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:47014 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKRsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:48:03 -0400
Received: by mail-vs1-f67.google.com with SMTP id e2so3969688vsc.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EdmEfhETvX5sRZ2i3AN4xgxKTisr0Ltj90Tc5NPzL+I=;
        b=jz89wF/PI7xg90sbXXootb01OYHrWVY1nyKpnYun8KA/55ifTn0poh8w9zFwRH252Z
         Dw+IysDpcGaJw6W5CznS2kYl/jSmZrStx7LG6OgW7ihxHEasnyj+5cNjp8m1rxozoENV
         vMjq/0/brXM7n2UaYUjItZAJjRAXYz1OmAao8Sd69dilMIvL2IJT3oDvDBgrSAejGbbH
         Zkfmdw/a3nVbVz2iTiFBR2bFuKyW6eJU5N2v2KaFR6vXkF5HJzyxVz9TqJVHMm1aLN/9
         EFNznjoGr1qh/+0NrHLQrLhfHjTFVDwPn5uDgrh7B5/JwMRo4NtPiZ0lSShhe+MBfz37
         1zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdmEfhETvX5sRZ2i3AN4xgxKTisr0Ltj90Tc5NPzL+I=;
        b=BcqqUIYTHpvyb7PKXdwXocuH621UvGsP86STtjwOqj3C/sTjoFupuPYneMP7C+SCTQ
         UxGM1dmvIJWaRViyrgzqfVkF8pRbE3ssKqDeDdxu328Vco0cpL0UFjPmdXoW/T0bwaAC
         Ym74bbx/mrnJYmymSFL5GGoYkKFoGTqEANNMKGoDEXbHiNrY+ZoUtN6L0dvQyV3aWTzr
         tKhWG3BTi0zlBCptJFVhpyFNH9oHADpCyN2thu7uA7SyqieER/Cas4yiBfe2S48yr10Q
         lS5s457EDaNFf7MPd8OKPNR2oJRgi3dMRqVo2CcRYSzUnR1BaZ0vnT41FZSKLgT94Uun
         CuNg==
X-Gm-Message-State: APjAAAVy9ZBhRMkbRFl5rXPM+zcUMg5BlYAxTSDeUiDzob6HkL+wjcgy
        Hai1U/wcZjzPuO8Ea5nk/nZH89tGdBpdoQxgC6atqA==
X-Google-Smtp-Source: APXvYqwI0Tosne+pusVzKzdHblB/C7MtpXTvYlDo3J+xGAIK5hCHrHvOO0GrDJKsNhe/ffI89eTSYRDp9xlhLXpu9Ig=
X-Received: by 2002:a05:6102:212:: with SMTP id z18mr29458490vsp.218.1555004881611;
 Thu, 11 Apr 2019 10:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
 <CAKOZuetFU4tXE27bxA86zzDfNSCbw83p8fPxfkQ_d_Em0C04Sg@mail.gmail.com> <20190411173649.GF22763@bombadil.infradead.org>
In-Reply-To: <20190411173649.GF22763@bombadil.infradead.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 11 Apr 2019 10:47:50 -0700
Message-ID: <CAKOZuet8-en+tMYu_QqVCxmkak44T7MnmRgfJBot0+P_A+Qzkw@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Apr 11, 2019 at 10:33:32AM -0700, Daniel Colascione wrote:
> > On Thu, Apr 11, 2019 at 10:09 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > On Thu, Apr 11, 2019 at 8:33 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > > > victim process. The usage of this flag is currently limited to SIGKILL
> > > > > signal and only to privileged users.
> > > >
> > > > What is the downside of doing expedited memory reclaim?  ie why not do it
> > > > every time a process is going to die?
> > >
> > > I think with an implementation that does not use/abuse oom-reaper
> > > thread this could be done for any kill. As I mentioned oom-reaper is a
> > > limited resource which has access to memory reserves and should not be
> > > abused in the way I do in this reference implementation.
> > > While there might be downsides that I don't know of, I'm not sure it's
> > > required to hurry every kill's memory reclaim. I think there are cases
> > > when resource deallocation is critical, for example when we kill to
> > > relieve resource shortage and there are kills when reclaim speed is
> > > not essential. It would be great if we can identify urgent cases
> > > without userspace hints, so I'm open to suggestions that do not
> > > involve additional flags.
> >
> > I was imagining a PI-ish approach where we'd reap in case an RT
> > process was waiting on the death of some other process. I'd still
> > prefer the API I proposed in the other message because it gets the
> > kernel out of the business of deciding what the right signal is. I'm a
> > huge believer in "mechanism, not policy".
>
> It's not a question of the kernel deciding what the right signal is.
> The kernel knows whether a signal is fatal to a particular process or not.
> The question is whether the killing process should do the work of reaping
> the dying process's resources sometimes, always or never.  Currently,
> that is never (the process reaps its own resources); Suren is suggesting
> sometimes, and I'm asking "Why not always?"

FWIW, Suren's initial proposal is that the oom_reaper kthread do the
reaping, not the process sending the kill. Are you suggesting that
sending SIGKILL should spend a while in signal delivery reaping pages
before returning? I thought about just doing it this way, but I didn't
like the idea: it'd slow down mass-killing programs like killall(1).
Programs expect sending SIGKILL to be a fast operation that returns
immediately.
