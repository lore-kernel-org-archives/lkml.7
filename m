Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F02C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBE4217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRA8Z7De"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfIWTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:18:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45899 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733304AbfIWTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:18:30 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so8598978oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3ARO5P/voRkLJ/81OmVWnKq2PkaLTCLvs0/erY8l7Q=;
        b=pRA8Z7DeRl2OOy1dNWWDy0CL0IrwV7LUvJzzR2ABsv6pUjW/XX9u2HzDv9vBVFadV2
         2lU+3fhdJcim/5u0Gj3TS3JjuFzMeUGudM47BZgjk5TbrpfvUL9uH77I1+atWzIDSF5o
         iEd7vic1+EXvvA4WqhVAArbE5Wqd8pFFlJ/8kvBx05JEp4OYVDNciV4+Q7nqzuNhpD99
         kngMj+JgNgiSE6w3392QPy2urAOPwmomOc9W4PUoVxTYlQmgs9gZhi2VfLGGGKNS0ft7
         cd52S56jiMT+CLw7kGwmqogkAe+erQxqJCIoNrPjLCTxFZtkgLii6jIwlntqttqDiURy
         OaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3ARO5P/voRkLJ/81OmVWnKq2PkaLTCLvs0/erY8l7Q=;
        b=rCrd0Glniq+InShtak2aR38Wh8SWntxoT7eH1I/5ZdlDG5e0SG9qDVMwYAG0tnvT/j
         uT6jOmh5vh5OkNfFyJtIRIuqdf+s0ImP6o1u+2aDrsM68Bx77O6J+OciygNh82Qgwvwu
         G53aHRxN51otFBDjvwF2+z46wA5tGWRqluQq4n9BacxZm5wRxmzJ/pPPMbLHH9+7TJIv
         vSo8vk7zsy/4ap1ywYjmjwiAWCt1BuaQoMMxc0sXngsWZF6mP3sxaEYnp0EDKNtx+Xa4
         8I4hryXpF8mNu8VaSQABjmnvjI+a9i3tL9k/l9TEsi0gioj0EU1WiZGfvAMkT8mcXR16
         4B5A==
X-Gm-Message-State: APjAAAV+0X8GttHu7tgD+1jEnpTwl3d/huo1meoqMgmkAvOmxXgnryPu
        N0p61HaZ6E0RbqdsmATkZOZxMRJcQ6HOmM2qHH+Dmw==
X-Google-Smtp-Source: APXvYqyIFK37RA36Cren3KxbuT1te6ouv5XN7/M6AabOpKvhgk4ImEHFhmGInEf1Ic45eJ7lnqBROdyPOAXNBiFU0tE=
X-Received: by 2002:aca:ed08:: with SMTP id l8mr1394322oih.151.1569266308493;
 Mon, 23 Sep 2019 12:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com> <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com>
In-Reply-To: <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 23 Sep 2019 12:18:17 -0700
Message-ID: <CAHS8izOj2AT4tX-+Hcb8LB2TOUKJDHScDtJ80u4M6OWpwktq0g@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/19/19 3:24 PM, Mina Almasry wrote:
> > Patch series implements hugetlb_cgroup reservation usage and limits, which
> > track hugetlb reservations rather than hugetlb memory faulted in. Details of
> > the approach is 1/7.
>
> Thanks for your continued efforts Mina.
>

And thanks for your reviews so far.

