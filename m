Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60FACA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7AD2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9xpZwg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfJ3R3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:29:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40074 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfJ3R3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:29:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id f4so2195991lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+N4fNfrCnh5XD/j+gw/u546scpk+p72M9d2GjwEKtw=;
        b=y9xpZwg0OQdIZjMrMKukF1S7Ka69MlShAM1iJwglQiGRsH8TYTtlSsS/XoTVPU417G
         RwuKDYlGLLZacB603dG7XmD9qdZiVIAxCBopK3ds/Jl7A9FeFTWFQX9Dxm2gEgy0iMlb
         twG3l3w89janLtyiDitMXtf7exm7sxwxezHpHrdVptEyfwUnR/B+ibzHUdlS9j8vn0KF
         d51o0YrJH7z9c+zAtw3yQH4b7IyX36PXqowV4BLEKZHEQ01SH40mFlQINcgd5BYcapul
         RCXFpVPlCnfkE6xPUF8smsHVwhxIHd3vAq58qioF7pFk8hJOgD/GUYeFnY06+OKtvEPh
         0PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+N4fNfrCnh5XD/j+gw/u546scpk+p72M9d2GjwEKtw=;
        b=mMMR/Y+aAHsZw0j2Uil7X4B6nHYi7mYPRFPqNgvyEpel9VtEnNM1nyQJBPRAMkTtvH
         xg/+vu9nLtvzpY36zQikfy21HifcMj6bltbuYERGwL1qde+Cc9NflM6EMwtrTpQYtf+J
         RfMuJpPr5BYYm4whuUxEXdyu9xHoIR4kQh2/T5P40i/90qIAvmS6Eqhao9r7wGcb8BFb
         o1cXUu9K9EignP5WojApEQPJE09X0E2Z+ler9nA92ZF+ssC+eY9TrOU0gYiuHAcd4YCG
         83VVqLzj9DAE0J3LH1kLe/7l14bRd9RTlOr3TKFn7HskTYGoy8IbXgTmUkbLLB1S+LPI
         6zdw==
X-Gm-Message-State: APjAAAWHXOpxBKX2mZgyoVRuKUebuvusid4MebpPEqS30jQ+9qyQObfh
        1BHPnLO0zfMoVOpJpdzkpKuWFXJ9sqdM92/0iu4GXg==
X-Google-Smtp-Source: APXvYqydNIr7id9WpujxwPLe92/g+xWzv9heU8ORIvLqOLxRa0azwKeI/zidx+TfsBFGQU2wHDoitQJLI2ypS18AIcc=
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr144378lfq.177.1572456541669;
 Wed, 30 Oct 2019 10:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191021075038.GA27361@gmail.com> <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb> <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb> <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb> <564ca629-5c34-dbd1-8e64-2da6910b18a3@arm.com>
 <bf96be8a-2358-b9ab-b8eb-d0b8b94ed0d7@arm.com> <20191030171914.GF1686@pauld.bos.csb>
In-Reply-To: <20191030171914.GF1686@pauld.bos.csb>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Oct 2019 18:28:50 +0100
Message-ID: <CAKfTPtDVJH_eGiHCyz1Boz4m0tqMP3rgbSoudZ+9kPXB4_aGnQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
To:     Phil Auld <pauld@redhat.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 18:19, Phil Auld <pauld@redhat.com> wrote:
>
> Hi,
>
> On Wed, Oct 30, 2019 at 05:35:55PM +0100 Valentin Schneider wrote:
> >
> >
> > On 30/10/2019 17:24, Dietmar Eggemann wrote:
> > > On 30.10.19 15:39, Phil Auld wrote:
> > >> Hi Vincent,
> > >>
> > >> On Mon, Oct 28, 2019 at 02:03:15PM +0100 Vincent Guittot wrote:
> > >
> > > [...]
> > >
> > >>>> When you say slow versus fast wakeup paths what do you mean? I'm still
> > >>>> learning my way around all this code.
> > >>>
> > >>> When task wakes up, we can decide to
> > >>> - speedup the wakeup and shorten the list of cpus and compare only
> > >>> prev_cpu vs this_cpu (in fact the group of cpu that share their
> > >>> respective LLC). That's the fast wakeup path that is used most of the
> > >>> time during a wakeup
> > >>> - or start to find the idlest CPU of the system and scan all domains.
> > >>> That's the slow path that is used for new tasks or when a task wakes
> > >>> up a lot of other tasks at the same time
> > >
> > > [...]
> > >
> > > Is the latter related to wake_wide()? If yes, is the SD_BALANCE_WAKE
> > > flag set on the sched domains on your machines? IMHO, otherwise those
> > > wakeups are not forced into the slowpath (if (unlikely(sd))?
> > >
> > > I had this discussion the other day with Valentin S. on #sched and we
> > > were not sure how SD_BALANCE_WAKE is set on sched domains on
> > > !SD_ASYM_CPUCAPACITY systems.
> > >
> >
> > Well from the code nobody but us (asymmetric capacity systems) set
> > SD_BALANCE_WAKE. I was however curious if there were some folks who set it
> > with out of tree code for some reason.
> >
> > As Dietmar said, not having SD_BALANCE_WAKE means you'll never go through
> > the slow path on wakeups, because there is no domain with SD_BALANCE_WAKE for
> > the domain loop to find. Depending on your topology you most likely will
> > go through it on fork or exec though.
> >
> > IOW wake_wide() is not really widening the wakeup scan on wakeups using
> > mainline topology code (disregarding asymmetric capacity systems), which
> > sounds a bit... off.
>
> Thanks. It's not currently set. I'll set it and re-run to see if it makes
> a difference.

Because the fix only touches the slow path and according to Valentin
and Dietmar comments on the wake up path, it would mean that your UC
creates regularly some new threads during the test ?

>
>
> However, I'm not sure why it would be making a difference for only the cgroup
> case. If this is causing issues I'd expect it to effect both runs.
>
> In general I think these threads want to wake up the last cpu they were on.
> And given there are fewer cpu bound tasks that CPUs that wake cpu should,
> more often than not, be idle.
>
>
> Cheers,
> Phil
>
>
>
> --
>
