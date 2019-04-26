Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36039C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1536206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4qs/hon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDZKwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:52:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46861 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZKwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:52:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so3758485wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cnxmmef+NwbrCUr8Oi81bt7qsrqIih/sC6dEusKYVao=;
        b=Y4qs/honthAe3HuUqrHOQK2sOIEwvGWrPnZ9iEqyZv32rQS74XsIJkpA8Glkfrb/Js
         YFShRzlxEi6C2HNTdkC9CCMz2n7YaFb94UXdnX2xI7ATBBVaHzs6PC1Z8fS2KGwfB0m5
         fC6lmKxUsjZo2guJNcxDa5aIBL6/JM9qpefIBmZz/TZpNbUA2Pr48T6oFn1R5GqDkHeZ
         vcxKmpDz4+G4eJm1fPIdVpbFj/yyD+Xd7psUwAc2IhkhtLwVrkOBujxgcoPTVZL4F0g6
         jAzDjVhLFVrZdxNwsEHCt8M0QhWHihNGEbG7EbrlRQQPIFyd2b1x9VLBKC0OHzq6+DPo
         0kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cnxmmef+NwbrCUr8Oi81bt7qsrqIih/sC6dEusKYVao=;
        b=frgu/JE2M+m1IaOrjG5pVvUlT3z9+Q0b5CPprh59Z3KbcWd9Gx0Mgegb9E3ZgCE6t5
         QFzKNzSSDtB7mdlG+Jqtgh3hwFdI5urXelPpYVYxAEgl1H0cenCrAeXsc5dDgsCFN8sO
         55mx9PI0BKCdnpk6DGhSbOKUSzNbP4ZYPjVujyv0UFkkIGV+C7r5n+7hEQDZr3CkwAsO
         guGKLM0QDc0rCW2zD8WbxZx1YGwhCW+vqCUTiJED34vslSuAlnz6wvoR4qzUeMLmiSxV
         8ot/RgZ5PVUo+XtZXdZ3sG65ivl8j7qZJ7JWetrb4w65w+biIm4CXikwbIynrLmTb5oM
         7oTw==
X-Gm-Message-State: APjAAAUz9xXxQZVu4+5dnAtKfKqym6QIaB67QITXUh+NseCQeyeexyQw
        lWeI3nLQWqmcVJJphkw9Oz8DxR5sG+tSfuvXEOxZm/20lxRR1Q==
X-Google-Smtp-Source: APXvYqxG0Aom1C9ZKTQFNoLPvCIsbo/CcKiQ22hDi9NEpiaFmrULh1+L2RdxhEkrt6pDzWrERGr710wq8mG8VGqmR9g=
X-Received: by 2002:adf:d081:: with SMTP id y1mr2827242wrh.283.1556275931043;
 Fri, 26 Apr 2019 03:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190423054131.GB31496@umbus.fritz.box> <20190425061958.GA7881@lst.de>
 <20190426010517.GA7378@umbus.fritz.box> <20190426035643.GB7378@umbus.fritz.box>
