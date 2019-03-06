Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11E9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B727620652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX2CGKZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfCFSAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:00:18 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:38009 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCFSAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:00:18 -0500
Received: by mail-it1-f175.google.com with SMTP id l66so11535538itg.3;
        Wed, 06 Mar 2019 10:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zO+AZEfAv5pHsN/jVDva2C5rp6LD2HHLHn2cEbcpRxs=;
        b=GX2CGKZfAwb3eSRY1stEGm0zcrDI1bnMDl/PzfN4dzsf+h01QTCSpfgZisXxp4Wxda
         n3NZZBNpA25to7B6uwR6j0FKHs6Ckfww7cjOFsXU5tSfi+KMJHF67zhHI2zKD7aMtr5Y
         m31RYrFTN1ezCHf2sn1tX3GofzFyE+/YgobvFZAAnNZNC/HHVV7pqvO5zgWxL2v08FKS
         0hqypg+2hzX954IsdkrkPMVVaSPFDXTNg1XbhwnAYKstlrc9G389H9S7duu2GnRxzGcu
         LqSuqpu/5H1fW+qeY91TsaueOxJDxCYHY2m/KKJxyNr0+xMUAxVqiG2yW7urfBC/u0Ah
         bdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zO+AZEfAv5pHsN/jVDva2C5rp6LD2HHLHn2cEbcpRxs=;
        b=XnIGImdaRtJ0TlG+wUNA+lhlHuVh2QmpH6Tv8O0sWYPtES77HYWt9WJF7BeWLZZZBf
         8SfY8YiE/MiHETi3cUBAuVzTJVQADzCsUrtlpFyU1oJOr5uX7xXEoIZNRvSM8ZOgO42g
         l3pf9T5ahxCKtg1/KQxmuepMlrUQIc03UnLoBhTxewS/a6XIPq8bPuqJ/UBmiIleYm5L
         a4GzeLBjeRqC+Eo2ONVzhGE4RJL8BGFyk3xLFvo+CvC91SOyrDcBFnGlBGYkXMtciyfm
         b42NdbwprzSUvoI/b9aLX8l1gOSrQTs1E8TMSPdpAQ2Gb7C0o1Goct/vH3wciOh/rY0M
         a18A==
X-Gm-Message-State: APjAAAUjccx3pHyPTMT483r/slCLkGJdVi1EEk52+Xx4tKsC4IHAdA9g
        x3rYfKHAV3Nj6UR81J+Mt/nxCSqhFFtdixviMLs=
X-Google-Smtp-Source: APXvYqzamDMOh1SCdmcXq4z4AMwZQJA7x6hMzYySmnOM0vwGjORa6rLhtGgRSAptmhP7AY8mJyheLv8bjv4hV4dhsvk=
X-Received: by 2002:a24:45e3:: with SMTP id c96mr2606444itd.89.1551895216704;
 Wed, 06 Mar 2019 10:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com>
In-Reply-To: <20190306155048.12868-1-nitesh@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Mar 2019 10:00:05 -0800
Message-ID: <CAKgT0Ud35pmmfAabYJijWo8qpucUWS8-OzBW=gsotfxZFuS9PQ@mail.gmail.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 7:51 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote=
:
>
> The following patch-set proposes an efficient mechanism for handing freed=
 memory between the guest and the host. It enables the guests with no page =
cache to rapidly free and reclaims memory to and from the host respectively=
.
>
> Benefit:
> With this patch-series, in our test-case, executed on a single system and=
 single NUMA node with 15GB memory, we were able to successfully launch 5 g=
uests(each with 5 GB memory) when page hinting was enabled and 3 without it=
. (Detailed explanation of the test procedure is provided at the bottom und=
er Test - 1).
>
> Changelog in v9:
>         * Guest free page hinting hook is now invoked after a page has be=
en merged in the buddy.
>         * Free pages only with order FREE_PAGE_HINTING_MIN_ORDER(currentl=
y defined as MAX_ORDER - 1) are captured.
>         * Removed kthread which was earlier used to perform the scanning,=
 isolation & reporting of free pages.

Without a kthread this has the potential to get really ugly really
fast. If we are going to run asynchronously we should probably be
truly asynchonous and just place a few pieces of data in the page that
a worker thread can use to identify which pages have been hinted and
which pages have not. Then we can have that one thread just walking
through the zone memory pulling out fixed size pieces at a time and
providing hints on that. By doing that we avoid the potential of
creating a batch of pages that eat up most of the system memory.

>         * Pages, captured in the per cpu array are sorted based on the zo=
ne numbers. This is to avoid redundancy of acquiring zone locks.
>         * Dynamically allocated space is used to hold the isolated guest =
free pages.

I have concerns that doing this per CPU and allocating memory
dynamically can result in you losing a significant amount of memory as
it sits waiting to be hinted.

>         * All the pages are reported asynchronously to the host via virti=
o driver.
>         * Pages are returned back to the guest buddy free list only when =
the host response is received.

I have been thinking about this. Instead of stealing the page couldn't
you simply flag it that there is a hint in progress and simply wait in
arch_alloc_page until the hint has been processed? The problem is in
stealing pages you are going to introduce false OOM issues when the
memory isn't available because it is being hinted on.

> Pending items:
>         * Make sure that the guest free page hinting's current implementa=
tion doesn't break hugepages or device assigned guests.
>         * Follow up on VIRTIO_BALLOON_F_PAGE_POISON's device side support=
. (It is currently missing)
>         * Compare reporting free pages via vring with vhost.
>         * Decide between MADV_DONTNEED and MADV_FREE.
>         * Analyze overall performance impact due to guest free page hinti=
ng.
>         * Come up with proper/traceable error-message/logs.

I'll try applying these patches and see if I can reproduce the results
you reported. With the last patch set I couldn't reproduce the results
as you reported them. It has me wondering if you were somehow seeing
the effects of a balloon instead of the actual memory hints as I
couldn't find any evidence of the memory ever actually being freed
back by the hints functionality.

Also do you have any idea if this patch set will work with an SMP
setup or is it still racy? I might try enabling SMP in my environment
to see if I can test the scalability of the VM with something like a
will-it-scale test.

> Tests:
> 1. Use-case - Number of guests we can launch
>
>         NUMA Nodes =3D 1 with 15 GB memory
>         Guest Memory =3D 5 GB
>         Number of cores in guest =3D 1
>         Workload =3D test allocation program allocates 4GB memory, touche=
s it via memset and exits.
>         Procedure =3D
>         The first guest is launched and once its console is up, the test =
allocation program is executed with 4 GB memory request (Due to this the gu=
est occupies almost 4-5 GB of memory in the host in a system without page h=
inting). Once this program exits at that time another guest is launched in =
the host and the same process is followed. We continue launching the guests=
 until a guest gets killed due to low memory condition in the host.
>
>         Results:
>         Without hinting =3D 3
>         With hinting =3D 5
>
> 2. Hackbench
>         Guest Memory =3D 5 GB
>         Number of cores =3D 4
>         Number of tasks         Time with Hinting       Time without Hint=
ing
>         4000                    19.540                  17.818
>
>
