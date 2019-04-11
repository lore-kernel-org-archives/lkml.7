Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86622C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB852084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkPzNjXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDKRdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:33:47 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38215 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKRdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:33:46 -0400
Received: by mail-ua1-f65.google.com with SMTP id t15so2302424uao.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSeB4tqmSiQUf8xagvhoDocOkuTqy8cOj2EPyNoK+Hk=;
        b=dkPzNjXOPXQj+xsCF+38A/HaY6qh0VHusVhAJKzysy47FbNOhUUCIcbwMydUH/VcZQ
         xreBFmJY6sDonha4AADF2FbS3h+SgPFvzvSs+PHAAcTEHIbJn9kqveFOtA9RcplWKd14
         lYxptEgekXVtBHwpDoalLAK3qtKwsItHBa9NyZ/MaJj6UoYmNAjWlwbVPzOb1lX8qie5
         i++9R1GRweh3laQur+vNb29rB0E8zRVJjyF3KfYxGH302nAAAJcboqi80HRvJ6Yf/yE6
         EL+xH3ITdEoKNtoQQcPwilYKEvWXaeoW/7txYVxkVLOexAiCr3feFP4UAP0bDQDG1/Tu
         FAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSeB4tqmSiQUf8xagvhoDocOkuTqy8cOj2EPyNoK+Hk=;
        b=Yevg8Ydc6oOjn5HGcC+b9IY+2Vs1n2UmRFcp6zgWRJHLQ/+zHYVIzvp5lygzfs6PYW
         idA9qK+8+t7F+AM4e5g0AmRhuUrctfob28fPdwDHGJds0mZhiqi/ANBOOt1SpstRo2zd
         3jBZONLELVezf15LBdVkIm82fbXnECjXR5IMYh3ORjjE9olTjGUxRCf1LkCaKFNeXPtS
         Zsfq0BgDkPEgxSq+e7OOu1d+9JL2e6l2boIdTR6ELNqXtDNRBNj5gX2xKbwFDJZ6e4FR
         oy1QMSpbJXeQNtvbr5d2MmzanYCx4SWj8EeOmmGjMKvziluYVDg/vAk/KujPBnyO2jRe
         8DWw==
X-Gm-Message-State: APjAAAUD+8Ee5xO2ssbM0K0Zea1TCDeuJbB04zId/jJ99qnxOmhyRbUl
        GP2rYcR1vJKKRetR8KnwiGbMSmUQEgMioS5GKsVxzg==
X-Google-Smtp-Source: APXvYqxqDK+UTWOrRe6VZKjRV9FXctB6pwjbwfPyvjf+G7uJso/BwQnnEQ9arJ5o/fbzju80DfACs+85KGLVnqMuDMw=
X-Received: by 2002:ab0:3b8:: with SMTP id 53mr4991933uau.118.1555004024530;
 Thu, 11 Apr 2019 10:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
In-Reply-To: <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 11 Apr 2019 10:33:32 -0700
Message-ID: <CAKOZuetFU4tXE27bxA86zzDfNSCbw83p8fPxfkQ_d_Em0C04Sg@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
        Daniel Colascione <dancol@google.com>,
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

On Thu, Apr 11, 2019 at 10:09 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Apr 11, 2019 at 8:33 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > victim process. The usage of this flag is currently limited to SIGKILL
> > > signal and only to privileged users.
> >
> > What is the downside of doing expedited memory reclaim?  ie why not do it
> > every time a process is going to die?
>
> I think with an implementation that does not use/abuse oom-reaper
> thread this could be done for any kill. As I mentioned oom-reaper is a
> limited resource which has access to memory reserves and should not be
> abused in the way I do in this reference implementation.
> While there might be downsides that I don't know of, I'm not sure it's
> required to hurry every kill's memory reclaim. I think there are cases
> when resource deallocation is critical, for example when we kill to
> relieve resource shortage and there are kills when reclaim speed is
> not essential. It would be great if we can identify urgent cases
> without userspace hints, so I'm open to suggestions that do not
> involve additional flags.

I was imagining a PI-ish approach where we'd reap in case an RT
process was waiting on the death of some other process. I'd still
prefer the API I proposed in the other message because it gets the
kernel out of the business of deciding what the right signal is. I'm a
huge believer in "mechanism, not policy".
