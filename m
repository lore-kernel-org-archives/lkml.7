Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ADBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774F7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfJJO1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:27:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:48114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfJJO1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:27:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65603AD26;
        Thu, 10 Oct 2019 14:27:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4D015DA7E3; Thu, 10 Oct 2019 16:27:33 +0200 (CEST)
Date:   Thu, 10 Oct 2019 16:27:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
Message-ID: <20191010142733.GT2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>, Steven Rostedt <rostedt@goodmis.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <20191009110943.7ff3a08a@gandalf.local.home>
 <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
 <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
 <CAKwvOdntBXd3OPiCV5adcDjXor886-XnsSxcStAjYBJpuEBrqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdntBXd3OPiCV5adcDjXor886-XnsSxcStAjYBJpuEBrqQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:33:45AM -0700, Nick Desaulniers wrote:
> On Wed, Oct 9, 2019 at 9:38 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Wed, 2019-10-09 at 09:13 -0700, Nick Desaulniers wrote:
> > > On Wed, Oct 9, 2019 at 8:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > On Wed, 9 Oct 2019 14:14:28 +0200 Markus Elfring <Markus.Elfring@web.de> wrote:
> > []
> > > > > Several functions return values with which useful data processing
> > > > > should be performed. These values must not be ignored then.
> > > > > Thus use the annotation “__must_check” in the shown function declarations.
> > []
> > > > I'm curious. How many warnings showed up when you applied this patch?
> > >
> > > I got zero for x86_64 and arm64 defconfig builds of linux-next with
> > > this applied.  Hopefully that's not an argument against the more
> > > liberal application of it?  I view __must_check as a good thing, and
> > > encourage its application, unless someone can show that a certain
> > > function would be useful to call without it.
> >
> > stylistic trivia, neither agreeing nor disagreeing with the patch
> > as I generally avoid reading Markus' patches.
> >
> > I believe __must_check is best placed before the return type as
> > that makes grep for function return type easier to parse.
> >
> > i.e. prefer
> >         [static inline] __must_check <type> <function>(<args...>);
> > over
> >         [static inline] <type> __must_check <function>(<args...>);
> >
> 
> + Miguel
> So I just checked `__cold`, and `__cold` is all over the board in
> style.  I see it:
> 1. before anything fs/btrfs/super.c#L101
> 2. after static before return type (what you recommend) fs/btrfs/super.c#L2318
> 3. after return type fs/btrfs/inode.c#L9426

As you can see in the git history, case 1 is from 2015 and the newer
changes put the attribute between type and name - that's my "current"
but hopefully final preference.

> Can we pick a style and enforce it via checkpatch? (It's probably not
> fun to check for each function attribute in
> include/linux/compiler_attributes.h).

Anything that has the return type, attributes and function name on one
line works for me, but I know that there are other style preferences
that put function name as the first word on a separate line.  My reasons
are for better search results, ie.

  extent_map.c:void __cold extent_map_exit(void)
  extent_map.h:void __cold extent_map_exit(void);
  file.c:void __cold btrfs_auto_defrag_exit(void)
  inode.c:void __cold btrfs_destroy_cachep(void)
  ordered-data.c:void __cold ordered_data_exit(void)
  ordered-data.h:void __cold ordered_data_exit(void);

is better than

  send.c:__cold
  super.c:__cold
  super.c:__cold
  super.c:__cold

which I might get to fix eventually.
