Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8A7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB27C208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfH2IMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:12:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfH2IMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:12:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 204D5AC8E;
        Thu, 29 Aug 2019 08:12:51 +0000 (UTC)
Date:   Thu, 29 Aug 2019 10:12:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        metux IT consult Enrico Weigelt <lkml@metux.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
Message-ID: <20190829081249.3zvvsa4ggb5pfozl@pathway.suse.cz>
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
 <74303921-aa95-9962-2254-27e556af54f4@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74303921-aa95-9962-2254-27e556af54f4@kleine-koenig.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-08-28 21:18:37, Uwe Kleine-König  wrote:
> Hello Petr,
> 
> On 8/28/19 1:32 PM, Petr Mladek wrote:
> > On Tue 2019-08-27 23:12:44, Uwe Kleine-König  wrote:
> >> Petr Mladek had some concerns:
> >>> There are ideas to make the code even more tricky to reduce
> >>> the size, keep it fast.
> >>
> >> I think Enrico Weigelt's suggestion to use a case is the best
> >> performance-wise so that's what I picked up. Also I hope that
> >> performance isn't that important because the need to print an error
> >> should not be so common that it really hurts in production.

This is contadicting. The "best" performance-wise solution was
choosen in favor of space. The next sentence says that performance
is not important.

> > I personally do not like switch/case. It is a lot of code.
> > I wonder if it even saved some space.
> 
> I guess we have to die either way. Either it is quick or it is space
> efficient.

I am more concerned about the size. Well, array of strings will
be both fast and size efficient.

> With the big case I trust the compiler to pick something
> sensible expecting that it adapts for example to -Osize.

I am not sure what are the expectations here. I can't imagine
another translation than:

   if (val == 1)
     str = "EPERM";
   else if (val == 2)
     str = "ENOENT"
   else if (val == 3)
     str = "ESRCH"
   ...

It means that all constans will be hardcoded in the code instead
of in data section. Plus there will be instructions for each
if/else part.

> > If you want to safe space, I would use u16 to store the numbers.
> > Or I would use array of strings. There will be only few holes.
> > 
> > You might also consider handling only the most commonly
> > used codes from errno.h and errno-base.h (1..133). There will
> > be no holes and the codes are stable.
> 
> I'd like to postpone the discussion about "how" until we agreed about
> the "if at all".

It seems that all people like this feature.

BTW: I though more about generating or cut&pasting the arrary.
I can't find any reasonable way how to generate it.

But both, errno.h and errno-base.h, are super stable. Only
comments were modified or new codes added. Most of them
are defined by POSIX so they should remain stable.

Therefore cut&pasted array of strings looks acceptable.
We should only allow to easily check numbers for each code,
e.g. by defining the array as

const err_str * [] {
	"0"			/*   0  Success */
	"EPERM",		/*   1	Operation not permitted */
	"ENOENT",		/*   2	No such file or directory */
	"ESRCH",		/*   3	No such process */
	...


If there is a hole, we could use something like:

	"-41",			/*  41  Skipped. EWOULDBLOCK is
	defined as EAGAIN.  Operation would block */

Best Regards,
Petr
