Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC9C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF525206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfHAHwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:52:13 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:39461 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbfHAHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:52:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7541F180A68C4;
        Thu,  1 Aug 2019 07:52:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: salt52_87225dffc9104
X-Filterd-Recvd-Size: 2881
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 07:52:08 +0000 (UTC)
Message-ID: <bc1d19db30ce5ccbbb936144b0f28518a37e8a6c.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     hpa@zytor.com, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 00:52:06 -0700
In-Reply-To: <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731171429.GA24222@amd>
         <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
         <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
         <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
         <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
         <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
         <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 23:10 -0700, hpa@zytor.com wrote:
> On July 31, 2019 4:55:47 PM PDT, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Wed, Jul 31, 2019 at 11:01 PM <hpa@zytor.com> wrote:
> > > The standard is moving toward adding this as an attribute with the
> > [[fallthrough]] syntax; it is in C++17, not sure when it will be in C
> > be if it isn't already.
> > 
> > Not yet, but it seems to be coming:
> > 
> >  http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf
> > 
> > However, even if C2x gets it, it will be quite a while until the GCC
> > minimum version gets bumped up to that, so...
> > 
> > Cheers,
> > Miguel
> 
> The point was that we should plan ahead in whatever we end up doing.

Using a local keyword will allow any compiler to work successfully.

It's pretty simple to modify this to something like

#define fallback [[fallback]]



