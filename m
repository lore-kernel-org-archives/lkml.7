Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F02C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE98A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxWwskZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfG2Fmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:42:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43419 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfG2Fmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:42:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so27407195pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vgWidJp1DyKTPwyq6dR9hsFgPGq4asNb2UOZODn9yGQ=;
        b=qxWwskZ3C+G1kw+A2FmYJoQv61D2xQZwsqpcFae5kfXhswGgnWidmxRQcnZrZ6yPZV
         mZwBU2UBbqOPpwc+oU3YfleOCfJYojBTTFZRCc15yxyWU7F3FaeZYSqy4NHGx3RNHUHN
         8cjLLQpsJxUiWXWELCqgOoKTzQqE+31m3ovrKt6oVQ153hZdbsiDWEHvIV5COLJfDPYU
         nwvbbod74iaAti79MsV8rp5T0RDGS+8mQ5YHzGKhKTt3OvZBrcLOkCozAjGPcjFc1LmH
         Qbjk8wF4T7aErnJLLioE6EGnjWdaOAUskIk3eL0Q09dvc5+R5kseZ0iBnu3FKC01l3t2
         lbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vgWidJp1DyKTPwyq6dR9hsFgPGq4asNb2UOZODn9yGQ=;
        b=FpnTEWsgMPk+SujjPbnmklURc549+V6kXs+8KdCPjzeVTtrkFvc27MGFnKjPXZKg2Y
         BLPC2WUrTOGp/v9JuaCuglnAU1Kh4tjQ8P94sh2hXHTPHJOgVC/O1xHr0T0bxum6x6KX
         eK6dI7WpOHwrOvASGJcwr2GJTn2+ekK5my39SAfGxm7GPvTEKysgMElJXlth2EkCfiW0
         GwhkKC6Kjq3JI5wW465uX0yZ2LrRZRiB06TZzuStcx1SUVCS/S0KQN71y31v3wQImsit
         47A4HJRMuwCPVzVb4IKITbO+t0eIMpVvwKZkvmhR7AFOwWi7l0y0v3zGaF3aLv+qtX/M
         4Ang==
X-Gm-Message-State: APjAAAU5RkPC704st+aYG5TAuc3dJbglL66tqyHhXUd4u1qSOOThUCiU
        v5s4o9+mhLEyZv5grg18vc4=
X-Google-Smtp-Source: APXvYqwHkaLh7KKBYR49920g/O6KFmHx1WSzwkwKnft1/r1u1sWuU0ghjoM3tFGfASlWddJiinqypQ==
X-Received: by 2002:a17:90a:214e:: with SMTP id a72mr69619150pje.0.1564378970729;
        Sun, 28 Jul 2019 22:42:50 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id n89sm77014876pjc.0.2019.07.28.22.42.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 22:42:50 -0700 (PDT)
Message-ID: <b7de7d9d84e9dd47358a254d36f6a24dd48da963.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
From:   Rashmica Gupta <rashmica.g@gmail.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, anshuman.khandual@arm.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 15:42:43 +1000
In-Reply-To: <0cd2c142-66ba-5b6d-bc9d-fe68c1c65c77@redhat.com>
References: <20190625075227.15193-1-osalvador@suse.de>
         <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
         <20190626080249.GA30863@linux>
         <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
         <20190626081516.GC30863@linux>
         <887b902e-063d-a857-d472-f6f69d954378@redhat.com>
         <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
         <0cd2c142-66ba-5b6d-bc9d-fe68c1c65c77@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 14:28 +0200, David Hildenbrand wrote:
