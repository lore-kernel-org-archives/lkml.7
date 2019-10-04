Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD39C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD6120873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICXJkKqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbfJDNp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:45:59 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36890 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfJDNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:45:59 -0400
Received: by mail-ua1-f65.google.com with SMTP id w7so2051781uag.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtRvtwjGRbYCsw+7d1bhF8H4AB/aClk4LmqQQW6q0qg=;
        b=ICXJkKqzB33AhHPs+SiVfyxcEzmKVXy/oHoYiHTsT120L3kRkyQFSb5X8KQV4+yb9i
         cTMIASlltOZMk1DOLYLMhmFT1Y81FHsJU57dUaqp65zbBPq9kN90iVEceym588zPTeFz
         kH398/qc9hF6jakYBk1NMR9R41MuGwH3DXZSZoPEfD6Q3zIHel7h1/jVfspcOEicjLOQ
         eVNzFiVHxCMhgtMfXUGG02QAvOoRqyF6ySkmuRkUJx3dg+Fx9yjGKXytgL6QlQ2w1oHI
         KC8NoZ9xpiZs9ftgI/nKG5W4gbbTPhmEtU9bjGhg/aTtan+xypipZkGcnCKQFUCeyG0z
         9C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtRvtwjGRbYCsw+7d1bhF8H4AB/aClk4LmqQQW6q0qg=;
        b=ImubemK8LWIaGjSNLl9HbxKqHzBRERqxKWFdEuZYBf5RgsQlmzeiCdsaXBQRQzUym8
         bflyD/gGQEJ4/sy6gXbE1gL9/E0sDAmvFqF7GRviwywlY7In4AGCpTyC9iwrBtOm1mLS
         iyhXajtITPH5hzKo/5Ly0JAOsLZdnIZySrikVN23BJZm0dbigyhzMyaRvdY10UXunfH+
         57q0qzh1XQNMd+YsUIjSB2GqaRDBg5Pu4zm6eB4Elgwvzkb7RZdP979lKMsyTJjZRiai
         QoRaHNgc+l5K4B7OwdzvQv3FEIw8OwU+awTC+0XewBPbN5BB20QRAY3RiZ5+ZkYRXpDA
         M6fA==
X-Gm-Message-State: APjAAAVcoLJscKAdet5McYw8BGsoULHKcZ/dvy2DK94RixMdcuKEyw1M
        lo6lv1rtkSor52MoBud7V5/t6O9rGZPZu0do7n5aai8r5FA=
X-Google-Smtp-Source: APXvYqxjF0CoPuCnxZytdFRri2vGndk6w36js/uFi10vdA/1zStGf7BrhD+CZCaBm8roV77/jNgn97xelmBnOweWlBQ=
X-Received: by 2002:ab0:14c4:: with SMTP id f4mr7966949uae.46.1570196758080;
 Fri, 04 Oct 2019 06:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
 <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw> <CAKOZuesKY_=qkSXfmDO_1ALaqQtU0kz5Z+fBh05c8BR7oCDxKw@mail.gmail.com>
 <20191004123349.GB10845@dhcp22.suse.cz> <20191004132624.ctaodxaxsd7wzwlh@box>
In-Reply-To: <20191004132624.ctaodxaxsd7wzwlh@box>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 4 Oct 2019 06:45:21 -0700
Message-ID: <CAKOZuesqgEBSNvpsdw1QhVvYBNBUjAL0pu1x_b-C5q22Z7BZ4g@mail.gmail.com>
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 6:26 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Fri, Oct 04, 2019 at 02:33:49PM +0200, Michal Hocko wrote:
> > On Wed 02-10-19 19:08:16, Daniel Colascione wrote:
> > > On Wed, Oct 2, 2019 at 6:56 PM Qian Cai <cai@lca.pw> wrote:
> > > > > On Oct 2, 2019, at 4:29 PM, Daniel Colascione <dancol@google.com> wrote:
> > > > >
> > > > > Adding the correct linux-mm address.
> > > > >
> > > > >
> > > > >> +config SPLIT_RSS_COUNTING
> > > > >> +       bool "Per-thread mm counter caching"
> > > > >> +       depends on MMU
> > > > >> +       default y if NR_CPUS >= SPLIT_PTLOCK_CPUS
> > > > >> +       help
> > > > >> +         Cache mm counter updates in thread structures and
> > > > >> +         flush them to visible per-process statistics in batches.
> > > > >> +         Say Y here to slightly reduce cache contention in processes
> > > > >> +         with many threads at the expense of decreasing the accuracy
> > > > >> +         of memory statistics in /proc.
> > > > >> +
> > > > >> endmenu
> > > >
> > > > All those vague words are going to make developers almost impossible to decide the right selection here. It sounds like we should kill SPLIT_RSS_COUNTING at all to simplify the code as the benefit is so small vs the side-effect?
> > >
> > > Killing SPLIT_RSS_COUNTING would be my first choice; IME, on mobile
> > > and a basic desktop, it doesn't make a difference. I figured making it
> > > a knob would help allay concerns about the performance impact in more
> > > extreme configurations.
> >
> > I do agree with Qian. Either it is really helpful (is it? probably on
> > the number of cpus) and it should be auto-enabled or it should be
> > dropped altogether. You cannot really expect people know how to enable
> > this without a deep understanding of the MM internals. Not to mention
> > all those users using distro kernels/configs.
> >
> > A config option sounds like a bad way forward.
>
> And I don't see much point anyway. Reading RSS counters from proc is
> inherently racy. It can just either way after the read due to process
> behaviour.

Split RSS accounting doesn't make reading from mm counters racy. It
makes these counters *wrong*. We flush task mm counters to the
mm_struct once every 64 page faults that a task incurs or when that
task exits. That means that if a thread takes 63 page faults and then
sleeps for a week, that thread's process's mm counters are wrong by 63
pages *for a week*. And some processes have a lot of threads,
compounding the error. Split RSS accounting means that memory usage
numbers don't add up. I don't think it's unreasonable to want a mode
where memory counters to agree with other indicators of system
activity.

Nobody has demonstrated that split RSS accounting actually helps in
the real world. But I've described above, concretely, how split RSS
accounting hurts. I've been trying for over a year to either disable
split RSS accounting or to let people opt out of it. If you won't
remove split RSS accounting and you won't let me add a configuration
knob that lets people opt out of it, what will you accept?
