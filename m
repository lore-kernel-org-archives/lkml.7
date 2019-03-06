Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D3DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18A920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlpLV90R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfCFTYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:24:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36795 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfCFTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:24:38 -0500
Received: by mail-io1-f65.google.com with SMTP id r136so11216976iod.3;
        Wed, 06 Mar 2019 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZiEiSPvTWNYJkEcELHi6QZ0IqecrFI4s8OYugZS1pk8=;
        b=JlpLV90RSAH9k2d8QE8l2UpOhkwPDT2DBu7qsYNQWSwJ3b8kyHxkbeLUmnOZam92wO
         ptfQvJSaMm4OWI6oL/DKWwLBGZogWE1idXjwrp/N5KZ2NfX+MMWjqhHs3BGW5DuYQ0/X
         V107f0kLkqdaUYWTcHuEof422ZXnOJ1fDogcM4pWurNbKtJFEN8tQefl0+BnW5g97Ned
         L3K62T0wOUYE/xQS2E21HWxLRsvfUNUKvpxoDhzXmWIG8nf0JN+RSnu0rYu+YN7w1g40
         caBTO1XHQLns3wytFIijKK/mIKYrycSIBDoenfHez74MJcrPDEQW6PPhZ94a6XFXIxti
         pqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZiEiSPvTWNYJkEcELHi6QZ0IqecrFI4s8OYugZS1pk8=;
        b=VtYhOS4tBZ1kveOToja/lY9OphOX7YITum+GajmTzLSnll+ae27xVBQ2Ja77NL3pXP
         zRlF0XCGWHz3z2uWhMHnxz/aBL2yekKpQoU/v2gG9Q3tFKgxYhgYkf1ogrN8hz/FHhZ2
         WKcNF+JPKGuvEPJawG8yjiLMucA94r9sHvx5QlwQReQE1JWgQGFwjjOqBC20vlBYDum1
         WAb+7u1i3pugogQy7tQfB7D7K5JDENcujoE8Cdmnv0LNwUUFz8DWV4GuUjxvfNfSpUI8
         1Pzav7PzBkVu2mZNRNt39Cpq1Wmv+iULZZSyUYfHj6suwBHg0JzAKXmlUrd7AJ3m+UP+
         LT7A==
X-Gm-Message-State: APjAAAUg8BGHC/cXqBAruw4dt+zRlxJKPen1r8TFbJD/mp7pWTbMZhZs
        N6yUD4GJISRgzsPX88C/USpvUy3svXd7avip/OQ=
X-Google-Smtp-Source: APXvYqxSUzuRjOdKAez74kTF5p1HGD/t+z3j7naZJe5Kawrl9zyHEpoKMYeP3t+JkBAQkFnxYzs4nIKVc/P54WqFdUA=
X-Received: by 2002:a5e:8c14:: with SMTP id n20mr3926504ioj.200.1551900276823;
 Wed, 06 Mar 2019 11:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com> <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com> <20190306133826-mutt-send-email-mst@kernel.org>
 <3f87916d-8d18-013c-8988-9eb516c9cd2e@redhat.com> <CAKgT0UdqCb37VNe7pABBYBXYFrVzYdPntmPf-V6ZYp9DdwmxYA@mail.gmail.com>
 <7b98b7b3-68f5-e4e0-1454-2217f41e46ad@redhat.com>
In-Reply-To: <7b98b7b3-68f5-e4e0-1454-2217f41e46ad@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Mar 2019 11:24:26 -0800
Message-ID: <CAKgT0UePn86cnjzietzuqdosjJH3McH2xDQ3ocjbujMKdsk7Pw@mail.gmail.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 11:18 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.03.19 20:08, Alexander Duyck wrote:
> > On Wed, Mar 6, 2019 at 11:00 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 06.03.19 19:43, Michael S. Tsirkin wrote:
> >>> On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
> >>>>>> Here are the results:
> >>>>>>
> >>>>>> Procedure: 3 Guests of size 5GB is launched on a single NUMA node with
> >>>>>> total memory of 15GB and no swap. In each of the guest, memhog is run
> >>>>>> with 5GB. Post-execution of memhog, Host memory usage is monitored by
> >>>>>> using Free command.
> >>>>>>
> >>>>>> Without Hinting:
> >>>>>>                  Time of execution    Host used memory
> >>>>>> Guest 1:        45 seconds            5.4 GB
> >>>>>> Guest 2:        45 seconds            10 GB
> >>>>>> Guest 3:        1  minute               15 GB
> >>>>>>
> >>>>>> With Hinting:
> >>>>>>                 Time of execution     Host used memory
> >>>>>> Guest 1:        49 seconds            2.4 GB
> >>>>>> Guest 2:        40 seconds            4.3 GB
> >>>>>> Guest 3:        50 seconds            6.3 GB
> >>>>> OK so no improvement.
> >>>> If we are looking in terms of memory we are getting back from the guest,
> >>>> then there is an improvement. However, if we are looking at the
> >>>> improvement in terms of time of execution of memhog then yes there is none.
> >>>
> >>> Yes but the way I see it you can't overcommit this unused memory
> >>> since guests can start using it at any time.  You timed it carefully
> >>> such that this does not happen, but what will cause this timing on real
> >>> guests?
> >>
> >> Whenever you overcommit you will need backup swap. There is no way
> >> around it. It just makes the probability of you having to go to disk
> >> less likely.
> >>
> >> If you assume that all of your guests will be using all of their memory
> >> all the time, you don't have to think about overcommiting memory in the
> >> first place. But this is not what we usually have.
> >
> > Right, but the general idea is that free page hinting allows us to
> > avoid having to use the swap if we are hinting the pages as unused.
> > The general assumption we are working with is that some percentage of
> > the VMs are unused most of the time so you can share those resources
> > between multiple VMs and have them free those up normally.
>
> Yes, similar to VCPU yielding or playin scheduling when the VCPU is
> spleeping. Instead of busy looping, hand over the resource to somebody
> who can actually make use of it.
>
> >
> > If we can reduce swap usage we can improve overall performance and
> > that was what I was pointing out with my test. I had also done
> > something similar to what Nitesh was doing with his original test
> > where I had launched 8 VMs with 8GB of memory per VM on a system with
> > 32G of RAM and only 4G of swap. In that setup I could keep a couple
> > VMs busy at a time without issues, and obviously without the patch I
> > just started to OOM qemu instances and  could only have 4 VMs at a
> > time running at maximum.
>
> While these are nice experiments (especially to showcase reduced swap
> usage!), I would not suggest to use 4GB of swap on a x2 overcomited
> system (32GB overcommited). Disks are so cheap nowadays that one does
> not have to play with fire.

Right. The only reason for using 4G is because the system normally has
128G of RAM available and I didn't really think I would need swap for
the system when I originally configured it.

> But yes, reducing swap usage implies overall system performance (unless
> the hinting is terribly slow :) ). Reducing swap usage, not swap space :)

Right. Also the swap is really a necessity if we are going to look at
things like MADV_FREE as I have not seen us really start to free up
resources until we are starting to put some pressure on swap.
