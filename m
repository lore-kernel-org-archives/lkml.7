Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34D4C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FB720657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEo7UP9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfG2VBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:01:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33925 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfG2VBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:01:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so22633191pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1pxBQK50aNcVoP8CcZn7ZUgislLWflfkS2yonacWrE=;
        b=VEo7UP9bT9B9nfOoYCkdJEM5gW2QD7xnTf1vczhfC1oEl45RhkdRC46U4pzWzAX4fZ
         7EVJd2cUG0Y/UHEUPD1NhDd5mBoYSgJN2UFG5M4G80NIocIsRGYeh+Mc4GE8wY0mLqj+
         Lkr1Y1cdJ1955081Hsczt/ZGmipz5Y4e76Y1TmPkuhSPQ80VFYjhbqo0ZrrPHCDfxood
         BY7qvupauFyEKOyDwAxZXzpiBpVAK+flBTmTwq6iFInQ6LlHUajlYhhd7MlTVlslRohN
         pcrVivF8AhgMYZcy+AnLj/ZoA9NBMV4xuhmGgnc/houMPrSF8NMxX8qAVUuPCQd54eeY
         fdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1pxBQK50aNcVoP8CcZn7ZUgislLWflfkS2yonacWrE=;
        b=DHM4pzIxpSwbc2zLxAg/qgZhlItvh2pnWa8c+VpEUaV5CtdXhx353xJOX4E8FZG+IO
         lEUzlwqV04eDQrLqan8dXfBJhMVrPgtxD33SCeb5lWIjZfQXePjW6cg7QRJBK70Ume8P
         /ZSbQDifnD97jEH7aNogFOtIduqzU2N2leHbN1hUaGbkC4kLpAE3nhWgpgpfoYG3FIjk
         8R80ZvLETifnkV8r/w2/3N3B7j0o89sL3Ccq24sgpjhWVO6YRlVipLYJ4arQZPqAFje2
         BiHOsAoMG0RphmLsHCJUma9LgsQh6hE//bXynFNmhVWHRpAOUsMZZ+r7xpD3NON5n7SH
         knRw==
X-Gm-Message-State: APjAAAWlX2sXtJlpJu47LZV5oEJl/aKlfAByRRvE4f0OOYQoXEN1Ckri
        tgERx81gQ3KOCya9ZUgLS4zcQEQsBkEKgC6a3wCNYQ==
X-Google-Smtp-Source: APXvYqw6mpG+SmS3TWiNIlzXGS9ZhffK0hsjP9aY7A1YJzXMBuhs8W5WALBAkp89RL519hINz64n4mpxrDvJtK8e6Vk=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr114790294pjs.73.1564434079710;
 Mon, 29 Jul 2019 14:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190729190739.971253303@linuxfoundation.org> <20190729190753.998851246@linuxfoundation.org>
 <20190729205422.GH250418@google.com> <20190729205746.GI250418@google.com>
In-Reply-To: <20190729205746.GI250418@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jul 2019 14:01:08 -0700
Message-ID: <CAKwvOdmwaUN70e8TLDS4ZXvge7j1a--kYPPO0dm9ycPKLRqfvA@mail.gmail.com>
Subject: Re: [PATCH 5.2 083/215] net/ipv4: fib_trie: Avoid cryptic ternary expressions
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:57 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Mon, Jul 29, 2019 at 01:54:22PM -0700, Matthias Kaehlcke wrote:
> > Hi Greg,
> >
> > Toralf just pointed out in another thread that the commit message and
> > the content of this patch don't match (https://lkml.org/lkml/2019/7/29/1475)
> >
> > I did some minor digging, the content of the queued patch is:
> >
> > commit 4df607cc6fe8e46b258ff2a53d0a60ca3008ffc7
> > Author: Nathan Huckleberry <nhuck@google.com>
> > Date:   Mon Jun 17 10:28:29 2019 -0700
> >
> >     kbuild: Remove unnecessary -Wno-unused-value
> >
> >
> > however the commit message is from:
> >
> > commit 25cec756891e8733433efea63b2254ddc93aa5cc
> > Author: Matthias Kaehlcke <mka@chromium.org>
> > Date:   Tue Jun 18 14:14:40 2019 -0700
> >
> >     net/ipv4: fib_trie: Avoid cryptic ternary expressions
> >
> >
> > It seems this hasn't been commited to -stable yet, so we are probably
> > in time to remove it from the queue before it becomes git history and
> > have Nathan re-spin the patch(es).
>
> s/Nathan/Sasha/
>
> For some reason I thought Nathan backported this and wondered that his
> SOB is missing. The correct SOB is actually there.

I don't think Nathan explicitly tried to backport anything.  This
looks to me like AUTOSEL maybe took a commit message from a different
commit, and applied it to this diff.

ie. I don't think this is a bug in a manual backport, I think AUTOSEL
did something funny and created a backport with commit message A but
commit diff B.

-- 
Thanks,
~Nick Desaulniers
