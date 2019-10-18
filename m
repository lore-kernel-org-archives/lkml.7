Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F433CA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB089222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIOtObID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391890AbfJRILv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:11:51 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36882 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfJRILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:11:51 -0400
Received: by mail-yb1-f195.google.com with SMTP id z125so1569955ybc.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbrbICubD3bXmWnYbOIskkXx4MwqbmP9fw85/ZSp3Ck=;
        b=aIOtObIDPdGwv7gk6cVYXSD+b7Yu7fjEezPclytEOVEnidkTqz45CNM/rjgEbn3n2Z
         PlFokea7ndfCUjN77HVdAXcDxcD5PlVPDILTeWKn2L65QHvKY5dBrl1/38VUQNn133y5
         J136qxDJcwpF4RkBMisALmKLHRm5SeXnUgD63kM/HWijSQXrt04h9xFBRW8hITaU5CaN
         NbORJ5V4HRCKYIDet8v49ZOu+zQPIwFYKFMC9srlJ0zQzdA3xLtzqgw9GgKkC7VXiOah
         elBa5z0y2Rljjdvm5511XrHapDcWom9TATNBKypSVXFSh+OIzuYlcZBQHBSmeOIcL+Hd
         KLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbrbICubD3bXmWnYbOIskkXx4MwqbmP9fw85/ZSp3Ck=;
        b=g5pitVomjm+GIou/xQAPLbJ17UIq1+mq2o+X7fHh2H9kXLhBevL+4RW6aY/B+FKhD6
         38PUha2uwJnenl7u3e7PUi9VjWE5lsUJSRsCwVIe6/pfwqqijTXT4zuTYCdQ37BBWvP4
         /76mla1f1PCXB8ePF7h3vP50gDp7QbgrYMCt64w0NxrINMBpupIAk/k1vlqZVmYd8w4m
         VWmC98hEAvTYMgegxXZfggoVIyMTsF+8XM6/NuuaEl8U1PeQ7kTKMNz9wEKQTww8deie
         7kr5vrpk4vsV8Oqxy8Y9YvpVVRhcLueRqXJdTBnwa2fjTQh2OG8v+llenVnW/5gOV8SH
         SYqw==
X-Gm-Message-State: APjAAAUdUNjWzf0ixO1J+r681zMnBI7z+Xq3/SjZekpDtd4NioKDgp+K
        dhG8DtpLafqHZmvjEOakzbPnPQBFXR8Oc+ukd0q7VQ==
X-Google-Smtp-Source: APXvYqxZ/JO+9feTE8in8AGq6r+hWQLtoKEIYK/DQzc8axjX00AoR+nxgxd+YoEz0nrAin1oK1HUKE6oml8LaZyK1dc=
X-Received: by 2002:a25:e5c2:: with SMTP id c185mr5195789ybh.332.1571386309974;
 Fri, 18 Oct 2019 01:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <CABCjUKDWRJO9s68qhKQGXzrW39KqfZzZhoOX0HgDcnv-RxJZPw@mail.gmail.com>
 <85512332-d9d4-6a72-0b42-a8523abc1b5f@intel.com>
In-Reply-To: <85512332-d9d4-6a72-0b42-a8523abc1b5f@intel.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Fri, 18 Oct 2019 17:11:38 +0900
Message-ID: <CABCjUKDa+AQLrXf1h2QPqDqVePQoL_mJo4uUiOZss2vmeGoN5g@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, dan.j.williams@intel.com,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 1:32 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/17/19 9:01 AM, Suleiman Souhlal wrote:
> > One problem that came up is that if you get into direct reclaim,
> > because persistent memory can have pretty low write throughput, you
> > can end up stalling users for a pretty long time while migrating
> > pages.
>
> Basically, you're saying that memory load spikes turn into latency spikes?

Yes, exactly.

> FWIW, we have been benchmarking this sucker with benchmarks that claim
> to care about latency.  In general, compared to DRAM, we do see worse
> latency, but nothing catastrophic yet.  I'd be interested if you have
> any workloads that act as reasonable proxies for your latency requirements.

Sorry, I don't know of any specific workloads I can share. :-(
Maybe Jonathan or Shakeel have something more.

I realize it's not very useful without giving specific examples, but
even disregarding persistent memory, we've had latency issues with
direct reclaim when using zswap. It's been such a problem that we're
conducting experiments with not doing zswap compression in direct
reclaim (but still doing it proactively).
The low write throughput of persistent memory would make this worse.

I think the case where we're most likely to run into this is when the
machine is close to OOM situation and we end up thrashing rather than
OOM killing.

Somewhat related, I noticed that this patch series ratelimits
migrations from persistent memory to DRAM, but it might also make
sense to ratelimit migrations from DRAM to persistent memory. If all
the write bandwidth is taken by migrations, there might not be any
more available for applications accessing pages in persistent memory,
resulting in higher latency.


Another issue we ran into, that I think might also apply to this patch
series, is that because kernel memory can't be allocated on persistent
memory, it's possible for all of DRAM to get filled by user memory and
have kernel allocations fail even though there is still a lot of free
persistent memory. This is easy to trigger, just start an application
that is bigger than DRAM.
To mitigate that, we introduced a new watermark for DRAM zones above
which user memory can't be allocated, to leave some space for kernel
allocations.

-- Suleiman
