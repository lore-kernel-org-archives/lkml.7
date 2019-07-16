Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD575C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE22206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="RL+CgOhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfGPE0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:26:00 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40306 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfGPE0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:26:00 -0400
Received: by mail-oi1-f172.google.com with SMTP id w196so14493347oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 21:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRcWjRmFxDg4SEfu8zxM0/EewJf42HkBJR2XudH/ONs=;
        b=RL+CgOhEgmcOursufR7ym3mvIjJtb8YF7FA4i1dQ+ChMdYOfqc7cBf1uOv9gSILKoX
         b/ZIQDh1+yyo4WOQI1zWbL9UsnEN41d9c8eOhCQUlxEnAf2ba9RhvS4YCEghd38lJe/P
         0X9z0o5i1Y64obie0hpaNiQlXjXOdyEuuLToKg649QodM5sbHcnrdwTceEK3QuZMYeVi
         nUsi/7l8E0iK4k9MhDtE6M0Gp72ZoUBYcsME/7rFufU+w6cq1dqrO5ggcgOHhn7elBYw
         iMX5dj6Pj8/PXmgIr7J2qXmqfIRtNxHCYfrW5TqGv+sKiXlZ/Q7c6ceS3NWIdIHEBq1r
         Nzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRcWjRmFxDg4SEfu8zxM0/EewJf42HkBJR2XudH/ONs=;
        b=g+BAL9Te14iuHULBagVGuX5zsvEHAyWMe+O758J9SZ2qK483S1ZQgM+B9uVTC7Ucyh
         XWGNLrKWHBDfRx9hIDsnSFc++i/8jfsEvQi/TWy0k9hjSJfyi3ZzH0CJG+QkDlWbsuz3
         UtxGrxm/UwcesNEc6rl+WuSzD4J5OrQfiIwssDlT3vSRkVRtna5OmkaWCb5GI1ZmcWY1
         elg0KWL/kQ5Wc26HwNy2mY9Gc702uo+fTzjpf5oHghVvaDCHOk2P4b6VDclfyGxU5P/o
         PNsOUNz7AgoxrOpnefAkPiqvrgbfu4HLaPQ6Q4DTb/GtC/lTIzAEsF3NopmT0BtwAc0K
         NOWQ==
X-Gm-Message-State: APjAAAWKCRk8trg+DPoWooIYPOOIl9G/cq9k7DcqBMPhaUBM9l8nk4LM
        LaQGt09jdFjxTSFpodehkq9EFnB0bM9P3ESC8Z6fMw==
X-Google-Smtp-Source: APXvYqznIzJKBkcX2EHDSxKUoYWP9K8fyWDLsG2+p7M5YMdh44wYFm51T0RqPbprZgpvnEg5STv9Fldjf1pllgR7iyU=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr15040114oii.0.1563251159049;
 Mon, 15 Jul 2019 21:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190704205536.32740b34@canb.auug.org.au> <20190704125539.GL3401@mellanox.com>
 <20190704230133.1fe67031@canb.auug.org.au> <20190704132836.GM3401@mellanox.com>
 <20190705070810.1e01ea9d@canb.auug.org.au> <CAPcyv4hHC3s3nePSSHaKkFFbxuABZE3GLa7Li=0j6Z45ERrPEg@mail.gmail.com>
 <20190705120810.GA31525@mellanox.com> <20190706220426.c2c4518f20e1ecc7ddd069fa@linux-foundation.org>
In-Reply-To: <20190706220426.c2c4518f20e1ecc7ddd069fa@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Jul 2019 21:25:47 -0700
Message-ID: <CAPcyv4i=c4ByS9dC4+vLf0Y0xNNcH2RemzwGj9eCdATMp=gb+w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 10:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 5 Jul 2019 12:08:15 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> > On Thu, Jul 04, 2019 at 04:29:55PM -0700, Dan Williams wrote:
> > > Guys, Andrew has kicked the subsection patches out of -mm because of
> > > the merge conflicts. Can we hold off on the hmm cleanups for this
> > > cycle?
> >
> > I agree with you we should prioritize your subsection patches over
> > CH's cleanup if we cannot have both.
> >
> > As I said, I'll drop CH's at Andrews request, but I do not want to
> > make any changes without being aligned with him.
>
> OK, I had a shot at repairing the damage on top of current linux-next.
> The great majority of the issues were in
> mm-devm_memremap_pages-enable-sub-section-remap.patch.
>
> Below are the rejects which I saw and below that is my attempt to
> resolve it all.  Dan, please go through this with a toothcomb.  I've
> just done an mmotm release with all this in it so please do whatever's
> needed to verify that it's all working correctly.

Apologies for the delay, I was offline last week for a move. This
looks good to me and even caught some "X >> PAGE_SHIFT" to
"PHYS_PFN(X)" conversions that I missed. It also passes my testing.
Thank you accommodating a rebase.

Now to take a look at Oscar's fixes.