> On 02.07.19 08:42, Rashmica Gupta wrote:
> > Hi David,
> > 
> > Sorry for the late reply.
> 
> Hi,
> 
> sorry I was on PTO :)
> 
> > On Wed, 2019-06-26 at 10:28 +0200, David Hildenbrand wrote:
> > > On 26.06.19 10:15, Oscar Salvador wrote:
> > > > On Wed, Jun 26, 2019 at 10:11:06AM +0200, David Hildenbrand
> > > > wrote:
> > > > > Back then, I already mentioned that we might have some users
> > > > > that
> > > > > remove_memory() they never added in a granularity it wasn't
> > > > > added. My
> > > > > concerns back then were never fully sorted out.
> > > > > 
> > > > > arch/powerpc/platforms/powernv/memtrace.c
> > > > > 
> > > > > - Will remove memory in memory block size chunks it never
> > > > > added
> > > > > - What if that memory resides on a DIMM added via
> > > > > MHP_MEMMAP_DEVICE?
> > > > > 
> > > > > Will it at least bail out? Or simply break?
> > > > > 
> > > > > IOW: I am not yet 100% convinced that MHP_MEMMAP_DEVICE is
> > > > > save
> > > > > to be
> > > > > introduced.
> > > > 
> > > > Uhm, I will take a closer look and see if I can clear your
> > > > concerns.
> > > > TBH, I did not try to use
> > > > arch/powerpc/platforms/powernv/memtrace.c
> > > > yet.
> > > > 
> > > > I will get back to you once I tried it out.
> > > > 
> > > 
> > > BTW, I consider the code in
> > > arch/powerpc/platforms/powernv/memtrace.c
> > > very ugly and dangerous.
> > 
> > Yes it would be nice to clean this up.
> > 
> > > We should never allow to manually
> > > offline/online pages / hack into memory block states.
> > > 
> > > What I would want to see here is rather:
> > > 
> > > 1. User space offlines the blocks to be used
> > > 2. memtrace installs a hotplug notifier and hinders the blocks it
> > > wants
> > > to use from getting onlined.
> > > 3. memory is not added/removed/onlined/offlined in memtrace code.
> > > 
> > 
> > I remember looking into doing it a similar way. I can't recall the
> > details but my issue was probably 'how does userspace indicate to
> > the kernel that this memory being offlined should be removed'?
> 
> Instead of indicating a "size", indicate the offline memory blocks
> that
> the driver should use. E.g. by memory block id for each node
> 
> 0:20-24,1:30-32
> 
> Of course, other interfaces might make sense.
> 
> You can then start using these memory blocks and hinder them from
> getting onlined (as a safety net) via memory notifiers.
> 
> That would at least avoid you having to call
> add_memory/remove_memory/offline_pages/device_online/modifying
> memblock
> states manually.

I see what you're saying and that definitely sounds safer.

We would still need to call remove_memory and add_memory from memtrace
as
just offlining memory doesn't remove it from the linear page tables
(if 
it's still in the page tables then hardware can prefetch it and if
hardware tracing is using it then the box checkstops).

> 
> (binding the memory block devices to a driver would be nicer, but the
> infrastructure is not really there yet - we have no such drivers in
> place yet)
> 
> > I don't know the mm code nor how the notifiers work very well so I
> > can't quite see how the above would work. I'm assuming memtrace
> > would
> > register a hotplug notifier and when memory is offlined from
> > userspace,
> > the callback func in memtrace would be called if the priority was
> > high
> > enough? But how do we know that the memory being offlined is
> > intended
> > for usto touch? Is there a way to offline memory from userspace not
> > using sysfs or have I missed something in the sysfs interface?
> 
> The notifier would really only be used to hinder onlining as a safety
> net. User space prepares (offlines) the memory blocks and then tells
> the
> drivers which memory blocks to use.
> 
> > On a second read, perhaps you are assuming that memtrace is used
> > after
> > adding new memory at runtime? If so, that is not the case. If not,
> > then
> > would you be able to clarify what I'm not seeing?
> 
> The main problem I see is that you are calling
> add_memory/remove_memory() on memory your device driver doesn't own.
> It
> could reside on a DIMM if I am not mistaking (or later on
> paravirtualized memory devices like virtio-mem if I ever get to
> implement them ;) ).

This is just for baremetal/powernv so shouldn't affect virtual memory
devices.

> 
> How is it guaranteed that the memory you are allocating does not
> reside
> on a DIMM for example added via add_memory() by the ACPI driver?

Good point. We don't have ACPI on powernv but currently this would try
to remove memory from any online memory node, not just the ones that
are backed by RAM. oops.


