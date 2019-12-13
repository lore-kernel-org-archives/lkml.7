Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1648CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FEF24671
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7V/LJBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLMVIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:08:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38748 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:08:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so74983pgm.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 13:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aur/Px0pwmfL3LzajV1sOTCWH1iRm6As8lK2q+00Kvk=;
        b=D7V/LJBAAvbi9quTcVnP/sUE97WgYXBhfFwHfKAwvCJ7Mnte3NFSQ2PwU4zKbWGwYs
         hpOQtYKpnWyUVMDEYTt0aU1agAgiGQsc8lFhsNtnJyW9uKQwSGfCDf/HJMmuFLNp/ovu
         KheVolmc4OUFCpCOvox+x3LAcvUulj9JPhazxFn5VMgoOx/ALU7FEquTym5anvDUevzQ
         pxL0LWf9kMd665fQfalNafdE+QJZEk+9m3E2fawui0ThRVGLKpFj7ZKQFSbMKes0obgp
         VM/p1TCB8CUEoiOTlLLiDYSBEbzl0tubmbzb3ydzypbamxgob6tUnZ5tLMoLnJnc3/wd
         SxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aur/Px0pwmfL3LzajV1sOTCWH1iRm6As8lK2q+00Kvk=;
        b=L8+6AvkScEOh5ESKDggkiWZJyVRdqVHjeq4mkq3RFgTUQU0HDGu++X8NoU3OfjSWb6
         cQBKptuPZPeHQz02Y/1bdQhxQkz923XF7ruqreD1w/01FINcYdwckZdBB0LyzakIKNyv
         KaZUpldIwraiy/cURTfoUqVQuL2/h034YbeCQh6IsqtPVjyCfleZQK78MOKi7BP9CZT2
         dS2b7ne7DQYGAtsBpmFB25eyKaxKHobd4BCVIJMdu8+YAcAYiPD3V5iAuGo9qTy0S1rw
         j6aPdBUV9brMmWGfHFTxK4QZVVCYxwElhoW/e3Ps5WYp1juFAlBg5O2946T4+pCF6Irr
         71VA==
X-Gm-Message-State: APjAAAUKYc+ZHdsf/WHm7XqEdMzOy+Nd39L7QAZJ5zxyOhCv7lHVe6S0
        XCSzgNUvacac6WXKocZYd6q5AvmgIldTZNKet8s=
X-Google-Smtp-Source: APXvYqxSkjKFoBVv7Ad12ZCq/bsvrWkPd42fTjHxdDc3ENs++tJHZ7K+wilKZt1FDx0auoBCVdQOAkEh57V4XaKi45g=
X-Received: by 2002:a63:5062:: with SMTP id q34mr1679417pgl.378.1576271299928;
 Fri, 13 Dec 2019 13:08:19 -0800 (PST)
MIME-Version: 1.0
References: <201912100401.fDYi5lhU%lkp@intel.com> <20191213111649.GU32742@smile.fi.intel.com>
In-Reply-To: <20191213111649.GU32742@smile.fi.intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 13 Dec 2019 13:08:08 -0800
Message-ID: <CAMo8BfKhSkHapX=mDhauZz8pAwR+1DtDNL=oE_RNhmaSQ9V_Zw@mail.gmail.com>
Subject: Re: WARNING: lib/test_bitmap.o(.text.unlikely+0x5c): Section mismatch
 in reference from the function bitmap_copy_clear_tail() to the variable .init.rodata:clump_exp
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Dec 13, 2019 at 3:16 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Dec 10, 2019 at 04:17:03AM +0800, kbuild test robot wrote:
>
> +Cc: Max for xtensa matters, perhaps he has an idea.
>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e42617b825f8073569da76dc4510bfa019b1c35a
> > commit: 30544ed5de431fe25d3793e4dd5a058d877c4d77 lib/bitmap: introduce bitmap_replace() helper
> > date:   5 days ago
> > config: xtensa-randconfig-a001-20191209 (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 7.5.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 30544ed5de431fe25d3793e4dd5a058d877c4d77
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.5.0 make.cross ARCH=xtensa
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
>
> I'm not sure I got this (esp. relation to my patch).
> The mentioned code definitely compiled for 32-bit (since only then mentioned
> bitmap API is in use). I have tried to reproduce on i386 compilation (gcc 9.x),
> but can't.

I was able to reproduce it on xtensa with gcc-9.
The issue comes from the test "test_replace", specifically
from the following call:
  bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);

An invariable part of the call sequence used here is instantiated in
the section .text.unlikely with a reference to exp2_to_exp3_mask built
into it and it's called from the test_replace. It looks like a compiler bug
to me, I'd expect this code to be emitted to the .init.text, i.e the same
section where the function it was hoisted from resides.
And why "unlikely"? This code is definitely executed.

I'll file a bug against gcc.

-- 
Thanks.
-- Max
