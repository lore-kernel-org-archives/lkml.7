Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C728C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6981020449
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfGaJef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:34:35 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:52694 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbfGaJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:34:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5DD26180A8145;
        Wed, 31 Jul 2019 09:34:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owl74_618f7876cda40
X-Filterd-Recvd-Size: 2772
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 09:34:30 +0000 (UTC)
Message-ID: <11f7da029d8b053c0069a02ec2c06f98280cddb5.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 02:34:28 -0700
In-Reply-To: <20190731090211.GP31381@hirez.programming.kicks-ass.net>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731090211.GP31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 11:02 +0200, Peter Zijlstra wrote:
> On Tue, Jul 30, 2019 at 10:35:18PM -0700, Joe Perches wrote:
> > Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> > various case block /* fallthrough */ style comments to appear to be an
> > actual reserved word with the same gcc case block missing fallthrough
> > warning capability.
> > 
> > All switch/case blocks now must end in one of:
> > 
> > 	break;
> > 	fallthrough;
> > 	goto <label>;
> > 	return [expression];
> > 
> > fallthough is gcc's __attribute__((__fallthrough__)) which was introduced
> > in gcc version 7..
> > 
> > fallthrough devolves to an empty "do {} while (0)" if the compiler version
> > (any version less than gcc 7) does not support the attribute.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> _MUCH_ better than that silly comment, thanks for doing this!
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I also hacked up a little perl script to do most of the
conversions and realignments for the 4200+ current comments.

I'll work on it a bit more and then post it when it's
presentable.

