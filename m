Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC08BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C257218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2y8SRdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfDLOOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:14:44 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46674 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLOOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:14:43 -0400
Received: by mail-vs1-f67.google.com with SMTP id e2so5594862vsc.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRoGxbJdzk5VSz+J5WZP/kt+pljWluiqtLQrAx6TCuI=;
        b=I2y8SRddDRNqAugRlPVyKaj1bSoHn3ghQl8DCaK1P1dXAsIS/lng2hR+VeAdB8hLex
         tb6tZ3i7e6rvBriPoLAs4UCeEHrYLuX17Op3KMmub0c6rb3hrU4KwK/oVCPDCJTqaJU3
         08DVZHhKgWljH8seJAKg9vLBdNH9RWvwil0OKY8Zkp/jyHmCeNEZ690BPyl+Obg56vbL
         M17lF+LdnoDqy8nXNH78D8o7OPJnodT+tCOv02Y7hhfmZ2zaggvO4EZD7Q2D1xyWn/kN
         PdjWyQajqDa6Gy4M+89LjMYNqhqMaMihQlTT/QoE/i2MA4eoYHJugVFqrj8UuW5csK3C
         hf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRoGxbJdzk5VSz+J5WZP/kt+pljWluiqtLQrAx6TCuI=;
        b=I0R/YiiNOUDTI7M88IRAO81r2Gm07pXBKLsBFAZvWbgclQJN5eFETMNHfVjIikl6sY
         ZL7cllkVVUGQmsUH2NyFKR37kEAzYSOx+45SKikBgmJ0BgHShiFStBF0gngn/df207ei
         wltM3J0rLPuAl/F/4c4qMMbtbpll+F9czXlhg413uWE3KFQSYq0L3tIYtPMZrDRFwF0x
         +hQz8iDu456wiNBdERffgIBlu58YRRK9CinakGfj5CkPjwLgogNZstHTjPeKrOPuu4o3
         fajxD0L3LW4yk38VNM7rF8y7/gN3j2xeBRdzVUer/Mt6wcaLmXu+neckrB5/SyF38Fpq
         41VQ==
X-Gm-Message-State: APjAAAVULYL+l6PvN/WzzYP13YB0I1rY07tWSPwkFzfTx9g6VoRDT/7X
        m8zz8m6D39BHzyYXvLTAnj1GY3qkZlhTgTCkYY5eIQ==
X-Google-Smtp-Source: APXvYqyu+/gmNYP2ogerG2Yndwwn3Grs2ZHb1phxFDU65FklJPoSvR4EM09M3KxMW143zzvBhxqw+7a9UvSE6NBly/s=
X-Received: by 2002:a67:6847:: with SMTP id d68mr31562611vsc.90.1555078482224;
 Fri, 12 Apr 2019 07:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <20190412065314.GC13373@dhcp22.suse.cz>
In-Reply-To: <20190412065314.GC13373@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Apr 2019 07:14:30 -0700
Message-ID: <CAKOZuetQH1rVtPdMNgw0sdnzWidd6v9eCWscRiOb7Y+3-JQ14Q@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:53 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 11-04-19 08:33:13, Matthew Wilcox wrote:
> > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > victim process. The usage of this flag is currently limited to SIGKILL
> > > signal and only to privileged users.
> >
> > What is the downside of doing expedited memory reclaim?  ie why not do it
> > every time a process is going to die?
>
> Well, you are tearing down an address space which might be still in use
> because the task not fully dead yeat. So there are two downsides AFAICS.
> Core dumping which will not see the reaped memory so the resulting

Test for SIGNAL_GROUP_COREDUMP before doing any of this then. If you
try to start a core dump after reaping begins, too bad: you could have
raced with process death anyway.

> coredump might be incomplete. And unexpected #PF/gup on the reaped
> memory will result in SIGBUS.

It's a dying process. Why even bother returning from the fault
handler? Just treat that situation as a thread exit. There's no need
to make this observable to userspace at all.
