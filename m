Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3B2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A692082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfBtLJFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfDKRw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:52:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46674 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDKRw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:52:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so8462908wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWmf2gFVGYdGp3+zu1SOeQRU5dF4/Q9osFeNuzPV66M=;
        b=cfBtLJFewyMKRnYYnw21vINnPqrk2z7GXrfM4YvSVrWBgQq+nJOjapX/bWa5GUvuYY
         H3toxmQkRamCTdWSc8N3hDwzQdehoe+ScCzHOv6ZBgAJX3biWy24vKWv0lNW4hrPaXaO
         qBo1S2X8vw7dHA2BxIBEuMUibMJqCRACcBwW8wcxJ2Yqwv+asIld9QHvEQnMVQOJPgWy
         bp+m/WK6Dg+OZiuHifUQQfGgY6JUUuTSwDSXRs3EJl8COHu1SeN09A6JrgzaeNx/3XHH
         XRcffG/t68HskedwzTcwrH5utbMjIhnZI1NtOUdPNt4GKX40dNXqMl0hOKzAz/WV4qKE
         NwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWmf2gFVGYdGp3+zu1SOeQRU5dF4/Q9osFeNuzPV66M=;
        b=iD9v6rORghsfkZANlPDFrsAF8IV3JXJPW+AziasgJbDs4m+rt+u8Ze54JlifmA0YT2
         LsPfXXFrGe/HkrvWZBrs1zbnNdf8Yph4zXJl75/nxZrqCvih+PezQps+mOHBn7a+vaxk
         L489L/4E5+7C1C8QGrY9txtlWrJlV+xKZTrIXcY6AQvBc93JHWGl+kS5JmfIHT+pnU1t
         ApUw8tE7izQ3vov/++fgg/vd0zuRNX2a2dAKcPF3gABpkOoPCXjdA8CB4Ij3t0lYiuOu
         FpF1pYpIIJad+TYDzqEgeYedlYCmyN5J0hQfjGrp8ojSy3gBmU5a5GHtWtEFIKnUePwa
         69Mw==
X-Gm-Message-State: APjAAAUROdC8s2OHUDB4kTwu+aYE99YSgldiCZYjUrh5YeATzUAswmkF
        f5vP7Aie5kUmc5Qw7XxtMfMKTK8YYtb7ibFQRmjZGg==
X-Google-Smtp-Source: APXvYqwhl9r+dJ0Z/fammLyczcHvRtwhpBRx/JMX+uk7Nbkdaz4yEC6SKsx9MC9/KkL3DGJtwTYbXhZG31qaO53ZZtA=
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr8296918wrj.118.1555005176426;
 Thu, 11 Apr 2019 10:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
 <CAKOZuetFU4tXE27bxA86zzDfNSCbw83p8fPxfkQ_d_Em0C04Sg@mail.gmail.com> <20190411173649.GF22763@bombadil.infradead.org>
In-Reply-To: <20190411173649.GF22763@bombadil.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 11 Apr 2019 10:52:45 -0700
Message-ID: <CAJuCfpG1P42qnDmGZLGkYy+mkS7QjfYUjGGpEBa9UGgLt5=q4Q@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Colascione <dancol@google.com>,
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

If there are no downsides of doing this always (like using some
resources that can be utilized in a better way) then by all means,
let's do it unconditionally. My current implementation is not one of
such cases :)

I think with implementation when killing process is doing the reaping
of the victim's mm this can be done unconditionally because we don't
use resources which might otherwise be used in a better way. Overall I
like Daniel's idea of the process that requested killing and is
waiting for the victim to die helping in reaping its memory. It kind
of naturally elevates the priority of the reaping if the priority of
the waiting process is higher than victim's priority (a kind of
priority inheritance).
