Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E794C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF212075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568195795;
	bh=U3DnUYNLnn6i+6J+wv+mDg0aFpCRdM0yuIQTHY+Sj1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OBIxKK73upbnM1+whbcGLdzGs2/QzI6+DfpvKZF9/g0hOuSZYyFWTo8R8JlpPF3Eo
	 4kDSQ7q1gDePClHFpUx0hLueWqC2kKL8gWHQIdjLzbjElbhU9dDV+Ut+mjuLPpn9b0
	 hl5s33n6yzTY8DjgNLc8k8XmvHjAqjI3brrcS/iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfIKJ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:56:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37188 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:56:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id y5so8555545lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BX2UgWIYaZS7GTCdolEhAhZHFFy6otxnhMgv6RCaPJY=;
        b=GBg+WG4tmzlhXfbndZfH+tCEkx7MdTOMJWwACCf6jNvjYMxvAvxAWixx9vqpoArYjd
         MUyL45LzIccC8KYScLWsw6AqvNnf8TuOB9+Tx5MzVtLZ76TzUymunajVI6T4C3O55uwa
         OrlWaOg4WGa1pxlojNeYinPvEPcvknjjqYgA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BX2UgWIYaZS7GTCdolEhAhZHFFy6otxnhMgv6RCaPJY=;
        b=UMOc3zUnsy2h+80NAUKTUzDcCyPH5vuede05yPTZoS83YjxykqaGHnWlzozWSlqQoH
         yzIXDbsOAbaup+aUHSho8n2tA7co5igz/MxRGWxqDhxVQOqfF8q/Il1RSVX+PAcw4lh8
         AD1sgpHEZ8EAMLh932A/O5zNVMvwZL9f/wqhCxS2oioiG6bS6DdmnrhqbGJ0bRm02lVd
         +uY0+oN8B6r3Zjbmga2IvKNT15wsZJyOre/UXYS8KRPZidHfquJKgqXSz22bfHDFb83j
         1Fgowqt4gYYkhwC/a5t10+wtz+1fA3vy/zGb7JHACeuAeHisflAE0eiiURt0RQBXNsOY
         w6Eg==
X-Gm-Message-State: APjAAAX8g5+saSwUgMtK/PcAaYvYC8quN6ke6u1ngeKJcHSdH0nvUErU
        3DqFIIlbmQT/avzwhF/3Tb7x8xBm/Riy2A==
X-Google-Smtp-Source: APXvYqz6yi2Q9SSZ4yBOgf8YV7h9cx8/AovEkuvf5c8Ij/jqD7rnO5D+Uwp5PI1uF5ci6/wQssKjVg==
X-Received: by 2002:a2e:8704:: with SMTP id m4mr22646957lji.65.1568195791158;
        Wed, 11 Sep 2019 02:56:31 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z9sm394189ljj.48.2019.09.11.02.56.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 02:56:30 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id u14so19348546ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:56:30 -0700 (PDT)
X-Received: by 2002:a2e:988e:: with SMTP id b14mr9258852ljj.52.1568195295684;
 Wed, 11 Sep 2019 02:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190911071007.20077-1-peterx@redhat.com> <20190911071007.20077-8-peterx@redhat.com>
In-Reply-To: <20190911071007.20077-8-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Sep 2019 10:47:59 +0100
X-Gmail-Original-Message-ID: <CAHk-=wh03Qx6zNS_yhhsf5gPah=2=mi7+dKMNCVrKhw6+894ag@mail.gmail.com>
Message-ID: <CAHk-=wh03Qx6zNS_yhhsf5gPah=2=mi7+dKMNCVrKhw6+894ag@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] mm/gup: Allow VM_FAULT_RETRY for multiple times
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:11 AM Peter Xu <peterx@redhat.com> wrote:
>
> This is the gup counterpart of the change that allows the
> VM_FAULT_RETRY to happen for more than once.  One thing to mention is
> that we must check the fatal signal here before retry because the GUP
> can be interrupted by that, otherwise we can loop forever.

I still get nervous about the signal handling here.

I'm not entirely sure we get it right even before your patch series.

Right now, __get_user_pages() can return -ERESTARTSYS when it's killed:

        /*
         * If we have a pending SIGKILL, don't keep faulting pages and
         * potentially allocating memory.
         */
        if (fatal_signal_pending(current)) {
                ret = -ERESTARTSYS;
                goto out;
        }

and I don't think your series changes that.  And note how this is true
_regardless_ of any FOLL_xyz flags (and we don't pass the
FAULT_FLAG_xyz flags at all, they get generated deeper down if we
actually end up faulting things in).

So this part of the patch:

+               if (fatal_signal_pending(current))
+                       goto out;
+
                *locked = 1;
-               lock_dropped = true;
                down_read(&mm->mmap_sem);
                ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
-                                      pages, NULL, NULL);
+                                      pages, NULL, locked);
+               if (!*locked) {
+                       /* Continue to retry until we succeeded */
+                       BUG_ON(ret != 0);
+                       goto retry;

just makes me go "that can't be right". The fatal_signal_pending() is
pointless and would probably better be something like

        if (down_read_killable(&mm->mmap_sem) < 0)
                goto out;

and then _after_ calling __get_user_pages(), the whole "negative error
handling" should be more obvious.

The BUG_ON(ret != 0) makes me nervous, but it might be fine (I guess
the fatal signal handling has always been done before the lock is
released?).

But exactly *because* __get_user_pages() can already return on fatal
signals, I think it should also set FAULT_FLAG_KILLABLE when faulting
things in. I don't think it does right now, so it doesn't actually
necessarily check fatal signals in a timely manner (not _during_ the
fault, only _before_ it).

See what I'm reacting to?

And maybe I'm wrong. Maybe I misread the code, and your changes. And
at least some of these logic error predate your changes, I just was
hoping that since this whole "react to signals" is very much what your
patch series is working on, you'd look at this.

Ok?

            Linus
