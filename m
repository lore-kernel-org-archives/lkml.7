Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24BC20856
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH0XLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:11:02 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:34622 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726034AbfH0XLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:11:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DC4C818224D63;
        Tue, 27 Aug 2019 23:10:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: form24_42aa91898ca32
X-Filterd-Recvd-Size: 2375
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Aug 2019 23:10:57 +0000 (UTC)
Message-ID: <a828ba39477f1cfb8933b0e6cc704dfa6c315bcc.camel@perches.com>
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Aug 2019 16:10:56 -0700
In-Reply-To: <59bfcf90-f7f8-4d55-b5bf-211f6ca67917@kleine-koenig.org>
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
         <04b021b263465c62628964ac402e15fd4cdc13a0.camel@perches.com>
         <59bfcf90-f7f8-4d55-b5bf-211f6ca67917@kleine-koenig.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 23:35 +0200, Uwe Kleine-König wrote:
> Hello Joe,
> 
> On 8/27/19 11:22 PM, Joe Perches wrote:
> > On Tue, 2019-08-27 at 23:12 +0200, Uwe Kleine-König wrote:
> > > The new format specifier %dE introduced with this patch pretty-prints
> > > the typical negative error values. So
> > > 
> > > 	pr_info("probing failed (%dE)\n", ret);
> > > 
> > > yields
> > > 
> > > 	probing failed (EIO)
> > > 
> > > if ret holds -EIO. This is easier to understand than the for now common
> > > 
> > > 	probing failed (-5)
> > 
> > I suggest using both outputs like '-5 -EIO'
> > rather than a single string
> 
> I like it the way it is implemented as it is more flexible. If you want
> to see both, you can still do
> 
> 	pr_info("probing failed (%d %dE)\n", ret, ret);
> 
> and people (like me) who think that giving only EIO can still do just that.

<shrug>  Up to you.  Just a suggestion.

btw:

The test for %<dixu>E (FORMAT_TYPE_INT)
should probably include a test for

(spec->flags & SIGN)

so that it only is used for %d and %i and
disregarded for %x and %u


