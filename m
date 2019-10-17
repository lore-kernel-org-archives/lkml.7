Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C2ECE597
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F1B21D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwkRzJle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440541AbfJQQ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:58:15 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:32774 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436726AbfJQQ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:58:15 -0400
Received: by mail-ua1-f67.google.com with SMTP id u31so898546uah.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kg//lwLZKtUtC71sdaS25fpU23PcwtzpAkjkp/pwT2U=;
        b=cwkRzJlepyoqyV1SYCC3uqvtuAB5npIfHD0177oRQgGm8B1l4ShBmYxu9y4hxVqJ9h
         pD8ZFYzF/gAAfz9pSCW4MOCW0Mx1zBeflWcPROFKUR0Yb+EYE/WqYpyoB1e1ONZ59gpP
         KzRrGZJPhDOiWuSiHaFVW0rjz6ZdRnLUWouQz8pXFjqrNXuryGyxrcUEyNlHgkQJ02g4
         kVeUK95AC/zB/sYoAvrAnxQ3h0anP48sED3MP3Rpjta1/xcQ7UTlUpOFOHwYfirlGiCX
         xC6+cxQ+ZqhuwIr3/M1k4i1p677dD6IQzsZJgTzgF93jgjIlotMH4DNm3GFegkDQ9i4B
         osTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kg//lwLZKtUtC71sdaS25fpU23PcwtzpAkjkp/pwT2U=;
        b=uLABrxlPFULB7o3h54R5gD1NDgTgvaVyZHuKlkYcF+ILMSvAQK8AnOyS+ynW10yIn8
         DQNzoLF0Ux4lyYP3mBblzcBcjAUHGgSXPEMcLnseT4pBhJaWWOY4pT97X45mYrrRjqrF
         HUgzf5YvG1QpqEN1XclmqCpHSo0goWnMIBFI3cwl4W0gMc6sZ8zYoHn5yC5ZiCE9yOtc
         Mvtpo+ZtXFhATuetoiPlozkVqTaUZ4Ne/oCsWj3P9yDMSCAS+lmH8sxsVAmo2y0CPIVf
         UKwoqm+5rNOy/wwOTv0aKdKBxxwZyAC2JqUnvcduMCtMB7v/PxYTtZz/AVHgQvgDF+A0
         BmWg==
X-Gm-Message-State: APjAAAVoW6xvzNV6Za018RExsox2LJUw+ASFjg1RAo7Wdc9lESTZY1Uf
        ZAPZHQAHD4wZQN13BZLz+d19sfZhC5rEegJoBOzbDQ==
X-Google-Smtp-Source: APXvYqyFO3ESXXkXBsBnMUusCukEWK9SCPYTcJ99h7r3Nfp8ePIiJudukiqQJ2LAUFg0xMCeDD6tgaD3LMszehfxXtw=
X-Received: by 2002:ab0:3748:: with SMTP id i8mr2917457uat.50.1571331493690;
 Thu, 17 Oct 2019 09:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <CALvZod5wdToX6bx4Bnwx9AgrzY3xkmE0OMH61f88hKxeGX+tvA@mail.gmail.com>
 <496566a6-2581-17f4-a4f2-e5def7f97582@intel.com>
In-Reply-To: <496566a6-2581-17f4-a4f2-e5def7f97582@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 17 Oct 2019 09:58:01 -0700
Message-ID: <CALvZod7kqjPJcdNQu3CO0+GU=0PyUE1YZgrDJcs8dBHpKbLkSg@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Adams <jwadams@google.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 7:26 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/16/19 8:45 PM, Shakeel Butt wrote:
> > On Wed, Oct 16, 2019 at 3:49 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> >> This set implements a solution to these problems.  At the end of the
> >> reclaim process in shrink_page_list() just before the last page
> >> refcount is dropped, the page is migrated to persistent memory instead
> >> of being dropped.
> ..> The memory cgroup part of the story is missing here. Since PMEM is
> > treated as slow DRAM, shouldn't its usage be accounted to the
> > corresponding memcg's memory/memsw counters and the migration should
> > not happen for memcg limit reclaim? Otherwise some jobs can hog the
> > whole PMEM.
>
> My expectation (and I haven't confirmed this) is that the any memory use
> is accounted to the owning cgroup, whether it is DRAM or PMEM.  memcg
> limit reclaim and global reclaim both end up doing migrations and
> neither should have a net effect on the counters.
>

Hmm I didn't see the memcg charge migration in the code on demotion.
So, in the code [patch 3] the counters are being decremented as DRAM
is freed but not incremented for PMEM.

> There is certainly a problem here because DRAM is a more valuable
> resource vs. PMEM, and memcg accounts for them as if they were equally
> valuable.  I really want to see memcg account for this cost discrepancy
> at some point, but I'm not quite sure what form it would take.  Any
> feedback from you heavy memcg users out there would be much appreciated.
>

There are two apparent use-cases i.e. explicit (apps moving their
pages to PMEM to reduce cost) and implicit (admin moves cold pages to
PMEM transparently to the apps) for the PMEM. In the implicit case, I
see both DRAM and PMEM as same resource from the perspective of memcg
limits i.e. same memcg counter, something like cgroup v1's  memsw).
For the explicit case, maybe separate counters make sense like cgroup
v2's memory and swap.

> > Also what happens when PMEM is full? Can the memory migrated to PMEM
> > be reclaimed (or discarded)?
>
> Yep.  The "migration path" can be as long as you want, but once the data
> hits a "terminal node" it will stop getting migrated and normal discard
> at the end of reclaim happens.

I might have missed it but I didn't see the migrated pages inserted
back to LRUs. If they are not in LRU, the reclaimer will never see
them.