> One thing that has bothered me with this approach from the beginning is that
> hugetlb reservations are related to, but somewhat distinct from hugetlb
> allocations.  The original (existing) huegtlb cgroup implementation does not
> take reservations into account.  This is an issue you are trying to address
> by adding a cgroup support for hugetlb reservations.  However, this new
> reservation cgroup ignores hugetlb allocations at fault time.
>
> I 'think' the whole purpose of any hugetlb cgroup is to manage the allocation
> of hugetlb pages.  Both the existing cgroup code and the reservation approach
> have what I think are some serious flaws.  Consider a system with 100 hugetlb
> pages available.  A sysadmin, has two groups A and B and wants to limit hugetlb
> usage to 50 pages each.
>
> With the existing implementation, a task in group A could create a mmap of
> 100 pages in size and reserve all 100 pages.  Since the pages are 'reserved',
> nobody in group B can allocate ANY huge pages.  This is true even though
> no pages have been allocated in A (or B).
>
> With the reservation implementation, a task in group A could use MAP_NORESERVE
> and allocate all 100 pages without taking any reservations.
>
> As mentioned in your documentation, it would be possible to use both the
> existing (allocation) and new reservation cgroups together.  Perhaps if both
> are setup for the 50/50 split things would work a little better.
>
> However, instead of creating a new reservation crgoup how about adding
> reservation support to the existing allocation cgroup support.  One could
> even argue that a reservation is an allocation as it sets aside huge pages
> that can only be used for a specific purpose.  Here is something that
> may work.
>
> Starting with the existing allocation cgroup.
> - When hugetlb pages are reserved, the cgroup of the task making the
>   reservations is charged.  Tracking for the charged cgroup is done in the
>   reservation map in the same way proposed by this patch set.
> - At page fault time,
>   - If a reservation already exists for that specific area do not charge the
>     faulting task.  No tracking in page, just the reservation map.
>   - If no reservation exists, charge the group of the faulting task.  Tracking
>     of this information is in the page itself as implemented today.
> - When the hugetlb object is removed, compare the reservation map with any
>   allocated pages.  If cgroup tracking information exists in page, uncharge
>   that group.  Otherwise, unharge the group (if any) in the reservation map.
>
> One of the advantages of a separate reservation cgroup is that the existing
> code is unmodified.  Combining the two provides a more complete/accurate
> solution IMO.  But, it has the potential to break existing users.
>
> I really would like to get feedback from anyone that knows how the existing
> hugetlb cgroup controller may be used today.  Comments from Aneesh would
> be very welcome to know if reservations were considered in development of the
> existing code.
> --

FWIW, I'm aware of the interaction with NORESERVE and my thoughts are:

AFAICT, the 2 counter approach we have here is strictly superior to
the 1 upgraded counter approach. Consider these points:

- From what I can tell so far, everything you can do with the 1
counter approach, you can do with the two counter approach by setting
both limit_in_bytes and reservation_limit_in_bytes to the limit value.
That will limit both reservations and at fault allocations.

- The 2 counter approach preserves existing usage of hugetlb cgroups,
so no need to muck around with reverting the feature some time from
now because of broken users. No existing users of hugetlb cgroups need
to worry about the effect of this on their usage.

- Users that use hugetlb memory strictly through reservations can use
only reservation_limit_in_bytes and enjoy cgroup limits that never
SIGBUS the application. This is our usage for example.

- The 2 counter approach provides more info to the sysadmin. The
sysadmin knows exactly how much reserved bytes there are via
reservation_usage_in_bytes, and how much actually in use bytes there
are via usage_in_bytes. They can even detect NORESERVE usage if
usage_in_bytes > reservation_usage_in_bytes. failcnt shows failed
reservations *and* failed allocations at fault, etc. All around better
debuggability when things go wrong. I think this is particularly
troubling for the 1 upgraded counter approach. That counter's
usage_in_bytes doesn't tell you if the usage came from reservations or
allocations at fault time.

- Honestly, I think the 2 counter approach is easier to document and
understand by the userspace? 1 counter that vaguely tracks both the
reservations and usage and decides whether or not to charge at fault
time seems hard to understand what really happened after something
goes wrong. 1 counter that tracks reservations and 1 counter that
tracks actual usage seem much simpler to digest, and provide better
visibility to what the cgroup is doing as I mentioned above.

I think it may be better if I keep the 2 counter approach but
thoroughly document the interaction between the existing counters and
NORESERVE. What do you think?

FWIW, it may be prudent to consider deprecating MAP_NORESERVE, if
that's an option. I'm not sure what that benefit that provides
applications, and on the other hand it makes it hard for the kernel to
guarantee the hugetlb memory is available to the application that
requested it, and makes it harder for the cgroups to police hugetlb
usage without SIGBUSing something. But that may be a discussion for
another proposal.

> Mike Kravetz
