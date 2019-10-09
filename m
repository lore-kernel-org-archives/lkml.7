Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB343ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B75B206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfJIQij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:38:39 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:59804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731824AbfJIQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:38:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id AE55918224D75;
        Wed,  9 Oct 2019 16:38:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cry32_10c0bd5169c3e
X-Filterd-Recvd-Size: 2450
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Oct 2019 16:38:34 +0000 (UTC)
Message-ID: <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Oct 2019 09:38:33 -0700
In-Reply-To: <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
         <20191009110943.7ff3a08a@gandalf.local.home>
         <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 09:13 -0700, Nick Desaulniers wrote:
> On Wed, Oct 9, 2019 at 8:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 9 Oct 2019 14:14:28 +0200 Markus Elfring <Markus.Elfring@web.de> wrote:
[]
> > > Several functions return values with which useful data processing
> > > should be performed. These values must not be ignored then.
> > > Thus use the annotation “__must_check” in the shown function declarations.
[]
> > I'm curious. How many warnings showed up when you applied this patch?
> 
> I got zero for x86_64 and arm64 defconfig builds of linux-next with
> this applied.  Hopefully that's not an argument against the more
> liberal application of it?  I view __must_check as a good thing, and
> encourage its application, unless someone can show that a certain
> function would be useful to call without it.

stylistic trivia, neither agreeing nor disagreeing with the patch
as I generally avoid reading Markus' patches.

I believe __must_check is best placed before the return type as
that makes grep for function return type easier to parse.

i.e. prefer
	[static inline] __must_check <type> <function>(<args...>);
over
	[static inline] <type> __must_check <function>(<args...>);

