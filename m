Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94367C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A54217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsUA/mVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDKQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:47:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54716 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:47:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so7575218wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dv8W0uSuhruB6Ow9v6QugrS+DKPFo5aGlRKpFpwFspQ=;
        b=HsUA/mVqT8CymoEiQoNg0/Gf38OXb3WUWxUJmy731gBB6WpUMaeudGZ4f19nZXlzTl
         TUgarR5hli10/HNcDwnIEshjO+2nNAFiloYql2j0uI0K/AoJsk3UPhZTXucSG4WRnEOg
         b+Il+Beep7TnFFCGGSx4kjhDo3oX+C9KtOhYm28Z4VzCPAZ4T7E1dqOerdtTOdSEY3XP
         JJfMLdH0fnD2qW/y71NuWz56BnewagU2COLoblBvdKnf+8j2h3vkpG1NBCiZEB8z7cAV
         Y7Stz4CxTNVZsbh40Maxh/sVRF1QdfRvGGs+1yHavzdRPA/5mwwAna8t5/lHibGm49Sa
         EqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dv8W0uSuhruB6Ow9v6QugrS+DKPFo5aGlRKpFpwFspQ=;
        b=DawzmHfAMVWvPFRiP6twpXvPZIZKq6lEwO46/TRXgHBYWUXbnGwMXUpxVRPnzfX9zV
         t/wOS64ygcOfUmYIabY8staaT7UIpQMwpj4Ozd8+mmRmrbvm/oOo4pvQjWNoatPqQ8WZ
         +YPQhcCa3BZJJ1bpSUvHMiU0HvKwO1jIxur24Yk3CS4mvY6fQev/NG9YMFuIUYIf4wVR
         PeZW4Oyn4p/z8z1aNXHmt/BmSwhhRG/N5G5EgGtw4G/Ay2kJ7Scy5KOpsbOF65lregZe
         AlZl93gUt40D4PxNOx+P+MnDWqRjVY6pw4/V9kn26DHI1UdWf/AQn93BZ1kaaNPLUTTr
         igNg==
X-Gm-Message-State: APjAAAUJ/HEKpXjMknu1tR7lEDifEErt1vychHYA+mN7VWwtSWCIdaxs
        yZ2oETiFma68rY7TsgUPzh1C24HaZ6BotTn9n/NOEg==
X-Google-Smtp-Source: APXvYqyUhP38IRLUvPR0RERwVmyTMwrFXW5LElNnjZkqnR1nruiB0aChEoQo7d8r3XG4O0l8VEhObtZBwb3LreblKDU=
X-Received: by 2002:a1c:7512:: with SMTP id o18mr7772122wmc.68.1555001262701;
 Thu, 11 Apr 2019 09:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411105111.GR10383@dhcp22.suse.cz>
In-Reply-To: <20190411105111.GR10383@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 11 Apr 2019 09:47:31 -0700
Message-ID: <CAJuCfpEqCKSHwAmR_TR3FaQzb=jkPH1nvzvkhAG57=Pb09GVrA@mail.gmail.com>
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
        ebiederm@xmission.com, Shakeel Butt <shakeelb@google.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback!

On Thu, Apr 11, 2019 at 3:51 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 10-04-19 18:43:51, Suren Baghdasaryan wrote:
> [...]
> > Proposed solution uses existing oom-reaper thread to increase memory
> > reclaim rate of a killed process and to make this rate more determinist=
ic.
> > By no means the proposed solution is considered the best and was chosen
> > because it was simple to implement and allowed for test data collection=
.
> > The downside of this solution is that it requires additional =E2=80=9Ce=
xpedite=E2=80=9D
> > hint for something which has to be fast in all cases. Would be great to
> > find a way that does not require additional hints.
>
> I have to say I do not like this much. It is abusing an implementation
> detail of the OOM implementation and makes it an official API.

I agree with you that this particular implementation is abusing oom
internal machinery and I don't think it is acceptable as is (hence
this is sent as an RFC). I would like to discuss the viability of the
idea of reaping kill victim's mm asynchronously. If we agree that this
is worth our time, only then I would love to get into more details on
how to implement it. The implementation in this RFC is a convenient
way to illustrate the idea and to collect test data.

> Also
> there are some non trivial assumptions to be fullfilled to use the
> current oom_reaper. First of all all the process groups that share the
> address space have to be killed. How do you want to guarantee/implement
> that with a simply kill to a thread/process group?
>

I'm not sure I understood this correctly but if you are asking how do
we know that the mm we are reaping is not shared with processes that
are not being killed then I think your task_will_free_mem() checks for
that. Or have I misunderstood your question?

> > Other possible approaches include:
> > - Implementing a dedicated syscall to perform opportunistic reclaim in =
the
> > context of the process waiting for the victim=E2=80=99s death. A natura=
l boost
> > bonus occurs if the waiting process has high or RT priority and is not
> > limited by cpuset cgroup in its CPU choices.
> > - Implement a mechanism that would perform opportunistic reclaim if it=
=E2=80=99s
> > possible unconditionally (similar to checks in task_will_free_mem()).
> > - Implement opportunistic reclaim that uses shrinker interface, PSI or
> > other memory pressure indications as a hint to engage.
>
> I would question whether we really need this at all? Relying on the exit
> speed sounds like a fundamental design problem of anything that relies
> on it.

Relying on it is wrong, I agree. There are protections like allocation
throttling that we can fall back to stop memory depletion. However
having a way to free up resources that are not needed by a dying
process quickly would help to avoid throttling which hurts user
experience.
I agree that this is an optimization which is beneficial in a specific
case - when we kill to free up resources. However this is an important
optimization for systems with low memory resources like embedded
systems, phones, etc. The only way to prevent being cornered into
throttling is to increase the free memory margin that system needs to
maintain (I describe this in my cover letter). And with limited
overall memory resources memory space is at a premium, so we try to
decrease that margin.
I think the other and arguably even more important issue than the
speed of memory reclaim is that this speed depends on what the victim
is doing at the time of a kill. This introduces non-determinism in how
fast we can free up resource and at this point we don't even know how
much safety margin we need.

> Sure task exit might be slow, but async mm tear down is just a
> mere optimization this is not guaranteed to really help in speading
> things up. OOM killer uses it as a guarantee for a forward progress in a
> finite time rather than as soon as possible.
>
> --
> Michal Hocko
> SUSE Labs
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
