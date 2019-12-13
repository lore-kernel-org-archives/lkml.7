Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED11AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D7A206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLMVTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:19:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:59024 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfLMVTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:19:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 13:19:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="297039087"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2019 13:19:01 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ifsKz-0004Nt-KV; Fri, 13 Dec 2019 23:19:01 +0200
Date:   Fri, 13 Dec 2019 23:19:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: WARNING: lib/test_bitmap.o(.text.unlikely+0x5c): Section
 mismatch in reference from the function bitmap_copy_clear_tail() to the
 variable .init.rodata:clump_exp
Message-ID: <20191213211901.GL32742@smile.fi.intel.com>
References: <201912100401.fDYi5lhU%lkp@intel.com>
 <20191213111649.GU32742@smile.fi.intel.com>
 <CAMo8BfKhSkHapX=mDhauZz8pAwR+1DtDNL=oE_RNhmaSQ9V_Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfKhSkHapX=mDhauZz8pAwR+1DtDNL=oE_RNhmaSQ9V_Zw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:08:08PM -0800, Max Filippov wrote:
> On Fri, Dec 13, 2019 at 3:16 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Dec 10, 2019 at 04:17:03AM +0800, kbuild test robot wrote:
> >
> > +Cc: Max for xtensa matters, perhaps he has an idea.
> >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   e42617b825f8073569da76dc4510bfa019b1c35a
> > > commit: 30544ed5de431fe25d3793e4dd5a058d877c4d77 lib/bitmap: introduce bitmap_replace() helper
> > > date:   5 days ago
> > > config: xtensa-randconfig-a001-20191209 (attached as .config)
> > > compiler: xtensa-linux-gcc (GCC) 7.5.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         git checkout 30544ed5de431fe25d3793e4dd5a058d877c4d77
> > >         # save the attached .config to linux build tree
> > >         GCC_VERSION=7.5.0 make.cross ARCH=xtensa
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> >
> > I'm not sure I got this (esp. relation to my patch).
> > The mentioned code definitely compiled for 32-bit (since only then mentioned
> > bitmap API is in use). I have tried to reproduce on i386 compilation (gcc 9.x),
> > but can't.
> 
> I was able to reproduce it on xtensa with gcc-9.
> The issue comes from the test "test_replace", specifically
> from the following call:
>   bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
> 
> An invariable part of the call sequence used here is instantiated in
> the section .text.unlikely with a reference to exp2_to_exp3_mask built
> into it and it's called from the test_replace. It looks like a compiler bug
> to me, I'd expect this code to be emitted to the .init.text, i.e the same
> section where the function it was hoisted from resides.
> And why "unlikely"? This code is definitely executed.
> 
> I'll file a bug against gcc.

Thanks for an analysis and quick response!

-- 
With Best Regards,
Andy Shevchenko


