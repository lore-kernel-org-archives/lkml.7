Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9192C20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563214594;
	bh=qdhtC0/Pgf3CEaUjJ89vzNo3pneK/G3TkGPozq5OoaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GC9S3SnH9NDWJNnmCr8R4OsLhN3xkLAhsSQdKKys9x0JRYRxLMP85NQPLRE00H86F
	 xw6OCilMi6NfuWigy3IGhTVq+i41snVMKDPF5zNAMYbAnd4lEozshGl11szbD/6UpK
	 3bDAQ/vk5rUhUhCwZtrP6pSv8aBDKe5b5a4KtstM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbfGOSQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:16:33 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:39273 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbfGOSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:16:32 -0400
Received: by mail-lf1-f46.google.com with SMTP id v85so11667459lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxYkT3JhQGsfdWSUR+NdZx3rfXwiwgFSiibvH8MhehY=;
        b=ZBzyUNS0vIupXboeYgjwKoFkRb/jk6ka+zjE8/RnQvKRMhfw2/LXNtVYnSmNFznuA6
         voTqfynVSNgNjN46S3bomWqXTpTiCA/4v3/qslmuA4Sbkaq/nTy2Yf6pAhdmIkngTKYD
         UUKAXwxgKQ/rbSW7ztyfx467P8kWDRiGNyS4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxYkT3JhQGsfdWSUR+NdZx3rfXwiwgFSiibvH8MhehY=;
        b=BiGE4l0gEpSDkiw627FDK83Rniawhq4q2ozj34Xv2Qir5iiCvTi40CLdbSlk2KvstD
         82B/6eC0tBeUy8H3LgmeD/+bA8RWxheIk5JydKcaHAtFrSBskEGnx7MuQHHOgEKB8jJ0
         hrmdg5lX1UgjPKHSP3ij8yGD4pBPttvqF6QCiKEKnqN8pm+B3K8Nzryp+2WW6WgyReU4
         lHnFIeZHx4MV6UiS+H4XkucegPxcRre7GLNCmQU/CEvAnXlwRBYp/NKzrESyyMrsmIFQ
         IbhY6kzvkAZkbVHja5Y0WQJya0BsSWnGBfTXEm0JUJPtQ+Y96y/R+rpnKcEx3DRVVOeh
         wzAA==
X-Gm-Message-State: APjAAAVSViF/OoInF0BeKJvNvREp5fbijMhj69xU51XhSSDpv2kbvulY
        JkbePn7AdOKOrOYmuGDwneXy4Gmo0RE=
X-Google-Smtp-Source: APXvYqyYsfkVX3xf3QaJTpmvbUCjdon2rZZbAjKbKXrbE7fX3vOG8bLcCjqUoFNlp8ahRYQfUij6dQ==
X-Received: by 2002:ac2:5a44:: with SMTP id r4mr12058649lfn.118.1563214589332;
        Mon, 15 Jul 2019 11:16:29 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u13sm2427341lfi.4.2019.07.15.11.16.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 11:16:28 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 62so6804821lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:16:28 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr12141495lfm.170.1563214587837;
 Mon, 15 Jul 2019 11:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com> <20190715122924.GA15202@mellanox.com>
In-Reply-To: <20190715122924.GA15202@mellanox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 11:16:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEimwxXiDUdp9eSGZn4j6n8g-4KhdEG0kPVgKFQeAXgw@mail.gmail.com>
Message-ID: <CAHk-=wgEimwxXiDUdp9eSGZn4j6n8g-4KhdEG0kPVgKFQeAXgw@mail.gmail.com>
Subject: Re: DRM pull for v5.3-rc1
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Ugh, I have three different threads about the drm pull because of
the subject / html confusion. So now I'm replying in separate threads
and I'm hoping the people involved have better threading than gmail
does ;/ ]

On Mon, Jul 15, 2019 at 5:29 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> The 'hmm' tree is something I ran to try and help workflow issues like
> this, as it could be merged to DRM as a topic branch - maybe consider
> this flow in future?
>
> Linus, do you have any advice on how best to handle sharing mm
> patches?

I don't have a lot of advice except for "very very carefully".

I think the hmm tree worked really well this merge window, at least
from my standpoint.

But it is of course possible that my happiness about the hmm tree is a
complete fluke and came about because pretty much all the patches were
removing oddities and cleaning things up, and they weren't adding new
odd things (or if they were, you hid it better ;^).

Basically, people should know that there are some subsystems that I
end up being *much* more worried about than others. If I see a pull
request that modifies core VM of VFS code, I tend to go into "careful
mode", in ways that I don't do when some maintainer sends me a pull
request that obviously only changes some subtree that the maintainer
owns.

When driver maintainers send me patches that touch their drivers, I
look at the diffstat.

But when driver maintainers send me patches that change mm/, I look at
individual commit messages and the actual diff itself, and if I see
contentious stuff, I simply won't pull.

It's why I left the hmm pull request (which came in early - thank you)
until yesterday, simply because just from the diffstat I could tell
that "ok, this merge isn't just me merging and doing sanity checks,
this is me having to set aside time to do reviews". So just from the
diffstat, I avoided even looking at it while I still had a mailbox
full of other pull requests.

So I do like seeing core mm changes come in through a separate branch.
That's partly because that way it's easier to review without having
the parts I care about be mixed up with other parts (it's one reason I
asked the security layer pulls to be split up, to pick another area
entirely as an example). But it's also partly because if you have a
separate branch for the stuff that you know is contentious, that
doesn't then hold up the parts that _aren't_.

For example, right now I'm not pulling _any_ of the drm updates,
simply because there's a part of it that I can't stomach.  It would
have been so much nicer if the contentious things that need a lot of
care separate, and I could have at least pulled the other stuff.

                  Linus
