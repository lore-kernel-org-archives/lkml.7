Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A98C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC2B21473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560571319;
	bh=ACe1Clulv/XGccKcTCcOd9Qt05JKYgvd+gemVer94Y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b3rzata2Rj5lCxpbGwLj09sk2JiEJMCXK8J+Kftklz8eZYzmzLOXYX8nwZvSs5VtM
	 pzjuT/fFm94sKVjjF3F2wo52D9pDy3hJGndv7GPRnA0ydsPuh3yjBzNzDhJXbHHRBd
	 eA/j2v2w9gu6baV49+BhHSGrxs1Pa14CvavAhEgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfFOEBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 00:01:30 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43649 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfFOEB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 00:01:29 -0400
Received: by mail-lj1-f170.google.com with SMTP id 16so4256527ljv.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 21:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNCCQDzXq6yRFhVLoEUQSeznUefXALf/b6AvjDf5zbk=;
        b=K+NlbgNmc77iE+WvrjEBgMNlZucBcKdO/O5/nk7OZOBx6QGiPLKgW6xHqeUKR/z1/9
         zyhhdNgrB4+1BFo6Zu6tRLbi1YgVBxzcym14Fw3e1Cvu/GabpqLG0GbD6xnKbRNydIPE
         3038hUhYpnFUOgY2FK0lkFrB+J3deHeUX1FtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNCCQDzXq6yRFhVLoEUQSeznUefXALf/b6AvjDf5zbk=;
        b=j96fJzXtcXXm/vNqH/90lJnYv8GlCDRreuH3C6gZDxQHX7F9y+qiH3pQ0vQQNIQzxV
         WtW3bAg4IXaS2ey0CwnkrKwSfWjhR1Gxh3BCURgblhK6BWK3V5vstdRcLAzUH18VpVj6
         nxDMr39CXS/UcwCB6k+Fae7F6O1ppzkB63GOMdzxo2dbUmZXoJ6NlLdiT7ObRmGhRFl/
         w8B08l2ntX/K85PRsgvoKJ9+0vjzWGI8e/4QwOtfzw4NmhlWZtUsPKuHzKEB7zeJGp+R
         54EYxu/54N8jIUrQ4WmybNl9Muh3s4vu1FIBm98opxvx/SWQYfNuMkCB1u0ybfF5dVg7
         oM8g==
X-Gm-Message-State: APjAAAVHOnKyLMPtW0birSD25XqbFMkErNGi2XpsjngHjpTrKaC/qxzZ
        HDIqIVxt4/EkiCk0wcSoa6omuv+GsR4=
X-Google-Smtp-Source: APXvYqwIefNGBgFt/em7vqk51EYY5g7bQ4PfNrqERzTvto7mbH22hHBZuNjqKPWfGdEcsv2JC0fuMA==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr5269078ljj.122.1560571287250;
        Fri, 14 Jun 2019 21:01:27 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f16sm805583lfc.81.2019.06.14.21.01.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 21:01:24 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h10so4311665ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 21:01:23 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr18772815ljk.72.1560571283486;
 Fri, 14 Jun 2019 21:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
In-Reply-To: <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jun 2019 18:01:07 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
Message-ID: <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 5:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do not believe that posix itself actually requires that at all,
> although extended standards may.

So I tried to see if I could find what this perhaps alludes to.

And I suspect it's not in the read/write thing, but the pthreads side
talks about atomicity.

Interesting, but I doubt if that's actually really intentional, since
the non-thread read/write behavior specifically seems to avoid the
whole concurrency issue.

The pthreads atomicity thing seems to be about not splitting up IO and
doing it in chunks when you have m:n threading models, but can be
(mis-)construed to have threads given higher atomicity guarantees than
processes.

               Linus
