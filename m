Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8E9217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565211694;
	bh=+qBbfBSMAH7Y3GHuWbe+rylHpzCgkxGkF76I78EmJxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zLtIArH1ovfoMfY6HPRujLXgdqLM+G3M68+xaXloQGehs+n4+SNFDdSKZrQbpyMyd
	 9a2JnXDT0IQJgy9FG7TaYGiapqqqMjJHsDjvu3SuYtaB1owYp8jpRWExUbbAQe+IKf
	 tGUqGC5Rihui9OcEDGgkDwDYXral604/XfKY76Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfHGVBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbfHGVBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:01:32 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E452173C;
        Wed,  7 Aug 2019 21:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565211691;
        bh=+qBbfBSMAH7Y3GHuWbe+rylHpzCgkxGkF76I78EmJxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVKMpM2eI1851tBovePX/3oFkhm0jedmWGpX0lOJRCyhVvcrHTCVgDWE9WFHNn1rP
         WFubGz9PQLZVC6YbI6q6EFc8Pfl349VJXeEIbnTNvRnETpfhuKci6P9uqPrkNuoWI2
         OZaLmDlzO29vPnGG+m4zGuD1EldUfhdTABKXMH6k=
Date:   Wed, 7 Aug 2019 14:01:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-Id: <20190807140130.7418e783654a9c53e6b6cd1b@linux-foundation.org>
In-Reply-To: <20190807205138.GA24222@cmpxchg.org>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
        <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
        <20190805193148.GB4128@cmpxchg.org>
        <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
        <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
        <20190806142728.GA12107@cmpxchg.org>
        <20190806143608.GE11812@dhcp22.suse.cz>
        <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
        <20190806220150.GA22516@cmpxchg.org>
        <20190807075927.GO11812@dhcp22.suse.cz>
        <20190807205138.GA24222@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019 16:51:38 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> However, eb414681d5a0 ("psi: pressure stall information for CPU,
> memory, and IO") introduced a memory pressure metric that quantifies
> the share of wallclock time in which userspace waits on reclaim,
> refaults, swapins. By using absolute time, it encodes all the above
> mentioned variables of hardware capacity and workload behavior. When
> memory pressure is 40%, it means that 40% of the time the workload is
> stalled on memory, period. This is the actual measure for the lack of
> forward progress that users can experience. It's also something they
> expect the kernel to manage and remedy if it becomes non-existent.
> 
> To accomplish this, this patch implements a thrashing cutoff for the
> OOM killer. If the kernel determines a sustained high level of memory
> pressure, and thus a lack of forward progress in userspace, it will
> trigger the OOM killer to reduce memory contention.
> 
> Per default, the OOM killer will engage after 15 seconds of at least
> 80% memory pressure. These values are tunable via sysctls
> vm.thrashing_oom_period and vm.thrashing_oom_level.

Could be implemented in userspace?
</troll>
