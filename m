Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE152C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD352184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfbLouN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDKT4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:56:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35919 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKT4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:56:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so8153292wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 12:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lg0hWMJ42KhS273dLVmtjiem1n57p0phYc3aCztZZmg=;
        b=ZfbLouN/yweSuJhHjVGX3qEBDhFipr1oU9Ux4JpVEY4ccPHDmRRjGkFvjsDvAmYf3g
         1pDg2ro6jZdw/T2aSxXiKjvAaq6/EiYvlfHQt6+BZ3+mn4MtVWEjsf3hM0glyTVXHxSl
         Xw5jcTP/LGwql0o47dSWBf1iwV1j5yxOfx8uEyOTuWtQI+WyC/LFiQqPWCcAwn2irhP3
         93Qm/bmSPNR1pWmSUuoPzG3Dc+wN7pBFww7r98LzOv6rfTpkOZSQB0iSFMfQ1ogyv28I
         e2zI9hVGG1Mt5N8Eoo6n9EOeQGbxaTtZqTQUiTf+vgF/fgKf0rvaX9SVOn2fm6HXASCa
         Z3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg0hWMJ42KhS273dLVmtjiem1n57p0phYc3aCztZZmg=;
        b=OHc1PW1xXcNR7InbHdTm/w7RRy5ISLEOq0SGug7g5upsUf/f52FMFO3QGOKVZ/KCfM
         5YVJMjE24FZgO9lqlqjyzukTw8vJXjlzOrMmgnagr5c5jClFyTQhj5PFADldxRS0kVek
         Yk13kgffdsxG8EZXFqqi9moarWsFU926fWBoIWyWk1NcITqd/VfVVjc0b86ixtnvaEF/
         uR+5+3yfswD6etRfhezUn0rXRqzPjl9kjEsX5JtiGCH02JSzrBiL3Vd/e6N81FSrGOPT
         SHsnojm/Z8lRAnqu2xZ1BJVspNwsXkfDQaMLQna+gwCOkKVvoqjY3lZNiLGqmvcTeZ6V
         IJkA==
X-Gm-Message-State: APjAAAU2B3RsFmfNZ9qn8n3Mo85jG5pgOyrnTQCc9dnHIYcow+mgHAxH
        X4TsrOlLwoS6h5EhmoNJHLRpD4CHNU4Mw59DEDAbVQ==
X-Google-Smtp-Source: APXvYqxcQbob+za9RtxHt5VEPHNzn+qHcbGuUw8nqxG71DyZhYNjRHFFhJRI11WDs1FeGghLePlsv4QZ23K7Ern9EPE=
X-Received: by 2002:a1c:cfcb:: with SMTP id f194mr7621486wmg.51.1555012603911;
 Thu, 11 Apr 2019 12:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411105111.GR10383@dhcp22.suse.cz>
 <CAJuCfpEqCKSHwAmR_TR3FaQzb=jkPH1nvzvkhAG57=Pb09GVrA@mail.gmail.com> <20190411181946.GC10383@dhcp22.suse.cz>
In-Reply-To: <20190411181946.GC10383@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 11 Apr 2019 12:56:32 -0700
Message-ID: <CAJuCfpERmBzCpRTj5W1929OOiVEjcdBoSAsYXiYKoq0gsgRyhg@mail.gmail.com>
Subject: Re: [RFC 0/2] opportunistic memory reclaim of a killed process
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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

On Thu, Apr 11, 2019 at 11:19 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 11-04-19 09:47:31, Suren Baghdasaryan wrote:
> [...]
> > > I would question whether we really need this at all? Relying on the exit
> > > speed sounds like a fundamental design problem of anything that relies
> > > on it.
> >
> > Relying on it is wrong, I agree. There are protections like allocation
> > throttling that we can fall back to stop memory depletion. However
> > having a way to free up resources that are not needed by a dying
> > process quickly would help to avoid throttling which hurts user
> > experience.
>
> I am not opposing speeding up the exit time in general. That is a good
> thing. Especially for a very large processes (e.g. a DB). But I do not
> really think we want to expose an API to control this specific aspect.

Great! Thanks for confirming that the intent is not worthless.
There were a number of ideas floating both internally and in the 2/2
of this patchset. I would like to get some input on which
implementation would be preferable. From your answer sounds like you
think it should be a generic feature, should not require any new APIs
or hints from the userspace and should be conducted for all kills
unconditionally (irrespective of memory pressure, who is waiting for
victim's death, etc.). Do I understand correctly that this would be
the preferred solution?

> --
> Michal Hocko
> SUSE Labs
>
> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
