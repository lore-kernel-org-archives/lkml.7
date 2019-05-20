Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B31C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54098216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="splOX657"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbfETRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:00:05 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:36933 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389465AbfETRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:00:05 -0400
Received: by mail-it1-f180.google.com with SMTP id m140so149694itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9HxCz0foDNs5O3pbgandNCjjTka/BKF7J0X9z8Vxf4=;
        b=splOX6579zCxu8w2x60dHrYaM+Xypz557w+QNlIAc5+jHrsya6YGpJe0FdAFDMLXLp
         s+PuQebm04NIf42o+d8/JT/s3fnZodHBtyot2dQR/eVP7Hs5DzLXOxtnMZM+mdx5aZt0
         U3/7AiokG+Pwo1P2b9icTB+0Xm0xOwSlPOdow59cuJUueC/13byLOut2FSxdKv1bSEAf
         mQi/TNTuOlUe2OGWsmzYyoUUeYcd8CzRIClsW2nEje4eZnxNG6qGl6OPxvfI3R4s19sV
         0eu9DUzq6niepxI7SSdVhMNyQeq2S1Ri2DtHk7VDpYokgeMQdPAiY2vb1TYVjQyzf4CX
         ng/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9HxCz0foDNs5O3pbgandNCjjTka/BKF7J0X9z8Vxf4=;
        b=ASKkuAogv5JfhdvATp4Bf8rJmOTNie64+V994hWubbk8A5ChtvMDHXjKo8pyoNFsyf
         qOFmCjOJLduvlos//eR/QCjEkYczMP+lxdqIzHeAJKu8RgsCbz4ANw9rWFPLJ1Alpdst
         UA0MFlcl8kEHDD42CYvIMpUOGNLuEWNCqt6cuQQtYBxozJr6RDYDyrJBUsJNKBhsqUVs
         BThPvbtHD1LDbMNZNFliYO4Kn11mz4RqBMCXoHpC/2p9VzZ0/PDI0dUbVbweuSjAQLnk
         dJnrPGKBj+3LsKgO6SQH/HG+4j8qteo5q+IsUjor92ghS6+veXv/RyOFPKuUQ6heYCft
         YxQQ==
X-Gm-Message-State: APjAAAXS87K6Xdkm7WtNqvQwbYUdsgy3Gu30FIo3duK2JVBK4J2fecrz
        qBorphBYqlOaDOlNITFtEm7IaZKWuQcHTtPppobr4A==
X-Google-Smtp-Source: APXvYqxcTQzgFbWL33MuIA08BQG6r4172rHpmkGhiZLa8jGMztN1c0YHSZispXFJVvLlv+unuZuWPF77PfLiwhvwKs8=
X-Received: by 2002:a24:c904:: with SMTP id h4mr53623itg.46.1558371604283;
 Mon, 20 May 2019 10:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
In-Reply-To: <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
From:   Tim Murray <timmurray@google.com>
Date:   Mon, 20 May 2019 09:59:52 -0700
Message-ID: <CAEe=Sxka3Q3vX+7aWUJGKicM+a9Px0rrusyL+5bB1w4ywF6N4Q@mail.gmail.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 11:37 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Or Is the objective here is reduce the number of processes which get killed by
> lmkd by triggering swapping for the unused memory (user hinted) sooner so that
> they dont get picked by lmkd. Under utilization for zram hardware is a concern
> here as well ?

The objective is to avoid some instances of memory pressure by
proactively swapping pages that userspace knows to be cold before
those pages reach the end of the LRUs, which in turn can prevent some
apps from being killed by lmk/lmkd. As soon as Android userspace knows
that an application is not being used and is only resident to improve
performance if the user returns to that app, we can kick off
process_madvise on that process's pages (or some portion of those
pages) in a power-efficient way to reduce memory pressure long before
the system hits the free page watermark. This allows the system more
time to put pages into zram versus waiting for the watermark to
trigger kswapd, which decreases the likelihood that later memory
allocations will cause enough pressure to trigger a kill of one of
these apps.

> Swapping out memory into zram wont increase the latency for a hot start ? Or
> is it because as it will prevent a fresh cold start which anyway will be slower
> than a slow hot start. Just being curious.

First, not all swapped pages will be reloaded immediately once an app
is resumed. We've found that an app's working set post-process_madvise
is significantly smaller than what an app allocates when it first
launches (see the delta between pswpin and pswpout in Minchan's
results). Presumably because of this, faulting to fetch from zram does
not seem to introduce a noticeable hot start penalty, not does it
cause an increase in performance problems later in the app's
lifecycle. I've measured with and without process_madvise, and the
differences are within our noise bounds. Second, because we're not
preemptively evicting file pages and only making them more likely to
be evicted when there's already memory pressure, we avoid the case
where we process_madvise an app then immediately return to the app and
reload all file pages in the working set even though there was no
intervening memory pressure. Our initial version of this work evicted
file pages preemptively and did cause a noticeable slowdown (~15%) for
that case; this patch set avoids that slowdown. Finally, the benefit
from avoiding cold starts is huge. The performance improvement from
having a hot start instead of a cold start ranges from 3x for very
small apps to 50x+ for larger apps like high-fidelity games.