In-Reply-To: <20190426035643.GB7378@umbus.fritz.box>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 26 Apr 2019 18:51:59 +0800
Message-ID: <CACVXFVOKmtiePmDFOkJ56zKcQPcJyCVTOOgQyo4MRti3xbw5ng@mail.gmail.com>
Subject: Re: powerpc hugepage leak caused by 576ed913 "block: use bio_add_page
 in bio_iov_iter_get_pages"
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Michael Ellerman <michael@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Nick Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:41 PM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Fri, Apr 26, 2019 at 11:05:17AM +1000, David Gibson wrote:
> > On Thu, Apr 25, 2019 at 08:19:58AM +0200, Christoph Hellwig wrote:
> > > Just curious:  What exact trees do you see this with?  This area
> > > changed a lot with the multipage bvec support, and subsequent fixes.
> >
> > So, I tried it with 576ed913 itself and with 576ed913^ to verify that
> > it didn't happen there.  The problem also occurred with Linus' tree as
> > of when I started bisecting, which appears to have been 444fe991.
> > Actually, come to that, here's the whole bisect log in case it's
> > helpful:
> >
> > # git bisect log
> > git bisect start
> > # good: [bebc6082da0a9f5d47a1ea2edc099bf671058bd4] Linux 4.14
> > git bisect good bebc6082da0a9f5d47a1ea2edc099bf671058bd4
> > # bad: [444fe991353987c1c9bc5ab1f903d01f1b4ad415] Merge tag 'riscv-for-linus-5.1-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux
> > git bisect bad 444fe991353987c1c9bc5ab1f903d01f1b4ad415
> > # good: [399c4129eba6145924ab90363352b7bdcd554751] Merge tag 'pxa-for-4.19-dma_slave_map' of https://github.com/rjarzmik/linux
> > git bisect good 399c4129eba6145924ab90363352b7bdcd554751
> > # bad: [73b6f96cbc0162787bcbdac5f538167084c8d605] Merge branch 'drm-fixes-4.20' of git://people.freedesktop.org/~agd5f/linux into drm-fixes
> > git bisect bad 73b6f96cbc0162787bcbdac5f538167084c8d605
> > # good: [85a585918fb4122ad26b6febaec5c3c90bf2535c] Merge tag 'loadpin-security-next' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-loadpin
> > git bisect good 85a585918fb4122ad26b6febaec5c3c90bf2535c
> > # bad: [3acbd2de6bc3af215c6ed7732dfc097d1e238503] Merge tag 'sound-4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> > git bisect bad 3acbd2de6bc3af215c6ed7732dfc097d1e238503
> > # good: [8f18da47211554f1ef674fef627c05f23b75a8e0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
> > git bisect good 8f18da47211554f1ef674fef627c05f23b75a8e0
> > # bad: [0d1b82cd8ac2e8856ae9045c97782ac1c359929c] Merge branch 'ras-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > git bisect bad 0d1b82cd8ac2e8856ae9045c97782ac1c359929c
> > # bad: [1650ac53066577a5e83fe3e9d992c9311597ff8c] Merge tag 'mmc-v4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> > git bisect bad 1650ac53066577a5e83fe3e9d992c9311597ff8c
> > # bad: [6ab9e09238fdfd742fe23b81e2d385a1cab49d9b] Merge tag 'for-4.20/block-20181021' of git://git.kernel.dk/linux-block
> > git bisect bad 6ab9e09238fdfd742fe23b81e2d385a1cab49d9b
> > # good: [528985117126f11beea339cf39120ee99da04cd2] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> > git bisect good 528985117126f11beea339cf39120ee99da04cd2
> > # bad: [2cf99bbd106f89fc72f778e8ad9d5538f1ef939b] lightnvm: pblk: add helpers for chunk addresses
> > git bisect bad 2cf99bbd106f89fc72f778e8ad9d5538f1ef939b
> > # bad: [33b14f67a4e1eabd219fd6543da8f15ed86b641c] nvme: register ns_id attributes as default sysfs groups
> > git bisect bad 33b14f67a4e1eabd219fd6543da8f15ed86b641c
> > # bad: [27ca1d4ed04ea29dc77b47190a3cc82697023e76] block: move req_gap_back_merge to blk.h
> > git bisect bad 27ca1d4ed04ea29dc77b47190a3cc82697023e76
> > # bad: [07b05bcc3213ac9f8c28c9d835b4bf3d5798cc60] blkcg: convert blkg_lookup_create to find closest blkg
> > git bisect bad 07b05bcc3213ac9f8c28c9d835b4bf3d5798cc60
> > # good: [cbeb869a3d1110450186b738199963c5e68c2a71] block, bfq: correctly charge and reset entity service in all cases
> > git bisect good cbeb869a3d1110450186b738199963c5e68c2a71
> > # bad: [576ed9135489c723fb39b97c4e2c73428d06dd78] block: use bio_add_page in bio_iov_iter_get_pages
> > git bisect bad 576ed9135489c723fb39b97c4e2c73428d06dd78
> > # good: [c8765de0adfcaaf4ffb2d951e07444f00ffa9453] blok, bfq: do not plug I/O if all queues are weight-raised
> > git bisect good c8765de0adfcaaf4ffb2d951e07444f00ffa9453
> > # first bad commit: [576ed9135489c723fb39b97c4e2c73428d06dd78] block: use bio_add_page in bio_iov_iter_get_pages
> >
> > The problem also occurred with the RHEL8 downstream kernel tree.
> > That's based on 4.18, but has 576ed913 backported.
> >
> > > So I'd be really curious if it can be reproduced with Jens' latest
> > > block for-5.2 tree (which should be in latest linux-next).
> >
> > I'll see if I can try that when I next get access to the machine.
>
> Ok, I've now had a chance to test the next-20190423 tree.
>
> I can still reproduce the problem: in fact it is substantially worse,
> and somewhat more consistent.
>
> Previously I usually lost 2-3 hugepages per run, though I'd
> occasionally seen other values between 0 and 8.  With the next tree, I
> lost 46 hugepages on most runs, though I also saw 45 and 48
> occasionally.

Please try to apply the following three patches, and I guess you may
see same behavior as linus tree(v5.1-rc, or v4.18). And the last one has
been applied to for-5.2/block which should be the latest next.

https://lore.kernel.org/linux-block/20190426104521.30602-2-ming.lei@redhat.com/T/#u
https://lore.kernel.org/linux-block/20190426104521.30602-3-ming.lei@redhat.com/T/#u

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.2/block&id=0257c0ed5ea3de3e32cb322852c4c40bc09d1b97

Thanks,
Ming Lei
