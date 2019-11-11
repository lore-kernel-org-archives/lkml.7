Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4935CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1565221872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QAutOGyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKKWjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:39:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40089 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfKKWjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:39:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so12630353otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2SfPwwCQiLJRr/QX6Jd0995kGjIbxtkaUwuaS+0KzI=;
        b=QAutOGyZC2XBfUx8rcwZ8HFguppkLV/FZuntrpc1YDFSMLg3IPLKq9PfArFl26TVk7
         w4osLNDiXI5MLZ49Ri97ZpcjYhSc/7aiq0QacbVHW7i9/9vlCudzLfgIXEmUbEvHxJRG
         iWYi07lvXHup+RmzZXG9fO256Gwq0YaCir8/aI0hWlf0BlostjS6n+SAdgYMAAjNi9j/
         dPbbm/ozOJkqU2vfB4Ef4UCrmKK8aptLRaD1tPPDXzrEQu63uyJZSvQqeEDwbltY4pwk
         Q5LEZeiA+UBjnJQ4ADx+kpEes0bEKZG8f2RxLBH1H64zRhqfK/4QwEdPHwd/IyhKDzbc
         D7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2SfPwwCQiLJRr/QX6Jd0995kGjIbxtkaUwuaS+0KzI=;
        b=N4qcKaaqxrhL32V5IJKWGnJVLAQ5QXKSDUiJzeN6qFGE/tf/GGw1HyMm2MTa8bnN1O
         S3Ry7Ntimee1qNQD9ikNx9739VFtV8SPcg+gcxF8tQtVnSN4hjnA0+spQjTdBCRJGImj
         6CqaUZ04Xz9RRCGDBLMw22TJFLdcbNtPNS2PZxa95Q5fZOZeT+1V46R4323wkx6dAdS1
         BhnwaJBbJhSdMWG5JypTSN4dIQ6e7uNxnlUxgK6igpiuVtCkbQLX+F20FV87HLXfa7dY
         SM0tH/wQaR721jix1Z4tXapFS+E71QZf7vmR8NoCAqijER8zrAVvamayZe7vU/E1f84O
         1yuQ==
X-Gm-Message-State: APjAAAVcVKrGQCk9lf80rjK/Vc8dv3sw7+D/7ZnGcLn7WQlzZ8P8wCmQ
        b4RHn4+jZ/dKFBbRZ4FbLkzY5cE1M5XgQCcOUzKWjw==
X-Google-Smtp-Source: APXvYqwuPw6B3Eul0BUNOj75pgGdIrj38jhNAnCqZC+wN/A9+QYJl0ffSUE2EA40M628idljzMnoDclHo3qzonh8Om8=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr22364185otb.126.1573511955643;
 Mon, 11 Nov 2019 14:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20191111221229.24732-1-sean.j.christopherson@intel.com> <20191111221229.24732-2-sean.j.christopherson@intel.com>
In-Reply-To: <20191111221229.24732-2-sean.j.christopherson@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Nov 2019 14:39:04 -0800
Message-ID: <CAPcyv4hyPWv0OpZVBJ-Vq8pGny1B59EkvykZ0RKZAgHB0tq2og@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: MMU: Do not treat ZONE_DEVICE pages as being reserved
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:12 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Explicitly exempt ZONE_DEVICE pages from kvm_is_reserved_pfn() and
> instead manually handle ZONE_DEVICE on a case-by-case basis.  For things
> like page refcounts, KVM needs to treat ZONE_DEVICE pages like normal
> pages, e.g. put pages grabbed via gup().  But for flows such as setting
> A/D bits or shifting refcounts for transparent huge pages, KVM needs to
> to avoid processing ZONE_DEVICE pages as the flows in question lack the
> underlying machinery for proper handling of ZONE_DEVICE pages.
>
> This fixes a hang reported by Adam Borowski[*] in dev_pagemap_cleanup()
> when running a KVM guest backed with /dev/dax memory, as KVM straight up
> doesn't put any references to ZONE_DEVICE pages acquired by gup().
>
> Note, Dan Williams proposed an alternative solution of doing put_page()
> on ZONE_DEVICE pages immediately after gup() in order to simplify the
> auditing needed to ensure is_zone_device_page() is called if and only if
> the backing device is pinned (via gup()).  But that approach would break
> kvm_vcpu_{un}map() as KVM requires the page to be pinned from map() 'til
> unmap() when accessing guest memory, unlike KVM's secondary MMU, which
> coordinates with mmu_notifier invalidations to avoid creating stale
> page references, i.e. doesn't rely on pages being pinned.
>
> [*] http://lkml.kernel.org/r/20190919115547.GA17963@angband.pl
>
> Reported-by: Adam Borowski <kilobyte@angband.pl>
> Debugged-by: David Hildenbrand <david@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

> Cc: stable@vger.kernel.org

Perhaps add:

Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")

...since that was the first kernel that broke KVM's assumption about
which pfn types needed to have the reference count managed.
