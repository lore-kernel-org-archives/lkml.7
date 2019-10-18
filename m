Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7759FCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C26C222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACvp92dW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409659AbfJRJTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:19:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46932 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390499AbfJRJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:19:07 -0400
Received: by mail-yw1-f67.google.com with SMTP id l64so1908814ywe.13;
        Fri, 18 Oct 2019 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+lQ2vvz51oFYeiM6k7BQbwMui72bfHQHjmRy0L+AxA=;
        b=ACvp92dWges5svxbhRUbOeZgMj4RVHJBCPyqRlUDAbQOWOtKdysk3+ZmIzVP3/p9of
         8QEJ0hTE5RHPa3EX4JMa/5betwdH08Nu0KjN60a++w/MREl7B0IP1Ha/Jvz2Ip6bDDpe
         HiAe2+rRuHb894TeULs91YERSQcOiCXJaQEx/Ni96LitP6ZmM3mlof0Jl7HkdE6VqHvS
         S2RBXc6NpfJIuvRXju4BmvjCvz8xaf5sNYPtzOhg5OluuDcmZf1HTcoZ3bqWnBbfTCCi
         wg/0CizUmf2y7YO5n7SceAu14dPfN4d04yO+VrcCkgBOOk4+O8gzD6FYMXl8xwDIp89S
         S9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+lQ2vvz51oFYeiM6k7BQbwMui72bfHQHjmRy0L+AxA=;
        b=Asfw7EEr+Z3DhA0Vs10+th+/hLuaiI1mSwSDt0jbTPUmYGj2OI8f3veOLNQXUmEY7z
         jhxR0k8NR5ZBL4sZ/cMzUxGVXzOsEf6Yq+KT0XKM/2riqOo7aZ2d25wIBfipUiAvK1ZI
         U2f3YZCQEZHRj0pD71VSW+whCQyRT4PfFkbpLerQNj4bcCQkzibIhWWiGtjUNfONKUYT
         Co7wlEBTnO+OOjXabeFIPZtpcCOqydqm9mz+UOMCX/gZHmWGU4B2sxeJ1iP/91J+u9wd
         SdZNpWaOmGtS4Vqmu8fGpztRnFxIFVSFRgTUcG40O4eeaoBOJM8Mc4V5i6whpb4aDMVO
         B5gw==
X-Gm-Message-State: APjAAAWIAGnAYTKrEIi0NOyzYQoRsS6j2i15RD+qsLjpTGCSQIwQfRq9
        2xmTYALC7r785tMGit6IEwQ7MHXqzBLslR4n59Q=
X-Google-Smtp-Source: APXvYqyxtzf+5bBLVuzlkXmXNftfRV/zdGyqW/ymUVUbvCi5HWZYp9XZivPbaMnTq4UTh6nHp++iGJRqsdcPz6YG/iE=
X-Received: by 2002:a81:5742:: with SMTP id l63mr5816824ywb.295.1571390346123;
 Fri, 18 Oct 2019 02:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
 <1571218608-15933-3-git-send-email-gkulkarni@marvell.com> <b8e1a637-faf4-4567-7d3e-a4f13dfa1cf0@huawei.com>
 <CAKTKpr4QoTDjbSxO4CvSH2sNvmrTJKjxi+RZH4mYfyDaaN96Sw@mail.gmail.com>
 <20191017154750.jgn6e3465qrsu53e@willie-the-truck> <CAKTKpr5ntp5X6Lvp=rKT_F1E1ftdqtjSWTgpEOqEwaDMH2kc1w@mail.gmail.com>
 <f7c91a7d-1f0e-24be-1491-fd0dae7f1daf@huawei.com>
In-Reply-To: <f7c91a7d-1f0e-24be-1491-fd0dae7f1daf@huawei.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 18 Oct 2019 14:48:55 +0530
Message-ID: <CAKTKpr5-m3s_7zE1C=62yjUL8mPURzTBTiR2OD8bgx65LEAj9w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jan Glauber <jglauber@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 2:08 PM John Garry <john.garry@huawei.com> wrote:
>
> On 18/10/2019 05:21, Ganapatrao Kulkarni wrote:
> > Hi Will,
> >
> > On Thu, Oct 17, 2019 at 9:17 PM Will Deacon <will@kernel.org> wrote:
> >>
> >> On Thu, Oct 17, 2019 at 12:38:51PM +0530, Ganapatrao Kulkarni wrote:
> >>> On Wed, Oct 16, 2019 at 7:01 PM John Garry <john.garry@huawei.com> wrote:
> >>>>> +TX2_EVENT_ATTR(req_pktsent, CCPI2_EVENT_REQ_PKT_SENT);
> >>>>> +TX2_EVENT_ATTR(snoop_pktsent, CCPI2_EVENT_SNOOP_PKT_SENT);
> >>>>> +TX2_EVENT_ATTR(data_pktsent, CCPI2_EVENT_DATA_PKT_SENT);
> >>>>> +TX2_EVENT_ATTR(gic_pktsent, CCPI2_EVENT_GIC_PKT_SENT);
> >>>>> +
> >>>>> +static struct attribute *ccpi2_pmu_events_attrs[] = {
> >>>>> +     &tx2_pmu_event_attr_req_pktsent.attr.attr,
> >>>>> +     &tx2_pmu_event_attr_snoop_pktsent.attr.attr,
> >>>>> +     &tx2_pmu_event_attr_data_pktsent.attr.attr,
> >>>>> +     &tx2_pmu_event_attr_gic_pktsent.attr.attr,
> >>>>> +     NULL,
> >>>>> +};
> >>>>
> >>>> Hi Ganapatrao,
> >>>>
> >>>> Have you considered adding these as uncore pmu-events in the perf tool?
> >>>>
> >>> At the moment no, since the number of events exposed/listed are very few.
> >>
> >> Then sounds like a perfect time to nip it in the bud before the list grows
> >> ;)
> >
> > I had internal discussion with architecture team, they have confirmed
> > that, these are the only published events and no plan to add new.
> > However, If any such request comes from HW team in future, i will add
> > them to JSON files.
>
> Don't you find perf list is swamped with all the uncore events?
>
> For Huawei platform, I find this:
> ./perf list pmu | grep "Kernel PMU event" | grep hisi | wc -l
> 648
>

We don't have such issue at the moment. As i said earlier, the events
exposed are limited.
Total 16 events altogether(DMC, L3C and CCPI2) per socket.

root@SBR-26>~>> perf list | grep uncore | wc -l
32

> That's because we have so many instances of the same PMUs, not because
> there are many events per PMU.
>
> TBH, I would like to delete all the events from the hisi uncore kernel
> drivers, now that they're supported in the perf tool, but I think that
> would constitute an ABI breakage.
>
> Maybe there is a way to hide them, but I couldn't find it.
>
> John
>
> >
> > I have incorporate all your previous comments, Can you please Ack and
> > queue it to 5.5?
> >
> >>
> >> If you can manage with these things in userspace, then I agree with John
> >> that it would be preferential to do it that way. It also offers more
> >> flexibility if we get the metricgroup stuff working properly (I think it's
> >> buggered for big/little atm).
> >>
> >> Will
> >
> > Thanks,
> > Ganapat
> >
> > .
> >
>
>

Thanks,
Ganapat
