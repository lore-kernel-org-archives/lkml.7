Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF97C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE04421850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lnxerxt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfGENfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:35:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44860 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfGENfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:35:02 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so19143594iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1fWimE5LBhG/grVg6eI87RotqFb0roHvhFn0bvlYoY=;
        b=Lnxerxt4jClA4MjKorP5iPnUVKYLaeN7x1LmQadqGzya9Hnsuvt1Nz9wAb5OsXmo9W
         v0cdoNBys7WZ955ZU3Jp3CS0nnG6UTbc7pTHuCw0PabUUK7ZcvnR2yAHDyUPJ31EssJA
         6eMIDFB8tZH9Tpq0HXoieDMIekGtVcLMioTtdx1aSD/MF6JcRI0wtkMg8NVsk4ncTIIT
         rAjOBCDqtFVernkxMTFQQZtxwhWs4xm6Y6W7WNCQZFq2IxBO8AIdiirHi+GkubXfRP0Z
         o6UFPOYlSIwvMSq0BNEidnCK5ORfTbGJuSi9ZkzUtHkMWj0KgL15xS6yG4sCnz5cW0Lj
         Io7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1fWimE5LBhG/grVg6eI87RotqFb0roHvhFn0bvlYoY=;
        b=jN35VBtYzacXfZiyd2iMfR870UeIURN7jyH05MdXPC7habxPvf1iR+YSYCinL/ZuY/
         NiP0QhzcLWFbjwtrRvMwVRrZl1uuNoRezjUxoV0mxF+4kdR8abw/x+Vb7YglM0uN0xWC
         GT7wgrn9sAvqmw9onsWQy+3ouFYr4lwI4m8CX0AoEopjeTQJFoxNX7+WjpirBdZKpm6M
         oMHeM5m4iJONwsIYvNaKrxEPV7NaKQBGl/hLaPxdnRJJOLBWNik8Kom4TfU1C4j0mUl9
         ZZUsunCLxkVOG8k3od/g1MLOX/VgAkSlB9iqpEEgjgqVDRHyG8/QYA0/pFb8V8hsjezR
         QNUQ==
X-Gm-Message-State: APjAAAWP4lglIXfNFY5eoiHfiyb2Q7SiEqGZHKYKVosnxxGfCkBb285D
        BMXOXKVHZUBo1Ylsh/NYvLVSqk6+zNHgDSo8HO865A==
X-Google-Smtp-Source: APXvYqyUsHHTlKMctHpic07R1doMCk0jHwk68Y9gsTeKbOEsxX+msCvOmfkff5qNb2py5BNyBqvtJ2UV3fs+Wa7D2BY=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr4038131iop.58.1562333701423;
 Fri, 05 Jul 2019 06:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190613081357.1360-1-walter-zh.wu@mediatek.com>
 <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com> <1560447999.15814.15.camel@mtksdccf07>
 <1560479520.15814.34.camel@mtksdccf07> <1560744017.15814.49.camel@mtksdccf07>
 <CACT4Y+Y3uS59rXf92ByQuFK_G4v0H8NNnCY1tCbr4V+PaZF3ag@mail.gmail.com>
 <1560774735.15814.54.camel@mtksdccf07> <1561974995.18866.1.camel@mtksdccf07>
