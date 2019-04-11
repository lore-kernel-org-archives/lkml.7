Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA78AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9724E2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNWDni2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDKQyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:54:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47074 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:54:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so8243982wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Otu8oQ57F7UNmqh12Qrt5qvVebAwqh7zepUUOR2psCw=;
        b=fNWDni2WBHljHOFUUJspzmpa63RWuYdVIS0I3zOyBS2lLLO6KySQ51cmWNiO7hc2Zl
         ECt/C5Ky670bJQ5Y/0J0LhOCfc0Lt2Iwpob0TZ7SIP5kv9C9NNRB1wStqN/N2tYLuIKw
         wZg0KFFK27GJ1pbKVFkdVwDqOyreBFZk/jafrt6UExSb4bI4BAkAjcPUss8hpIGyWHct
         5ikRIfAdd9LNMlN4QIMJoanmN2oiEoSZWVAINnP8ESOpbf1mzxDB7iVXd9gmjJZUG9zF
         Ju866VB9mBqZkVotHQnuvZKKWpWRfOzBfvhObdATWC3h+6KUBTdrH/MXs5IMpClUYU84
         G7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Otu8oQ57F7UNmqh12Qrt5qvVebAwqh7zepUUOR2psCw=;
        b=AEbj1dCNevHD2UJXrSswP26aZ7yRUITBKouFoPi8mxN0QNQcgQX7bK7KbQ2NvZNxKn
         OwE8458X46id+2kO2GDtVFXXzkyT4Wzxp20mkecAqU3OPaSBP9XjjPq4tNEUX7ld3hiO
         ii8trMPTQFEJVJ98Ayq9eI3Ubk4KSpJsUp1Uwc+ftBoh6VPdDa304VyywCXuKigvVLV1
         vGI/Hj6vw800Wvjx3NC05yMFsynKdvpLCrX7pOX1yGYmYfO8WgirVqd3BJne9oNFn8UI
         HKCmYN6SnsukiRI3OXp9bEP/2fFgm4xLKCTiHSj84w1nylhjk0VsWmi1Q/Jeyghx4PK6
         gTow==
X-Gm-Message-State: APjAAAVDnZs5QScQQ7As4uU1FK4lKPuU6cdneyWHq4SMQ2kRwHG2tOlu
        iA11Hhx5p9ux0Hvgk65n9JgPWE0LHK3OzU7GZljgjQ==
X-Google-Smtp-Source: APXvYqwj1boQo/nBHeqnGk+RcSMgv151Qay/U+p6/XYdYT7weeYhs8WiIbKmtBlUigIKITxE7cnT6zBNx7yHx2o6yRk=
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr12832082wrj.16.1555001660732;
 Thu, 11 Apr 2019 09:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <e1fc2c84f5ef2e1408f6fee7228a52a458990b31.camel@surriel.com>
 <20190411121633.GV10383@dhcp22.suse.cz>
In-Reply-To: <20190411121633.GV10383@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 11 Apr 2019 09:54:09 -0700
Message-ID: <CAJuCfpG0qE4LCq78UzT-Bh0Q+iYL0yaMByqeaNDwmXgrXCVZVQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [RFC 0/2] opportunistic memory reclaim of a killed process
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-team <kernel-team@android.com>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        yuzhoujian@didichuxing.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Tim Murray <timmurray@google.com>,
        lsf-pc@lists.linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Christian Brauner <christian@brauner.io>, ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 5:16 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 11-04-19 07:51:21, Rik van Riel wrote:
> > On Wed, 2019-04-10 at 18:43 -0700, Suren Baghdasaryan via Lsf-pc wrote:
> > > The time to kill a process and free its memory can be critical when
> > > the
> > > killing was done to prevent memory shortages affecting system
> > > responsiveness.
> >
> > The OOM killer is fickle, and often takes a fairly
> > long time to trigger. Speeding up what happens after
> > that seems like the wrong thing to optimize.
> >
> > Have you considered using something like oomd to
> > proactively kill tasks when memory gets low, so
> > you do not have to wait for an OOM kill?
>
> AFAIU, this is the point here. They probably have a user space OOM
> killer implementation and want to achieve killing to be as swift as
> possible.

That is correct. Android has a userspace daemon called lmkd (low
memory killer daemon) to respond to memory pressure before things get
bad enough for kernel oom-killer to get involved. So this asynchronous
reclaim optimization would allow lmkd do its job more efficiently.

> --
> Michal Hocko
> SUSE Labs
>
> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
