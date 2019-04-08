Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfDHWDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:03:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:38246 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfDHWDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:03:16 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A5AC3301;
        Mon,  8 Apr 2019 22:03:15 +0000 (UTC)
Date:   Mon, 8 Apr 2019 16:03:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Let backtick and backslash escape percent
 sign
Message-ID: <20190408160314.05bc5ecb@lwn.net>
In-Reply-To: <20190405211820.17617-1-sean.j.christopherson@intel.com>
References: <20190405211820.17617-1-sean.j.christopherson@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Apr 2019 14:18:20 -0700
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> There are a handful of instances where kernel doc comments want an
> actual '%' in the final output, e.g. vsnprintf() wants to display "%n"
> and "%p" to document format specifiers, and assembly functions that use
> a custom call ABI may want to document their register usage, e.g. %eax.
> 
> Because kernel-doc unconditionally interprets '%' followed by a word
> character as a constant definition, i.e. %CONST, it's impossible to get
> an actual '%\w' when kernel-doc is used to translate comments into rst
> format.  Treat backtick and backlash as escaping '%', the former to
> handle '%' in a ``LITERAL``, and the latter to allow '%' when using
> standard formatting.

So I'm sympathetic toward the goal; we want this stuff to format properly.
But I'm less convinced about this specific solution.  Starting with the
details: 

> -my $type_constant2 = '\%([-_\w]+)';
> +my $type_constant2 = '(^|[^\`\\\])\%([-_\w]+)';

This only escapes the % if it occurs *immediately* after the backtick, so
something like ``foo %p`` will still get processed incorrectly.  Somebody
will surely run into that at some point and waste a bunch of time trying to
figure out what's going on.

Also, believe it or not, I don't think you have enough backslashes; that
inner expression, I believe, should be:

	[^\`\\\\]

Gosh Perl regexes are fun...  This highlights the danger of adding
functionality that isn't exercised anywhere; I don't think it works here.

Now to more general considerations.  Willy's suggestion of using %% instead
makes some sense, though it may lead to pushback from the "no extra markup
ever" contingent.  It should be more straightforward to implement
correctly.

I have to wonder if the % thing is actually buying us much, honestly.  It's
another form of markup that kind of duplicates the Sphinx notation, and
we've kind of agreed that most of the time, we don't want to clutter our
text with ``explicit markup`` like that.  I'm curious what people think:
might the best solution be to just make %const do nothing special, with the
idea of phasing it out?

Thanks,

jon