In-Reply-To: <1561974995.18866.1.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 15:34:49 +0200
Message-ID: <CACT4Y+aMXTBE0uVkeZz+MuPx3X1nESSBncgkScWvAkciAxP1RA@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: add memory corruption identification for
 software tag-based mode
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Miles Chen <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 11:56 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > > > This patch adds memory corruption identification at bug report for
> > > > > > > > software tag-based mode, the report show whether it is "use-after-free"
> > > > > > > > or "out-of-bound" error instead of "invalid-access" error.This will make
> > > > > > > > it easier for programmers to see the memory corruption problem.
> > > > > > > >
> > > > > > > > Now we extend the quarantine to support both generic and tag-based kasan.
> > > > > > > > For tag-based kasan, the quarantine stores only freed object information
> > > > > > > > to check if an object is freed recently. When tag-based kasan reports an
> > > > > > > > error, we can check if the tagged addr is in the quarantine and make a
> > > > > > > > good guess if the object is more like "use-after-free" or "out-of-bound".
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > We already have all the information and don't need the quarantine to make such guess.
> > > > > > > Basically if shadow of the first byte of object has the same tag as tag in pointer than it's out-of-bounds,
> > > > > > > otherwise it's use-after-free.
> > > > > > >
> > > > > > > In pseudo-code it's something like this:
> > > > > > >
> > > > > > > u8 object_tag = *(u8 *)kasan_mem_to_shadow(nearest_object(cacche, page, access_addr));
> > > > > > >
> > > > > > > if (access_addr_tag == object_tag && object_tag != KASAN_TAG_INVALID)
> > > > > > >   // out-of-bounds
> > > > > > > else
> > > > > > >   // use-after-free
> > > > > >
> > > > > > Thanks your explanation.
> > > > > > I see, we can use it to decide corruption type.
> > > > > > But some use-after-free issues, it may not have accurate free-backtrace.
> > > > > > Unfortunately in that situation, free-backtrace is the most important.
> > > > > > please see below example
> > > > > >
> > > > > > In generic KASAN, it gets accurate free-backrace(ptr1).
> > > > > > In tag-based KASAN, it gets wrong free-backtrace(ptr2). It will make
> > > > > > programmer misjudge, so they may not believe tag-based KASAN.
> > > > > > So We provide this patch, we hope tag-based KASAN bug report is the same
> > > > > > accurate with generic KASAN.
> > > > > >
> > > > > > ---
> > > > > >     ptr1 = kmalloc(size, GFP_KERNEL);
> > > > > >     ptr1_free(ptr1);
> > > > > >
> > > > > >     ptr2 = kmalloc(size, GFP_KERNEL);
> > > > > >     ptr2_free(ptr2);
> > > > > >
> > > > > >     ptr1[size] = 'x';  //corruption here
> > > > > >
> > > > > >
> > > > > > static noinline void ptr1_free(char* ptr)
> > > > > > {
> > > > > >     kfree(ptr);
> > > > > > }
> > > > > > static noinline void ptr2_free(char* ptr)
> > > > > > {
> > > > > >     kfree(ptr);
> > > > > > }
> > > > > > ---
> > > > > >
> > > > > We think of another question about deciding by that shadow of the first
> > > > > byte.
> > > > > In tag-based KASAN, it is immediately released after calling kfree(), so
> > > > > the slub is easy to be used by another pointer, then it will change
> > > > > shadow memory to the tag of new pointer, it will not be the
> > > > > KASAN_TAG_INVALID, so there are many false negative cases, especially in
> > > > > small size allocation.
> > > > >
> > > > > Our patch is to solve those problems. so please consider it, thanks.
> > > > >
> > > > Hi, Andrey and Dmitry,
> > > >
> > > > I am sorry to bother you.
> > > > Would you tell me what you think about this patch?
> > > > We want to use tag-based KASAN, so we hope its bug report is clear and
> > > > correct as generic KASAN.
> > > >
> > > > Thanks your review.
> > > > Walter
> > >
> > > Hi Walter,
> > >
> > > I will probably be busy till the next week. Sorry for delays.
> >
> > It's ok. Thanks your kindly help.
> > I hope I can contribute to tag-based KASAN. It is a very important tool
> > for us.
>
> Hi, Dmitry,
>
> Would you have free time to discuss this patch together?
> Thanks.

Sorry for delays. I am overwhelm by some urgent work. I afraid to
promise any dates because the next week I am on a conference, then
again a backlog and an intern starting...

Andrey, do you still have concerns re this patch? This change allows
to print the free stack.
We also have a quarantine for hwasan in user-space. Though it works a
bit differently then the normal asan quarantine. We keep a per-thread
fixed-size ring-buffer of recent allocations:
https://github.com/llvm-mirror/compiler-rt/blob/master/lib/hwasan/hwasan_report.cpp#L274-L284
and scan these ring buffers during reports.
