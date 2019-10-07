Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E99C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1DD2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="XsijO0EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfJGALT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 20:11:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40232 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJGALS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:11:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so10809799edm.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 17:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QGtrV+pb9vRgHm1oQhfpzA9Xe3MxFc1eFcaUiM/XTQQ=;
        b=XsijO0EWaBkewhpB/UMbNmWnA32SVQuYAW0k+oYa5PG6m6BVil8Lm76X28imP60KQo
         BmXFXTK1GfpbhZ6w3jzMjOZXxB7ORbMYXu45JuPzBHlxosmghnO/LNBQfyRbBOIOLK4+
         X7vV5VKXs1ypP5Kmz+2tT3e/fVsrsnZ3uIxED9PPPhH/aRXMB2zYtr6wbEO//Qn0aNEv
         uvh1Y6KYTX3ULzVmCxwQp6Q/UFpg1yp4gwY+NrINi4ErLm209xL08fhvjNj+NbPu+IBP
         Zab4OkAHb+D+KKEamMP0Pqg5I0Op97/mYxn+zmvlSL/hGSvwTunFFrqq2ve5wO8Nb1zK
         c//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QGtrV+pb9vRgHm1oQhfpzA9Xe3MxFc1eFcaUiM/XTQQ=;
        b=oYiwA+kdBQf7tVb98X2PuX5z9vGV4KGg/SB8Ua39MSE8fTEfqAxv1k1wPuZgdKbot/
         uDbY2bjzf4MYATeCh7JZwXVf60msFgt+A9M+7a92+ChD/VxPkkm30qCmlHTGpSzoCWn+
         gKgaU9DLCxPWSjvJa1dp5e55MSuTIQFVbvHImWAXeilnPferQaBDR0iXd8NnEm4fL13n
         +Vsbwo/OPew1vFoGkd4hnZXqBGA5tL+GwmgQAGopSZtDU7G5WCrZxDdPW8XyE1v79ek4
         lVTgn4mP5Xfn+6mML5b3PrdqHCIVuljztZFsd1g19WFR1Z7HQgJk9VsPfdoh7BT7DMGL
         EEKw==
X-Gm-Message-State: APjAAAXxh0/5gaRoXq7sBTH52heEAwpJTIVXJs7ciua6fQFlhtUPusah
        OYDIq5UfcIT22eJcRNc6GPWLfw==
X-Google-Smtp-Source: APXvYqwHDN40ec2a36S6fE0iPuB/n9YMuih2kxEFHdcazhYB8H+9N5RB3OlUeiHgWosBecTviOo9lQ==
X-Received: by 2002:a17:906:e0c2:: with SMTP id gl2mr21419914ejb.157.1570407076098;
        Sun, 06 Oct 2019 17:11:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z20sm3048900edb.3.2019.10.06.17.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 17:11:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D4007103243; Mon,  7 Oct 2019 03:11:13 +0300 (+03)
Date:   Mon, 7 Oct 2019 03:11:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Daniel Colascione <dancol@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
Message-ID: <20191007001113.ad4lbxqjxexo5svq@box.shutemov.name>
References: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
 <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw>
 <CAKOZuesKY_=qkSXfmDO_1ALaqQtU0kz5Z+fBh05c8BR7oCDxKw@mail.gmail.com>
 <20191004123349.GB10845@dhcp22.suse.cz>
 <20191004132624.ctaodxaxsd7wzwlh@box>
 <CAKOZuesqgEBSNvpsdw1QhVvYBNBUjAL0pu1x_b-C5q22Z7BZ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesqgEBSNvpsdw1QhVvYBNBUjAL0pu1x_b-C5q22Z7BZ4g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 06:45:21AM -0700, Daniel Colascione wrote:
> On Fri, Oct 4, 2019 at 6:26 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Fri, Oct 04, 2019 at 02:33:49PM +0200, Michal Hocko wrote:
> > > On Wed 02-10-19 19:08:16, Daniel Colascione wrote:
> > > > On Wed, Oct 2, 2019 at 6:56 PM Qian Cai <cai@lca.pw> wrote:
> > > > > > On Oct 2, 2019, at 4:29 PM, Daniel Colascione <dancol@google.com> wrote:
> > > > > >
> > > > > > Adding the correct linux-mm address.
> > > > > >
> > > > > >
> > > > > >> +config SPLIT_RSS_COUNTING
> > > > > >> +       bool "Per-thread mm counter caching"
> > > > > >> +       depends on MMU
> > > > > >> +       default y if NR_CPUS >= SPLIT_PTLOCK_CPUS
> > > > > >> +       help
> > > > > >> +         Cache mm counter updates in thread structures and
> > > > > >> +         flush them to visible per-process statistics in batches.
> > > > > >> +         Say Y here to slightly reduce cache contention in processes
> > > > > >> +         with many threads at the expense of decreasing the accuracy
> > > > > >> +         of memory statistics in /proc.
> > > > > >> +
> > > > > >> endmenu
> > > > >
> > > > > All those vague words are going to make developers almost
> > > > > impossible to decide the right selection here. It sounds like we
> > > > > should kill SPLIT_RSS_COUNTING at all to simplify the code as
> > > > > the benefit is so small vs the side-effect?
> > > >
> > > > Killing SPLIT_RSS_COUNTING would be my first choice; IME, on mobile
> > > > and a basic desktop, it doesn't make a difference. I figured making it
> > > > a knob would help allay concerns about the performance impact in more
> > > > extreme configurations.
> > >
> > > I do agree with Qian. Either it is really helpful (is it? probably on
> > > the number of cpus) and it should be auto-enabled or it should be
> > > dropped altogether. You cannot really expect people know how to enable
> > > this without a deep understanding of the MM internals. Not to mention
> > > all those users using distro kernels/configs.
> > >
> > > A config option sounds like a bad way forward.
> >
> > And I don't see much point anyway. Reading RSS counters from proc is
> > inherently racy. It can just either way after the read due to process
> > behaviour.
> 
> Split RSS accounting doesn't make reading from mm counters racy. It
> makes these counters *wrong*. We flush task mm counters to the
> mm_struct once every 64 page faults that a task incurs or when that
> task exits. That means that if a thread takes 63 page faults and then
> sleeps for a week, that thread's process's mm counters are wrong by 63
> pages *for a week*. And some processes have a lot of threads,
> compounding the error. Split RSS accounting means that memory usage
> numbers don't add up. I don't think it's unreasonable to want a mode
> where memory counters to agree with other indicators of system
> activity.

It's documented behaviour that is upstream for 9 years. Why is your workload
special?

The documentation suggests to use smaps if you want to have precise data.
Why would it not fly for you?

> Nobody has demonstrated that split RSS accounting actually helps in
> the real world.

The original commit 34e55232e59f ("mm: avoid false sharing of mm_counter")
shows numbers on cache misses. It's not a real world workload, but you
don't have any numbers at all to back your claim.

> But I've described above, concretely, how split RSS
> accounting hurts. I've been trying for over a year to either disable
> split RSS accounting or to let people opt out of it. If you won't
> remove split RSS accounting and you won't let me add a configuration
> knob that lets people opt out of it, what will you accept?

Keeping stats precise is welcome, but often expensive. It might be
negligible for small machine, but becomes a problem on multisocket
machine with dozens or hundreds of cores. We need to keep kernel scalable.

We have other stats that update asynchronously (i.e. /proc/vmstat). Would
you like to convert them too?

-- 
 Kirill A. Shutemov
