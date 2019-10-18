Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F5CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9698A222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKiKLVDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506194AbfJRVjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:39:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36398 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfJRVjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:39:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so6713503qkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bY4NoLLIA2LxI2FyZ9aT3ORwvJrt5W+Zk+P87M9n+pk=;
        b=QKiKLVDIzFSHKUdugd17QjjW7ZK9xWnIft/pB3KIyyahySNnv9Zzbdtt1jtshbe9rO
         kCAfYk/7g6+T54u1ZvAgHnoBMtBbl7X1zZ1OjcYQ1vbGqo0/dN2cqhcH3K3wOCOZXYNZ
         XyY23Q4vhkwoEA27BMwX6wMp7pQuVC2RUZGP2daSuFYTFJToYF6yzzBPgpkyfZ8br4xU
         JdqtVRC85gxwisHMIrTWSkoS8I1vQhJFeQOIaYrZqStYlaDzAh4ZR3EKkzWSXoG3xypE
         G2EAOfT2+qavqzrJvDtqlt4JYoqJmnGlQ1Jx9hlCj5PNW36Tf1T+PRlDVh5Of1Z079ay
         p1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bY4NoLLIA2LxI2FyZ9aT3ORwvJrt5W+Zk+P87M9n+pk=;
        b=RSZDwrNSLb4EGS6zGrC2Gv7zgnfX5ylKgDBxBjJ6rdXNNVQlxmM1sjQvw8J8m/qEJk
         jAPqk+k6DbQCaq9eB/Uzgv0RV77vY4eCV3f+f9fZn3lUA5BvxiqptwTWPOPx2K/0r9yQ
         qFQUsPZtTWUJiEKjI82lD3Z3XvDvc1q21eI8kj5d448o4gIhjH3kmfsuMXa5YxYRI0aj
         eDhkv7Ic7eYWON8XwumsywAs/Da0hMgDxnOGCjyohi+pm0k1ATmQj/3V6LvIXzCQkob+
         uuAYUCTB48fsdKR8gSDqt/qjaZ0YgdyEa4KuN3Mo7Le+5oCRLBuejDOlIHUwyJhobFZu
         rAPw==
X-Gm-Message-State: APjAAAWy++7aVKCTb8ysErDCGkl+f4jYgOuNOZVRKOubqGXoWY+HNM5g
        XgJqpnu2VRME+pqrvkb+XdGvoMjgqjz64dS0jZE=
X-Google-Smtp-Source: APXvYqxBDQBjlYNcXuWgi6Z/8MKJ3/Q6fRnQiF/OXUjrxAyj4RaKcjPeB0LFAQTCe8+AuFmUUHdnYkae8oiTNgXh6K8=
X-Received: by 2002:a05:620a:20d5:: with SMTP id f21mr10873227qka.209.1571434788093;
 Fri, 18 Oct 2019 14:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <20191018074411.GC5017@dhcp22.suse.cz>
 <0b05c135-4762-e745-5289-58ee84cc8c3e@intel.com>
In-Reply-To: <0b05c135-4762-e745-5289-58ee84cc8c3e@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 18 Oct 2019 14:39:34 -0700
Message-ID: <CAHbLzkq3h1u=EUXeR3+S7D4fru7U15Tw+5Am8BE_FUkpHQTuWg@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 7:54 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/18/19 12:44 AM, Michal Hocko wrote:
> > How does this compare to
> > http://lkml.kernel.org/r/1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com
>
> It's a _bit_ more tied to persistent memory and it appears a bit more
> tied to two tiers rather something arbitrarily deep.  They're pretty
> similar conceptually although there are quite a few differences.

My patches do assume two tiers for now but it is not hard to extend to
multiple tiers. Since it is a RFC so I didn't make it that
complicated.

However, IMHO I really don't think supporting multiple tiers by making
the migration path configurable to admins or users is a good choice.
Memory migration caused by compaction or reclaim (not via syscall)
should be transparent to the users, it is the kernel internal
activity. It shouldn't be exposed to the end users.

I prefer firmware or OS build the migration path personally.

>
> For instance, what I posted has a static mapping for the migration path.
>  If node A is in reclaim, we always try to allocate pages on node B.
> There are no restrictions on what those nodes can be.  In Yang Shi's
> apporach, there's a dynamic search for a target migration node on each
> migration that follows the normal alloc fallback path.  This ends up
> making migration nodes special.

The reason that I didn't pursue static mapping is that the node might
be offlined or onlined, so you have to keep the mapping right every
time the node state is changed. Dynamic search just returns the
closest migration target node no matter what the topology is. It
should be not time consuming.

Actually, my patches don't restrict the migration target node has to
be PMEM, it could be any memory lower than DRAM, but it just happens
PMEM is the only available media. My patch's commit log explains this
point. Again I really prefer the firmware or HMAT or ACPI driver could
build the migration path in kernel.

In addition, DRAM node is definitely excluded from migration target
since I don't think doing such migration between DRAM nodes is a good
idea in general.

>
> There are also some different choices that are pretty arbitrary.  For
> instance, when you allocation a migration target page, should you cause
> memory pressure on the target?

Yes, those are definitely arbitrary. We do need sort of a lot of
details in the future by figuring out how real life workload work.

>
> To be honest, though, I don't see anything fatally flawed with it.  It's
> probably a useful exercise to factor out the common bits from the two
> sets and see what we can agree on being absolutely necessary.

Sure, that definitely would help us move forward.

>
