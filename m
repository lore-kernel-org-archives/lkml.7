Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6CFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1C02073F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfH3JG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:06:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:46406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfH3JG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:06:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B268AF93;
        Fri, 30 Aug 2019 09:06:25 +0000 (UTC)
Date:   Fri, 30 Aug 2019 11:06:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Juergen Gross <jgross@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        metux IT consult Enrico Weigelt <lkml@metux.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
Message-ID: <20190830090624.tb2tmhbt3wzwz6rp@pathway.suse.cz>
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
 <74303921-aa95-9962-2254-27e556af54f4@kleine-koenig.org>
 <20190829081249.3zvvsa4ggb5pfozl@pathway.suse.cz>
 <45cd5b50-9854-fce7-5f08-f7660abb8691@suse.com>
 <a83449cf-3a4a-f3e0-210a-dc7c39505355@rasmusvillemoes.dk>
 <002dc2a7-40a3-f52a-c8fa-5dbb42e6dd7b@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002dc2a7-40a3-f52a-c8fa-5dbb42e6dd7b@kleine-koenig.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-08-29 19:39:45, Uwe Kleine-König  wrote:
> On 8/29/19 11:09 AM, Rasmus Villemoes wrote:
> > On 29/08/2019 10.27, Juergen Gross wrote:
> >> On 29.08.19 10:12, Petr Mladek wrote:
> >>> On Wed 2019-08-28 21:18:37, Uwe Kleine-König  wrote:
> >>>>
> >>>> I'd like to postpone the discussion about "how" until we agreed about
> >>>> the "if at all".
> >>>
> >>> It seems that all people like this feature.
> >>
> >> Hmm, what about already existing format strings conatining "%dE"?
> >>
> >> Yes, I could find only one (drivers/staging/speakup/speakup_bns.c), but
> >> nevertheless...
> > 
> > Indeed, Uwe still needs to respond to how he wants to handle that. I
> 
> This is indeed bad and I didn't expect that. I just took a quick look
> and this string is indeed used as sprintf format string.

Hmm, it seems that solving this might be pretty tricky.

I see this as a warning that we should not play with fire.
There might be a reason why all format modifiers are put
between % and the format identifier.

> > still prefer making it %pE, both because it's easier to convert integers
> > to ERR_PTRs than having to worry about the type of PTR_ERR() being long
> > and not int, and because alphanumerics after %p have been ignored for a
> > long time (10 years?) whether or not those characters have been
> > recognized as a %p extension, so nobody relies on %pE putting an E after
> > the %p output. It also keeps the non-standard extensions in the same
> > "namespace", so to speak.
>
> > Oh, 'E' is taken, well, make it 'e' then.
> 
> I like having %pe to print error valued pointers. Then maybe we could
> have both %de for ints and %pe for pointers. :-)

I would prefer to avoid %pe. It would make sense only when the value
really contains error id. It means that it has to be used as:

    if (IS_ERR(p)) {
       pr_warn(...);

The error path might handle the error using PTR_ERR() also
on other locations. Also PTR_ERR() will make it clear that we
are trying to print the error code.

Best Regards,
Petr
