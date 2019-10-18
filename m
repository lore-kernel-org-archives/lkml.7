Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8079ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5777421852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKUwiF9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405917AbfJRPjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:39:46 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44577 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfJRPjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:39:45 -0400
Received: by mail-yb1-f194.google.com with SMTP id v1so1936500ybo.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyX3ITW1lAwaLBwEuGBaqhYdKeg34Dzcm26Ri/ifd24=;
        b=RKUwiF9lIf8864JdEImdlk6BX1M7tycwiSIZaMlkA8pqzCYHEsZkL8IXsYZDGLW6Ls
         C1RbVAEUy18DKa5zsJYsUC3UnLXXnbHcuX8i9ATVWKJFDlqfuwb9/8zmnaFQ84BAurg3
         lcZhA4wrJgqr1bpeW2Sbrz1RRprWsRsYk80T7JFJWHqZ5vBfA3ylUQ9r/1ekleD/C3X2
         HLfRUjV6BJEN6bUK7xM/fXjZULA/m/TcSmX42XrjQKBkCHjywgkzysu9mgcWSLUMFH+e
         bwKydbi820y6uRiihSD8FvRpwg15e6dNnL3jBCgkdi1YVlegXExHrfZsfPk0Jm9cwOfN
         Dzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyX3ITW1lAwaLBwEuGBaqhYdKeg34Dzcm26Ri/ifd24=;
        b=PLHJCXxAcTXY1Rbi+RyQ4WTxackR1Urmkq+VSbFHEwgJa0ye6pEbUti7WLbM3svGcK
         7Lb3lslnJayJPYg1nr995X1qVK5NSfiBJ0ioUIp1GY2LZtGWHoNs6Todm6RLrip8j4sQ
         4nbMUJi1MtsMd5dlXNEKVUdDtt4HJg0yl9QN0cQJHcYRd6Xb6Qz0hBTnNwHM8q8Ml17O
         DjfkJ3j9hrH86Bguvau7dgFGQuz2hnQebVTEs0NccwfZQyKDNjEgtPJNTo6nJP0hPwDD
         +aqMRZ2+eaW4Q3iEVk0BspNantPhDWw9fQo4FDzt9RymhmUZ+QlwF/r1Ti6e4MqcgDKa
         Allg==
X-Gm-Message-State: APjAAAWBZ7e26u6OAktTVttRPINF4F6miRtyR5cZgSmDG+eU6W7m7Qv5
        Iyj2ZEei51h+LYKdnF/09vU/QXbX9IRtGKz0w7aIHg==
X-Google-Smtp-Source: APXvYqxaj+1g9zU1VsKsXTnZY97z8aK39y4QODL3dMb4ol7w7TlofYd4oOfUkm6ldGQl3UcfYUc74+hVB8tSjEg++yo=
X-Received: by 2002:a25:8b0a:: with SMTP id i10mr6476076ybl.459.1571413182525;
 Fri, 18 Oct 2019 08:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <CABCjUKDWRJO9s68qhKQGXzrW39KqfZzZhoOX0HgDcnv-RxJZPw@mail.gmail.com>
 <85512332-d9d4-6a72-0b42-a8523abc1b5f@intel.com> <CABCjUKDa+AQLrXf1h2QPqDqVePQoL_mJo4uUiOZss2vmeGoN5g@mail.gmail.com>
 <197ba38f-0443-b3a7-7ce4-544bf97c58dd@intel.com>
In-Reply-To: <197ba38f-0443-b3a7-7ce4-544bf97c58dd@intel.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Sat, 19 Oct 2019 00:39:30 +0900
Message-ID: <CABCjUKDs_E8WVObPNTckwNdg2kn0AnO650uMmkQtQs-6grcavg@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, dan.j.williams@intel.com,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 12:10 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/18/19 1:11 AM, Suleiman Souhlal wrote:
> > Another issue we ran into, that I think might also apply to this patch
> > series, is that because kernel memory can't be allocated on persistent
> > memory, it's possible for all of DRAM to get filled by user memory and
> > have kernel allocations fail even though there is still a lot of free
> > persistent memory. This is easy to trigger, just start an application
> > that is bigger than DRAM.
>
> Why doesn't this happen on everyone's laptops where DRAM is contended
> between userspace and kernel allocations?  Does the OOM killer trigger
> fast enough to save us?

Well in this case, there is plenty of free persistent memory on the
machine, but not any free DRAM to allocate kernel memory.
In the situation I'm describing, we end up OOMing when we, in my
opinion, shouldn't.

> > To mitigate that, we introduced a new watermark for DRAM zones above
> > which user memory can't be allocated, to leave some space for kernel
> > allocations.
>
> I'd be curious why the existing users of ZONE_MOVABLE don't have to do
> this?  Are there just no users of ZONE_MOVABLE?

That's an excellent question for which I don't currently have an answer.

I haven't had the chance to test your patch series, and it's possible
that it doesn't suffer from the issue.

-- Suleiman
